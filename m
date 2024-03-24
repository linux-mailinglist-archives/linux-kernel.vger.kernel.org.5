Return-Path: <linux-kernel+bounces-113406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14B888412
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E991F2475F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7221A5946;
	Sun, 24 Mar 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9Mz+fMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFED1A592A;
	Sun, 24 Mar 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320208; cv=none; b=BgSHmZVvZHCV+JnnAhlhwKZUU/c4PhnXquuLsOQ13vXl/a/AoKnWbuw+lneT3xA/bqb+ZcJfEEpA81J770ysemFakA8wh+ZSYw/5OLk/+VcGrPIWd7SEGvmhb7pzYUFQ1dkXU7lDhxqTMhPIABcNG4mFT0sQys68g+kzEPQoNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320208; c=relaxed/simple;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGnOiN3n7Bx6QdlODnPVMLS9CceY7oXyda/D6cFyfRdwWATg8SYoN+Op0dL5kiRWarW00SqiJii4TC9DTnFYaeJPNFfCm+f58c/L+NlaMc/EmvtcHJL96c08izZrZxviP/2KY6LafoGVRWGoRoO6muc4vYoapr1XbbXJlyivLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9Mz+fMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BF9C433C7;
	Sun, 24 Mar 2024 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320208;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9Mz+fMaIu7MEipCEaRI5fM+35IYjjNJQ0JXMcqCgPBbq88+Op/leIalI5lW4qY9J
	 hWirp1V2FPBPIw164qcS/+ViSRt8d7+p1iSD5Y/7BeuxZ28wpnOVe5uCvNnVMR5r+2
	 Cu6bj8qq4R+QBklCvz0dMg+FfpoMXUFZ48HcWjKwlR/8YOfNF4424UgORmoYp7Dp/3
	 UftzEmsODRaenbQ14kKGFEsNZrIxb9WMbhXYYkqn43aM8dbCA3UKGOVJzfXfizz4ns
	 5k+ulPuQDRxB+ewdXoS3ebdrNdQSM93eewrI5l9jr1cw/NiLoUpUKt8fVj9cx0Vgx/
	 tKj4mh1GxDJlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 515/715] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
Date: Sun, 24 Mar 2024 18:31:34 -0400
Message-ID: <20240324223455.1342824-516-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 78334c343bef528b911da83a6b041d15a1a72efb ]

Two regs have wrong values in existing fields, change them to match
the datasheet.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240301101547.2136948-1-mstrozek@opensource.cirrus.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 73c88ee6a866c..1cea3f8f467d4 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -84,7 +84,7 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_DRV_CTRL_5,				0x136C00C0 },
 	{ CS42L43_GPIO_CTRL1,				0x00000707 },
 	{ CS42L43_GPIO_CTRL2,				0x00000000 },
-	{ CS42L43_GPIO_FN_SEL,				0x00000000 },
+	{ CS42L43_GPIO_FN_SEL,				0x00000004 },
 	{ CS42L43_MCLK_SRC_SEL,				0x00000000 },
 	{ CS42L43_SAMPLE_RATE1,				0x00000003 },
 	{ CS42L43_SAMPLE_RATE2,				0x00000003 },
@@ -217,7 +217,7 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_CTRL_REG,				0x00000006 },
 	{ CS42L43_FDIV_FRAC,				0x40000000 },
 	{ CS42L43_CAL_RATIO,				0x00000080 },
-	{ CS42L43_SPI_CLK_CONFIG1,			0x00000000 },
+	{ CS42L43_SPI_CLK_CONFIG1,			0x00000001 },
 	{ CS42L43_SPI_CONFIG1,				0x00000000 },
 	{ CS42L43_SPI_CONFIG2,				0x00000000 },
 	{ CS42L43_SPI_CONFIG3,				0x00000001 },
-- 
2.43.0


