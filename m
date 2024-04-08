Return-Path: <linux-kernel+bounces-135614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07189C888
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F61F24A48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F81411E4;
	Mon,  8 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHb3MfgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5B2561F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590829; cv=none; b=YcURRPKC1i0U/MUs0aI420k9Coi0E68xtHnTQQ8sPO+4hY6mu/kW2oclNb654n654b6lOYGUf1Xcuz1vJvGdQzxiGKf1/HECABJ8bkKJM/13PniRKswDStYQPQmlydUkXnl2pbMMN4hFVXsZshDbVxS0l+YOKtz2nkF2qrMsFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590829; c=relaxed/simple;
	bh=PwZ0U9sZzNkD0KaVqwgkszl5WrTAUE7/ASJNm1Q6o/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhlPg++QyAS9VVCegTFNlzVk6/dQoTk1YRCaqJ9OaMl8V/cSLq6laXIP4OEBUXJwAubfTiZAggz7DAH//+FoSpF61gdjf5SMrj4PImCh9E2Um7vv6AhBgIjmhIwYfncDUChLLnek2OiW/aqdnoh4RmeU4h8+riLMBPQAzf9UpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHb3MfgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF580C433F1;
	Mon,  8 Apr 2024 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712590829;
	bh=PwZ0U9sZzNkD0KaVqwgkszl5WrTAUE7/ASJNm1Q6o/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHb3MfgPvwrWQm3k7uMR+X/ZVuy6AsSrHO2oEzZBvIGK3Ara/PXVFf5vvF1Is6oOF
	 IviCPuF7Fl70MR4XKy5vMNLgdAImIvgD+re95FXhRWfRC7jwlicPlh+BlNhAib991h
	 4+lyX/oNPd8QLHoKraUPbcFzJOqk/aldsxrxpifWkatQXWZAhxgXnSgq8iu0UzuoSY
	 YS7Js+fcGyeWmQRQzu+ZAiayDH5soEmiuQHPV0UuWSQMgnb2x8iIjvWjj1C4flJ+R2
	 /DY/IifpBVlR4/nKvJ6PR5sUukdxrRiZ5b4dDG3GHIxUPRGGdrEdKksdIswxUVm8kM
	 nNSLAa/MIlSDg==
From: Robert Foss <rfoss@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>,
	Swapnil Jakhade <sjakhade@cadence.com>
Cc: Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Zhu Wang <wangzhu9@huawei.com>,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Rob Herring <robh@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jyri Sarha <jsarha@ti.com>,
	Yuti Amonkar <yamonkar@cadence.com>,
	Nikhil Devshatwar <nikhil.nd@ti.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
Date: Mon,  8 Apr 2024 17:40:20 +0200
Message-ID: <171259081156.2558005.10286796627234601438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240408125810.21899-1-amishin@t-argos.ru>
References: <20240408125810.21899-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 8 Apr 2024 15:58:10 +0300, Aleksandr Mishin wrote:
> In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate() is
> assigned to mhdp_state->current_mode, and there is a dereference of it in
> drm_mode_set_name(), which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate().
> 
> Fix this bug add a check of mhdp_state->current_mode.
> 
> [...]

Applied, thanks!

[1/1] drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=935a92a1c400



Rob


