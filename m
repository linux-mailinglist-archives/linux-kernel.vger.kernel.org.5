Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E922C7ACA54
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjIXPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjIXPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:17:35 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900D11B;
        Sun, 24 Sep 2023 08:17:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsimePF_1695568631;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsimePF_1695568631)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:13 +0800
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
Subject: [PATCH net-next v4 06/18] net/smc: extend GID to 128bits only for virtual ISM device
Date:   Sun, 24 Sep 2023 23:16:41 +0800
Message-Id: <1695568613-125057-7-git-send-email-guwen@linux.alibaba.com>
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

Virtual ISM devices are introduced to SMC-Dv2.1 protocal, whose GIDs
are 128-bits UUIDs as defined by RFC4122. And note that the GIDs of
ISM devices still remain 64-bits.

This patch adapts the relevant codes, such as CLC handshake, to make
it compatible with 128 bits GID.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/s390/net/ism_drv.c    | 18 +++++++------
 include/net/smc.h             | 15 +++++++----
 include/uapi/linux/smc.h      |  3 +++
 include/uapi/linux/smc_diag.h |  2 ++
 net/smc/af_smc.c              | 60 +++++++++++++++++++++++++++++++++----------
 net/smc/smc_clc.c             | 43 +++++++++++++++++++++----------
 net/smc/smc_clc.h             |  4 +--
 net/smc/smc_core.c            | 41 +++++++++++++++++++++--------
 net/smc/smc_core.h            |  7 ++---
 net/smc/smc_diag.c            | 11 ++++++--
 net/smc/smc_ism.c             | 18 ++++++++-----
 net/smc/smc_ism.h             |  3 ++-
 net/smc/smc_pnet.c            |  4 +--
 13 files changed, 163 insertions(+), 66 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index a34e913..8e42eb2 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -774,10 +774,10 @@ static void __exit ism_exit(void)
 /*************************** SMC-D Implementation *****************************/
 
 #if IS_ENABLED(CONFIG_SMC)
-static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
-			   u32 vid)
+static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			   u32 vid_valid, u32 vid)
 {
-	return ism_query_rgid(smcd->priv, rgid, vid_valid, vid);
+	return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
 }
 
 static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
@@ -811,10 +811,10 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
 	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
 }
 
-static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
-			   u32 event_code, u64 info)
+static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			   u32 trigger_irq, u32 event_code, u64 info)
 {
-	return ism_signal_ieq(smcd->priv, rgid, trigger_irq, event_code, info);
+	return ism_signal_ieq(smcd->priv, rgid->gid, trigger_irq, event_code, info);
 }
 
 static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
@@ -830,9 +830,11 @@ static int smcd_supports_v2(void)
 		SYSTEM_EID.type[0] != '0';
 }
 
-static u64 smcd_get_local_gid(struct smcd_dev *smcd)
+static void smcd_get_local_gid(struct smcd_dev *smcd,
+			       struct smcd_gid *smcd_gid)
 {
-	return ism_get_local_gid(smcd->priv);
+	smcd_gid->gid = ism_get_local_gid(smcd->priv);
+	smcd_gid->gid_ext = 0;
 }
 
 static u16 smcd_get_chid(struct smcd_dev *smcd)
diff --git a/include/net/smc.h b/include/net/smc.h
index f75116e..d8db5e1 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -51,9 +51,14 @@ struct smcd_dmb {
 
 struct smcd_dev;
 
+struct smcd_gid {
+	u64	gid;
+	u64	gid_ext;
+};
+
 struct smcd_ops {
-	int (*query_remote_gid)(struct smcd_dev *dev, u64 rgid, u32 vid_valid,
-				u32 vid);
+	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
+				u32 vid_valid, u32 vid);
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
 			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
@@ -61,14 +66,14 @@ struct smcd_ops {
 	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
 	int (*set_vlan_required)(struct smcd_dev *dev);
 	int (*reset_vlan_required)(struct smcd_dev *dev);
-	int (*signal_event)(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
-			    u32 event_code, u64 info);
+	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
+			    u32 trigger_irq, u32 event_code, u64 info);
 	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
 	int (*supports_v2)(void);
 	u8* (*get_system_eid)(void);
-	u64 (*get_local_gid)(struct smcd_dev *dev);
+	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
 };
diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 837fcd4..0d2f020 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -99,6 +99,9 @@ enum {
 	SMC_NLA_LGR_V2_OS,		/* u8 */
 	SMC_NLA_LGR_V2_NEG_EID,		/* string */
 	SMC_NLA_LGR_V2_PEER_HOST,	/* string */
+	SMC_NLA_LGR_V2_PAD,		/* flag */
+	SMC_NLA_LGR_V2_GID_EXT,		/* u64 */
+	SMC_NLA_LGR_V2_PEER_GID_EXT,	/* u64 */
 	__SMC_NLA_LGR_V2_MAX,
 	SMC_NLA_LGR_V2_MAX = __SMC_NLA_LGR_V2_MAX - 1
 };
diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 8cb3a6f..78b7dfb 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -107,6 +107,8 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	__aligned_u64	my_gid;		/* My GID */
 	__aligned_u64	token;		/* Token of DMB */
 	__aligned_u64	peer_token;	/* Token of remote DMBE */
+	__aligned_u64	peer_gid_ext;	/* Peer GID extension */
+	__aligned_u64	my_gid_ext;	/* My GID extension */
 };
 
 #endif /* _UAPI_SMC_DIAG_H_ */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd97..5bb41404 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -719,7 +719,7 @@ static void smcd_conn_save_peer_info(struct smc_sock *smc,
 	int bufsize = smc_uncompress_bufsize(clc->d0.dmbe_size);
 
 	smc->conn.peer_rmbe_idx = clc->d0.dmbe_idx;
-	smc->conn.peer_token = clc->d0.token;
+	smc->conn.peer_token = ntohll(clc->d0.token);
 	/* msg header takes up space in the buffer */
 	smc->conn.peer_rmbe_size = bufsize - sizeof(struct smcd_cdc_msg);
 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
@@ -1044,7 +1044,8 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 {
 	int rc = SMC_CLC_DECL_NOSMCDDEV;
 	struct smcd_dev *smcd;
-	int i = 1;
+	int i = 1, slot = 1;
+	bool is_virtdev;
 	u16 chid;
 
 	if (smcd_indicated(ini->smc_type_v1))
@@ -1056,14 +1057,21 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 		chid = smc_ism_get_chid(smcd);
 		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
 			continue;
+		is_virtdev = __smc_ism_is_virtdev(chid);
 		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
 		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
+			if (is_virtdev && slot == SMC_MAX_ISM_DEVS)
+				/* no enough space for virtual ISM devices, whose GID
+				 * takes 2 slots. Try the next potential ISM device.
+				 */
+				continue;
 			ini->ism_dev[i] = smcd;
 			ini->ism_chid[i] = chid;
 			ini->is_smcd = true;
 			rc = 0;
 			i++;
-			if (i > SMC_MAX_ISM_DEVS)
+			slot = is_virtdev ? slot + 2 : slot + 1;
+			if (slot > SMC_MAX_ISM_DEVS)
 				break;
 		}
 	}
@@ -1409,8 +1417,13 @@ static int smc_connect_ism(struct smc_sock *smc,
 		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
 		if (rc)
 			return rc;
+
+		if (__smc_ism_is_virtdev(ini->ism_chid[ini->ism_selected]))
+			ini->ism_peer_gid[ini->ism_selected].gid_ext =
+						ntohll(aclc_v2->d1.gid_ext);
+		/* for non-virtual ISM devices, peer gid_ext remains 0. */
 	}
-	ini->ism_peer_gid[ini->ism_selected] = aclc->d0.gid;
+	ini->ism_peer_gid[ini->ism_selected].gid = ntohll(aclc->d0.gid);
 
 	/* there is only one lgr role for SMC-D; use server lock */
 	mutex_lock(&smc_server_lgr_pending);
