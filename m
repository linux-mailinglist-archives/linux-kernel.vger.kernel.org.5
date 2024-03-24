Return-Path: <linux-kernel+bounces-114883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AD8891FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D71F2E240
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31112CD507;
	Mon, 25 Mar 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVou3ziR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FF178234;
	Sun, 24 Mar 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323535; cv=none; b=QtPhtSACAC15Y2px5QBvdXrqJr4yKdApTNdyYiWfAQTMaqWvFtVGIA0Zo3hS8ogfo0o9U/hOBBrpdPdgYcW/iLgzfmFsqPn1/M57aINbBs54HYUFogph/LitN0tir91vEClLbB1st2IiiL4v4WaiotaAeOlJEFRnGZIBnVBPLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323535; c=relaxed/simple;
	bh=Y/T1UTQFZUMjgdl++nQhzNbXjoRoJFygBapXnieBu70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3KVX5WkwY84z/ylVbqUiXIWHCMMjdesv9CN0GMbHfuOQbYHpdt28MXDQhbn+JexafPtEQidvxnbt27ja8lUtFXH0rRaTlsQfAwVntIaw181tiwa6kek0Dvs7vL8rXPJCBf4/7CfZj3rUM9T5IwgF8exXV0K3f55OXYdNx6Suwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVou3ziR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD202C433F1;
	Sun, 24 Mar 2024 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323535;
	bh=Y/T1UTQFZUMjgdl++nQhzNbXjoRoJFygBapXnieBu70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVou3ziRwzeFeu8L4kKAAMju8HvhKOC2u3pG20PmNAJuWvMciWbNfk+27cd3CyOTJ
	 R/1Tov6RpRoOBiegBCFl7S+QaFEAMW7SR0Gu+cn8Em+Z6WbQIsAUehzNp5jXVAGBEv
	 MQSVMbsuzpXS0ml5w0mosGCDV+1Ye+hPBEe6karLqV7ujioxjQCb1ct9M6gsgXRVCo
	 59E6CYuA0iZvN9qG1zVHeNlbbKYgAFXZdwGJtIv/jWSRQQ1H6Gd+C4MRF2jSOYLSUK
	 nDxsPbbe5RDPSCsQ2lw1fumYRgotVePjAu7zatJSI1X5MxPTyV+9Wu/t62dIe7rkdI
	 nmY+9EIeW73oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 243/317] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 19:33:43 -0400
Message-ID: <20240324233458.1352854-244-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index e8b185bb6f5ee..371c633f1e629 100644
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


