Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCA7ACA47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjIXPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjIXPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:17:17 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C8CB8;
        Sun, 24 Sep 2023 08:17:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsimeNt_1695568626;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsimeNt_1695568626)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:08 +0800
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
Subject: [PATCH net-next v4 04/18] net/smc: support SMCv2.x supplemental features negotiation
Date:   Sun, 24 Sep 2023 23:16:39 +0800
Message-Id: <1695568613-125057-5-git-send-email-guwen@linux.alibaba.com>
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

This patch adds SMCv2.1 supplemental features negotiation. Supported
SMCv2.1 supplemental features are represented by feature_mask in FCE
header of CLC messages.

 Server                                  Client
        Proposal(features(c-mask bits))
      <-----------------------------------
         Accept(features(s-mask bits))
      ----------------------------------->
        Confirm(features(s&c-mask bits))
      <-----------------------------------

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_clc.c  | 7 +++++++
 net/smc/smc_clc.h  | 6 ++++--
 net/smc/smc_core.h | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 8deb46c..125b0d2 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -426,6 +426,7 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
 	memset(fce, 0, sizeof(*fce));
 	fce->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
 	fce->fce_v2_base.release = ini->release_nr;
+	fce->fce_v2_base.feature_mask = htons(ini->feature_mask);
 	memcpy(fce->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
 	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1) {
 		ret = sizeof(struct smc_clc_first_contact_ext);
@@ -906,6 +907,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		pclc_smcd->v2_ext_offset = htons(v2_ext_offset);
 		plen += sizeof(*v2_ext);
 
+		v2_ext->feature_mask = htons(ini->feature_mask);
 		read_lock(&smc_clc_eid_table.lock);
 		v2_ext->hdr.eid_cnt = smc_clc_eid_table.ueid_cnt;
 		plen += smc_clc_eid_table.ueid_cnt * SMC_MAX_EID_LEN;
@@ -1219,6 +1221,7 @@ int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 			return SMC_CLC_DECL_MAXLINKERR;
 		ini->max_links = fce_v2x->max_links;
 	}
+	ini->feature_mask &= ntohs(fce->feature_mask);
 
 	return 0;
 }
@@ -1250,6 +1253,10 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 			return SMC_CLC_DECL_MAXLINKERR;
 	}
 
+	if (~(ini->feature_mask) & ntohs(fce->feature_mask))
+		return SMC_CLC_DECL_FEATUNSUPP;
+	ini->feature_mask = ntohs(fce->feature_mask);
+
 	return 0;
 }
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index c5c8e7d..bcf37c8 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -48,6 +48,7 @@
 #define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
 #define SMC_CLC_DECL_MAXCONNERR	0x0303000a  /* max connections negotiate failed */
 #define SMC_CLC_DECL_MAXLINKERR	0x0303000b  /* max links negotiate failed */
+#define SMC_CLC_DECL_FEATUNSUPP	0x0303000c  /* supplemental features not supported */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
@@ -138,7 +139,8 @@ struct smc_clc_v2_extension {
 	u8 roce[16];		/* RoCEv2 GID */
 	u8 max_conns;
 	u8 max_links;
-	u8 reserved[14];
+	__be16 feature_mask;
+	u8 reserved[12];
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
 
@@ -234,7 +236,7 @@ struct smc_clc_first_contact_ext {
 	u8 release : 4,
 	   os_type : 4;
 #endif
-	u8 reserved2[2];
+	__be16 feature_mask;
 	u8 hostname[SMC_MAX_HOSTNAME_LEN];
 };
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 120027d..9f65678 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -401,6 +401,7 @@ struct smc_init_info {
 	u8			max_links;
 	u8			first_contact_peer;
 	u8			first_contact_local;
+	u16			feature_mask;
 	unsigned short		vlan_id;
 	u32			rc;
 	u8			negotiated_eid[SMC_MAX_EID_LEN];
-- 
1.8.3.1

