Return-Path: <linux-kernel+bounces-28768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7E8302D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D761F236BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809D14276;
	Wed, 17 Jan 2024 09:52:23 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDA1426E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485143; cv=none; b=UXSfNav65GU9aN5XSwz5E8y4VBfQb4aXyQU7QHYPBpjEny7rR9Uk5RsJ4GVPzePQaQBAS2YCTqcePaO6hvy4TMyIot6Xnf8b6/9vhBdnJw2ktlkDNwtArUn2aHX68gQlDQIhzalaoQAeOwXT39nSEQT5qA4HU/kv91IirNrjncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485143; c=relaxed/simple;
	bh=a0voOYbt1IzxAQ/bf3kPxdBL1u9I41DQqbrFxRE+vsI=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=k/+sxCnPLhXLgHsy65+g4GC+pphVUuXYw8c2E6FcipDjF5wCDyZm8U9RTtjsEArBlyvgJzl/i75zt94l6LbKW/i8UpPz6BJnJSEDBK9nnidzaqqfA1ZIV7GPnCWiWA8OPWq/ZRxi/OROa+9Zg8vqImkZ2nzpRzynvonSCcB+SKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rQ2ab-0006Am-SJ; Wed, 17 Jan 2024 10:52:05 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Bee <knaerzche@gmail.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject:
 Re: (subset) [PATCH] drm/rockchip: inno_hdmi: Explicitly include drm_atomic.h
Date: Wed, 17 Jan 2024 10:52:04 +0100
Message-ID: <3186012.MsWZr2WtbB@diego>
In-Reply-To: <170548481754.96553.11502916321137598260.b4-ty@kernel.org>
References:
 <20240115092434.41695-2-knaerzche@gmail.com>
 <170548481754.96553.11502916321137598260.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maxime,

Am Mittwoch, 17. Januar 2024, 10:46:57 CET schrieb Maxime Ripard:
> On Mon, 15 Jan 2024 10:24:35 +0100, Alex Bee wrote:
> > Commit d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
> > started using drm_atomic_get_new_connector_state and
> > drm_atomic_get_new_crtc_state which are defined in drm_atomic.h
> > Building does currently only work if CONFIG_OF and CONFIG_DRM_PANEL_BRIDGE
> > are enabled since this will include drm_atomic.h via drm_bridge.h (see
> > drm_of.h).
> > 
> > [...]
> 
> Applied to drm/drm-misc (drm-misc-next).

wouldn't have drm-misc-next-fixes been more appropriate?
Because I _think_ the change causing the issue made it in during the
current merge-window?

Heiko



