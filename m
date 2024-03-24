Return-Path: <linux-kernel+bounces-115526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB55889C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C6AB30B35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5A23FE6E;
	Mon, 25 Mar 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVzgh4LE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0912B165;
	Sun, 24 Mar 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320979; cv=none; b=Jwmc44msIzXra5qyvI6qoXx6NcNRj+0y+DMGlizyot1rj7GzhtX46CgnaG8JJFOLJ63ZVbMpOSFz3fgarYW+grJOS2LSiOvBHg7L/Fy4CXW7gxp1N1itCbORQ9I0VHtvD8pSHymbxMLHzBNXzlguUL+YrfLVlV1p7xG+jvcTQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320979; c=relaxed/simple;
	bh=Oss6bjUsKm5GZpOQgtk0CjUeQx721nGleVe/HKBy+JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT4bKYRNAhY5+tq20l5lYzw2n9RE0MbNK3sC/MZdEEDLoklrKUGGZ/MhwRsxUqtmU43VkglqfZqha0qMopF487m10tpVgtN9SckzsFTlXEJL4FOL9dcOJSFDSdTGfC4wxVkhbzY/NyWgYceIG9uOsrCOX8C6CkqzrZsDS9RF2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVzgh4LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4732EC433F1;
	Sun, 24 Mar 2024 22:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320979;
	bh=Oss6bjUsKm5GZpOQgtk0CjUeQx721nGleVe/HKBy+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVzgh4LE7GDOBtMNueYY8UIM+VVIN7xE3fU4+UwGp00y2sInTpzoSLNiygiQLxER2
	 ZIUcVzKk+8IlVSFtUeIHGFSsJoSZiOjgirmamajO2G4W9e0RsY84lrgGnsOZ5tbU83
	 0KRqPfARBv35Q7VhHouvaqo5MbidIfS0rs/6GnnYm0ZX4PSZOqvkTcb52T0UNCv1l8
	 wcrVpFDoYUtBmbUBJAShiWMyBTyjbxS4O+KeUuSYAPRunxWmhwdvZEH/AoGqcGkc3N
	 2LLZb2hiQRkOQMrQkPRMRBUv07BpYb1GaVFGHiwWzaHJtqoiHiNi7xAPFyRJf7HbjQ
	 4pKGakkMFGhbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 542/713] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 18:44:28 -0400
Message-ID: <20240324224720.1345309-543-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 8fcb62be597b8..2e2240b278482 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -343,6 +343,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


