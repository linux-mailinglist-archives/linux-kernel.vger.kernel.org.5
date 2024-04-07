Return-Path: <linux-kernel+bounces-134189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F289AECF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBEB22D87
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E863B8;
	Sun,  7 Apr 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEHQ9yVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E790184D;
	Sun,  7 Apr 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712470404; cv=none; b=E/e8Du2t1wTQobFq+TY35ZrcZVcpBvkWMk2OByP8jdpvMh04CjvS82aLNknfWrg2bYrV9bn8iBtVYfcBZ4vdW/spuvTYHFlh6UlFkzWRhjwNdbrMPeN6jIaV1o27BHYMEfmsp76K0Urq0kfsJ21ztYdzsqq9dyzy6aoT7xDnrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712470404; c=relaxed/simple;
	bh=4wcLIJ61+MYcFNncPI6IcB5hQwoIi8wRWHK0RjMxaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2lE4/hbc4Tes0VVrBBOYI8NFXRCxczNb+VevOAKr3ya7iZGlW5fWAR95/yeJz4MnNdycxMJP7PmcilU11mv6OAKuQNwhFr3fntJe5IaOyZglwjW7x9BMWZ3KqXv+9OFEzpRspnmUMIsrS3382CBqUynosB35Q1q5o0e+pAu704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEHQ9yVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2F2C433C7;
	Sun,  7 Apr 2024 06:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712470403;
	bh=4wcLIJ61+MYcFNncPI6IcB5hQwoIi8wRWHK0RjMxaog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEHQ9yVQtK1MSybStYHVzVrR94EHrGftYkrZf0sx+cnPVNg4J5MFIMaYU5Yc1092R
	 8+ElU4E7SknAZPdszFo0iXxICwLpgh8l/pLmHYT2lnz+s5x695j31L/JDmacM5Sbj/
	 va2S2xOXsq+sNbDrUQ5p72jLGIBRYkraWXSTlpNI=
Date: Sun, 7 Apr 2024 08:13:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
Message-ID: <2024040708-dividing-igloo-37ed@gregkh>
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>

On Wed, Apr 03, 2024 at 05:16:28PM -0700, Jackson Chui wrote:
> Reported by checkpatch:
> 
> CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> precedence issues
> 
> Disambiguates '&' (address-of) operator and '->' operator precedence,
> accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
> 'struct device*', which is required by the dev_{dbg,info,err} driver
> model diagnostic macros. Issue found by checkpatch.

This really is not an issue at all, as you are dealing with pointers and
structures and nothing else.

> 
> Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index a8173aa3a995..d82a2d2abdca 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
>  
>  #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
>  
> -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> +#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)

Again, the original code here is fine.  Getting rid of the gcam_*()
functions would be nice, as hiding dev_*() calls isn't really needed.

thanks,

greg k-h

