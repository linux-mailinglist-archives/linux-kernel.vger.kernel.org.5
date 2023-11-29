Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDEE7FD7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjK2NSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjK2NSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:18:18 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1CBE9A;
        Wed, 29 Nov 2023 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZuVjrWr8wX46bqcce9
        Cf5hGZQTG2aZ8czUpTlfy7WnQ=; b=ePlShHCijkw4pyW/7v1OmPiWnVfkyxMOwo
        XICgzvJ+GihHruj9VN3wwxyhCDdBYYhgUkeZ+4CHS1k4ZDq0Tapti/6ytRiisjiy
        xkFkUqGMtvtgiEW5UAV3JsF6t0Jpx/B9ktA4h9zQsHfR98VcVLD8yInXfInCErTd
        vqUX6upns=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3v9IJOmdl5eXHBQ--.12960S2;
        Wed, 29 Nov 2023 21:18:02 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [power/reset] msm-poweroff: Add error handling
Date:   Wed, 29 Nov 2023 05:17:59 -0800
Message-Id: <20231129131759.33938-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3v9IJOmdl5eXHBQ--.12960S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr4kGryxKry3Zw13uF1xZrb_yoW8JrW7pr
        4kCr1Ykr43Cw47ZF4jvF1xCFyruan3t3y7CrWxGw1xZw4DXr95tr1UtFyUtF47Kry7XFyS
        vF4avry8uF43uFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi89N3UUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgU3gletj5Qh6wABso
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the
register_restart_handler call in the msm_restart_probe function
within drivers/power/reset/msm-poweroff.c. Previously, the
function lacked error checking after calling
register_restart_handler, which could potentially lead to
unnoticed failures during system restart operations.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/power/reset/msm-poweroff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index d96d248a6e25..9fd84dfa6882 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -35,11 +35,18 @@ static void do_msm_poweroff(void)
 
 static int msm_restart_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	register_restart_handler(&restart_nb);
+	ret = register_restart_handler(&restart_nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register restart handler: %d\n", ret);
+		return ret;
+	}
 
 	pm_power_off = do_msm_poweroff;
 
-- 
2.17.1

