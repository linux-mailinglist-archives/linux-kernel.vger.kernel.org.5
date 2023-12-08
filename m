Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B6809D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573327AbjLHHlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573295AbjLHHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:41:05 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A82171D;
        Thu,  7 Dec 2023 23:41:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vy2TDL0_1702021266;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy2TDL0_1702021266)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 15:41:08 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, raspl@linux.ibm.com,
        schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/9] net/smc: support SMCv2.x supplemental features negotiation
Date:   Fri,  8 Dec 2023 15:40:53 +0800
Message-Id: <1702021259-41504-4-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMCv2.x supplemental features negotiation. Supported
SMCv2.x supplemental features are represented by feature_mask in FCE
field. The negotiation process is as follows.

 Server                                        Client
            Proposal(features(c-mask bits))
      <-----------------------------------------
            Accept(features(s-mask bits))
      ----------------------------------------->
           Confirm(features(s&c-mask bits))
      <-----------------------------------------

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc.h      |  4 ++++
 net/smc/smc_clc.c  |  7 +++++++
 net/smc/smc_clc.h  | 14 ++++++++++----
 net/smc/smc_core.h |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index cd51261..95f56c7 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,6 +58,10 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
+#define SMC_FEATURE_MASK	0	/* bitmask of
+					 * supported supplemental features
+					 */
+
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 52b4ea9..81e09d1 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -438,6 +438,7 @@ static int smc_clc_fill_fce_v2x(struct smc_clc_first_contact_ext_v2x *fce_v2x,
 			fce_v2x->max_conns = ini->max_conns;
 			fce_v2x->max_links = ini->max_links;
 		}
+		fce_v2x->feature_mask = htons(ini->feature_mask);
 	}
 
 out:
@@ -908,6 +909,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		pclc_smcd->v2_ext_offset = htons(v2_ext_offset);
 		plen += sizeof(*v2_ext);
 
+		v2_ext->feature_mask = htons(SMC_FEATURE_MASK);
 		read_lock(&smc_clc_eid_table.lock);
 		v2_ext->hdr.eid_cnt = smc_clc_eid_table.ueid_cnt;
 		plen += smc_clc_eid_table.ueid_cnt * SMC_MAX_EID_LEN;
@@ -1214,6 +1216,7 @@ int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
 
 	ini->max_conns = SMC_CONN_PER_LGR_MAX;
 	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
+	ini->feature_mask = SMC_FEATURE_MASK;
 
 	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
 	    ini->release_nr < SMC_RELEASE_1)
@@ -1257,6 +1260,8 @@ int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 			return SMC_CLC_DECL_MAXLINKERR;
 		ini->max_links = fce_v2x->max_links;
 	}
+	/* common supplemental features of server and client */
+	ini->feature_mask = ntohs(fce_v2x->feature_mask) & SMC_FEATURE_MASK;
 
 	return 0;
 }
@@ -1287,6 +1292,8 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 		if (fce_v2x->max_links != ini->max_links)
 			return SMC_CLC_DECL_MAXLINKERR;
 	}
+	/* common supplemental features returned by client */
+	ini->feature_mask = ntohs(fce_v2x->feature_mask);
 
 	return 0;
 }
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 1697b84..0112e7c 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -138,7 +138,8 @@ struct smc_clc_v2_extension {
 	u8 roce[16];		/* RoCEv2 GID */
 	u8 max_conns;
 	u8 max_links;
-	u8 reserved[14];
+	__be16 feature_mask;
+	u8 reserved[12];
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
 
@@ -240,9 +241,14 @@ struct smc_clc_first_contact_ext {
 
 struct smc_clc_first_contact_ext_v2x {
 	struct smc_clc_first_contact_ext fce_v2_base;
-	u8 max_conns; /* for SMC-R only */
-	u8 max_links; /* for SMC-R only */
-	u8 reserved3[2];
+	union {
+		struct {
+			u8 max_conns; /* for SMC-R only */
+			u8 max_links; /* for SMC-R only */
+		};
+		u8 reserved3[2];	/* for SMC-D only */
+	};
+	__be16 feature_mask;
 	__be32 vendor_exp_options;
 	u8 reserved4[8];
 } __packed;		/* format defined in
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

