Return-Path: <linux-kernel+bounces-115113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CC888F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A08B2BC47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A91C634B;
	Mon, 25 Mar 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYCDEdy+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F218147F;
	Sun, 24 Mar 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324107; cv=none; b=ZUiUl4uMFTsEI1LezNQ+YvRxmYNzGI5Cgarl41YDwiqgIyvPTOaCuP/y6E/pTzyoWhXMML7MlCgn5/l21F1UcfviRZAVUQ2ZMaj0uitizRxwUSNQF6kYgxQg6AzaqM6nXDnSm3eBNDxV588mDhXofgcRCbYvAs8xewjDsAnUf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324107; c=relaxed/simple;
	bh=iHOmPupuYN1u4C6Wff80pv7Gaw7k94/ErZJbEesHVgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr+CD1cOVRMXjboBSBeDvrb4sd0AvNFNJOMUs5iIn9NvK6/pFrbgDAXLc4BZwy6hfTxyD21Uc0GIjMw98JX7bUAFvMfb82KhsCSXFesl3APSvuyMQnenbgU2QylWVsJOlaNBx0zi/sZyyQrVQmXFYPFcOuwFYmgyoZYg+12qIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYCDEdy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96498C433F1;
	Sun, 24 Mar 2024 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324106;
	bh=iHOmPupuYN1u4C6Wff80pv7Gaw7k94/ErZJbEesHVgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYCDEdy+DAaVIVgVL8WTyEobvANwV1Q0wxd7X/PO7655XKYLyCsZGjXqp8Wiqo3JF
	 1SYnzxUXwQPG99/PmTBgMPrEwlFxdUzuFKuDPNgXujc/Oxu25zSz53vA4lBpOazH/o
	 q4sLXysqKbGCrnZ2yyPb1aAoauPqurWi6HuzMZ4XmZHi0yJsCzQbc6eGryZ98H/3v4
	 q0Cfe6Bte599jg/03pcZjKlgRFuGM0tdHobyhgSJ6trhmT7ILtj0pluG+sW8yzCZOM
	 XpthUfdOhGAcUVI64REgutgYJi4SHyp/czYdxNENyvMZtI/W0Ty6slCgWZN/4bUthJ
	 ihbBoR9mGueYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/183] clk: qcom: reset: Allow specifying custom reset delay
Date: Sun, 24 Mar 2024 19:45:18 -0400
Message-ID: <20240324234638.1355609-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

[ Upstream commit 2cb8a39b6781ea23accd1fa93b3ad000d0948aec ]

The amount of time required between asserting and deasserting the reset
signal can vary depending on the involved hardware component. Sometimes
1 us might not be enough and a larger delay is necessary to conform to
the specifications.

Usually this is worked around in the consuming drivers, by replacing
reset_control_reset() with a sequence of reset_control_assert(), waiting
for a custom delay, followed by reset_control_deassert().

However, in some cases the driver making use of the reset is generic and
can be used with different reset controllers. In this case the reset
time requirement is better handled directly by the reset controller
driver.

Make this possible by adding an "udelay" field to the qcom_reset_map
that allows setting a different reset delay (in microseconds).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20220706134132.3623415-4-stephan.gerhold@kernkonzept.com
Stable-dep-of: 2f8cf2c3f3e3 ("clk: qcom: reset: Ensure write completion on reset de/assertion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 4 +++-
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194be8f7b..2a16adb572d2b 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,8 +13,10 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
 	rcdev->ops->assert(rcdev, id);
-	udelay(1);
+	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e282c77..b8c113582072b 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -11,6 +11,7 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	u8 udelay;
 };
 
 struct regmap;
-- 
2.43.0


