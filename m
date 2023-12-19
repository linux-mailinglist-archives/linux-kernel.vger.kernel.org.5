Return-Path: <linux-kernel+bounces-4912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4968183BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26A61C239D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857771549B;
	Tue, 19 Dec 2023 08:45:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CC14F82;
	Tue, 19 Dec 2023 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyqAsv6_1702975546;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyqAsv6_1702975546)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 16:45:48 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 04/10] net/smc: support SMCv2.x supplemental features negotiation
Date: Tue, 19 Dec 2023 16:45:30 +0800
Message-Id: <20231219084536.8158-5-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231219084536.8158-1-guwen@linux.alibaba.com>
References: <20231219084536.8158-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/smc.h      |  4 ++++
 net/smc/smc_clc.c  |  7 +++++++
 net/smc/smc_clc.h  | 14 ++++++++++----
 net/smc/smc_core.h |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index cd51261b7d9e..95f56c712b0a 100644
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
index 64733335b6ca..900d307c17a9 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -438,6 +438,7 @@ static int smc_clc_fill_fce_v2x(struct smc_clc_first_contact_ext_v2x *fce_v2x,
 			fce_v2x->max_conns = ini->max_conns;
 			fce_v2x->max_links = ini->max_links;
 		}
+		fce_v2x->feature_mask = htons(ini->feature_mask);
 	}
 
 out:
@@ -907,6 +908,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		pclc_smcd->v2_ext_offset = htons(v2_ext_offset);
 		plen += sizeof(*v2_ext);
 
+		v2_ext->feature_mask = htons(SMC_FEATURE_MASK);
 		read_lock(&smc_clc_eid_table.lock);
 		v2_ext->hdr.eid_cnt = smc_clc_eid_table.ueid_cnt;
 		plen += smc_clc_eid_table.ueid_cnt * SMC_MAX_EID_LEN;
@@ -1208,6 +1210,7 @@ int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
 
 	ini->max_conns = SMC_CONN_PER_LGR_MAX;
 	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
+	ini->feature_mask = SMC_FEATURE_MASK;
 
 	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
 	    ini->release_nr < SMC_RELEASE_1)
@@ -1251,6 +1254,8 @@ int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 			return SMC_CLC_DECL_MAXLINKERR;
 		ini->max_links = fce_v2x->max_links;
 	}
+	/* common supplemental features of server and client */
+	ini->feature_mask = ntohs(fce_v2x->feature_mask) & SMC_FEATURE_MASK;
 
 	return 0;
 }
@@ -1279,6 +1284,8 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 		if (fce_v2x->max_links != ini->max_links)
 			return SMC_CLC_DECL_MAXLINKERR;
 	}
+	/* common supplemental features returned by client */
+	ini->feature_mask = ntohs(fce_v2x->feature_mask);
 
 	return 0;
 }
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 03f9ccea8c5e..c187d5f09d02 100644
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
index 120027d40469..9f656780d46c 100644
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
2.32.0.3.g01195cf9f


