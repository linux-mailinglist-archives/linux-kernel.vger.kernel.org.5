Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA07BE82F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378022AbjJIRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377997AbjJIRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531ADB6;
        Mon,  9 Oct 2023 10:32:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E0C433C7;
        Mon,  9 Oct 2023 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872748;
        bh=hOqxwwj4R1P+EKnufjhjvIS/kNuMb6T35WWc1dRZ9O4=;
        h=From:To:Cc:Subject:Date:From;
        b=uEcN4iqpBBPTXSuTJmmsQW0XBmgffVYlQgaBjmqqdTkRMVBG3BPa8lkOyWVCiwydU
         3UuptraJO6PiL4/jHqCtCVy7SBukoRQZkIpSXQM74DtScLLZeIn6rEoAdqqv44LPlq
         hTyApjxodLZmzbOPa81Mzs0EvyUJ1mMNGXa2ZCpkIb0AhuQGzdOkz6h/wsixIaX67b
         AqDMNmUTbTAFH+gmagJH7m1KciVoh8iecrwwuRs7IDflPBSn6msD4mUb4WKZscDXo3
         ZVBsOTMkYpgYhuo0I8Fi1xNzkEWqhft5b3tfUaMhb7EkdATxM03er2qwuR78FSd7FX
         1lhz54xTAGRjg==
Received: (nullmailer pid 2526325 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: ti: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:08 -0500
Message-ID: <20231009172923.2457844-13-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/opp/ti-opp-supply.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 8f3f13fbbb25..e3b97cd1fbbf 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -373,23 +374,15 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev = get_cpu_device(0);
-	const struct of_device_id *match;
 	const struct ti_opp_supply_of_data *of_data;
 	int ret = 0;
 
-	match = of_match_device(ti_opp_supply_of_match, dev);
-	if (!match) {
-		/* We do not expect this to happen */
-		dev_err(dev, "%s: Unable to match device\n", __func__);
-		return -ENODEV;
-	}
-	if (!match->data) {
+	of_data = device_get_match_data(dev);
+	if (!of_data) {
 		/* Again, unlikely.. but mistakes do happen */
 		dev_err(dev, "%s: Bad data in match\n", __func__);
 		return -EINVAL;
 	}
-	of_data = match->data;
-
 	dev_set_drvdata(dev, (void *)of_data);
 
 	/* If we need optimized voltage */
-- 
2.42.0

