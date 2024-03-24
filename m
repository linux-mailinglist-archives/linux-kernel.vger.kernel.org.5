Return-Path: <linux-kernel+bounces-114359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F9888FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3466C2903FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94826D9D7;
	Sun, 24 Mar 2024 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/crmq97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE70215921;
	Sun, 24 Mar 2024 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321749; cv=none; b=B9oe043u9yaWwHIlVwynLE9cEYZJ0PVzfR5xu+Q7pIymbgSugDp9ZfaEjGcOoBT8PWcxP2KXGjmliNYl4277KLLmgFi4m+bCTfTGKJbnU4ushZuuPmVzanXP5XFGCS8n5KiPdRr789CH6Y5HxVDOyL+GW16N/C+tpkKEnrMnwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321749; c=relaxed/simple;
	bh=wmy064nOM2YSIWgVWW0lJkqy0LIKv+O0CcMtr46fkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH6cDHbFCQDc5Dj5l2JHlm8/uztRdi+2mb/ixGXkLQGithwSOGRuCF68klphGEV4x7TQBBh5uJhPb9JSJYrUWz7xyQb7jyAL57MXKoGbJNvYRzCccOtj8MWFmFSxt0M61baAa5ZU5oLMya3vAHBLVbDUg5gPm5LMCtZkDZyFPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/crmq97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5ECC43390;
	Sun, 24 Mar 2024 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321748;
	bh=wmy064nOM2YSIWgVWW0lJkqy0LIKv+O0CcMtr46fkOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/crmq97YFNFX/SgZgTX9FddIflHmpsfmDbz2hPD9NLWbcf6XzQ8qhrFPbU51EGOi
	 GXXmQVL8pQHaSsXUi+fcCLQ9WCu8x5pRa03k49hGxZitCJ1OvE0wAJHscqLVyrVz4j
	 TOBr6gr6C8ZXCX54QDrgQGYCuzsV8PjhlGl/y7X+A4xL+/lZjUqMNcp3MAkGJ1rwMj
	 BiOwumarqkC78EgBseicEUcDxa/16mPsXwuDo4zDQX0iZa7uZ/RYB1N8LNAapWe3gj
	 4LoLi9FRwQJ9wHe8O72Jv/ha4HmAsMjwj0NqBgtcnCuLDMrr03XHRIa6k3wwYZMqiY
	 JAfGSaouVPeYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 476/638] clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
Date: Sun, 24 Mar 2024 18:58:33 -0400
Message-ID: <20240324230116.1348576-477-sashal@kernel.org>
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

[ Upstream commit 11b752ac5a07cbfd95592fac5237a02f45662926 ]

The following table shows the values of the 'halt_reg' and the
'enable_reg' fields from the pcie clocks defined in the current
driver:

  clock                        halt_reg    enable_reg

  gcc_pcie0_ahb_clk            0x75010     0x75010
  gcc_pcie0_aux_clk            0x75014     0x75014
  gcc_pcie0_axi_m_clk          0x75008     0x75008
  gcc_pcie0_axi_s_bridge_clk   0x75048     0x75048
  gcc_pcie0_axi_s_clk          0x7500c     0x7500c
  gcc_pcie0_pipe_clk           0x75018     0x75018

  gcc_pcie1_ahb_clk            0x76010     0x76010
  gcc_pcie1_aux_clk            0x76014     0x76014
  gcc_pcie1_axi_m_clk          0x76008     0x76008
  gcc_pcie1_axi_s_bridge_clk   0x76048     0x76048
  gcc_pcie1_axi_s_clk          0x7600c     0x7600c
  gcc_pcie1_pipe_clk                 8*    0x76018

Based on the table, it is quite likely that the pcie0 and the pci1
clocks are using the same register layout, however it seems that
the value of the 'halt_reg' field in the 'gcc_pcie1_pipe_clk' clock
is wrong.

In the downstream driver [1], the same '0x76018' value is used for
both the 'halt_reg' and for the 'enable_reg' fields of the
'gcc_pcie1_pipe_clk' clock.

Update the current driver to use the same value used downstream as
probably that is the correct value.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L2316

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/20240225-gcc-ipq5018-register-fixes-v1-2-3c191404d9f0@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 72484a44a8219..cd15819cdce8b 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -2179,7 +2179,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
 };
 
 static struct clk_branch gcc_pcie1_pipe_clk = {
-	.halt_reg = 8,
+	.halt_reg = 0x76018,
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {
-- 
2.43.0


