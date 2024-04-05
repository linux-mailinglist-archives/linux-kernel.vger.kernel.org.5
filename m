Return-Path: <linux-kernel+bounces-133047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DB899E07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA10B248F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C40716D33A;
	Fri,  5 Apr 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS0svyP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACD2E401;
	Fri,  5 Apr 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322580; cv=none; b=aWnM2x/DepBEBH0EF660oV6FP8yzDGplUQ/Qd+CQ6W9bbGAjXkgd1sdmyr50EtXQa7MfIjk5mcjLK4QEQZ7cDvH6B+xotO8HuNpbKLFaBGBD6fxB2XOWuY4sY3hZvZ5Vlw5gYdba2bKsvezkYENwyboDv5EpKlp1MqMImrisshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322580; c=relaxed/simple;
	bh=pyHYY0cp6y2a364+xVjeEgDvNZHaRJHSrzno1tz0wqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J7pSdwwwno1WUHsqGYiwqaDMMrD5HKv4SCCfeGud+OlR8mcYbuf43RrGugYwq/ZgdGcL7doo1cxwzdgKcQgeLB8aZ7PPOriXzC/8+TCFk7itVOzdXm1WTh8wUFXxRo/EIDqpm7s+oEuronrd2j3bnzTttX3W7oBaHP7W5qtXf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS0svyP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D91C433F1;
	Fri,  5 Apr 2024 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322580;
	bh=pyHYY0cp6y2a364+xVjeEgDvNZHaRJHSrzno1tz0wqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WS0svyP5nQ5Y51sfjmnIMoEz4bk7HWaPLMzZ5/XR8ZsndM4HSutHmVx75uhKXnxHz
	 a+d+MUETkrKLuFUZiDkkXDelX/QPUVyP3mtHfHYY1F8oiExp3TatZQ6UtesekDiSW7
	 2N23PohtQ9+wOc+UQW6I/VOCeV56swmF0M0ExPBvulC1T1KuFlQdgyYKpffKNTsM1V
	 +mP+oIEweIjLxmr/gQGPVYuq29CRiK7uqwtGEPam5sF2W7pBi+vhr/sePNRo4cY4Vg
	 iSKPWXZ/MSHkKBqv88ZrCpJbnL4KVaAoiS2XQuXroXAhgGa4Yk3RceKMD8QmS9o8d9
	 bxegeazWRQM1A==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Maxime Ripard <mripard@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-1-afbc4a835c38@kernel.org>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <20240403-fix-dw-hdmi-kconfig-v1-1-afbc4a835c38@kernel.org>
Subject: Re: (subset) [PATCH 1/7] drm/display: Select DRM_KMS_HELPER for DP
 helpers
Message-Id: <171232257737.9066.13262201288345110455.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 15:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 03 Apr 2024 12:56:19 +0200, Maxime Ripard wrote:
> The DisplayPort helpers rely on some
> (__drm_atomic_helper_private_obj_duplicate_state,
> drm_kms_helper_hotplug_event) helpers found in files compiled by
> DRM_KMS_HELPER.
> 
> Prior to commit d674858ff979 ("drm/display: Make all helpers visible and
> switch to depends on"), DRM_DISPLAY_DP_HELPER was only selectable so it
> wasn't really a big deal. However, since that commit, it's now something
> that can be enabled as is, and since there's no expressed dependency
> with DRM_KMS_HELPER, it can break too.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