@@ -2101,7 +2114,8 @@ static bool smc_is_already_selected(struct smcd_dev *smcd,
 
 /* check for ISM devices matching proposed ISM devices */
 static void smc_check_ism_v2_match(struct smc_init_info *ini,
-				   u16 proposed_chid, u64 proposed_gid,
+				   u16 proposed_chid,
+				   struct smcd_gid *proposed_gid,
 				   unsigned int *matches)
 {
 	struct smcd_dev *smcd;
@@ -2113,7 +2127,11 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
 			continue;
 		if (smc_ism_get_chid(smcd) == proposed_chid &&
 		    !smc_ism_cantalk(proposed_gid, ISM_RESERVED_VLANID, smcd)) {
-			ini->ism_peer_gid[*matches] = proposed_gid;
+			ini->ism_peer_gid[*matches].gid = proposed_gid->gid;
+			if (__smc_ism_is_virtdev(proposed_chid))
+				ini->ism_peer_gid[*matches].gid_ext =
+							proposed_gid->gid_ext;
+				/* non-virtual ISM's peer gid_ext remains 0. */
 			ini->ism_dev[*matches] = smcd;
 			(*matches)++;
 			break;
@@ -2135,9 +2153,11 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	struct smc_clc_v2_extension *smc_v2_ext;
 	struct smc_clc_msg_smcd *pclc_smcd;
 	unsigned int matches = 0;
+	struct smcd_gid smcd_gid;
 	u8 smcd_version;
 	u8 *eid = NULL;
 	int i, rc;
+	u16 chid;
 
 	if (!(ini->smcd_version & SMC_V2) || !smcd_indicated(ini->smc_type_v2))
 		goto not_found;
@@ -2147,18 +2167,31 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
 
 	mutex_lock(&smcd_dev_list.mutex);
-	if (pclc_smcd->ism.chid)
+	if (pclc_smcd->ism.chid) {
 		/* check for ISM device matching proposed native ISM device */
+		smcd_gid.gid = ntohll(pclc_smcd->ism.gid);
+		smcd_gid.gid_ext = 0;
 		smc_check_ism_v2_match(ini, ntohs(pclc_smcd->ism.chid),
-				       ntohll(pclc_smcd->ism.gid), &matches);
+				       &smcd_gid, &matches);
+	}
 	for (i = 1; i <= smc_v2_ext->hdr.ism_gid_cnt; i++) {
 		/* check for ISM devices matching proposed non-native ISM
 		 * devices
 		 */
-		smc_check_ism_v2_match(ini,
-				       ntohs(smcd_v2_ext->gidchid[i - 1].chid),
-				       ntohll(smcd_v2_ext->gidchid[i - 1].gid),
-				       &matches);
+		smcd_gid.gid = ntohll(smcd_v2_ext->gidchid[i - 1].gid);
+		smcd_gid.gid_ext = 0;
+		chid = ntohs(smcd_v2_ext->gidchid[i - 1].chid);
+		if (__smc_ism_is_virtdev(chid)) {
+			if (i >= smc_v2_ext->hdr.ism_gid_cnt ||
+			    chid != ntohs(smcd_v2_ext->gidchid[i].chid))
+				/* check if next slot exists and the next slot's
+				 * chid is consistent with the current slot.
+				 */
+				continue;
+
+			smcd_gid.gid_ext = ntohll(smcd_v2_ext->gidchid[i++].gid);
+		}
+		smc_check_ism_v2_match(ini, chid, &smcd_gid, &matches);
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
@@ -2207,7 +2240,8 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
 		goto not_found;
 	ini->is_smcd = true; /* prepare ISM check */
-	ini->ism_peer_gid[0] = ntohll(pclc_smcd->ism.gid);
+	ini->ism_peer_gid[0].gid = ntohll(pclc_smcd->ism.gid);
+	ini->ism_peer_gid[0].gid_ext = 0;
 	rc = smc_find_ism_device(new_smc, ini);
 	if (rc)
 		goto not_found;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 125b0d2..aeb9643 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -882,11 +882,13 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		       ETH_ALEN);
 	}
 	if (smcd_indicated(ini->smc_type_v1)) {
+		struct smcd_gid smcd_gid;
+
 		/* add SMC-D specifics */
 		if (ini->ism_dev[0]) {
 			smcd = ini->ism_dev[0];
-			pclc_smcd->ism.gid =
-				htonll(smcd->ops->get_local_gid(smcd));
+			smcd->ops->get_local_gid(smcd, &smcd_gid);
+			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
 			pclc_smcd->ism.chid =
 				htons(smc_ism_get_chid(ini->ism_dev[0]));
 		}
@@ -919,10 +921,11 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		read_unlock(&smc_clc_eid_table.lock);
 	}
 	if (smcd_indicated(ini->smc_type_v2)) {
+		struct smcd_gid smcd_gid;
 		u8 *eid = NULL;
+		int slot = 0;
 
 		v2_ext->hdr.flag.seid = smc_clc_eid_table.seid_enabled;
-		v2_ext->hdr.ism_gid_cnt = ini->ism_offered_cnt;
 		v2_ext->hdr.smcd_v2_ext_offset = htons(sizeof(*v2_ext) -
 				offsetofend(struct smc_clnt_opts_area_hdr,
 					    smcd_v2_ext_offset) +
@@ -934,14 +937,21 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		if (ini->ism_offered_cnt) {
 			for (i = 1; i <= ini->ism_offered_cnt; i++) {
 				smcd = ini->ism_dev[i];
-				gidchids[i - 1].gid =
-					htonll(smcd->ops->get_local_gid(smcd));
-				gidchids[i - 1].chid =
+				smcd->ops->get_local_gid(smcd, &smcd_gid);
+				gidchids[slot].chid =
 					htons(smc_ism_get_chid(ini->ism_dev[i]));
+				gidchids[slot].gid = htonll(smcd_gid.gid);
+				if (__smc_ism_is_virtdev(gidchids[slot].chid)) {
+					/* virtual-ism takes two slots */
+					gidchids[slot + 1].chid = gidchids[slot].chid;
+					gidchids[slot + 1].gid = htonll(smcd_gid.gid_ext);
+					slot++;
+				}
+				slot++;
 			}
-			plen += ini->ism_offered_cnt *
-				sizeof(struct smc_clc_smcd_gid_chid);
+			plen += slot * sizeof(struct smc_clc_smcd_gid_chid);
 		}
+		v2_ext->hdr.ism_gid_cnt = slot;
 	}
 	if (smcr_indicated(ini->smc_type_v2)) {
 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
@@ -977,7 +987,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 			vec[i++].iov_len = sizeof(*smcd_v2_ext);
 			if (ini->ism_offered_cnt) {
 				vec[i].iov_base = gidchids;
-				vec[i++].iov_len = ini->ism_offered_cnt *
+				vec[i++].iov_len = v2_ext->hdr.ism_gid_cnt *
 					sizeof(struct smc_clc_smcd_gid_chid);
 			}
 		}
@@ -1019,23 +1029,28 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 	if (first_contact)
 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
 	if (conn->lgr->is_smcd) {
+		struct smcd_gid smcd_gid;
+		u16 chid;
+
 		/* SMC-D specific settings */
 		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
 		       sizeof(SMCD_EYECATCHER));
+		conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd, &smcd_gid);
 		clc->hdr.typev1 = SMC_TYPE_D;
-		clc->d0.gid =
-			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
-		clc->d0.token = conn->rmb_desc->token;
+		clc->d0.gid = htonll(smcd_gid.gid);
+		clc->d0.token = htonll(conn->rmb_desc->token);
 		clc->d0.dmbe_size = conn->rmbe_size_comp;
 		clc->d0.dmbe_idx = 0;
 		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
 		if (version == SMC_V1) {
 			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
 		} else {
-			clc_v2->d1.chid =
-				htons(smc_ism_get_chid(conn->lgr->smcd));
+			chid = smc_ism_get_chid(conn->lgr->smcd);
+			clc_v2->d1.chid = htons(chid);
 			if (eid && eid[0])
 				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
+			if (__smc_ism_is_virtdev(chid))
+				clc_v2->d1.gid_ext = htonll(smcd_gid.gid_ext);
 			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact) {
 				fce_len = smc_clc_fill_fce(&fce, ini);
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index bcf37c8..611763a 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -281,8 +281,8 @@ struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
 			struct smcd_clc_msg_accept_confirm_common d0;
 			__be16 chid;
 			u8 eid[SMC_MAX_EID_LEN];
-			u8 reserved5[8];
-		} d1;
+			__be64 gid_ext;
+		} __packed d1;
 	};
 };
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d520ee6..6d7c738 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -284,6 +284,9 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
 {
 	char smc_host[SMC_MAX_HOSTNAME_LEN + 1];
 	char smc_eid[SMC_MAX_EID_LEN + 1];
+	struct smcd_dev *smcd = lgr->smcd;
+	struct smcd_gid smcd_gid;
+	bool is_virtdev;
 
 	if (nla_put_u8(skb, SMC_NLA_LGR_V2_VER, lgr->smc_version))
 		goto errv2attr;
@@ -299,6 +302,16 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
 	smc_eid[SMC_MAX_EID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_V2_NEG_EID, smc_eid))
 		goto errv2attr;
