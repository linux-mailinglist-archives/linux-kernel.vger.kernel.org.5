Return-Path: <linux-kernel+bounces-113895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35A888ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4288A1F2B751
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D671ED0F3;
	Sun, 24 Mar 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK5QWpFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16F1494B4;
	Sun, 24 Mar 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320971; cv=none; b=WArPeFe8JZpZoxmIiE6GOBxfJn3xvae0JlOTYlOv0fqLpjBHq1iloEbGLzgpnHlfA0VhUMh0ptThLcTnPZaTmxq4FY/3t6rKUUrBiExcPS5ju5w/ThxfyahpnJiEfLVGsCaLP2pyqS/0moygx7a48pbCozqIKEQAotqXLN/UcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320971; c=relaxed/simple;
	bh=hG24ceIatTC20ZxBsqp5TxfOgfB2eDG8J9pF5Gn0hMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7WEFrGkzD1nHO11es0IbRqlO7Ik8VJnW2WS/E2fznq3xFHphunJ2lxF7/FUzYvC5L+GctpanPvWqcDnC8zcgyNfDiF0BXDp0jjhBjF3RVxvw3pOphCXawe64Ad1c0CFhHi1ZiKAX9D1qYQ9J9Y3DKngSYsIhRzIoNiZG1nAZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK5QWpFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE4C433F1;
	Sun, 24 Mar 2024 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320970;
	bh=hG24ceIatTC20ZxBsqp5TxfOgfB2eDG8J9pF5Gn0hMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fK5QWpFkN8VAqgUk5WaW6M2MZXQtyDRBu7uFhksNwLIMOxNV+BWfvDz8HQQqJa8ol
	 rvHfxMHvdBJsB32EXyPHvn35tdDtvacPm671lPsjq0cU3z7m8YpXXiL7XSTrLNHzNT
	 lH9eONzyCKoaBbFOf5pHzsvKPqxDZGOxSl7aPXiLsgRhIjicSLXI5pHaIfKTaePgAA
	 yb129eXFdVoXXBU+VyV2Me/YW79lBCX9G+7Lf7sEwAWT3jKIQPuQqkAJuPfjAtFJXb
	 2xs2L4z3mbV59gbiTUUkAV5639rqOVyfS8pehqWqNzAANKq8ADe71+lnsgpP9zNzUL
	 FNFdVj28ujzsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 533/713] clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset
Date: Sun, 24 Mar 2024 18:44:19 -0400
Message-ID: <20240324224720.1345309-534-sashal@kernel.org>
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
index 5e81cfa77293a..e2bd54826a4ce 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3632,7 +3632,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
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


