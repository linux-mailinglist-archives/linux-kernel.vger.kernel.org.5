Return-Path: <linux-kernel+bounces-114357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB338889FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1AA1C25C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D172BBC;
	Sun, 24 Mar 2024 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Do2yvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8C13BACA;
	Sun, 24 Mar 2024 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321754; cv=none; b=JZBuvCfZ5K9ELkhPfR1Qe2GRFrX6Wkheen2mIvlPVIia5/rA9Ve/A2ObXDgZelQOLMwbyYaScw9SZnHmykIT6zEdK3Vbcr/WyZOLQYXZeU6Fnog3e0HTjHzBSKL/7jTUIhYUmKSeivrn9X8LtRIBmCIsy3hkF1wGQ34SLv4fzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321754; c=relaxed/simple;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNxtfe/jHQZuM/eoRx4wFC3ZcneJ4DzaSLXhFiC4z1AfR0UuQRCdzPqRTazTG8nSAbnT/eD3WiuA6B9iCFJdJDsXc/q22fu3xkNDakliFuroi06HPjI6mcyhibbvLZAQYM/VxxZy8nyqQNqmepaq5U6wwpDceO50Nv+aMrjbccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Do2yvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8BFC433C7;
	Sun, 24 Mar 2024 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321752;
	bh=FfAkLR82zNo8vXgN3x469UcnQzAZ56OYmk6OGgnHwmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7Do2yvwhhmHdhwje7PFFXI4GJu4z1yNAYCHDAXCCeYCcQOdpfTmeQNEZDPdXz+yv
	 4/SkmAJcn2V61c7/Fccw1dXj+1y0Xx3ISKKsqB3HWPTYR9cm3kF1myX3dZN7BXDf41
	 km9QjB0TR1NALQZWb6MmKUX2mvk6A/xniE6s+ykETdH+p76m8WPiPktnioP5kkku9r
	 uhkzllsqDBw68rsTjOyWzSkoQu8ihhSYcnwYFzqpPSgXVZe0/7aOoP/Y3/1qQnqdV+
	 EQkA8aDaIUgs8vjgR06U6GDXK3DqlSlFuE9RMxQjPC9nrFBR2Ay/rZXJM9YGtyoXaZ
	 PqkhDfZY1N4GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 480/638] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
Date: Sun, 24 Mar 2024 18:58:37 -0400
Message-ID: <20240324230116.1348576-481-sashal@kernel.org>
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


