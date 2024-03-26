Return-Path: <linux-kernel+bounces-120091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DA88D16D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF201C6442B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B313E895;
	Tue, 26 Mar 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hS9m7+Y3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29938F86;
	Tue, 26 Mar 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492991; cv=none; b=bLK28pHihZdAROjjcZ1blzQ+5e927+1Zvo1j8l4KU6g5Ec1akJYh8flDLC32Zme9RF+sxAr0nmDCwr5OsNAlMd/KP1iGreJZLRXUspYRqg22lLcC+eRLQJR7A5LGgeGxqTImHZLxugU2uq7OsXT6PAtw2zAEvWagtkLME4eck6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492991; c=relaxed/simple;
	bh=GuyTOe7sfsFDL6EEc8g8HvzuSNvtqY2y8Bzhmb6nCxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYRPShfcU60oyxSd5q7iwRq4P/KAEmuAjQu9NyTw+qubX+x1SrCU1p5BYG5VBIu/58Y93sA4ZMWO/J2q4nxPX1Dt6gZSXGOWn6pPnIW0tuODyDu/up00ouVtDvZBUQ7/iwSmJHk5khznerFBDjcFmsUdLYFIeFwJVgHn6o7no5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hS9m7+Y3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4DB7497;
	Tue, 26 Mar 2024 23:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711492950;
	bh=GuyTOe7sfsFDL6EEc8g8HvzuSNvtqY2y8Bzhmb6nCxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hS9m7+Y387Lya0A9eZHtLKLH0rHZXo7KtngBEJ3GASXw3qRA8zl3/VjTi8FP7y2Ns
	 1TWjH4pZK/ftMHkZ1I+e3m98Hu/8MZyA77PTrLTAJQUOwMseJL4Ym1IamjiL8No0Bd
	 frXsA6Fzbhtq1gh718SEqCrz2hSTclbXdzWdab/M=
Date: Wed, 27 Mar 2024 00:42:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] fbdev: shmobile: fix snprintf truncation
Message-ID: <20240326224252.GB14986@pendragon.ideasonboard.com>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326223825.4084412-2-arnd@kernel.org>

Hi Arnd,

Thank you for the patch.

On Tue, Mar 26, 2024 at 11:38:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The name of the overlay does not fit into the fixed-length field:
> 
> drivers/video/fbdev/sh_mobile_lcdcfb.c:1577:2: error: 'snprintf' will always be truncated; specified size is 16, but format string expands to at least 25
> 
> Make it short enough by changing the string.
> 
> Fixes: c5deac3c9b22 ("fbdev: sh_mobile_lcdc: Implement overlays support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index eb2297b37504..d35d2cf99998 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1575,7 +1575,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
>  	 */
>  	info->fix = sh_mobile_lcdc_overlay_fix;
>  	snprintf(info->fix.id, sizeof(info->fix.id),
> -		 "SH Mobile LCDC Overlay %u", ovl->index);
> +		 "SHMobile ovl %u", ovl->index);
>  	info->fix.smem_start = ovl->dma_handle;
>  	info->fix.smem_len = ovl->fb_size;
>  	info->fix.line_length = ovl->pitch;

-- 
Regards,

Laurent Pinchart

