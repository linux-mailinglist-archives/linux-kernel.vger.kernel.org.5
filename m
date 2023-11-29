Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47267FD890
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjK2NrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjK2NrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:47:23 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0239B19A;
        Wed, 29 Nov 2023 05:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JYC5B10TWRchyHN96t
        T3YdbL8clZjtk6DHRMYsmi0FU=; b=hUbws6al1txBXOAkqAlg5bnYsvI364QoXN
        IfYGq7lJj3BGPXzQWwpy2Xfbok1hfV7Ig4amVik8uo6dBcOVYx5j1QX37ZCQTzaR
        NcCRs0HTglMB2buZmsEhfaSEregIS7JUJ5RVfUfk2L9hpl8x4Oi6CtE5at+nnnuM
        8ny92SM8k=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDXnxTnQGdlILsMCg--.42572S2;
        Wed, 29 Nov 2023 21:47:21 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [power/reset] qnap-poweroff: Add error handling
Date:   Wed, 29 Nov 2023 05:47:16 -0800
Message-Id: <20231129134716.34161-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXnxTnQGdlILsMCg--.42572S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UAr13Zw4rCrWfXr1xuFg_yoWDurc_W3
        4fX34xXan7Kr1kCFsakF47ZrWxCF92vFn3Xr4IqFyfC345Ww1DJrWqqr17Ja4kX34UCrWD
        GFZ8Xr43CF1fZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK73kUUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgc3gletj5TR4QABsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the of_match_node call
in the qnap_power_off_probe function within
drivers/power/reset/qnap-poweroff.c. Previously, there was no
check for a null return value from of_match_node, which could
lead to improper behavior if the device tree matching failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/power/reset/qnap-poweroff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 0ddf7f25f7b8..bc0b547211d6 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -77,6 +77,11 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 
 	const struct of_device_id *match =
 		of_match_node(qnap_power_off_of_match_table, np);
+	if (!match) {
+		dev_err(&pdev->dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	cfg = match->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1

