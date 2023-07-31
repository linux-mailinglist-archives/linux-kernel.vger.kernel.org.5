Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A227690B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGaIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGaIql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:41 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2A2112
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:23 -0700 (PDT)
X-ASG-Debug-ID: 1690793119-086e231869033b0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id Z2HnKAJvtAwZKXyU (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 31 Jul 2023 16:45:19 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 16:45:18 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 16:45:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <jiajie.ho@starfivetech.com>, <conor.dooley@microchip.com>,
        <martin@kaiser.cx>, <mmyangfl@gmail.com>,
        <jenny.zhang@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <leoliu@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH v2 1/2] hwrng: via-rng: convert to x86_cpu_id probing
Date:   Mon, 31 Jul 2023 16:45:14 +0800
X-ASG-Orig-Subj: [PATCH v2 1/2] hwrng: via-rng: convert to x86_cpu_id probing
Message-ID: <20230731084515.2057375-2-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731084515.2057375-1-LeoLiu-oc@zhaoxin.com>
References: <20230731084515.2057375-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1690793119
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1824
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112114
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

With this, In addition to the Feature matching check,
add the CPU Vendor ID/Family check.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/char/hw_random/via-rng.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index a9a0a3b09c8b..d7feb3923819 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
 	 * is always enabled if CPUID rng_en is set.  There is no
 	 * RNG configuration like it used to be the case in this
 	 * register */
-	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
+	if (((c->x86 == 6) && (c->x86_model >= 0x0f))) {
 		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
 			pr_err(PFX "can't enable hardware RNG "
 				"if XSTORE is not enabled\n");
@@ -191,12 +191,17 @@ static struct hwrng via_rng = {
 	.data_read	= via_rng_data_read,
 };
 
+static const struct x86_cpu_id via_rng_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);
 
 static int __init via_rng_mod_init(void)
 {
 	int err;
 
-	if (!boot_cpu_has(X86_FEATURE_XSTORE))
+	if (!x86_match_cpu(via_rng_cpu_ids))
 		return -ENODEV;
 
 	pr_info("VIA RNG detected\n");
@@ -217,11 +222,5 @@ static void __exit via_rng_mod_exit(void)
 }
 module_exit(via_rng_mod_exit);
 
-static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
-
 MODULE_DESCRIPTION("H/W RNG driver for VIA CPU with PadLock");
 MODULE_LICENSE("GPL");
-- 
2.34.1

