Return-Path: <linux-kernel+bounces-114363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC18888A07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9822905B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400926E5F4;
	Sun, 24 Mar 2024 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogJWB4kF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778C21616C;
	Sun, 24 Mar 2024 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321758; cv=none; b=Ut15Ev6aoYfIG65r1ntmt0CfYZ/5k0E+O9yCzDUv6VSXxFxEbPsS73vqy2lwnGqqpXXptg3tK8fzK1mBreEAFp50J3XKDxBru6wE0L1YJW3eK7DWrWrKBy+e8pLMoHEV1G0lejzTXJrTQPA4q7WYH7KNGGykw/YCw839gyZA+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321758; c=relaxed/simple;
	bh=Oss6bjUsKm5GZpOQgtk0CjUeQx721nGleVe/HKBy+JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBfFSjYrONXkj3gYMkvtd/YjmghVnMLYbltsOlVnjGXIbVGRIxrNQBNKU95eGb1KPmzrITWbcUUYoMZd2T8ReHUJfbmQiyVOXYVe/u1jZ350rLjNu95/1OOtjTpYfysvOFK4nP77wiRqtdbWpFC/ap074miGKaDZ+r/1JuNlOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogJWB4kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5126C43390;
	Sun, 24 Mar 2024 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321757;
	bh=Oss6bjUsKm5GZpOQgtk0CjUeQx721nGleVe/HKBy+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogJWB4kFAQ5mvoPbAhXbhShkFB0uwqn03dNUiuPGX//3zQywn9G4dTEHdHxDZL01N
	 NwqgZQWQV4A/VFEUfj71I9R75MNqDDpgGM1Mvc4ow5u4ZFocmE/WoUPVH+U5zz47kY
	 vjMApK2q5UiXpzRrEDOVCGSfDsYwrIOkr/2HD3KRC4l94jitwYGKKjo/+TzSYaUYth
	 i25vCUBaUc5Wd5zMcndSKTvbdmGIdXkCfNpZptCxE1P7Q/1hX7PvRsiw8TEPN9510u
	 LDuOXZ24aAZ5OQ8YU9SIUdzYOluL/LlgC+FDqvIcNjlXoq5HG7xokCp1fbBfLPgvTo
	 oegNYfRRYhCdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 485/638] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 18:58:42 -0400
Message-ID: <20240324230116.1348576-486-sashal@kernel.org>
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


