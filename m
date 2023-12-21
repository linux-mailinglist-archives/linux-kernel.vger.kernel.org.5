Return-Path: <linux-kernel+bounces-7977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D2281B000
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8ED282A33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64815AC3;
	Thu, 21 Dec 2023 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAS8tZni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C7156DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F36DC433C7;
	Thu, 21 Dec 2023 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703146137;
	bh=rFoRj/pk6FCKS0+gZZHfdCuP2ih2ZQ5SGrIVftTQQ5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAS8tZnikDKTIuPQcCkaijxQFPEQKVlHNzAG0euK80hZEI0yksfAm+2n+8jSlo2Bd
	 31UwHVY9Y6eT8+3V68L/hKEBmy6J/bhEapDSBAke2J1OpSsuxGHjJBoC+Hjl0VNZzY
	 +3EMVCFLEqx7L1zZWjYJM8tlos74D4Simtw+bmJU=
Date: Thu, 21 Dec 2023 09:08:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH] uio: Fix use-after-free in uio_open
Message-ID: <2023122115-strewn-unsigned-b3e5@gregkh>
References: <1703132808-14322-1-git-send-email-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703132808-14322-1-git-send-email-guanghuifeng@linux.alibaba.com>

On Thu, Dec 21, 2023 at 12:26:48PM +0800, Guanghui Feng wrote:
> core-1					core-2
> -------------------------------------------------------------
> uio_unregister_device			uio_open
> 					idev = idr_find()
> device_unregister(&idev->dev)
> put_device(&idev->dev)
> uio_device_release
> 					get_device(&idev->dev)
> kfree(idev)
> uio_free_minor(minor)
> 					uio_release
> 					put_device(&idev->dev)
> 					kfree(idev)
> -------------------------------------------------------------
> 
> In the core-1 uio_unregister_device(), the device_unregister will kfree idev
> when the idev->dev kobject ref is one. But after core-1 device_unregister,
> put_device and before doing kfree, the core-2 may get_device. Then:
> 1. After core-1 kfree idev, the core-2 will do use-after-free for idev.
> 2. When core-2 do uio_release and put_device, the idev will be double freed.
> 
> To address this issue, we can get idev atomic & inc idev reference with minor_lock.

Nit, can you wrap your lines at 72 columns?

Anyway, nice fix, how did you find this?

> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>

What commit id does this fix?

thanks,

greg k-h

