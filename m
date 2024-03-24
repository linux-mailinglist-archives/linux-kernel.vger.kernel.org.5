Return-Path: <linux-kernel+bounces-114360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60848889FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C5F1C2874A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A652172BCA;
	Sun, 24 Mar 2024 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lph+8Kzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC87215932;
	Sun, 24 Mar 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321750; cv=none; b=dy26GuBcBTkr7HqvH+8RfactD5kP0v5goO0fb6xS63m1M83MzfBjPBkaoarYVSM8GIKhzAoVNuCE7DFOah9GAGmTq9MPnMhggAbHRAmXsrBMHX3+rGema1o1/W9Xp6HSmRWWjg1rQnEnEVLZYV9Wti37bWPaqlIsEhoE+UmVvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321750; c=relaxed/simple;
	bh=FHiWeRcLfrPVkdYOZ+aErmQGpvRQvlXwkAjYsghwiK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyrZwUz817d4dMvg0S7XSmb2Df5B9pqQWr2dAtxoCVAUneZiK/MgN4002GmoUEzgQhcYc6CGARydZAUc2kXzSjNflzaTzy0cq6AHUyCD27455E/yppUevGCtGkeLLeQAbuPvmej28VLmLiLRcgxGpqNU64ylCp20Mowb71Lqc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lph+8Kzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5DC433C7;
	Sun, 24 Mar 2024 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321749;
	bh=FHiWeRcLfrPVkdYOZ+aErmQGpvRQvlXwkAjYsghwiK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lph+8KzdF57EL+lZOrLzcGnJTgqStAQIkU04oEGj8ODtge6EjcHFG4SMF6tnBiF+/
	 JJFky02dZdNVkIrpc6hn6y4XtjKoip3ibhvj2JuRdCU5qPmNvfLzWi90GYpuXx++vq
	 lwMC4MNi0QAi/CwmXTTg9dVrUo6ybTFwPfMYeO8QtTTclwKLNJzQF/xeGGNIG+GJGk
	 3uh6nW7ae3XBN8o1uh2jml5FbcfCLx5wIbYZoA3FLD5zb2vTPwnRcTdL/vABBJ+ydX
	 1eqs9LmqK6XuUsQrC6YLEpiAoY3l6jx6uYGwbnNg8NMHmvVXlU1N3phTKRCF/uEyXt
	 LJlUM55/887pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 477/638] clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset
Date: Sun, 24 Mar 2024 18:58:34 -0400
Message-ID: <20240324230116.1348576-478-sashal@kernel.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 7d474b43087aa356d714d39870c90d77fc6f1186 ]

The current register offset used for the GCC_UBI0_AXI_ARES reset
seems wrong. Or at least, the downstream driver uses [1] the same
offset which is used for other the GCC_UBI0_*_ARES resets.

Change the code to use the same offset used in the downstream
driver and also specify the reset bit explicitly to use the
same format as the followup entries.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L3773

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index cd15819cdce8b..cc2331d729fb6 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3631,7 +3631,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x26000, 0 },
 	[GCC_TCSR_BCR] = { 0x28000, 0 },
 	[GCC_TLMM_BCR] = { 0x34000, 0 },
-	[GCC_UBI0_AXI_ARES] = { 0x680},
+	[GCC_UBI0_AXI_ARES] = { 0x68010, 0 },
 	[GCC_UBI0_AHB_ARES] = { 0x68010, 1 },
 	[GCC_UBI0_NC_AXI_ARES] = { 0x68010, 2 },
 	[GCC_UBI0_DBG_ARES] = { 0x68010, 3 },
-- 
2.43.0


