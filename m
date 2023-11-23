Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE67F5B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKWJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:27:55 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86ADD;
        Thu, 23 Nov 2023 01:28:00 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN9RsJf084120;
        Thu, 23 Nov 2023 03:27:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700731674;
        bh=LonyEqVOhXEOCtfZCFfFFF4BaDOFmpgVZfHtaMqFxzs=;
        h=From:Date:Subject:To:CC;
        b=QCvwnSxf8filjQOzypEHgBVe6L69k7q2pLl/pyfNppyl4gbBByp5TOyHu4JKFfCzm
         KgbfSQbwr0caG8lrPj2gNIbmT33YXebReZoeEGhb4FVPTfOruzMUsL5kirRPvpaZoY
         LlagExDQyT5p/GvU/ouNg5GFZKds35TP0c24tvMI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN9Rrmb016329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 03:27:54 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 03:27:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 03:27:53 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN9RqnP001798;
        Thu, 23 Nov 2023 03:27:53 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 23 Nov 2023 14:57:31 +0530
Subject: [PATCH] dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231123-psil_fix-v1-1-6604d80819be@ti.com>
X-B4-Tracking: v=1; b=H4sIAAIbX2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNj3YLizJz4tMwKXRAvOc0w2SIlyUAJqLygKBUoDDYqOra2FgCOAk9
 tWgAAAA==
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ronald Wahl <rwahl@gmx.de>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=924hpPwJxhmNS3x60PJd3VL+xH0u9ptGMGFk0d3PDdg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlXxsSvFh644Swbz0rcxw0sgevJgo0GO5Bk3ehs
 C0bG9Kp2x6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZV8bEgAKCRBD3pH5JJpx
 Re7+D/94649Hcne8rnC//ihmcjnbMRGPhvZCFzfh4bZSZfMG3ZwTLWV99Zn0XHNtVMJHJtLuj0T
 8PArSVP8843pYfZem4BTUWtaqJHy/y+vrilbds0aoegpl2TSxNPuBEoeD1ht0VcRlX82RBPDzNk
 Y2TzpRGhJGd7iGcMvka4zzwDRsDBEwkl7XJNUNYm8RwWA37bW7Ihw4v8TDLkqZzLdm85OiwQO89
 rOHmVFpVaODr7btlifx0zdULU6+1bcMJigWhpkPJg0GDLsnRFsJVxVZwxFlu8lNPjDE2E1XSkGC
 ckgcNy83k0rqGiIVVvLYku7ni74eMIwUKpyDVo+Tf2HYQsuN0AndGVV7SPwUtbJK3duycEcPbou
 5iSuHarybsC851OXeGzs4H8cgYlRAa+3h3s8C2Dv+SdNpdpt8w/9/cA/ZtIFh//eCY+CIK0Ro72
 +OkkgosRBWGUJz3AdagS46yll+fQKfrts9pbujPlcXVIPi+l6BwMxvtaNYlbfIkSabZEJ3aAnEK
 aJ6xbYlm9cYE1RIxmXrt1vkX0aoSw5A+RJ0RwnDneVH5pU4hJiXm1Z/W5vpkkoEr9ClhFawfWKh
 GLoTIrNCH/fCY3H6+WqpgEXLqZGl9JtrEgR9NJqMky9Xx00jNSMMwbIuN3t1XSvLo455Wsnfwq4
 E69qMPEjyiAheXQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62Ax has 3 SPI channels where each channel has 4x TX and 4x RX
threads. Also fix the thread numbers to match what the firmware expects
according to the PSI-L device description.

Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62ax/psil_cfg.html [1]
Fixes: aac6db7e243a ("dmaengine: ti: k3-psil-am62a: Add AM62Ax PSIL and PDMA data")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
This is the same fix done for a different SoC (AM62) here:
https://lore.kernel.org/all/20231030190113.16782-1-rwahl@gmx.de/
---
 drivers/dma/ti/k3-psil-am62a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/k3-psil-am62a.c b/drivers/dma/ti/k3-psil-am62a.c
index ca9d71f91422..4cf9123b0e93 100644
--- a/drivers/dma/ti/k3-psil-am62a.c
+++ b/drivers/dma/ti/k3-psil-am62a.c
@@ -84,7 +84,9 @@ static struct psil_ep am62a_src_ep_map[] = {
 	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
 	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
 	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0x4300),
+	PSIL_PDMA_XY_PKT(0x4301),
 	PSIL_PDMA_XY_PKT(0x4302),
 	PSIL_PDMA_XY_PKT(0x4303),
 	PSIL_PDMA_XY_PKT(0x4304),
@@ -95,8 +97,6 @@ static struct psil_ep am62a_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4309),
 	PSIL_PDMA_XY_PKT(0x430a),
 	PSIL_PDMA_XY_PKT(0x430b),
-	PSIL_PDMA_XY_PKT(0x430c),
-	PSIL_PDMA_XY_PKT(0x430d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0x4400),
 	PSIL_PDMA_XY_PKT(0x4401),
@@ -151,7 +151,9 @@ static struct psil_ep am62a_dst_ep_map[] = {
 	/* SAUL */
 	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
 	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0xc300),
+	PSIL_PDMA_XY_PKT(0xc301),
 	PSIL_PDMA_XY_PKT(0xc302),
 	PSIL_PDMA_XY_PKT(0xc303),
 	PSIL_PDMA_XY_PKT(0xc304),
@@ -162,8 +164,6 @@ static struct psil_ep am62a_dst_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0xc309),
 	PSIL_PDMA_XY_PKT(0xc30a),
 	PSIL_PDMA_XY_PKT(0xc30b),
-	PSIL_PDMA_XY_PKT(0xc30c),
-	PSIL_PDMA_XY_PKT(0xc30d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0xc400),
 	PSIL_PDMA_XY_PKT(0xc401),

---
base-commit: 948112cbca96dba98bee51f2a064d28a947abf07
change-id: 20231123-psil_fix-1123cf1c8db0

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

