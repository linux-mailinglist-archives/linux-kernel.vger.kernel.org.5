Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8277F793
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351375AbjHQNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351360AbjHQNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:20:43 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F02133;
        Thu, 17 Aug 2023 06:20:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vq.3QPC_1692278436;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vq.3QPC_1692278436)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 21:20:37 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/6] net/smc: support smc release version negotiation in clc handshake
Date:   Thu, 17 Aug 2023 21:20:27 +0800
Message-Id: <20230817132032.23397-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support smc release version negotiation in clc handshake based on
SMC v2, where no negotiation process for different releases, but
for different versions. The latest smc release version was updated
to v2.1. And currently there are two release versions of SMCv2, v2.0
and v2.1. In the release version negotiation, client sends the preferred
release version by CLC Proposal Message, server makes decision for which
release version to use based on the client preferred release version and
self-supported release version (here choose the minimum release version
of the client preferred and server latest supported), then the decision
returns to client by CLC Accept Message. Client confirms the decision by
CLC Confirm Message.

Client                                    Server
      Proposal(preferred release version)
     ------------------------------------>

      Accept(accpeted release version)
 min(client preferred, server latest supported)
     <------------------------------------

      Confirm(accpeted release version)
     ------------------------------------>

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c   | 21 +++++++++++++++++----
 net/smc/smc.h      |  5 ++++-
 net/smc/smc_clc.c  | 14 +++++++-------
 net/smc/smc_clc.h  | 23 ++++++++++++++++++++++-
 net/smc/smc_core.h |  1 +
 5 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a7f887d91d89..c99ac371b5b1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1167,8 +1167,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
 		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
 	struct smc_clc_first_contact_ext *fce =
-		(struct smc_clc_first_contact_ext *)
-			(((u8 *)clc_v2) + sizeof(*clc_v2));
+		smc_get_clc_first_contact_ext(clc_v2, false);
 
 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
 		return 0;
@@ -1187,6 +1186,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 			return SMC_CLC_DECL_NOINDIRECT;
 		}
 	}
+
+	ini->release_nr = fce->release;
+
 	return 0;
 }
 
@@ -1355,6 +1357,13 @@ static int smc_connect_ism(struct smc_sock *smc,
 		struct smc_clc_msg_accept_confirm_v2 *aclc_v2 =
 			(struct smc_clc_msg_accept_confirm_v2 *)aclc;
 
+		if (ini->first_contact_peer) {
+			struct smc_clc_first_contact_ext *fce =
+				smc_get_clc_first_contact_ext(aclc_v2, true);
+
+			ini->release_nr = fce->release;
+		}
+
 		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
 		if (rc)
 			return rc;
@@ -1389,7 +1398,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	rc = smc_clc_send_confirm(smc, ini->first_contact_local,
-				  aclc->hdr.version, eid, NULL);
+				  aclc->hdr.version, eid, ini);
 	if (rc)
 		goto connect_abort;
 	mutex_unlock(&smc_server_lgr_pending);
@@ -1965,6 +1974,10 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
 		}
 	}
 
+	ini->release_nr = pclc_v2_ext->hdr.flag.release;
+	if (pclc_v2_ext->hdr.flag.release > SMC_RELEASE)
+		ini->release_nr = SMC_RELEASE;
+
 out:
 	if (!ini->smcd_version && !ini->smcr_version)
 		return rc;
@@ -2412,7 +2425,7 @@ static void smc_listen_work(struct work_struct *work)
 	/* send SMC Accept CLC message */
 	accept_version = ini->is_smcd ? ini->smcd_version : ini->smcr_version;
 	rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
-				 accept_version, ini->negotiated_eid);
+				 accept_version, ini->negotiated_eid, ini);
 	if (rc)
 		goto out_unlock;
 
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2eeea4cdc718..9cce1a41e011 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -21,7 +21,10 @@
 
 #define SMC_V1		1		/* SMC version V1 */
 #define SMC_V2		2		/* SMC version V2 */
