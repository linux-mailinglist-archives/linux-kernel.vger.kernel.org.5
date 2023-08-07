Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45809771A51
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjHGG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHGG1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:27:33 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C058170B;
        Sun,  6 Aug 2023 23:27:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpANHvG_1691389646;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpANHvG_1691389646)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 14:27:27 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 net-next 3/6] net/smc: support smc v2.x features validate
Date:   Mon,  7 Aug 2023 14:27:17 +0800
Message-Id: <20230807062720.20555-4-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
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

Support smc v2.x features validate for smc v2.1.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c  | 18 ++++++++++++++++++
 net/smc/smc_clc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_clc.h |  7 +++++++
 3 files changed, 71 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 52279bdc100a..fd58e25beddf 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1169,6 +1169,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 	struct smc_clc_first_contact_ext *fce =
 		(struct smc_clc_first_contact_ext *)
 			(((u8 *)clc_v2) + sizeof(*clc_v2));
+	int rc;
 
 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
 		return 0;
@@ -1191,6 +1192,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 	if (fce->release > SMC_RELEASE)
 		return SMC_CLC_DECL_VERSMISMAT;
 	ini->release_ver = fce->release;
+	rc = smc_clc_cli_v2x_features_validate(fce, ini);
+	if (rc)
+		return rc;
 
 	return 0;
 }
@@ -1367,6 +1371,9 @@ static int smc_connect_ism(struct smc_sock *smc,
 			if (fce->release > SMC_RELEASE)
 				return SMC_CLC_DECL_VERSMISMAT;
 			ini->release_ver = fce->release;
+			rc = smc_clc_cli_v2x_features_validate(fce, ini);
+			if (rc)
+				return rc;
 		}
 
 		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
@@ -2417,6 +2424,10 @@ static void smc_listen_work(struct work_struct *work)
 	if (rc)
 		goto out_decl;
 
+	rc = smc_clc_srv_v2x_features_validate(pclc, ini);
+	if (rc)
+		goto out_decl;
+
 	mutex_lock(&smc_server_lgr_pending);
 	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
@@ -2449,6 +2460,13 @@ static void smc_listen_work(struct work_struct *work)
 		goto out_decl;
 	}
 
+	rc = smc_clc_v2x_features_confirm_check(cclc, ini);
+	if (rc) {
+		if (!ini->is_smcd)
+			goto out_unlock;
+		goto out_decl;
+	}
+
 	/* finish worker */
 	if (!ini->is_smcd) {
 		rc = smc_listen_rdma_finish(new_smc, cclc,
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index ae80c191a834..4f6b69af2b80 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -1158,6 +1158,52 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
 	return len > 0 ? 0 : len;
 }
 
+int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
+				      struct smc_init_info *ini)
+{
+	struct smc_clc_v2_extension *pclc_v2_ext;
+
+	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
+	    ini->release_ver < SMC_RELEASE_1)
+		return 0;
+
+	pclc_v2_ext = smc_get_clc_v2_ext(pclc);
+	if (!pclc_v2_ext)
+		return SMC_CLC_DECL_NOV2EXT;
+
+	return 0;
+}
+
+int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
+				      struct smc_init_info *ini)
+{
+	if (ini->release_ver < SMC_RELEASE_1)
+		return 0;
+
+	return 0;
+}
+
+int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
+				       struct smc_init_info *ini)
+{
+	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
+		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
+	struct smc_clc_first_contact_ext *fce =
+		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
+
+	if (cclc->hdr.version == SMC_V1 ||
+	    !(cclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
+		return 0;
+
+	if (ini->release_ver != fce->release)
+		return SMC_CLC_DECL_RELEASEERR;
+
+	if (fce->release < SMC_RELEASE_1)
+		return 0;
+
+	return 0;
+}
+
 void smc_clc_get_hostname(u8 **host)
 {
 	*host = &smc_hostname[0];
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 6133276a8839..66932bfdc6d0 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -45,6 +45,7 @@
 #define SMC_CLC_DECL_NOSEID	0x03030006  /* peer sent no SEID	      */
 #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
 #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
+#define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
@@ -415,6 +416,12 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 			 u8 version, u8 *eid, struct smc_init_info *ini);
 int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
 			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
+int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
+				      struct smc_init_info *ini);
+int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
+				      struct smc_init_info *ini);
+int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
+				       struct smc_init_info *ini);
 void smc_clc_init(void) __init;
 void smc_clc_exit(void);
 void smc_clc_get_hostname(u8 **host);
-- 
2.24.3 (Apple Git-128)

