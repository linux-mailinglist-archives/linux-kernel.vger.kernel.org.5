Return-Path: <linux-kernel+bounces-113894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA1888732
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CAA2940AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F391ED0C9;
	Sun, 24 Mar 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdzbubYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F531494A1;
	Sun, 24 Mar 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320969; cv=none; b=tQgrS2/OKrUH5tHdQsgY2q2OHacE5zwAUhA/INbjxikFLHykEb8NofNXpYDswFp/3LgEB3wRPOXYK32W9JDd3il+17SzRA6AseCSz+kReL66oDGGSzebVUMafMMCuoUNDju9MZTO2VbfpllGXhPDb1itrDJyolpknDnQa3IQt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320969; c=relaxed/simple;
	bh=uudrhNqYTKl+5oPWr560nyF2+A8KIYZ0yK+KN9k+7a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LscNZvpc24VLFC5g9pVZx8CsjLovaxgEN3wiR67kqParOmuN33Dx4tem18xCCpCYRj22a+EfuWkibq3Lj4ZGxNV7kztkK9K18vlDHlPZz4TFIiOHL6o73YXC1Y3GhwReft1TwNQMPIl6kWdIVXbxXzxrYewzelqRR2ylsw5sRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdzbubYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77806C43390;
	Sun, 24 Mar 2024 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320969;
	bh=uudrhNqYTKl+5oPWr560nyF2+A8KIYZ0yK+KN9k+7a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdzbubYJk3T6kZr398JSBb7FuGdK7Gy58w/+7++M57W9QYWgjiaYjUKETze7qpj62
	 4vWbwJnICV+ZKcIXaxxO1+NP/Q1qVT1u4FauHzk0CMqVg3/cum74XsJAR924A8eP4d
	 rSQxzPortBh4H1ItGpTxfl4Dm++TwNSg4hoOsEtGZBIFnuZ/9dAvuxTr+AKbxCHTuE
	 h3AcTwkIMW9wxYp1Sk6yLmLRE9FFrDQHtlDkd1+BEuPz98Bg3JOGOYouXidnTWSJ0g
	 jxdGvv7596SkzcX4Z0HGk37I8pKXxXEfaxDozPj4y9wAYJrIl7anQSudUvOvFstKVa
	 MrOp3aggtI8kA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 532/713] clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
Date: Sun, 24 Mar 2024 18:44:18 -0400
Message-ID: <20240324224720.1345309-533-sashal@kernel.org>
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
index cef9a1e7c9fdb..5e81cfa77293a 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -2180,7 +2180,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
 };
 
 static struct clk_branch gcc_pcie1_pipe_clk = {
-	.halt_reg = 8,
+	.halt_reg = 0x76018,
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {
-- 
2.43.0


