Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5514B7FD16E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjK2Ixc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjK2Ixa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:53:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E008AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:53:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F62C433C7;
        Wed, 29 Nov 2023 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701248016;
        bh=3eLt23KooZa2k2I13M7RSXAGLV1T4oMfWl3vu8htwmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H10Gz0c3p5v4a9BqkCBUfFhbKlxaGH2dQYHXYqZneRUQxkzvQwROkFvxs4Rg8WvxC
         S8QlKDnjKBwY5Vpjv4JJUHKT3vJcZCUps0TFUqyC4XWMd7l14OuAScT1a2YmqYNGLo
         Wtf7cA9G2XPCJbTXDJVBUgnCmqEoRe6wxquimnOLui+qvzj7Ztu+IbBnlrbXBHsTXY
         6LxgFjHdPm37ysKu/Q4Ydk/eZK7IdsdbKf1RgXtHiI3Myq8xjiqQXvb694Z7h3WtoB
         ra7qfCfO/yhM96Ih3Vfuo4WL+QHBvf9jzhkVX7lH54048S6kowXlPwREYfjOlwpV+N
         buiuIt3WJFAaw==
Date:   Wed, 29 Nov 2023 00:53:34 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <ZWb8DgFoQuzWfumk@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-4-saeed@kernel.org>
 <2023112722-imitate-impromptu-c9a7@gregkh>
 <ZWT-elg2hzX7s7B4@x130>
 <2023112802-false-tumble-ea38@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023112802-false-tumble-ea38@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 09:13, Greg Kroah-Hartman wrote:
>On Mon, Nov 27, 2023 at 12:39:22PM -0800, Saeed Mahameed wrote:
>> On 27 Nov 19:09, Greg Kroah-Hartman wrote:
>> > On Mon, Nov 20, 2023 at 11:06:17PM -0800, Saeed Mahameed wrote:
>> > > +static int mlx5ctl_info_ioctl(struct file *file,
>> > > +			      struct mlx5ctl_info __user *arg,
>> > > +			      size_t usize)
>> > > +{
>> > > +	struct mlx5ctl_fd *mfd = file->private_data;
>> > > +	struct mlx5ctl_dev *mcdev = mfd->mcdev;
>> > > +	struct mlx5_core_dev *mdev = mcdev->mdev;
>> > > +	struct mlx5ctl_info *info;
>> > > +	size_t ksize = 0;
>> > > +	int err = 0;
>> > > +
>> > > +	ksize = max(sizeof(struct mlx5ctl_info), usize);
>> >
>> > Why / How can usize be larger than the structure size and you still want
>> > to allocate a memory chunk that big?  Shouldn't the size always match?
>> >
>>
>> new user-space old kernel, the driver would allocate the usiae and make
>> sure to clear all the buffer with 0's, then fill in what the kernel
>> understands and send the whole buffer back to user with trailer always
>> zeroed out.
>
>No, at that point you know something is wrong and you need to just abort
>and return -EINVAL as the structure sizes do not match.
>
>If you need to "extend" the structure to include more information, do so
>in a new ioctl.
>

Ack, will remove these fields.

>> > > --- /dev/null
>> > > +++ b/include/uapi/misc/mlx5ctl.h
>> > > @@ -0,0 +1,24 @@
>> > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
>> > > +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>> > > +
>> > > +#ifndef __MLX5CTL_IOCTL_H__
>> > > +#define __MLX5CTL_IOCTL_H__
>> > > +
>> > > +struct mlx5ctl_info {
>> > > +	__aligned_u64 flags;
>> >
>> > Is this used?
>> >
>>
>> no, not yet, but it is good for future extendibility and compatibility
>> checking.
>
>But you are not checking anything now, so please don't include something
>that will not work in the future.
>

Ack, will remove.

>> > > +	__u32 size;
>> > > +	__u8 devname[64]; /* underlaying ConnectX device */
>> >
>> > 64 should be a define somewhere, right?  And why 64?
>> >
>>
>> It is usually the kobj->name of the underlying device, I will have to
>> define this in the uAPI. 64 seemed large enough, any other suggestion ?
>
>What happens if the names get bigger?
>
>> This field is informational only for the user to have an idea which is the
>> underlying physical device, it's ok if in odd situation the name has to be
>> truncated to fit into the uAPI buffer.
>
>As the truncation will happen on the right side of the string, usually
>the actual device id or unique identifier, that's not going to help out
>much to drop that portion :(
>

Right :/, it's an assumption that mlx5 devices can either be a pci device
or an auxiliary device in case of a mlx5-subfunction, so i don't expect the
names to get larger and can easily fit in 64B string, but you are right, I
shouldn't make such assumption in an IOCTL, I will figure out something or
completely drop this field in V4.

>> > > +	__u16 uctx_uid; /* current process allocated UCTX UID */
>> > > +	__u16 reserved1;
>> >
>> > Where is this checked to be always 0?  Well it's a read so I guess where
>> > is the documentation saying it will always be set to 0?
>> >
>>
>> I forgot to add the checks in the info ioctl path, will add that.
>> Isn't it an unwritten rule that reserved fields has to be always 0 ?
>> Do I really need to document this ?
>
>It is a written rule that reserved fields must be 0, please see the
>documentation for how to write an ioctl.
>

Ack, will document.

>thanks,
>
>greg k-h
