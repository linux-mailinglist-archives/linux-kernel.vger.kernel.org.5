Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF280771A52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHGG1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHGG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:27:35 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A211711;
        Sun,  6 Aug 2023 23:27:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpANHvo_1691389647;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpANHvo_1691389647)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 14:27:28 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 net-next 4/6] net/smc: support max connections per lgr negotiation
Date:   Mon,  7 Aug 2023 14:27:18 +0800
Message-Id: <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
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

Support max connections per lgr negotiation for SMCR v2.1,
which is one of smc v2.1 features.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c   |  1 +
 net/smc/smc_clc.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_clc.h  |  7 +++++--
 net/smc/smc_core.c |  4 +++-
 net/smc/smc_core.h |  5 +++++
 net/smc/smc_llc.c  |  6 +++++-
 6 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index fd58e25beddf..b95d3fd48c28 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1214,6 +1214,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	memcpy(ini->peer_systemid, aclc->r0.lcl.id_for_peer, SMC_SYSTEMID_LEN);
 	memcpy(ini->peer_gid, aclc->r0.lcl.gid, SMC_GID_SIZE);
 	memcpy(ini->peer_mac, aclc->r0.lcl.mac, ETH_ALEN);
+	ini->max_conns = SMC_RMBS_PER_LGR_MAX;
 
 	reason_code = smc_connect_rdma_v2_prepare(smc, aclc, ini);
 	if (reason_code)
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 4f6b69af2b80..e2b224063dcc 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -427,9 +427,17 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
 	fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
 	fce->fce_v20.release = ini->release_ver;
 	memcpy(fce->fce_v20.hostname, smc_hostname, sizeof(smc_hostname));
-	if (ini->is_smcd && ini->release_ver < SMC_RELEASE_1)
+	if (ini->is_smcd && ini->release_ver < SMC_RELEASE_1) {
 		ret = sizeof(struct smc_clc_first_contact_ext);
+		goto out;
+	}
+
+	if (ini->release_ver >= SMC_RELEASE_1) {
+		if (!ini->is_smcd)
+			fce->max_conns = ini->max_conns;
+	}
 
+out:
 	return ret;
 }
 
@@ -931,8 +939,10 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 				sizeof(struct smc_clc_smcd_gid_chid);
 		}
 	}
-	if (smcr_indicated(ini->smc_type_v2))
+	if (smcr_indicated(ini->smc_type_v2)) {
 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
+		v2_ext->max_conns = SMC_CONN_PER_LGR_MAX;
+	}
 
 	pclc_base->hdr.length = htons(plen);
 	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
@@ -1163,6 +1173,11 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
 {
 	struct smc_clc_v2_extension *pclc_v2_ext;
 
+	/* default max conn is SMC_RMBS_PER_LGR_MAX(255),
+	 * which is the default value in smc v1 and v2.0.
+	 */
+	ini->max_conns = SMC_RMBS_PER_LGR_MAX;
+
 	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
 	    ini->release_ver < SMC_RELEASE_1)
 		return 0;
@@ -1171,15 +1186,30 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
 	if (!pclc_v2_ext)
 		return SMC_CLC_DECL_NOV2EXT;
 
+	if (ini->smcr_version & SMC_V2) {
+		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_MAX);
+		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
+			return SMC_CLC_DECL_MAXCONNERR;
+	}
+
 	return 0;
 }
 
 int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 				      struct smc_init_info *ini)
 {
+	struct smc_clc_first_contact_ext_v2x *fce_v2x =
+		(struct smc_clc_first_contact_ext_v2x *)fce;
+
 	if (ini->release_ver < SMC_RELEASE_1)
 		return 0;
 
+	if (!ini->is_smcd) {
+		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
+			return SMC_CLC_DECL_MAXCONNERR;
+		ini->max_conns = fce_v2x->max_conns;
+	}
+
 	return 0;
 }
 
@@ -1190,6 +1220,8 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
 	struct smc_clc_first_contact_ext *fce =
 		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
