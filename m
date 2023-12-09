Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471880B1D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjLIDKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 22:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjLIDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:10:45 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC95A6;
        Fri,  8 Dec 2023 19:10:46 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BAF6E24E203;
        Sat,  9 Dec 2023 11:10:44 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 9 Dec
 2023 11:10:44 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 9 Dec
 2023 11:10:41 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     Michal Simek <michal.simek@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>
CC:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] i2c: cadence: Add system suspend and resume PM support
Date:   Sat, 9 Dec 2023 11:09:55 +0800
Message-ID: <20231209030955.1156905-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable device system suspend and resume PM support, and mark the device
state as suspended during system suspend to reject any data transfer.

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/i2c/busses/i2c-cadence.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index de3f58b60dce..c42d6afded2a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -1176,6 +1176,18 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused cdns_i2c_suspend(struct device *dev)
+{
+	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
+
+	i2c_mark_adapter_suspended(&xi2c->adap);
+
+	if (!pm_runtime_status_suspended(dev))
+		return cdns_i2c_runtime_suspend(dev);
+
+	return 0;
+}
+
 /**
  * cdns_i2c_init -  Controller initialisation
  * @id:		Device private data structure
@@ -1219,7 +1231,28 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused cdns_i2c_resume(struct device *dev)
+{
+	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
+	int err;
+
+	err = cdns_i2c_runtime_resume(dev);
+	if (err)
+		return err;
+
+	if (pm_runtime_status_suspended(dev)) {
+		cdns_i2c_runtime_suspend(dev);
+		if (err)
+			return err;
+	}
+
+	i2c_mark_adapter_resumed(&xi2c->adap);
+
+	return 0;
+}
+
 static const struct dev_pm_ops cdns_i2c_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_i2c_suspend, cdns_i2c_resume)
 	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
 			   cdns_i2c_runtime_resume, NULL)
 };
-- 
2.25.1

