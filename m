Return-Path: <linux-kernel+bounces-114404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2FF888A49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9040B1F233E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42D2762BD;
	Sun, 24 Mar 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBzyL23L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382014B060;
	Sun, 24 Mar 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321813; cv=none; b=uWz0MJAYx9km7BRbndgLRjTCVeIc2zwjeBOQgJq418+8ETv/sR8QW8Q6vJAXggpKnEKCo+Xyp8T4BC2JdWZNdLthIWV8xOhOXyp1rxiUZ9ZHdu5xHs4z8lyN9A/0OWPPBR3YtxZe4+CuOEEjs9Mhp04H3m3hmhozdXBN21sNABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321813; c=relaxed/simple;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brIVVgNjZwbA0bhg6jUKahEoENl/KiaFiiCxJA320QlGlAB9YbIrvpKocR4sb4AK9ZvfCXMrVLAsllhQxRLv9gQV1GWWHXflO3QSy61fxHniihUNAqMp9jCqTPEE2C/1Zl12Ybyg+wQBlUkt6qvOUjB2A0oWn2akNw7+UvHrKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBzyL23L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535A6C4166B;
	Sun, 24 Mar 2024 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321811;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBzyL23LHmQp2/G+uS0BAmENV71gsqDhzQCMvwBoJONjBoPaeC3GLglIslMd8Kq2R
	 9utyS2UwkkqrYG2RmU0MKIu2CxRcyqSvF8+NrUYQiL072LXQvKjTp6qsPNDE/3Nuch
	 WWDCIbZPbhcYSlsNlSNZj0x10n8Z3WNw2xklH7NnN2w+hBgYBMqsWT/J6b3hxV1b2Y
	 N2p0ChEn9XRIinOePIGC3rlLNLGPGdmcgOfaRnNl9RuHIQBjkZXYM7ypoO7pkUtWPq
	 mrHUsQO/rHama1m+l9X+mYyNvxKWtomei67CW9k/ONEoAv9jr4VPlPMgZVYwYc63KY
	 Gkd6HHACOWRnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff LaBundy <jeff@labundy.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 540/638] Input: iqs7222 - add support for IQS7222D v1.1 and v1.2
Date: Sun, 24 Mar 2024 18:59:37 -0400
Message-ID: <20240324230116.1348576-541-sashal@kernel.org>
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

From: Jeff LaBundy <jeff@labundy.com>

[ Upstream commit 992cf65674778e22436807796b2df927de21bb75 ]

The vendor has introduced two new revisions with slightly different
memory maps; update the driver to support them.

Fixes: dd24e202ac72 ("Input: iqs7222 - add support for Azoteq IQS7222D")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/ZelTRYX3fenMQuhF@nixie71
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/iqs7222.c | 112 +++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 36aeeae776110..9ca5a743f19fe 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -620,6 +620,118 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 		},
 	},
+	{
+		.prod_num = IQS7222_PROD_NUM_D,
+		.fw_major = 1,
+		.fw_minor = 2,
+		.touch_link = 1770,
+		.allow_offset = 9,
+		.event_offset = 10,
+		.comms_offset = 11,
+		.reg_grps = {
+			[IQS7222_REG_GRP_STAT] = {
+				.base = IQS7222_SYS_STATUS,
+				.num_row = 1,
+				.num_col = 7,
+			},
+			[IQS7222_REG_GRP_CYCLE] = {
+				.base = 0x8000,
+				.num_row = 7,
+				.num_col = 2,
+			},
+			[IQS7222_REG_GRP_GLBL] = {
+				.base = 0x8700,
+				.num_row = 1,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_BTN] = {
+				.base = 0x9000,
+				.num_row = 14,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_CHAN] = {
+				.base = 0xA000,
+				.num_row = 14,
+				.num_col = 4,
+			},
+			[IQS7222_REG_GRP_FILT] = {
+				.base = 0xAE00,
+				.num_row = 1,
+				.num_col = 2,
+			},
+			[IQS7222_REG_GRP_TPAD] = {
+				.base = 0xB000,
+				.num_row = 1,
+				.num_col = 24,
+			},
+			[IQS7222_REG_GRP_GPIO] = {
+				.base = 0xC000,
+				.num_row = 3,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_SYS] = {
+				.base = IQS7222_SYS_SETUP,
+				.num_row = 1,
+				.num_col = 12,
+			},
+		},
+	},
+	{
+		.prod_num = IQS7222_PROD_NUM_D,
+		.fw_major = 1,
+		.fw_minor = 1,
+		.touch_link = 1774,
+		.allow_offset = 9,
+		.event_offset = 10,
+		.comms_offset = 11,
+		.reg_grps = {
+			[IQS7222_REG_GRP_STAT] = {
+				.base = IQS7222_SYS_STATUS,
+				.num_row = 1,
+				.num_col = 7,
+			},
+			[IQS7222_REG_GRP_CYCLE] = {
+				.base = 0x8000,
+				.num_row = 7,
+				.num_col = 2,
+			},
+			[IQS7222_REG_GRP_GLBL] = {
+				.base = 0x8700,
+				.num_row = 1,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_BTN] = {
+				.base = 0x9000,
+				.num_row = 14,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_CHAN] = {
+				.base = 0xA000,
+				.num_row = 14,
+				.num_col = 4,
+			},
+			[IQS7222_REG_GRP_FILT] = {
+				.base = 0xAE00,
+				.num_row = 1,
+				.num_col = 2,
+			},
+			[IQS7222_REG_GRP_TPAD] = {
+				.base = 0xB000,
+				.num_row = 1,
+				.num_col = 24,
+			},
+			[IQS7222_REG_GRP_GPIO] = {
+				.base = 0xC000,
+				.num_row = 3,
+				.num_col = 3,
+			},
+			[IQS7222_REG_GRP_SYS] = {
+				.base = IQS7222_SYS_SETUP,
+				.num_row = 1,
+				.num_col = 12,
+			},
+		},
+	},
 	{
 		.prod_num = IQS7222_PROD_NUM_D,
 		.fw_major = 0,
-- 
2.43.0