+	struct smc_clc_first_contact_ext_v2x *fce_v2x =
+		(struct smc_clc_first_contact_ext_v2x *)fce;
 
 	if (cclc->hdr.version == SMC_V1 ||
 	    !(cclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
@@ -1201,6 +1233,11 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 	if (fce->release < SMC_RELEASE_1)
 		return 0;
 
+	if (!ini->is_smcd) {
+		if (fce_v2x->max_conns != ini->max_conns)
+			return SMC_CLC_DECL_MAXCONNERR;
+	}
+
 	return 0;
 }
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 66932bfdc6d0..54077e50c368 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -46,6 +46,7 @@
 #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
 #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
 #define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
+#define SMC_CLC_DECL_MAXCONNERR	0x0303000a  /* max connections negotiate failed */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
@@ -134,7 +135,8 @@ struct smc_clc_smcd_gid_chid {
 struct smc_clc_v2_extension {
 	struct smc_clnt_opts_area_hdr hdr;
 	u8 roce[16];		/* RoCEv2 GID */
-	u8 reserved[16];
+	u8 max_conns;
+	u8 reserved[15];
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
 
@@ -236,7 +238,8 @@ struct smc_clc_first_contact_ext {
 
 struct smc_clc_first_contact_ext_v2x {
 	struct smc_clc_first_contact_ext fce_v20;
-	u8 reserved3[4];
+	u8 max_conns; /* for SMC-R only */
+	u8 reserved3[3];
 	__be32 vendor_exp_options;
 	u8 reserved4[8];
 } __packed;		/* format defined in
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6aa3db47a956..5de1fbaa6e28 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -895,9 +895,11 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 			lgr->uses_gateway = ini->smcrv2.uses_gateway;
 			memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
 			       ETH_ALEN);
+			lgr->max_conns = ini->max_conns;
 		} else {
 			ibdev = ini->ib_dev;
 			ibport = ini->ib_port;
+			lgr->max_conns = SMC_RMBS_PER_LGR_MAX;
 		}
 		memcpy(lgr->pnet_id, ibdev->pnetid[ibport - 1],
 		       SMC_MAX_PNETID_LEN);
@@ -1890,7 +1892,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		    (ini->smcd_version == SMC_V2 ||
 		     lgr->vlan_id == ini->vlan_id) &&
 		    (role == SMC_CLNT || ini->is_smcd ||
-		    (lgr->conns_num < SMC_RMBS_PER_LGR_MAX &&
+		    (lgr->conns_num < lgr->max_conns &&
 		      !bitmap_full(lgr->rtokens_used_mask, SMC_RMBS_PER_LGR_MAX)))) {
 			/* link group found */
 			ini->first_contact_local = 0;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 1a97fef39127..f4f7299c810a 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -22,6 +22,8 @@
 #include "smc_ib.h"
 
 #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
+#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group */
+#define SMC_CONN_PER_LGR_MIN	16	/* min. # of connections per link group */
 
 struct smc_lgr_list {			/* list of link group definition */
 	struct list_head	list;
@@ -331,6 +333,8 @@ struct smc_link_group {
 			__be32			saddr;
 						/* net namespace */
 			struct net		*net;
+			u8			max_conns;
+						/* max conn can be assigned to lgr */
 		};
 		struct { /* SMC-D */
 			u64			peer_gid;
@@ -375,6 +379,7 @@ struct smc_init_info {
 	u8			smc_type_v1;
 	u8			smc_type_v2;
 	u8			release_ver;
+	u8			max_conns;
 	u8			first_contact_peer;
 	u8			first_contact_local;
 	unsigned short		vlan_id;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 90f0b60b196a..5347b62f1518 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -52,7 +52,8 @@ struct smc_llc_msg_confirm_link {	/* type 0x01 */
 	u8 link_num;
 	u8 link_uid[SMC_LGR_ID_SIZE];
 	u8 max_links;
-	u8 reserved[9];
+	u8 max_conns;
+	u8 reserved[8];
 };
 
 #define SMC_LLC_FLAG_ADD_LNK_REJ	0x40
@@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
 	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
 	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
+	if (link->lgr->smc_version == SMC_V2 &&
+	    link->lgr->peer_smc_release >= SMC_RELEASE_1)
+		confllc->max_conns = link->lgr->max_conns;
 	/* send llc message */
 	rc = smc_wr_tx_send(link, pend);
 put_out:
-- 
2.24.3 (Apple Git-128)

