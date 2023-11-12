Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5127E9036
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKLN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjKLNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:25:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA783A98;
        Sun, 12 Nov 2023 05:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADBC433AB;
        Sun, 12 Nov 2023 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795490;
        bh=fA/Gl85/aqYKqIqYNvGeoHYQKLCcLZ+PRdv4RZjBolk=;
        h=From:To:Cc:Subject:Date:From;
        b=VfkWE/N82Aa9TlRCs4EA5pwjosr03DRRx4+Oi0Nq2vthBD+TsZ5stC0yC0QVuhx6X
         hn8eDug8m9d82QaGAuuN4mZCda2LaLWjPRQfuN2qNvA1riGQQd9g6Kb05VpbmRrVKE
         B+iAXO6hSE6HrFE+kvbmo9jTPBjYFEGnmGvfeejXNioEU2IEp2CnRfZEczF0DsqQy2
         WQtv0+6nTJNU2YMlAGGRIDoSKYtNOby9Rgoyl3FWRiPPqLqLGfQ3Wb9hvBAsNO0Htr
         t0prGrB8KxMVV3Php0hz01MEnz5ZkXIKHCYAjOUq3eUH2rIu6xwFHmlS6huodijOpu
         XHLmry5QH19kw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        andi.shyti@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4] i2c: sun6i-p2wi: Prevent potential division by zero
Date:   Sun, 12 Nov 2023 08:24:46 -0500
Message-ID: <20231112132446.174847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.260
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 5ac61d26b8baff5b2e5a9f3dc1ef63297e4b53e7 ]

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7c07ce116e384..540c33f4e3500 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -202,6 +202,11 @@ static int p2wi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (clk_freq == 0) {
+		dev_err(dev, "clock-frequency is set to 0 in DT\n");
+		return -EINVAL;
+	}
+
 	if (of_get_child_count(np) > 1) {
 		dev_err(dev, "P2WI only supports one slave device\n");
 		return -EINVAL;
-- 
2.42.0