+	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	is_virtdev = smc_ism_is_virtdev(smcd);
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_GID_EXT,
+			      is_virtdev ? smcd_gid.gid_ext : 0,
+			      SMC_NLA_LGR_V2_PAD))
+		goto errv2attr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_PEER_GID_EXT,
+			      is_virtdev ? lgr->peer_gid.gid_ext : 0,
+			      SMC_NLA_LGR_V2_PAD))
+		goto errv2attr;
 
 	nla_nest_end(skb, v2_attrs);
 	return 0;
@@ -506,6 +519,7 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 {
 	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
 	struct smcd_dev *smcd = lgr->smcd;
+	struct smcd_gid smcd_gid;
 	struct nlattr *attrs;
 	void *nlh;
 
@@ -521,11 +535,11 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_ID, *((u32 *)&lgr->id)))
 		goto errattr;
+	smcd->ops->get_local_gid(smcd, &smcd_gid);
 	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
-			      smcd->ops->get_local_gid(smcd),
-				  SMC_NLA_LGR_D_PAD))
+			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
 		goto errattr;
-	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid,
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid.gid,
 			      SMC_NLA_LGR_D_PAD))
 		goto errattr;
 	if (nla_put_u8(skb, SMC_NLA_LGR_D_VLAN_ID, lgr->vlan_id))
