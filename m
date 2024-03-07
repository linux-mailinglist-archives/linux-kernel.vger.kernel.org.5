Return-Path: <linux-kernel+bounces-96082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF18756DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDA31C20F57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A64135A68;
	Thu,  7 Mar 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TRScb7o7"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E07AE43;
	Thu,  7 Mar 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838966; cv=none; b=qIW+rCHNVa2051HsLFk1MkwOVo9/0aN7h8fv+Ti2U0JTFMYt970RN1FYymOqhzE4CWJ6CmUlaDRoO1yDs0Rt0erAedHDDWpAMTvaRjsCxk17/Y1e1/0VsNpPDqeX280yZ8bc573kanA2YfAZDxfuD5+/Z3DP9wAq98CjuOltk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838966; c=relaxed/simple;
	bh=bgK4Acbo1DeP/ZP5WYU+++L3+bVzaYl6dbeRo+mQ+54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho7y/xXDb6oDUkVEutyqC0qAUdmy+dLdpNO2fBgNifN8iZTUtC4QC2qMPGBDz8urwVZf5qMXLftlUqTHiOf2ZT4WPVd5wrswDBCjnxlYSnfSZAnSgnLkGNiRT/FWKYYY6C5U3HDf2TSfyIK7A1z1sLcwfyf4sWSztgOcMQpjelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TRScb7o7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=QG+vD5UcPLDqkon8SpYHzF6cSkBi1G9XY1xA7CEShgk=; b=TRScb7o7LHLPRM2wBrz5VE1RKF
	TyLD6+m4Dw1GMpy54EL8rsar4DugF6K4nOif/m+mM+EHAaWJiagwzF5gNyynMQxUQ+VW90Tq9+jX9
	uX3JTNShGv7yfjknLZkAMtlXtpSBng/lPfXUN6gjajO0EyseDfMxl4F1m7++Y0zWBdVZ1jd9WT/AX
	3gEmg11AEECOzVcITS6yemsPIy1Gva28nekHI1GuytplOYvVVEyfg37TJFs2DF6mf5J5/aIrAJVyi
	C3d9YYCDZIwDbx/xpjHD5RPZ8TtgQO4/ZYJGsTAVFwJC+oJQaLX9jj4Bfr/VO4mUYPb65DqVNnYow
	6NJa3z6Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1riIcv-00BazA-2S;
	Thu, 07 Mar 2024 18:37:57 +0000
Date: Thu, 7 Mar 2024 18:37:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] lib/fonts: Allow Sparc console 8x16 font for sparc64
 early boot text console
Message-ID: <ZeoJhSUFeL_GhlRA@gallifrey>
References: <20240307180742.900068-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240307180742.900068-1-andreas@gaisler.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 18:36:27 up 64 days, 21:26,  1 user,  load average: 0.02, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Andreas Larsson (andreas@gaisler.com) wrote:
> Allow FONT_SUN8x16 when EARLYFB is enabled for sparc64, even when
> FRAMEBUFFER_CONSOLE is not to avoid the following warning for this case
> 
>    WARNING: unmet direct dependencies detected for FONT_SUN8x16
>      Depends on [n]: FONT_SUPPORT [=y] && (FRAMEBUFFER_CONSOLE [=n] && (FONTS [=n] || SPARC [=y]) || BOOTX_TEXT)
>      Selected by [y]:
>      - EARLYFB [=y] && SPARC64 [=y]
> 
> by allowing it in the same manner as is done for powerpc in commit
> 0ebc7feae79a ("powerpc: Use shared font data").

Yeh that looks like it should do it; I was hoping there was a way to make
that line simpler, but hey, thanks for fixing it.

Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>

> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Fixes: 0f1991949d9b ("sparc: Use shared font data")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402241539.epQT43nI-lkp@intel.com/
> Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
> The commit this fixes can be found on my for-next branch from
> https://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git/
> ---
>  lib/fonts/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
> index 7ee468ef21ec6..7e945fdcbf115 100644
> --- a/lib/fonts/Kconfig
> +++ b/lib/fonts/Kconfig
> @@ -98,7 +98,8 @@ config FONT_10x18
>  
>  config FONT_SUN8x16
>  	bool "Sparc console 8x16 font"
> -	depends on (FRAMEBUFFER_CONSOLE && (FONTS || SPARC)) || BOOTX_TEXT
> +	depends on (FRAMEBUFFER_CONSOLE && (FONTS || SPARC)) || \
> +		   BOOTX_TEXT || EARLYFB
>  	help
>  	  This is the high resolution console font for Sun machines. Say Y.
>  
> 
> base-commit: 626db6ee8ee1edac206610db407114aa83b53fd3
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

