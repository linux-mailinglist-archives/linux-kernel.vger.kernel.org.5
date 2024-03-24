Return-Path: <linux-kernel+bounces-114591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E7888B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B2E2916F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABD629D387;
	Sun, 24 Mar 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7mR1G2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37635232118;
	Sun, 24 Mar 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322257; cv=none; b=qql5cpAwM/4ecmw4An15LLmJ++AXyV/ImmEpPLYghsZl2N7BB6EvUU5ZbNEilKll5xf5nhY2gfs1+U3GrQLZsPfq6F5i9byKMyGAt1RUkT7FIcmiGx3wfGucLmIMtxnfafn7r92TM+AxP5aEz/6Z9p8xHJ2v+CzE1HOeYEqmIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322257; c=relaxed/simple;
	bh=mA/FdB/ILepXOKnaZRIA8fPzJ15qQPq8YcnleMPrszk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4Io1bj0pQRaXIOh+Ql59B5NBwgOkCB4UGXoTeVh5iA2HUeNeUtRTyD8CXnIleFvh66U7SeUqjMbMdhU3exduabsE5P7dyk2nmdRPQj9fsVur2lUcJpkeMvd4T+f409l3RLCSJgf0McON4UxZrBve6Fo/sq2+8rdPXdyBtwT0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7mR1G2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E516C43390;
	Sun, 24 Mar 2024 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322256;
	bh=mA/FdB/ILepXOKnaZRIA8fPzJ15qQPq8YcnleMPrszk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7mR1G2WIGxhl4D6xn0w4BCtur3SUp2hwKeh4FFlN3PKtS0pzz4cPMmMwrr2Q0v/u
	 lDMr0N4NFe2GHX4/S4yA2zitTuXNq6KCwUFzmjBrkuWPYl3Qa6dvIl6bnTD8JqwuV7
	 0ziV0nMLk8dz8RWUbdfXK4oe6bP4EkQ4cUljcCzk8jYVkE0BVquyqz3/OnqKfQiEP6
	 9tNTOtNYPdGNuxKA6do7JKLFiEEr34HNPwA+pDZ1/UDP+0n40q1Pdftge0Ogawd+ZK
	 V/Lk6L/JNeX2GBOVBS2g6X1o+ApN1ZHLlsm73NeHbcUbPH9x4pJ2lw0jjqotsQnkE1
	 tgkPJlnXq2d6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 338/451] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 19:10:14 -0400
Message-ID: <20240324231207.1351418-339-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit ad9aeb0e3aa90ebdad5fabf9c21783740eb95907 ]

The backlight_properties struct should be initialized to zero before
using, otherwise there will be some random values in the struct.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 475f35635bf67..855c275754578 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -339,6 +339,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


