Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B397A6700
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjISOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjISOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:42:51 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A048D6;
        Tue, 19 Sep 2023 07:42:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxW5r_1695134559;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxW5r_1695134559)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:42:41 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/18] net/smc: extract v2 check helper from SMC-D device registration
Date:   Tue, 19 Sep 2023 22:41:47 +0800
Message-Id: <1695134522-126655-4-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extracts v2-capable logic from the process of registering the
ISM device as an SMC-D device, so that the registration process of other
underlying devices can reuse it.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 29 ++++++++++++++++++-----------
 net/smc/smc_ism.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 9e53bcf..6fa87d8 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -69,6 +69,22 @@ bool smc_ism_is_v2_capable(void)
 	return smc_ism_v2_capable;
 }
 
+/* must be called under smcd_dev_list.mutex lock */
+void smc_ism_check_v2_capable(struct smcd_dev *smcd)
+{
+	u8 *system_eid = NULL;
+
+	if (smc_ism_v2_capable)
+		return;
+
+	system_eid = smcd->ops->get_system_eid();
+	if (smcd->ops->supports_v2()) {
+		smc_ism_v2_capable = true;
+		memcpy(smc_ism_v2_system_eid, system_eid,
+		       SMC_MAX_EID_LEN);
+	}
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
@@ -424,16 +440,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 		smc_pnetid_by_table_smcd(smcd);
 
 	mutex_lock(&smcd_dev_list.mutex);
-	if (list_empty(&smcd_dev_list.list)) {
-		u8 *system_eid = NULL;
-
-		system_eid = smcd->ops->get_system_eid();
-		if (smcd->ops->supports_v2()) {
-			smc_ism_v2_capable = true;
-			memcpy(smc_ism_v2_system_eid, system_eid,
-			       SMC_MAX_EID_LEN);
-		}
-	}
+	smc_ism_check_v2_capable(smcd);
 	/* sort list: devices without pnetid before devices with pnetid */
 	if (smcd->pnetid[0])
 		list_add_tail(&smcd->list, &smcd_dev_list.list);
@@ -536,10 +543,10 @@ int smc_ism_init(void)
 {
 	int rc = 0;
 
-#if IS_ENABLED(CONFIG_ISM)
 	smc_ism_v2_capable = false;
 	memset(smc_ism_v2_system_eid, 0, SMC_MAX_EID_LEN);
 
+#if IS_ENABLED(CONFIG_ISM)
 	rc = ism_register_client(&smc_ism_client);
 #endif
 	return rc;
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 832b2f4..14d2e77 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -42,6 +42,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
+void smc_ism_check_v2_capable(struct smcd_dev *dev);
 int smc_ism_init(void);
 void smc_ism_exit(void);
 int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
-- 
1.8.3.1

