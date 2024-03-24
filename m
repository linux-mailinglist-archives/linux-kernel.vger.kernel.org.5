Return-Path: <linux-kernel+bounces-115541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6F889C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE772E1FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09711248EFC;
	Mon, 25 Mar 2024 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dst1og2e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081A1EF7DC;
	Sun, 24 Mar 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321035; cv=none; b=iUAeKeXmPvHXITBraWgfdefrzp+AiTL75qnpIs1GbZR2SX/TsQ57kGiZdy1WGs9WYM4+C+Uox5n993V7ZNQ3j0yfJqbh99ZMogMvDeZglgc3NOFCrK03K9f7I/MgMDOaHCMXDNh6DHdGjSWQjADtUvbO4n1YH9gO0lgNhsL4jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321035; c=relaxed/simple;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsSkgprLlF6MCZnFlIPt40874sRnz4of1ZuBAYi8+3DOkGsLXJWVQs1lcXPed9kPVcv/I2HKTvHLIT+tQubMPxIM4mtoji169SjylbBu8GgS/D8GWvnUcvAkEInBy6IoMldgwSSb0xLEcpKX40t+WiyngdbxX3IW/PWQnCAHblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dst1og2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F5C433A6;
	Sun, 24 Mar 2024 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321035;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dst1og2ebcPqA/E37s9NjrzsuV46tE8zY1nGulmStIgzi8yJrILX81xot5Eed5T97
	 hp4KgFVZglgIepLmvWtHZDkwmFNV3eGwrACbv3aAUVGic/c7oKtAB4z3lYLUbMtm4b
	 yDUP0DhAr9TR47g89wU7BXP5OPSg188LXAWssXFJbZRdd6k1u4aws4CAC96Ong4BZW
	 So3rcEroGgnrp+YvgbLZWySV+fp5X0de8OoHWCmaZs+4zGnTWoZtytEt5cjgBbl+Xb
	 SR4gCAxJgO7yoksLF+2nQpMBf7TK04SK/9O7676b3bxUeTwMKizq05fkcrq/m1BJ6a
	 zlLD4f34AwgJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff LaBundy <jeff@labundy.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 598/713] Input: iqs7222 - add support for IQS7222D v1.1 and v1.2
Date: Sun, 24 Mar 2024 18:45:24 -0400
Message-ID: <20240324224720.1345309-599-sashal@kernel.org>
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


