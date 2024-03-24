Return-Path: <linux-kernel+bounces-114367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE377888A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AEF290713
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E63173D93;
	Sun, 24 Mar 2024 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBv9okLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205921690E;
	Sun, 24 Mar 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321762; cv=none; b=rlnLwI2BzeSCGdFxI4GdHPDK7scQh7kMaWk1vpLyxmaTImM6nH6TbSbpMrUehlDTz8y2Wtc1MiuQEzGr5JtygjHsj9elF2Fbm7eIvULifANXpOoedyuBAn0arh1LwRtt44frOgZaFm/YNTVs6qZo5AkC7DGhGkRB1sKDInrFguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321762; c=relaxed/simple;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4pTazZvhrn5Ewkep7rBDMOJE4XxjWoZNlMq2vXLU9eFGTGl3NIRF2lH2YARwZeri5FzMONsFTInpjY95rgR3lxFVrQv4xKrVl/CM78xje5wrexcLwMfHgLW/WfMzpnMTtdu7YUOGl7DdIe26DGQ3DIzS2OrZU5ZolwYIOv5uTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBv9okLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DC3C43394;
	Sun, 24 Mar 2024 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321761;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBv9okLO0DPvCKj7Gw7P7zOnD3j7C9eEQEZGORPE0jTNVrZFiiGsks9i2oFBIUdu/
	 homhp7H2my5fSnUjUhFjJAMxsF7m8YqoEu9zIY9JDSIZjGs3hyK+VLOY+OKHMFydT7
	 G459w9c4cHOD+R8IX1vaV4wC41RmNPHkNKG0/HuIVfdCNEY6t6574gdWVdvRDCZ3ot
	 C9sacb77d3TxU5V2lrABQuGBG3PkmWLlBEbSOeJb5QicZVqEekpoW/TrHU09MFdFlt
	 D4Jb8K6YvFbsOO2xUhvA96VXfF8PTb9/Y1Z3PcUg0Kiqwn1PxXnUgUwRGuz/EBkgRl
	 psMMnS2qm2r1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 489/638] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:58:46 -0400
Message-ID: <20240324230116.1348576-490-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit 392346827fbe8a7fd573dfb145170d7949f639a6 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-4-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d1a14b0db265b..31f97230ee506 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


