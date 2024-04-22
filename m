Return-Path: <linux-kernel+bounces-152714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467B8AC345
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D9C28191B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B611078B;
	Mon, 22 Apr 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VPy8bsJE"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67243F9EC;
	Mon, 22 Apr 2024 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758306; cv=none; b=eRqeo8jUedyh1m8ivpctCIEsdRgaZyIOu46ABmLNxG4o73YbHCOiZviCZ40oxV0lCw9R45vIoZXKzhFYPhbmc0hnd8QmiBmm4NotN1tBZtOngl8DCFSaiCU/1DrU/SpDYuCDm1fx++r1SkXtDSOvGe15tAnD3G/A6ZcEaraW47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758306; c=relaxed/simple;
	bh=74DDXzIMt+qGRJSOmzuMZBwtJRLIogdL8tSrRW8MmsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNp///xJeu7L3gJ0lFSM7HuhuKqwAi8LwfOSMDHzYHcJB6MLoW5YQ0fhDJzfqj2xDDy4gXN0o+F9aSyXyanR6xkfmCdhh0bpBY2UABWcoKw28/+Mejbz1BI7+gggQDIUNon8FoXMfCpaGcaXyNTQZvsk1Nx5acugHB6ggaLzD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VPy8bsJE; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tz47OXMk6zbzBGF1ySQDbEiSUSoHnPDqD9rcCDIH3/o=;
	b=VPy8bsJEtjhzPsrf057kTfxn2QcwPsyLbEVeyhEsMSlK1s6rOKafjwW1tFiiXn
	BJzxCWUZ19e2Y3C1m3C9snT+A1us0lCGXrTutHQS0mIMD7kHaG1J3L1xyb9+9UsR
	k5LTxpbP8FNwbH+D37t/J+5ZPUoN9EXp4qxqlsRVJmVDQ=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrABHzw5N3yVmRawrAw--.30849S3;
	Mon, 22 Apr 2024 11:53:50 +0800 (CST)
Date: Mon, 22 Apr 2024 11:53:49 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Mark Brown <broonie@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/7] ARM: configs: imx_v6_v7: Enable DRM_DW_HDMI
Message-ID: <ZiXfTfNoc0/2XL9s@dragon>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <20240403-fix-dw-hdmi-kconfig-v1-3-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-3-afbc4a835c38@kernel.org>
X-CM-TRANSID:ClUQrABHzw5N3yVmRawrAw--.30849S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kr4Duw13uw1UuF1UAF13urg_yoWxGwcEyF
	yxKrn7Zr15Za4jyw15KFZavrsa93WUWFn8X3yUKrW3WFn8XF45Ar4kt34Sywn7Z3WIyrsr
	CFs5J3Wvyw4IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbco7JUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQ7IZVsVCfARMAAAsw

On Wed, Apr 03, 2024 at 12:56:21PM +0200, Maxime Ripard wrote:
> Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
> module") turned the DRM_DW_HDMI dependency of DRM_IMX_HDMI into a
> depends on which ended up disabling the driver in the defconfig. Make
> sure it's still enabled.
> 
> Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>