@@ -876,7 +890,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		/* SMC-D specific settings */
 		smcd = ini->ism_dev[ini->ism_selected];
 		get_device(smcd->ops->get_dev(smcd));
-		lgr->peer_gid = ini->ism_peer_gid[ini->ism_selected];
+		memcpy(&lgr->peer_gid, &ini->ism_peer_gid[ini->ism_selected],
+		       sizeof(struct smcd_gid));
 		lgr->smcd = ini->ism_dev[ini->ism_selected];
 		lgr_list = &ini->ism_dev[ini->ism_selected]->lgr_list;
 		lgr_lock = &lgr->smcd->lgr_lock;
@@ -1514,7 +1529,8 @@ void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 }
 
 /* Called when peer lgr shutdown (regularly or abnormally) is received */
-void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
+void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
+			unsigned short vlan)
 {
 	struct smc_link_group *lgr, *l;
 	LIST_HEAD(lgr_free_list);
@@ -1522,7 +1538,10 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 	/* run common cleanup function and build free list */
 	spin_lock_bh(&dev->lgr_lock);
 	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
-		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
+		if ((!peer_gid->gid ||
+		     (lgr->peer_gid.gid == peer_gid->gid &&
+		      !smc_ism_is_virtdev(dev) ? 1 :
+		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
 		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
 			if (peer_gid) /* peer triggered termination */
 				lgr->peer_shutdown = 1;
@@ -1859,10 +1878,12 @@ static bool smcr_lgr_match(struct smc_link_group *lgr, u8 smcr_version,
 	return false;
 }
 
-static bool smcd_lgr_match(struct smc_link_group *lgr,
-			   struct smcd_dev *smcismdev, u64 peer_gid)
+static bool smcd_lgr_match(struct smc_link_group *lgr, struct smcd_dev *smcismdev,
+			   struct smcd_gid *peer_gid)
 {
-	return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
+	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
+		smc_ism_is_virtdev(smcismdev) ?
+		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
 }
 
 /* create a new SMC connection (and a new link group if necessary) */
@@ -1892,7 +1913,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		write_lock_bh(&lgr->conns_lock);
 		if ((ini->is_smcd ?
 		     smcd_lgr_match(lgr, ini->ism_dev[ini->ism_selected],
-				    ini->ism_peer_gid[ini->ism_selected]) :
+				    &ini->ism_peer_gid[ini->ism_selected]) :
 		     smcr_lgr_match(lgr, ini->smcr_version,
 				    ini->peer_systemid,
 				    ini->peer_gid, ini->peer_mac, role,
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 9f65678..d57eb9b 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 #include <net/genetlink.h>
+#include <net/smc.h>
 
 #include "smc.h"
 #include "smc_ib.h"
@@ -355,7 +356,7 @@ struct smc_link_group {
 						/* max links can be added in lgr */
 		};
 		struct { /* SMC-D */
-			u64			peer_gid;
+			struct smcd_gid		peer_gid;
 						/* Peer GID (remote) */
 			struct smcd_dev		*smcd;
 						/* ISM device for VLAN reg. */
@@ -417,7 +418,7 @@ struct smc_init_info {
 	u32			ib_clcqpn;
 	struct smc_init_info_smcrv2 smcrv2;
 	/* SMC-D */
-	u64			ism_peer_gid[SMC_MAX_ISM_DEVS + 1];
+	struct smcd_gid		ism_peer_gid[SMC_MAX_ISM_DEVS + 1];
 	struct smcd_dev		*ism_dev[SMC_MAX_ISM_DEVS + 1];
 	u16			ism_chid[SMC_MAX_ISM_DEVS + 1];
 	u8			ism_offered_cnt; /* # of ISM devices offered */
@@ -545,7 +546,7 @@ static inline void smc_set_pci_values(struct pci_dev *pci_dev,
 void smc_lgr_put(struct smc_link_group *lgr);
 void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport);
 void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport);
-void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
+void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
 			unsigned short vlan);
 void smc_smcd_terminate_all(struct smcd_dev *dev);
 void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 7ff2152..a7a48b6 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -21,6 +21,7 @@
 
 #include "smc.h"
 #include "smc_core.h"
+#include "smc_ism.h"
 
 struct smc_diag_dump_ctx {
 	int pos[2];
@@ -168,12 +169,18 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 		struct smc_connection *conn = &smc->conn;
 		struct smcd_diag_dmbinfo dinfo;
 		struct smcd_dev *smcd = conn->lgr->smcd;
+		struct smcd_gid smcd_gid;
 
 		memset(&dinfo, 0, sizeof(dinfo));
 
 		dinfo.linkid = *((u32 *)conn->lgr->id);
-		dinfo.peer_gid = conn->lgr->peer_gid;
-		dinfo.my_gid = smcd->ops->get_local_gid(smcd);
+		dinfo.peer_gid = conn->lgr->peer_gid.gid;
+		smcd->ops->get_local_gid(smcd, &smcd_gid);
+		dinfo.my_gid = smcd_gid.gid;
+		if (smc_ism_is_virtdev(smcd)) {
+			dinfo.peer_gid_ext = conn->lgr->peer_gid.gid_ext;
+			dinfo.my_gid_ext = smcd_gid.gid_ext;
+		}
 		dinfo.token = conn->rmb_desc->token;
 		dinfo.peer_token = conn->peer_token;
 
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 8f1ba74..0922fab 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -44,7 +44,8 @@ static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
 #endif
 
 /* Test if an ISM communication is possible - same CPC */
-int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *smcd)
+int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
+		    struct smcd_dev *smcd)
 {
 	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
 					   vlan_id);
@@ -223,7 +224,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	dmb.dmb_len = dmb_len;
 	dmb.sba_idx = dmb_desc->sba_idx;
 	dmb.vlan_id = lgr->vlan_id;
-	dmb.rgid = lgr->peer_gid;
+	dmb.rgid = lgr->peer_gid.gid;
 	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, lgr->smcd->client);
 	if (!rc) {
 		dmb_desc->sba_idx = dmb.sba_idx;
@@ -353,18 +354,20 @@ struct smc_ism_event_work {
 
 static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 {
+	struct smcd_gid peer_gid = { .gid = wrk->event.tok,
+				     .gid_ext = 0 };
 	union smcd_sw_event_info ev_info;
 
 	ev_info.info = wrk->event.info;
 	switch (wrk->event.code) {
 	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
-		smc_smcd_terminate(wrk->smcd, wrk->event.tok, ev_info.vlan_id);
+		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
 		break;
 	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
 		if (ev_info.code == ISM_EVENT_REQUEST) {
 			ev_info.code = ISM_EVENT_RESPONSE;
 			wrk->smcd->ops->signal_event(wrk->smcd,
-						     wrk->event.tok,
+						     &peer_gid,
 						     ISM_EVENT_REQUEST_IR,
 						     ISM_EVENT_CODE_TESTLINK,
 						     ev_info.info);
@@ -378,10 +381,13 @@ static void smc_ism_event_work(struct work_struct *work)
 {
 	struct smc_ism_event_work *wrk =
 		container_of(work, struct smc_ism_event_work, work);
+	struct smcd_gid smcd_gid = { .gid = wrk->event.tok,
+				     .gid_ext = 0 };
 
 	switch (wrk->event.type) {
 	case ISM_EVENT_GID:	/* GID event, token is peer GID */
-		smc_smcd_terminate(wrk->smcd, wrk->event.tok, VLAN_VID_MASK);
+		smcd_gid.gid = wrk->event.tok;
+		smc_smcd_terminate(wrk->smcd, &smcd_gid, VLAN_VID_MASK);
 		break;
 	case ISM_EVENT_DMB:
 		break;
@@ -530,7 +536,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
 	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
 	ev_info.vlan_id = lgr->vlan_id;
 	ev_info.code = ISM_EVENT_REQUEST;
-	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
+	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
 					  ISM_EVENT_REQUEST_IR,
 					  ISM_EVENT_CODE_SHUTDOWN,
 					  ev_info.info);
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 2ecc8de..e6ea08c 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -33,7 +33,8 @@ struct smc_ism_vlanid {			/* VLAN id set on ISM device */
 
 struct smcd_dev;
 
-int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *dev);
+int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
+		    struct smcd_dev *dev);
 void smc_ism_set_conn(struct smc_connection *conn);
 void smc_ism_unset_conn(struct smc_connection *conn);
 int smc_ism_get_vlan(struct smcd_dev *dev, unsigned short vlan_id);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 1177540..9f2c58c 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1103,8 +1103,8 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
 		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid) &&
 		    !ismdev->going_away &&
-		    (!ini->ism_peer_gid[0] ||
-		     !smc_ism_cantalk(ini->ism_peer_gid[0], ini->vlan_id,
+		    (!ini->ism_peer_gid[0].gid ||
+		     !smc_ism_cantalk(&ini->ism_peer_gid[0], ini->vlan_id,
 				      ismdev))) {
 			ini->ism_dev[0] = ismdev;
 			break;
-- 
1.8.3.1

