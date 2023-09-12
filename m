Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847979CFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjILLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjILLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:30:08 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C01706;
        Tue, 12 Sep 2023 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Qu39PQ0U2Ph5m1ZjnlmlC8FtqW2Q1p6q+fQQPfB0rxg=; b=Kw6L05BgsU0e+oBduAi3AmSIMC
        kQr0uIEKSM5/Z/cnvJVkyGPvaUluJ+hN7NvFeyxX0Mwi6OhPULr4DzFGIIf/9Pagg4V48lay9QOYo
        DT1h41WrVW5qJtK9sjBuPhQVlLSQgindSvucBe2vs7Q0u+8B4g8mJUYSimrdWIMYRbLKb89F/19x2
        jGtWiO2iESI53J+886MB7VttrSn0nRaftNxKaHUG0TB07NIefxOkRu2fJ/tnvIl6q8+xlO2FbpR2O
        sWY/woMhBGZtHyDIq3kkr1Hr9dHEfU6lUNeVoMNs60zPDwTdrS4ztMwyteKULuxyatKSNSk69DBPe
        B8wecZ+A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qg1ag-00Fv4Q-0P;
        Tue, 12 Sep 2023 14:29:58 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Timo Alho <talho@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: tegra: fix error return case for recalc_rate
Date:   Tue, 12 Sep 2023 14:29:50 +0300
Message-ID: <20230912112951.2330497-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Alho <talho@nvidia.com>

tegra-bpmp clocks driver makes implicit conversion of signed error
code to unsigned value in recalc_rate operation. The behavior for
recalc_rate, according to it's specification, should be that "If the
driver cannot figure out a rate for this clock, it must return 0."

Fixes: ca6f2796eef7 ("clk: tegra: Add BPMP clock driver")
Signed-off-by: Timo Alho <talho@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/clk/tegra/clk-bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index a9f3fb448de6..7bfba0afd778 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -159,7 +159,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
-- 
2.41.0

