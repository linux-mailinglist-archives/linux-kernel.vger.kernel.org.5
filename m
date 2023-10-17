Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8157CC36C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjJQMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:42:45 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DEDB;
        Tue, 17 Oct 2023 05:42:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuNiO2r_1697546558;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuNiO2r_1697546558)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 20:42:38 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net/smc: change function name from smc_find_ism_store_rc to smc_find_device_store_rc
Date:   Tue, 17 Oct 2023 20:42:33 +0800
Message-Id: <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function smc_find_ism_store_rc is not only used for ism, so it is
reasonable to change the function name to smc_find_device_store_rc.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 net/smc/af_smc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 35ddebae8894..b3a67a168495 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2122,7 +2122,7 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
 	}
 }
 
-static void smc_find_ism_store_rc(u32 rc, struct smc_init_info *ini)
+static void smc_find_device_store_rc(u32 rc, struct smc_init_info *ini)
 {
 	if (!ini->rc)
 		ini->rc = rc;
@@ -2164,7 +2164,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	mutex_unlock(&smcd_dev_list.mutex);
 
 	if (!ini->ism_dev[0]) {
-		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
+		smc_find_device_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
 		goto not_found;
 	}
 
@@ -2181,7 +2181,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 		ini->ism_selected = i;
 		rc = smc_listen_ism_init(new_smc, ini);
 		if (rc) {
-			smc_find_ism_store_rc(rc, ini);
+			smc_find_device_store_rc(rc, ini);
 			/* try next active ISM device */
 			continue;
 		}
@@ -2218,7 +2218,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 		return;		/* V1 ISM device found */
 
 not_found:
-	smc_find_ism_store_rc(rc, ini);
+	smc_find_device_store_rc(rc, ini);
 	ini->smcd_version &= ~SMC_V1;
 	ini->ism_dev[0] = NULL;
 	ini->is_smcd = false;
@@ -2268,7 +2268,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
 	rc = smc_find_rdma_device(new_smc, ini);
 	if (rc) {
-		smc_find_ism_store_rc(rc, ini);
+		smc_find_device_store_rc(rc, ini);
 		goto not_found;
 	}
 	if (!ini->smcrv2.uses_gateway)
@@ -2285,7 +2285,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	if (!rc)
 		return;
 	ini->smcr_version = smcr_version;
-	smc_find_ism_store_rc(rc, ini);
+	smc_find_device_store_rc(rc, ini);
 
 not_found:
 	ini->smcr_version &= ~SMC_V2;
@@ -2332,7 +2332,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 	/* check for matching IP prefix and subnet length (V1) */
 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
 	if (prfx_rc)
-		smc_find_ism_store_rc(prfx_rc, ini);
+		smc_find_device_store_rc(prfx_rc, ini);
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
@@ -2359,7 +2359,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 		int rc;
 
 		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
-		smc_find_ism_store_rc(rc, ini);
+		smc_find_device_store_rc(rc, ini);
 		return (!rc) ? 0 : ini->rc;
 	}
 	return prfx_rc;
-- 
2.24.3 (Apple Git-128)