-#define SMC_RELEASE	0
+
+#define SMC_RELEASE_0 0
+#define SMC_RELEASE_1 1
+#define SMC_RELEASE	SMC_RELEASE_1 /* the latest release version */
 
 #define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
 #define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index b9b8b07aa702..7c5627c6abcc 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -420,11 +420,11 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 	return true;
 }
 
-static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len)
+static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_nr)
 {
 	memset(fce, 0, sizeof(*fce));
 	fce->os_type = SMC_CLC_OS_LINUX;
-	fce->release = SMC_RELEASE;
+	fce->release = release_nr;
 	memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
 	(*len) += sizeof(*fce);
 }
@@ -1019,7 +1019,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact)
-				smc_clc_fill_fce(&fce, &len);
+				smc_clc_fill_fce(&fce, &len, ini->release_nr);
 			clc_v2->hdr.length = htons(len);
 		}
 		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
@@ -1063,10 +1063,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact) {
-				smc_clc_fill_fce(&fce, &len);
+				smc_clc_fill_fce(&fce, &len, ini->release_nr);
 				fce.v2_direct = !link->lgr->uses_gateway;
 				memset(&gle, 0, sizeof(gle));
-				if (ini && clc->hdr.type == SMC_CLC_CONFIRM) {
+				if (clc->hdr.type == SMC_CLC_CONFIRM) {
 					gle.gid_cnt = ini->smcrv2.gidlist.len;
 					len += sizeof(gle);
 					len += gle.gid_cnt * sizeof(gle.gid[0]);
@@ -1141,7 +1141,7 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 
 /* send CLC ACCEPT message across internal TCP socket */
 int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
-			u8 version, u8 *negotiated_eid)
+			u8 version, u8 *negotiated_eid, struct smc_init_info *ini)
 {
 	struct smc_clc_msg_accept_confirm_v2 aclc_v2;
 	int len;
@@ -1149,7 +1149,7 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
 	memset(&aclc_v2, 0, sizeof(aclc_v2));
 	aclc_v2.hdr.type = SMC_CLC_ACCEPT;
 	len = smc_clc_send_confirm_accept(new_smc, &aclc_v2, srv_first_contact,
-					  version, negotiated_eid, NULL);
+					  version, negotiated_eid, ini);
 	if (len < ntohs(aclc_v2.hdr.length))
 		len = len >= 0 ? -EPROTO : -new_smc->clcsock->sk->sk_err;
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 5fee545c9a10..b923e89acafb 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -370,6 +370,27 @@ smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
 		 ntohs(prop_v2ext->hdr.smcd_v2_ext_offset));
 }
 
+static inline struct smc_clc_first_contact_ext *
+smc_get_clc_first_contact_ext(struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			      bool is_smcd)
+{
+	int clc_v2_len;
+
+	if (clc_v2->hdr.version == SMC_V1 ||
+	    !(clc_v2->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
+		return NULL;
+
+	if (is_smcd)
+		clc_v2_len =
+			offsetofend(struct smc_clc_msg_accept_confirm_v2, d1);
+	else
+		clc_v2_len =
+			offsetofend(struct smc_clc_msg_accept_confirm_v2, r1);
+
+	return (struct smc_clc_first_contact_ext *)(((u8 *)clc_v2) +
+						    clc_v2_len);
+}
+
 struct smcd_dev;
 struct smc_init_info;
 
@@ -382,7 +403,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini);
 int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 			 u8 version, u8 *eid, struct smc_init_info *ini);
 int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
-			u8 version, u8 *negotiated_eid);
+			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
 void smc_clc_init(void) __init;
 void smc_clc_exit(void);
 void smc_clc_get_hostname(u8 **host);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 3c1b31bfa1cf..b6c68db61f23 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -374,6 +374,7 @@ struct smc_init_info {
 	u8			is_smcd;
 	u8			smc_type_v1;
 	u8			smc_type_v2;
+	u8			release_nr;
 	u8			first_contact_peer;
 	u8			first_contact_local;
 	unsigned short		vlan_id;
-- 
2.24.3 (Apple Git-128)

