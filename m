Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103B7FB553
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjK1JNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjK1JNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:13:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43982CC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:13:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F74C433C8;
        Tue, 28 Nov 2023 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701162820;
        bh=ZeeCm7idj89U8UZKIa3RFNtoR2EbeGgCevjyYm3xwuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggESWRz7ES06rvYsVhRW6Q8VbbyoBOOB0rxl3/SsUCtei8Rc7gqSGyaRmuTyyOKE4
         irFXRKPWlUl04mE3x68G4p58//02mSUHY335JTYQYxxRp04YoXtkGa9ZUBQc98WuII
         ZhXcinQHvj6knNvuiesvuS0JMQkkYZCyWX7tWHzQ=
Date:   Tue, 28 Nov 2023 09:13:37 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <2023112802-false-tumble-ea38@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-4-saeed@kernel.org>
 <2023112722-imitate-impromptu-c9a7@gregkh>
 <ZWT-elg2hzX7s7B4@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWT-elg2hzX7s7B4@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:39:22PM -0800, Saeed Mahameed wrote:
> On 27 Nov 19:09, Greg Kroah-Hartman wrote:
> > On Mon, Nov 20, 2023 at 11:06:17PM -0800, Saeed Mahameed wrote:
> > > +static int mlx5ctl_info_ioctl(struct file *file,
> > > +			      struct mlx5ctl_info __user *arg,
> > > +			      size_t usize)
> > > +{
> > > +	struct mlx5ctl_fd *mfd = file->private_data;
> > > +	struct mlx5ctl_dev *mcdev = mfd->mcdev;
> > > +	struct mlx5_core_dev *mdev = mcdev->mdev;
> > > +	struct mlx5ctl_info *info;
> > > +	size_t ksize = 0;
> > > +	int err = 0;
> > > +
> > > +	ksize = max(sizeof(struct mlx5ctl_info), usize);
> > 
> > Why / How can usize be larger than the structure size and you still want
> > to allocate a memory chunk that big?  Shouldn't the size always match?
> > 
> 
> new user-space old kernel, the driver would allocate the usiae and make
> sure to clear all the buffer with 0's, then fill in what the kernel
> understands and send the whole buffer back to user with trailer always
> zeroed out.

No, at that point you know something is wrong and you need to just abort
and return -EINVAL as the structure sizes do not match.

If you need to "extend" the structure to include more information, do so
in a new ioctl.

> > > --- /dev/null
> > > +++ b/include/uapi/misc/mlx5ctl.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
> > > +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> > > +
> > > +#ifndef __MLX5CTL_IOCTL_H__
> > > +#define __MLX5CTL_IOCTL_H__
> > > +
> > > +struct mlx5ctl_info {
> > > +	__aligned_u64 flags;
> > 
> > Is this used?
> > 
> 
> no, not yet, but it is good for future extendibility and compatibility
> checking.

But you are not checking anything now, so please don't include something
that will not work in the future.

> > > +	__u32 size;
> > > +	__u8 devname[64]; /* underlaying ConnectX device */
> > 
> > 64 should be a define somewhere, right?  And why 64?
> > 
> 
> It is usually the kobj->name of the underlying device, I will have to
> define this in the uAPI. 64 seemed large enough, any other suggestion ?

What happens if the names get bigger?

> This field is informational only for the user to have an idea which is the
> underlying physical device, it's ok if in odd situation the name has to be
> truncated to fit into the uAPI buffer.

As the truncation will happen on the right side of the string, usually
the actual device id or unique identifier, that's not going to help out
much to drop that portion :(

> > > +	__u16 uctx_uid; /* current process allocated UCTX UID */
> > > +	__u16 reserved1;
> > 
> > Where is this checked to be always 0?  Well it's a read so I guess where
> > is the documentation saying it will always be set to 0?
> > 
> 
> I forgot to add the checks in the info ioctl path, will add that.
> Isn't it an unwritten rule that reserved fields has to be always 0 ?
> Do I really need to document this ?

It is a written rule that reserved fields must be 0, please see the
documentation for how to write an ioctl.

thanks,

greg k-h
