Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6027FA9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjK0TJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjK0TJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:09:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3CD72
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:09:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FD5C433C8;
        Mon, 27 Nov 2023 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701112156;
        bh=OIi/wbJ0/rEp166PY5kASMNiDK5ClwsexDRJ4xGtS/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mhyq7NZ88UJz+sSkbecXsABvdNc/lpITZHyeO49BE/m0WuvO6JeDZUN0qdF2udmBm
         sy0loINj8HazC3WHIM9eIOrYbEYZaa6YlhM7cW00jZbuF+ongRRdp3wrNge9hLaguu
         j+PjWC0byF17ofzFTJA9rVnwwsC2nc/rZaZ8x7bQ=
Date:   Mon, 27 Nov 2023 19:09:13 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <2023112722-imitate-impromptu-c9a7@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-4-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070619.9836-4-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:06:17PM -0800, Saeed Mahameed wrote:
> +static int mlx5ctl_info_ioctl(struct file *file,
> +			      struct mlx5ctl_info __user *arg,
> +			      size_t usize)
> +{
> +	struct mlx5ctl_fd *mfd = file->private_data;
> +	struct mlx5ctl_dev *mcdev = mfd->mcdev;
> +	struct mlx5_core_dev *mdev = mcdev->mdev;
> +	struct mlx5ctl_info *info;
> +	size_t ksize = 0;
> +	int err = 0;
> +
> +	ksize = max(sizeof(struct mlx5ctl_info), usize);

Why / How can usize be larger than the structure size and you still want
to allocate a memory chunk that big?  Shouldn't the size always match?

And what if it's too small?

> +	info = kzalloc(ksize, GFP_KERNEL_ACCOUNT);

Why account as it will go away almost instantly?

> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->size = sizeof(struct mlx5ctl_info);
> +
> +	info->dev_uctx_cap = MLX5_CAP_GEN(mdev, uctx_cap);
> +	info->uctx_cap = mfd->uctx_cap;
> +	info->uctx_uid = mfd->uctx_uid;
> +	info->ucap = mfd->ucap;
> +
> +	strscpy(info->devname, dev_name(&mdev->pdev->dev),
> +		sizeof(info->devname));
> +
> +	if (copy_to_user(arg, info, usize))
> +		err = -EFAULT;

So if usize is smaller than the structure you don't copy it all?

What am I missing here?

> +
> +	kfree(info);
> +	return err;
> +}
> +
> +static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct mlx5ctl_fd *mfd = file->private_data;
> +	struct mlx5ctl_dev *mcdev = mfd->mcdev;
> +	void __user *argp = (void __user *)arg;
> +	size_t size = _IOC_SIZE(cmd);
> +	int err = 0;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	mlx5ctl_dbg(mcdev, "ioctl 0x%x type/nr: %d/%d size: %d DIR:%d\n", cmd,
> +		    _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd), _IOC_DIR(cmd));
> +
> +	down_read(&mcdev->rw_lock);
> +	if (!mcdev->mdev) {
> +		err = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	switch (cmd) {
> +	case MLX5CTL_IOCTL_INFO:
> +		err = mlx5ctl_info_ioctl(file, argp, size);
> +		break;
> +
> +	default:
> +		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
> +		err = -ENOIOCTLCMD;

-ENOTTY is the correct error.

> --- /dev/null
> +++ b/include/uapi/misc/mlx5ctl.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5CTL_IOCTL_H__
> +#define __MLX5CTL_IOCTL_H__
> +
> +struct mlx5ctl_info {
> +	__aligned_u64 flags;

Is this used?

> +	__u32 size;
> +	__u8 devname[64]; /* underlaying ConnectX device */

64 should be a define somewhere, right?  And why 64?

> +	__u16 uctx_uid; /* current process allocated UCTX UID */
> +	__u16 reserved1;

Where is this checked to be always 0?  Well it's a read so I guess where
is the documentation saying it will always be set to 0?

> +	__u32 uctx_cap; /* current process effective UCTX cap */
> +	__u32 dev_uctx_cap; /* device's UCTX capabilities */
> +	__u32 ucap; /* process user capability */
> +	__u32 reserved2;

Same here.

And why reserve anything?  What does that help with?

thanks,

greg k-h
