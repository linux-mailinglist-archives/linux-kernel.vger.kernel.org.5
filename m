Return-Path: <linux-kernel+bounces-113394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA3E8883FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B964628488E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE71A2F56;
	Sun, 24 Mar 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZmIXNyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0F6F07D;
	Sun, 24 Mar 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320195; cv=none; b=hMwoyAR2LO6qBib0jdY5MHwNc3ySBMBzBuEy9px9GgFthrewF0npEbvjztNlW/SMh/pHzlXkn840BdUYoK5yR4kRcRWNnUdDvxMCh4zByQEdCdgLVnkfHfBaX0GoUWbR2nYIklkYQJP9qp/GgOXAyzWsha02SlmQtwcfnwPiLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320195; c=relaxed/simple;
	bh=K7s6iZDEqBncdjY4M9PX3Elscxa3YIEsRcGyrG/j8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rabJZDwk6gjYrNjr9m1cdGWHHouNogfUhc+9Vpg3iqpfEUHCkBVza3+ZDDJbYmOCOo8lgn4Ji/dDXrwhre0UjyCPP95KVAMyWj5xG8cjDfaejoNReWs1Ixwk6RStvmfKZDvfs6UgaS0n4XW1KzkOID/XIumXbKVp55WsSLQpmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZmIXNyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D3C433A6;
	Sun, 24 Mar 2024 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320195;
	bh=K7s6iZDEqBncdjY4M9PX3Elscxa3YIEsRcGyrG/j8L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZmIXNyPdBBERgUn7BXjpDYo3xnvyrSLFdRHtjdcQZYiM6GHD1DmJJ4xeuiCWsUVj
	 8BaqLo3d7YsUW1zF1Ru0oSwPWaZwX9g9C2BYwUntcLJCFg+qnFzhax+6AEV+shCgOb
	 5WByUPOraYhYhOXdwlgt0Y12OZGzZrudUu/XFBWaj4OHoF3kQAskyDOprsJBZwmlGk
	 w1HAcsL9WyVTPVCde+t0jbE4NAP0+6mJDr2NjwATf8zB/AIRjDe+PJpba+M2viITZd
	 FQ3b/LxrHPDBn+UFc6wRZcYYqU3MoXMURZnPB5DRleq4cXysnKbSQqEXhgmKuMMdUx
	 R3O1r5muORlMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 503/715] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
Date: Sun, 24 Mar 2024 18:31:22 -0400
Message-ID: <20240324223455.1342824-504-sashal@kernel.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit f982adcc1b1c02a3114f68ac73c811cbfabe90fa ]

The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
clock definition seems wrong as it is greater than the
'max_register' value defined in the regmap configuration.
Additionally, all other gmac specific branch clock definitions
within the driver uses the same value both for the 'enable_reg'
and for the 'halt_reg' fields.

Due to the lack of documentation the correct value is not known.
Looking into the downstream driver does not help either, as that
uses the same (presumably wrong) value [1].

Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
to use the value from the 'halt_reg' field so it follows the pattern
used in other gmac clock definitions. The change is based on the
assumption that the register layout of this clock is the same
as the other gmac clocks.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 4aba47e8700d2..cef9a1e7c9fdb 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -1754,7 +1754,7 @@ static struct clk_branch gcc_gmac0_sys_clk = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {
-		.enable_reg = 0x683190,
+		.enable_reg = 0x68190,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_gmac0_sys_clk",
-- 
2.43.0


