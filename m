Return-Path: <linux-kernel+bounces-113481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6188884A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D928978E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D61B5DBA;
	Sun, 24 Mar 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzPCSozY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB721B5DA0;
	Sun, 24 Mar 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320282; cv=none; b=kKZWDPGlDuqoYvFmPsG70hf6iF7hsYCsAesjr5GmZb8FPfpQSheuz5ysoHxYAEc1lFHjEPQGtc46c2b/ggSr2luQF9rQ7niIbYXNY4s+7Xvbx4VBETDqQ6bvCA79FZ+lDv/QEVpVkwofuewqT6MBQcJkqj2eeQzZzg8ESaJgUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320282; c=relaxed/simple;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHp/cHL8M9hxx9LSCoA6NuopmuZJ2lB0wBfOnqTw1LaZ14YR2XSMjQkcePUg7mqrj0tOJfOECFD+xZf5K4av7wjpYI+dc8lZxvTMrpC7tL90uxeNnj7UWMociyOFDDYXDiOVCuzs8A9YeiqaJsqmAvzhfilwpUDBCXWSMItFOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzPCSozY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1ADC433C7;
	Sun, 24 Mar 2024 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320282;
	bh=yUS06+jBKCnlD25vjcbgsGFLnvBZQdDnVaI/PR/gXtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzPCSozY71BQJlpL3TIsmzaCpvMDHiYAk7jFA/+hEE7fBBUmoHqBCuAEDyQLtIEFd
	 pF2jqOdhP4nO8RRqrPr2QwGsFjASnKPx/25RYjCnSRkfPkyyC7fJpfJ1JHUPZOhBdv
	 6quphhHAihgjZgQO5lMAYMNCcrOcIXeI6EisbeWqnAuM4Zndz2iKw2e1skDAfw5LNd
	 qh5IN2ONzg98hYOJ6wsS6W7UyQntwOwgrCn9C0QhEBNlWg4BQPnFKDTy8i1xNZGL0B
	 pwYU7+tJ1VBTkq+TLc2f6GJbVtA5dDW1uq58ubGlP7wnkBIzYFyL1clKs6aIbd4xoG
	 F5RkvowDyAfXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff LaBundy <jeff@labundy.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 590/715] Input: iqs7222 - add support for IQS7222D v1.1 and v1.2
Date: Sun, 24 Mar 2024 18:32:49 -0400
Message-ID: <20240324223455.1342824-591-sashal@kernel.org>
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


