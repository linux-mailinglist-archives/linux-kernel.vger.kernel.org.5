Return-Path: <linux-kernel+bounces-35226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB1838E18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDA1C22DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341E5D91A;
	Tue, 23 Jan 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT02Oqjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF325C908
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011375; cv=none; b=QETsYP1xmwr6LUluRJJuriJkoSLSPbp+RCRnJdLv+06wEGAUK14uggZGuvNA9gDSx+tulxRos0mP6JhCbkt+jiVnGzWwiNU8DBLRRBSph5HG8BXFPztR1rBS2EtIxcg7DOg5M3Av7yekXUHqXy1/CX/Fa49Wlw8+JKsuxVNt5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011375; c=relaxed/simple;
	bh=jSyQomysxmQFF4FXTse/TNYzaMJ3yJzv3a0uIbVl41M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tQ0MXcMCmUsuoyyZVEZb8UL/+n3UFMouYNU4pxyY1wkZJ3Tn7GIVxBtIeGUTd01E7zawODz3mjKdQvWV+prUezxwUf803S4PLJp+PU8Z3pzEGg/B4R4Oed3qWAT5+BTnCVoDy09qQ06qrKJeghHdDQ64WVB4giDXFTt9fTngUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT02Oqjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A8C433C7;
	Tue, 23 Jan 2024 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706011374;
	bh=jSyQomysxmQFF4FXTse/TNYzaMJ3yJzv3a0uIbVl41M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kT02OqjhhG1/NwWPCLLshXa8KKtIlwuflvNINLEJBipf5QXDaj6ENlsvI4WKbVdWe
	 3ZLTF7g4vwKD1BxDNclqCRzJ9FPeTR/eZjN0/g1gMsASq3zFxn5sybVXPs6tUmrZPZ
	 R7rFwRLQ5apGqfurFCq/+sDBWYPaSDJrU3sHYsdXfUd7AEzCEki2pxjyvARNLsV0K2
	 HjNG5ELF4iy6Ol6E/oSF9O7hY5xcu2ZmmJaymkmB/znTVQDDm1awzhHcwgq1D0ideY
	 VHKhyHbkKOGjnsS6U4FfMpiYgj1hoN6FZhc4KJcnpOLFpVob+NAxNPcnXK80+4/YXI
	 jQB8seas42Ppw==
From: Robert Foss <rfoss@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, Thomas Zimmermann <tzimmermann@suse.de>,
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Peter Rosin <peda@axentia.se>, Andrzej Hajda <andrzej.hajda@intel.com>, Linus Walleij <linus.walleij@linaro.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maxime Ripard <mripard@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Jyri Sarha <jsarha@ti.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
References: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
Subject: Re: [PATCH 0/2] drm/bridge: sii902x: Crash fixes
Message-Id: <170601136965.3255303.18345118012936200208.b4-ty@kernel.org>
Date: Tue, 23 Jan 2024 13:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Wed, 03 Jan 2024 15:31:06 +0200, Tomi Valkeinen wrote:
> Two small fixes to sii902x for crashes.
> 
> 

Applied, thanks!

[1/2] drm/bridge: sii902x: Fix probing race issue
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dffdfb8f5de1
[2/2] drm/bridge: sii902x: Fix audio codec unregistration
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bc77bde2d3f0



Rob


