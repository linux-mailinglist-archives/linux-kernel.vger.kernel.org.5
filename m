Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011177AB2B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHMUXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:23:48 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B060E113
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:23:48 -0700 (PDT)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 034E13E1A3B;
        Sun, 13 Aug 2023 23:23:44 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: isci: init Return result of sas_register_ha()
Date:   Sun, 13 Aug 2023 23:23:36 +0300
Message-Id: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 179213 [Aug 12 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;localhost.biz:7.1.1;red-soft.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/08/13 18:44:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/13 17:49:00 #21598114
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly manage possible failure of sas_register_ha() in
isci_register_sas_ha() return it's result instead of zero

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/scsi/isci/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index ac1e04b86d8f..4f4800edf4f0 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -264,9 +264,7 @@ static int isci_register_sas_ha(struct isci_host *isci_host)
 
 	sas_ha->strict_wide_ports = 1;
 
-	sas_register_ha(sas_ha);
-
-	return 0;
+	return sas_register_ha(sas_ha);
 }
 
 static void isci_unregister(struct isci_host *isci_host)
-- 
2.37.3

