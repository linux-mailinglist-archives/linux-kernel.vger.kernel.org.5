Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B07ACA59
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjIXPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjIXPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:17:38 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E4CE5;
        Sun, 24 Sep 2023 08:17:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vsir4-C_1695568635;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vsir4-C_1695568635)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:17 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 08/18] net/smc: enable virtual ISM device feature bit
Date:   Sun, 24 Sep 2023 23:16:43 +0800
Message-Id: <1695568613-125057-9-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the first supplement feature of SMCv2.1, that
is the support for virtual ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 net/smc/smc.h    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5bb41404..c5b7716 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1528,6 +1528,7 @@ static int __smc_connect(struct smc_sock *smc)
 	ini->smcr_version = SMC_V1 | SMC_V2;
 	ini->smc_type_v1 = SMC_TYPE_B;
 	ini->smc_type_v2 = SMC_TYPE_B;
+	ini->feature_mask = SMC_FEATURE_MASK;
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(smc->clcsock, ini)) {
@@ -1993,6 +1994,7 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
 	ini->smc_type_v2 = pclc->hdr.typev2;
 	ini->smcd_version = smcd_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
 	ini->smcr_version = smcr_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
+	ini->feature_mask = SMC_FEATURE_MASK;
 	if (pclc->hdr.version > SMC_V1) {
 		if (smcd_indicated(ini->smc_type_v2))
 			ini->smcd_version |= SMC_V2;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 24745fd..71b9640 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,6 +58,13 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
+enum smc_supp_feature {	/* supplemental features supported by current version */
+	SMC_SPF_VIRT_ISM_DEV	= 0,
+};
+
+#define SMC_FEATURE_MASK \
+	(BIT(SMC_SPF_VIRT_ISM_DEV))
+
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
-- 
1.8.3.1

