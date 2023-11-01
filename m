Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADF7DE442
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjKAPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjKAPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:55:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB3102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:55:48 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yDZKqJ4wOLilFyDZKqui3f; Wed, 01 Nov 2023 16:55:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698854147;
        bh=ufZ6eZhZNmydg60KYGYUmr72dJOjnFUCCdCp0lk2s4g=;
        h=From:To:Cc:Subject:Date;
        b=HIfwAvNr4Wr/ZqZITN+UDDI6Sr+OP0ffSXr6wMVGL42Io4gtcI2JevZbjrzSmRSHb
         sPI5r2tTON9FAGdFrWEhkWCVHArvlw/pkjUzyIm/E0CWmrpmALHSCdoslU/7LDArhu
         0yLkai4iY4mIAZ9dver1cur852e+lofck18LtFau0yGJdoz3mrgW4p4V2gEI8WsGdk
         UN5FhiWAH587QA/dCkXrmVLHHApBfoGkV5CjuyieGtowAiWgtocibWW/aBXtKsf3ZF
         TtgcauYzH7yQz8UUKLZF8RFYqnZTTggBadf9g+V55FohN6L9Myy3hAER7walH0IX+X
         vn32+War5/CGQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 16:55:47 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: intel-lpss: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 16:55:38 +0100
Message-Id: <a63f3da5745187f5a9b1e2ec0492f2fe2e0b0b8d.1698854117.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/intel-lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 9591b354072a..9115ba4c768f 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -405,7 +405,7 @@ int intel_lpss_probe(struct device *dev,
 
 	intel_lpss_init_dev(lpss);
 
-	lpss->devid = ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_KERNEL);
+	lpss->devid = ida_alloc(&intel_lpss_devid_ida, GFP_KERNEL);
 	if (lpss->devid < 0)
 		return lpss->devid;
 
@@ -442,7 +442,7 @@ int intel_lpss_probe(struct device *dev,
 	intel_lpss_unregister_clock(lpss);
 
 err_clk_register:
-	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+	ida_free(&intel_lpss_devid_ida, lpss->devid);
 
 	return ret;
 }
@@ -456,7 +456,7 @@ void intel_lpss_remove(struct device *dev)
 	intel_lpss_debugfs_remove(lpss);
 	intel_lpss_ltr_hide(lpss);
 	intel_lpss_unregister_clock(lpss);
-	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+	ida_free(&intel_lpss_devid_ida, lpss->devid);
 }
 EXPORT_SYMBOL_GPL(intel_lpss_remove);
 
-- 
2.34.1

