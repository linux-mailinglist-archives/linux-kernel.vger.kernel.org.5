Return-Path: <linux-kernel+bounces-115239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930A888F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C684B27584
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AA313699;
	Mon, 25 Mar 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFFnNuEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C8184EFD;
	Sun, 24 Mar 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324338; cv=none; b=QCAFiBrUYKco5JXfRPH3MAdYndy975PiWP2bkgZ9JhCCmdhuNQ/10DeHYVgS9d2x/tT+wBmbnHzNoByx84ctUd22uCl1Hk4Tr4UVcIU/uAKZK3aj/nHqgAwa4DekyvBNUM51pvn4CpY7RYrEr1vJnoDSTdj68d6g1lOsYNkfhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324338; c=relaxed/simple;
	bh=KgzdISlknt7VdZFatRB38/qjLQ9kXZXtbuQfpsc4PfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBCyS/3l4i7ndCe6oyqSpGo1/OPHrGmU1zOCrI2Ok+WsFTJnWMev3f8CAQdx8CdKG+aREGdo5m8M7T7MzBqaKkQtox3KK4t4X15jXkOhOC7F++IFaQdkyck2uyyMGdx5sUbbaHLWaf3ar9enBsTjYEAGb4NKi19mwbb2NtVAZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFFnNuEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7E4C43390;
	Sun, 24 Mar 2024 23:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324337;
	bh=KgzdISlknt7VdZFatRB38/qjLQ9kXZXtbuQfpsc4PfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFFnNuEWf0rv+qBOBDV1q9xKufZJ+cnDSVVGPZ1H3K9CK4Si2SgLBIc36aC6zA9nX
	 K6GjCnd32oSbCZcoRtaOk4p+6kIjLpbrCR+lq8gg2c21mnD+or7KLtqoBM/vztPAjR
	 yJ+YrIvwaAT4nvhlCI1vdg24M+7tPmstzGugbKqboH8IKphJRMDPIxExzkWgWBMHU+
	 veHzkSheTzXF+BZqgjpf35PJ5Sx2uyDtimTyQloFppg1AuOpcfvdqZ2cb+hz37idLA
	 yx++ceM0vmeEvGB2P1iqZcGiuzJHYQH4R/8LMcuodsBxYN22e8GW1u7B117papZxt6
	 U7g2IvsPj6brw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 107/148] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 19:49:31 -0400
Message-ID: <20240324235012.1356413-108-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 74e39f526d95c0c119ada1874871ee328c59fbee ]

The gates are stored in 'hi3519_gate_clks', not 'hi3519_mux_clks'.
This is also in line with how hisi_clk_register_gate() is called in the
probe.

Fixes: 224b3b262c52 ("clk: hisilicon: hi3519: add driver remove path and fix some issues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/c3f1877c9a0886fa35c949c8f0ef25547f284f18.1704912510.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3519.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index 51b173ef1ddad..d789735160a2b 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -142,7 +142,7 @@ static void hi3519_clk_unregister(struct platform_device *pdev)
 	of_clk_del_provider(pdev->dev.of_node);
 
 	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
+				ARRAY_SIZE(hi3519_gate_clks),
 				crg->clk_data);
 	hisi_clk_unregister_mux(hi3519_mux_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
-- 
2.43.0


