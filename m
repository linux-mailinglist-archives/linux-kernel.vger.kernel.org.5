Return-Path: <linux-kernel+bounces-115520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D756889C20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B51C33BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B323CB93;
	Mon, 25 Mar 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWwG1vxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BB1494B2;
	Sun, 24 Mar 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320973; cv=none; b=TUnKYf4235hiUC0tJi1JQB87bSN7czFlPklvyE/+HtW2M9bvQg/7/yfS7Lf8zre8cLlEy+7MhS0HzzPvGYS42VdLLew713pDFVOBINPeqPsZCTmNkqAg0IgO3lYUOF7meoBVOS+pQJHQZpDlqTlPKNF9frknLpns9QLv45NEDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320973; c=relaxed/simple;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVwOW/bf1wQ4YMcGwywesqtOyuGALi5+N0cqwOW4EfxUlIYoMvEx9fq+ZZwnOnP1Lcsl6FfBw+qx5TS0kWCNG+mRg1coR9ZfNreJSeWz33Vc6qeK4Ahqnuz3+VDjCggY5pWfQ4Th4XZHkRXdrqi1+mJFzHBkwAcj/NxD5qaW2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWwG1vxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF70C43609;
	Sun, 24 Mar 2024 22:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320973;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWwG1vxPwChTraVyU1vlUpFvYpntmxHywL3ZRGuL/ZRw1HDHmn1dWBRsH0OcLNK0h
	 hKs1/isrDRcSf7rJ7d15qMUW/ZwsrliaGTMYh6VJ6PlRFR9KZCxyBXOnRPdsKuAmA5
	 TDHieLWOjHjvK8NW+SHZUWwRNZNK/kpAeCjIUliDcNlzq3kH0E7Jv/WmhtBX/0rpa1
	 NvXI1XBqL/+hlINP3iUWuej2MK3a+jyYmi25TPsma3hChcax1X3KumGq2rvuJA0Sbk
	 H0fjwYfjuqQE2uSP/4T/N/xKZcnIPgQv5RrgPCrfYwOUWQf689rtiUxaG/8TAq260N
	 FAE6br1l1wnEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 536/713] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
Date: Sun, 24 Mar 2024 18:44:22 -0400
Message-ID: <20240324224720.1345309-537-sashal@kernel.org>
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


