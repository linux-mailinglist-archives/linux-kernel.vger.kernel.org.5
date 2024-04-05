Return-Path: <linux-kernel+bounces-133048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B6899E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5128D1F2260B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E116D4E0;
	Fri,  5 Apr 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgBfZS1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE016D4D7;
	Fri,  5 Apr 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322584; cv=none; b=Jgs3BJIvtzDD8tfH+WIbjfqyTTG1mZoyVCAZj6G9ZzSxKvmvfBY6SPXZ3ll0b4ylODzl26bGw78yHMuN5Ps266Ogixan3fEqrHVPYH4BMQjI33n04/5Mhgj+m7PQIbidnR0sgQAQnSIoqRcOwP2QPd57S8J2sc3nNv5A2/wGnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322584; c=relaxed/simple;
	bh=v7bIaae5C/I6EIJFTJcdJOvBIkgxWyP1jUsycI59f+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dXyYGq5AyPPmlKdjTqwFgdkA/NmdwN9U+KHa85yqw8wlG1zmbRAQ4jjQwPwwrSO9c+5qTpqJ/Wz/uwo0Ei0j3sVR61wCvNSE9CuVdMgy8PTnCxZrmfKnOifCimodP1TdUKQqw9dBlVBwNbB0Ix66UGAAVk1llfJCke9jMARIN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgBfZS1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2615C433F1;
	Fri,  5 Apr 2024 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322583;
	bh=v7bIaae5C/I6EIJFTJcdJOvBIkgxWyP1jUsycI59f+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JgBfZS1EDsNnoTq60ro9de0ZIbrh2fHpnCts5KpU6pOCszcYuYFrKZ+ZNwxTb0VN+
	 4q9fU8l9sFekTKY+zdDStYi/jZu/SdaxmJ4yeD9tXLI6h9nSqvKPF392lX2Ob1zMqw
	 boTG21b9AfgMljRTZ3UYt9r8/oQ6PxaYoMBJmwXHdqAMifkSbR4rY0VHufsurS7skW
	 Hwz90Im0NKVDpwmq7S/iyZcY93sGNpGrKWdAPjHzA6g2bWjOMRpFK02YWFg8Mpl3J3
	 7Gil4ozHLUjgw0NxmBc+4LtbPSo4YwX0w3TzBedmKeUtUsSsAq9BPA/uklsOjL9Q8N
	 MhHD9Y9vLXLSA==
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
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-2-afbc4a835c38@kernel.org>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <20240403-fix-dw-hdmi-kconfig-v1-2-afbc4a835c38@kernel.org>
Subject: Re: (subset) [PATCH 2/7] drm/bridge: dw-hdmi: Make DRM_DW_HDMI
 selectable
Message-Id: <171232258054.9066.6298567481555840770.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 15:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 03 Apr 2024 12:56:20 +0200, Maxime Ripard wrote:
> Commit c0e0f139354c ("drm: Make drivers depends on DRM_DW_HDMI") turned
> select dependencies into depends on ones. However, DRM_DW_HDMI was not
> manually selectable which resulted in no way to enable the drivers that
> were now depending on it.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


