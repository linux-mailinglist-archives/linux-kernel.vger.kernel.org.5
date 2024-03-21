Return-Path: <linux-kernel+bounces-110133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9790885A79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A99282638
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABE84FDE;
	Thu, 21 Mar 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW9dH7BM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296D84FC8;
	Thu, 21 Mar 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030578; cv=none; b=kciv2QFogEIAKkdj9ocb755M2FbYIKRTg3M6+E/5vPKrc5gsCWIknqO/SouJSaCkskKHGFxkkmqbVdwJ86SvC+FljZuBf7FmklSUhgrp3xS0ccGmxREf/INOr0IxGo7+Km19evFb2Vq1HKX33ObR6R8CFqbJgzXqo1UPIJrqmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030578; c=relaxed/simple;
	bh=P2zV7GBm6lZnqd1GyySXrz0bEM2Hy/g25qCyixz2gNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE+WLIYQLxsjYfoDqIdrNWtD9A5W1o90RYJqhVgpnAgQGoDoE1FuQm/ajzSd9uQe8BMBj0ihIIIhsCSuu+/BLqwvEsqCFnrd/RXNGdmT7EOAdG6UjDNPARtoqCL1Yrk73ToHGQdxLIfhGCCys9zaLOvGTN3HYaEZqbmglmJcOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW9dH7BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59432C433F1;
	Thu, 21 Mar 2024 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711030577;
	bh=P2zV7GBm6lZnqd1GyySXrz0bEM2Hy/g25qCyixz2gNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fW9dH7BMmIevERikyWGHcZmsIbOXQ9fjWzyoXErKCIDVVF3sZz35Q38spMoqCGUPQ
	 V6P5o6VLXr2LR0+3xT7Zl28eqHrz2DGjZ46KY2QXwvVHG6u/LkgyfMWiLngP6GTIWV
	 vhijr0O3NijoGph47oDIOt9ggTLUtlWPLV1DHGs4CvryZ+CRti4C5ePTr/jsSiCKBz
	 a/Vahj2Z7pQJturGtGRJbE+80oBoxYEZ124/29P2RcDW8gMZp+lHutGUYTUYVFXu9K
	 PbCxcp5y9ZJhB7KwEkACyDXDqMroHv0rq6MDAt+pLUBVqoD1bGVyToKyAT8ink4lxH
	 GtDTJckgKsd5g==
Date: Thu, 21 Mar 2024 15:16:12 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v21 9/9] media: verisilicon: Support removing buffers on
 capture queue
Message-ID: <20240321151612.42de52a5@coco.lan>
In-Reply-To: <20240314153226.197445-10-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
	<20240314153226.197445-10-benjamin.gaignard@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Mar 2024 16:32:26 +0100
Benjamin Gaignard <benjamin.gaignard@collabora.com> escreveu:

> Allow to remove buffers on capture queue because it the one which
> own the decoded buffers. After a dynamic resolution change lot of
> them could remain allocated but won't be used anymore so deleting
> them save memory.


LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 941fa23c211a..df6f2536263b 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_remove_bufs = v4l2_m2m_ioctl_remove_bufs,
>  	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,



Thanks,
Mauro

