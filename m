Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315A7C66B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378046AbjJLHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjJLHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:54:20 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C653EC0;
        Thu, 12 Oct 2023 00:54:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VtzoebO_1697097250;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VtzoebO_1697097250)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 15:54:11 +0800
Date:   Thu, 12 Oct 2023 15:54:10 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/18] net/smc: extend GID to 128bits only
 for virtual ISM device
Message-ID: <20231012075410.GQ92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-7-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695568613-125057-7-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 11:16:41PM +0800, Wen Gu wrote:
>Virtual ISM devices are introduced to SMC-Dv2.1 protocal, whose GIDs
>are 128-bits UUIDs as defined by RFC4122. And note that the GIDs of
>ISM devices still remain 64-bits.
>
>This patch adapts the relevant codes, such as CLC handshake, to make
>it compatible with 128 bits GID.
>
>Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>---
> drivers/s390/net/ism_drv.c    | 18 +++++++------
> include/net/smc.h             | 15 +++++++----
> include/uapi/linux/smc.h      |  3 +++
> include/uapi/linux/smc_diag.h |  2 ++
> net/smc/af_smc.c              | 60 +++++++++++++++++++++++++++++++++----------
> net/smc/smc_clc.c             | 43 +++++++++++++++++++++----------
> net/smc/smc_clc.h             |  4 +--
> net/smc/smc_core.c            | 41 +++++++++++++++++++++--------
> net/smc/smc_core.h            |  7 ++---
> net/smc/smc_diag.c            | 11 ++++++--
> net/smc/smc_ism.c             | 18 ++++++++-----
> net/smc/smc_ism.h             |  3 ++-
> net/smc/smc_pnet.c            |  4 +--
> 13 files changed, 163 insertions(+), 66 deletions(-)
>
>diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>index a34e913..8e42eb2 100644
>--- a/drivers/s390/net/ism_drv.c
>+++ b/drivers/s390/net/ism_drv.c
>@@ -774,10 +774,10 @@ static void __exit ism_exit(void)
> /*************************** SMC-D Implementation *****************************/
> 
> #if IS_ENABLED(CONFIG_SMC)
>-static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
>-			   u32 vid)
>+static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>+			   u32 vid_valid, u32 vid)
> {
>-	return ism_query_rgid(smcd->priv, rgid, vid_valid, vid);
>+	return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
> }
> 
> static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>@@ -811,10 +811,10 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
> 	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
> }
> 
>-static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
>-			   u32 event_code, u64 info)
>+static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
>+			   u32 trigger_irq, u32 event_code, u64 info)
> {
>-	return ism_signal_ieq(smcd->priv, rgid, trigger_irq, event_code, info);
>+	return ism_signal_ieq(smcd->priv, rgid->gid, trigger_irq, event_code, info);
> }
> 
> static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
>@@ -830,9 +830,11 @@ static int smcd_supports_v2(void)
> 		SYSTEM_EID.type[0] != '0';
> }
> 
>-static u64 smcd_get_local_gid(struct smcd_dev *smcd)
>+static void smcd_get_local_gid(struct smcd_dev *smcd,
>+			       struct smcd_gid *smcd_gid)
> {
>-	return ism_get_local_gid(smcd->priv);
>+	smcd_gid->gid = ism_get_local_gid(smcd->priv);
>+	smcd_gid->gid_ext = 0;
> }
> 
> static u16 smcd_get_chid(struct smcd_dev *smcd)
>diff --git a/include/net/smc.h b/include/net/smc.h
>index f75116e..d8db5e1 100644
>--- a/include/net/smc.h
>+++ b/include/net/smc.h
>@@ -51,9 +51,14 @@ struct smcd_dmb {
> 
> struct smcd_dev;
> 
>+struct smcd_gid {
>+	u64	gid;
>+	u64	gid_ext;
>+};
>+
> struct smcd_ops {
>-	int (*query_remote_gid)(struct smcd_dev *dev, u64 rgid, u32 vid_valid,
>-				u32 vid);
>+	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
>+				u32 vid_valid, u32 vid);
> 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
> 			    void *client);
> 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
>@@ -61,14 +66,14 @@ struct smcd_ops {
> 	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
> 	int (*set_vlan_required)(struct smcd_dev *dev);
> 	int (*reset_vlan_required)(struct smcd_dev *dev);
>-	int (*signal_event)(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
>-			    u32 event_code, u64 info);
>+	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
>+			    u32 trigger_irq, u32 event_code, u64 info);
> 	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
> 			 bool sf, unsigned int offset, void *data,
> 			 unsigned int size);
> 	int (*supports_v2)(void);
> 	u8* (*get_system_eid)(void);
>-	u64 (*get_local_gid)(struct smcd_dev *dev);
>+	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
> 	u16 (*get_chid)(struct smcd_dev *dev);
> 	struct device* (*get_dev)(struct smcd_dev *dev);
> };
>diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
>index 837fcd4..0d2f020 100644
>--- a/include/uapi/linux/smc.h
>+++ b/include/uapi/linux/smc.h
>@@ -99,6 +99,9 @@ enum {
> 	SMC_NLA_LGR_V2_OS,		/* u8 */
> 	SMC_NLA_LGR_V2_NEG_EID,		/* string */
> 	SMC_NLA_LGR_V2_PEER_HOST,	/* string */
>+	SMC_NLA_LGR_V2_PAD,		/* flag */
>+	SMC_NLA_LGR_V2_GID_EXT,		/* u64 */
>+	SMC_NLA_LGR_V2_PEER_GID_EXT,	/* u64 */

Why those abbributes are add here, which was supposed to add common
abbritubtes ?


> 	__SMC_NLA_LGR_V2_MAX,
> 	SMC_NLA_LGR_V2_MAX = __SMC_NLA_LGR_V2_MAX - 1
> };
>diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
>index 8cb3a6f..78b7dfb 100644
>--- a/include/uapi/linux/smc_diag.h
>+++ b/include/uapi/linux/smc_diag.h
>@@ -107,6 +107,8 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
> 	__aligned_u64	my_gid;		/* My GID */
> 	__aligned_u64	token;		/* Token of DMB */
> 	__aligned_u64	peer_token;	/* Token of remote DMBE */
>+	__aligned_u64	peer_gid_ext;	/* Peer GID extension */
>+	__aligned_u64	my_gid_ext;	/* My GID extension */
> };
> 
> #endif /* _UAPI_SMC_DIAG_H_ */
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index bacdd97..5bb41404 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -719,7 +719,7 @@ static void smcd_conn_save_peer_info(struct smc_sock *smc,
> 	int bufsize = smc_uncompress_bufsize(clc->d0.dmbe_size);
> 
> 	smc->conn.peer_rmbe_idx = clc->d0.dmbe_idx;
>-	smc->conn.peer_token = clc->d0.token;
>+	smc->conn.peer_token = ntohll(clc->d0.token);
> 	/* msg header takes up space in the buffer */
> 	smc->conn.peer_rmbe_size = bufsize - sizeof(struct smcd_cdc_msg);
> 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
>@@ -1044,7 +1044,8 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
> {
> 	int rc = SMC_CLC_DECL_NOSMCDDEV;
> 	struct smcd_dev *smcd;
>-	int i = 1;
>+	int i = 1, slot = 1;
>+	bool is_virtdev;
> 	u16 chid;
> 
> 	if (smcd_indicated(ini->smc_type_v1))
>@@ -1056,14 +1057,21 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
> 		chid = smc_ism_get_chid(smcd);
> 		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
> 			continue;
>+		is_virtdev = __smc_ism_is_virtdev(chid);
> 		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
> 		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
>+			if (is_virtdev && slot == SMC_MAX_ISM_DEVS)
>+				/* no enough space for virtual ISM devices, whose GID
>+				 * takes 2 slots. Try the next potential ISM device.
>+				 */
>+				continue;
> 			ini->ism_dev[i] = smcd;
> 			ini->ism_chid[i] = chid;
> 			ini->is_smcd = true;
> 			rc = 0;
> 			i++;
>-			if (i > SMC_MAX_ISM_DEVS)
>+			slot = is_virtdev ? slot + 2 : slot + 1;
>+			if (slot > SMC_MAX_ISM_DEVS)
> 				break;
> 		}
> 	}
>@@ -1409,8 +1417,13 @@ static int smc_connect_ism(struct smc_sock *smc,
> 		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
> 		if (rc)
> 			return rc;
>+
>+		if (__smc_ism_is_virtdev(ini->ism_chid[ini->ism_selected]))
>+			ini->ism_peer_gid[ini->ism_selected].gid_ext =
>+						ntohll(aclc_v2->d1.gid_ext);
>+		/* for non-virtual ISM devices, peer gid_ext remains 0. */
> 	}
>-	ini->ism_peer_gid[ini->ism_selected] = aclc->d0.gid;
>+	ini->ism_peer_gid[ini->ism_selected].gid = ntohll(aclc->d0.gid);
> 
> 	/* there is only one lgr role for SMC-D; use server lock */
> 	mutex_lock(&smc_server_lgr_pending);
>@@ -2101,7 +2114,8 @@ static bool smc_is_already_selected(struct smcd_dev *smcd,
> 
> /* check for ISM devices matching proposed ISM devices */
> static void smc_check_ism_v2_match(struct smc_init_info *ini,
>-				   u16 proposed_chid, u64 proposed_gid,
>+				   u16 proposed_chid,
>+				   struct smcd_gid *proposed_gid,
> 				   unsigned int *matches)
> {
> 	struct smcd_dev *smcd;
>@@ -2113,7 +2127,11 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
> 			continue;
> 		if (smc_ism_get_chid(smcd) == proposed_chid &&
> 		    !smc_ism_cantalk(proposed_gid, ISM_RESERVED_VLANID, smcd)) {
>-			ini->ism_peer_gid[*matches] = proposed_gid;
>+			ini->ism_peer_gid[*matches].gid = proposed_gid->gid;
>+			if (__smc_ism_is_virtdev(proposed_chid))
>+				ini->ism_peer_gid[*matches].gid_ext =
>+							proposed_gid->gid_ext;
>+				/* non-virtual ISM's peer gid_ext remains 0. */
> 			ini->ism_dev[*matches] = smcd;
> 			(*matches)++;
> 			break;
>@@ -2135,9 +2153,11 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
> 	struct smc_clc_v2_extension *smc_v2_ext;
> 	struct smc_clc_msg_smcd *pclc_smcd;
> 	unsigned int matches = 0;
>+	struct smcd_gid smcd_gid;
> 	u8 smcd_version;
> 	u8 *eid = NULL;
> 	int i, rc;
>+	u16 chid;
> 
> 	if (!(ini->smcd_version & SMC_V2) || !smcd_indicated(ini->smc_type_v2))
> 		goto not_found;
>@@ -2147,18 +2167,31 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
> 	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
> 
> 	mutex_lock(&smcd_dev_list.mutex);
>-	if (pclc_smcd->ism.chid)
>+	if (pclc_smcd->ism.chid) {
> 		/* check for ISM device matching proposed native ISM device */
>+		smcd_gid.gid = ntohll(pclc_smcd->ism.gid);
>+		smcd_gid.gid_ext = 0;
> 		smc_check_ism_v2_match(ini, ntohs(pclc_smcd->ism.chid),
>-				       ntohll(pclc_smcd->ism.gid), &matches);
>+				       &smcd_gid, &matches);
>+	}
> 	for (i = 1; i <= smc_v2_ext->hdr.ism_gid_cnt; i++) {
> 		/* check for ISM devices matching proposed non-native ISM
> 		 * devices
> 		 */
>-		smc_check_ism_v2_match(ini,
>-				       ntohs(smcd_v2_ext->gidchid[i - 1].chid),
>-				       ntohll(smcd_v2_ext->gidchid[i - 1].gid),
>-				       &matches);
>+		smcd_gid.gid = ntohll(smcd_v2_ext->gidchid[i - 1].gid);
>+		smcd_gid.gid_ext = 0;
>+		chid = ntohs(smcd_v2_ext->gidchid[i - 1].chid);
>+		if (__smc_ism_is_virtdev(chid)) {
>+			if (i >= smc_v2_ext->hdr.ism_gid_cnt ||
>+			    chid != ntohs(smcd_v2_ext->gidchid[i].chid))
>+				/* check if next slot exists and the next slot's
>+				 * chid is consistent with the current slot.
>+				 */
>+				continue;
>+
>+			smcd_gid.gid_ext = ntohll(smcd_v2_ext->gidchid[i++].gid);
>+		}
>+		smc_check_ism_v2_match(ini, chid, &smcd_gid, &matches);
> 	}
> 	mutex_unlock(&smcd_dev_list.mutex);
> 
>@@ -2207,7 +2240,8 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
> 	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
> 		goto not_found;
> 	ini->is_smcd = true; /* prepare ISM check */
>-	ini->ism_peer_gid[0] = ntohll(pclc_smcd->ism.gid);
>+	ini->ism_peer_gid[0].gid = ntohll(pclc_smcd->ism.gid);
>+	ini->ism_peer_gid[0].gid_ext = 0;
> 	rc = smc_find_ism_device(new_smc, ini);
> 	if (rc)
> 		goto not_found;
>diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>index 125b0d2..aeb9643 100644
>--- a/net/smc/smc_clc.c
>+++ b/net/smc/smc_clc.c
>@@ -882,11 +882,13 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 		       ETH_ALEN);
> 	}
> 	if (smcd_indicated(ini->smc_type_v1)) {
>+		struct smcd_gid smcd_gid;
>+
> 		/* add SMC-D specifics */
> 		if (ini->ism_dev[0]) {
> 			smcd = ini->ism_dev[0];
>-			pclc_smcd->ism.gid =
>-				htonll(smcd->ops->get_local_gid(smcd));
>+			smcd->ops->get_local_gid(smcd, &smcd_gid);
>+			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
> 			pclc_smcd->ism.chid =
> 				htons(smc_ism_get_chid(ini->ism_dev[0]));
> 		}
>@@ -919,10 +921,11 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 		read_unlock(&smc_clc_eid_table.lock);
> 	}
> 	if (smcd_indicated(ini->smc_type_v2)) {
>+		struct smcd_gid smcd_gid;
> 		u8 *eid = NULL;
>+		int slot = 0;
> 
> 		v2_ext->hdr.flag.seid = smc_clc_eid_table.seid_enabled;
>-		v2_ext->hdr.ism_gid_cnt = ini->ism_offered_cnt;
> 		v2_ext->hdr.smcd_v2_ext_offset = htons(sizeof(*v2_ext) -
> 				offsetofend(struct smc_clnt_opts_area_hdr,
> 					    smcd_v2_ext_offset) +
>@@ -934,14 +937,21 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 		if (ini->ism_offered_cnt) {
> 			for (i = 1; i <= ini->ism_offered_cnt; i++) {
> 				smcd = ini->ism_dev[i];
>-				gidchids[i - 1].gid =
>-					htonll(smcd->ops->get_local_gid(smcd));
>-				gidchids[i - 1].chid =
>+				smcd->ops->get_local_gid(smcd, &smcd_gid);
>+				gidchids[slot].chid =
> 					htons(smc_ism_get_chid(ini->ism_dev[i]));
>+				gidchids[slot].gid = htonll(smcd_gid.gid);
>+				if (__smc_ism_is_virtdev(gidchids[slot].chid)) {
>+					/* virtual-ism takes two slots */
>+					gidchids[slot + 1].chid = gidchids[slot].chid;
>+					gidchids[slot + 1].gid = htonll(smcd_gid.gid_ext);
>+					slot++;
>+				}
>+				slot++;
> 			}
>-			plen += ini->ism_offered_cnt *
>-				sizeof(struct smc_clc_smcd_gid_chid);
>+			plen += slot * sizeof(struct smc_clc_smcd_gid_chid);
> 		}
>+		v2_ext->hdr.ism_gid_cnt = slot;
> 	}
> 	if (smcr_indicated(ini->smc_type_v2)) {
> 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
>@@ -977,7 +987,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
> 			vec[i++].iov_len = sizeof(*smcd_v2_ext);
> 			if (ini->ism_offered_cnt) {
> 				vec[i].iov_base = gidchids;
>-				vec[i++].iov_len = ini->ism_offered_cnt *
>+				vec[i++].iov_len = v2_ext->hdr.ism_gid_cnt *
> 					sizeof(struct smc_clc_smcd_gid_chid);
> 			}
> 		}
>@@ -1019,23 +1029,28 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
> 	if (first_contact)
> 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
> 	if (conn->lgr->is_smcd) {
>+		struct smcd_gid smcd_gid;
>+		u16 chid;
>+
> 		/* SMC-D specific settings */
> 		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
> 		       sizeof(SMCD_EYECATCHER));
>+		conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd, &smcd_gid);
> 		clc->hdr.typev1 = SMC_TYPE_D;
>-		clc->d0.gid =
>-			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
>-		clc->d0.token = conn->rmb_desc->token;
>+		clc->d0.gid = htonll(smcd_gid.gid);
>+		clc->d0.token = htonll(conn->rmb_desc->token);
> 		clc->d0.dmbe_size = conn->rmbe_size_comp;
> 		clc->d0.dmbe_idx = 0;
> 		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
> 		if (version == SMC_V1) {
> 			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
> 		} else {
>-			clc_v2->d1.chid =
>-				htons(smc_ism_get_chid(conn->lgr->smcd));
>+			chid = smc_ism_get_chid(conn->lgr->smcd);
>+			clc_v2->d1.chid = htons(chid);
> 			if (eid && eid[0])
> 				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>+			if (__smc_ism_is_virtdev(chid))
>+				clc_v2->d1.gid_ext = htonll(smcd_gid.gid_ext);
> 			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
> 			if (first_contact) {
> 				fce_len = smc_clc_fill_fce(&fce, ini);
>diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>index bcf37c8..611763a 100644
>--- a/net/smc/smc_clc.h
>+++ b/net/smc/smc_clc.h
>@@ -281,8 +281,8 @@ struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
> 			struct smcd_clc_msg_accept_confirm_common d0;
> 			__be16 chid;
> 			u8 eid[SMC_MAX_EID_LEN];
>-			u8 reserved5[8];
>-		} d1;
>+			__be64 gid_ext;
>+		} __packed d1;
> 	};
> };
> 
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index d520ee6..6d7c738 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -284,6 +284,9 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
> {
> 	char smc_host[SMC_MAX_HOSTNAME_LEN + 1];
> 	char smc_eid[SMC_MAX_EID_LEN + 1];
>+	struct smcd_dev *smcd = lgr->smcd;
>+	struct smcd_gid smcd_gid;
>+	bool is_virtdev;
> 
> 	if (nla_put_u8(skb, SMC_NLA_LGR_V2_VER, lgr->smc_version))
> 		goto errv2attr;
>@@ -299,6 +302,16 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
> 	smc_eid[SMC_MAX_EID_LEN] = 0;
> 	if (nla_put_string(skb, SMC_NLA_LGR_V2_NEG_EID, smc_eid))
> 		goto errv2attr;
>+	smcd->ops->get_local_gid(smcd, &smcd_gid);
>+	is_virtdev = smc_ism_is_virtdev(smcd);
>+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_GID_EXT,
>+			      is_virtdev ? smcd_gid.gid_ext : 0,
>+			      SMC_NLA_LGR_V2_PAD))
>+		goto errv2attr;
>+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_PEER_GID_EXT,
>+			      is_virtdev ? lgr->peer_gid.gid_ext : 0,
>+			      SMC_NLA_LGR_V2_PAD))
>+		goto errv2attr;

I ran into a kernel panic which pointed to here, and it turns out the
smcd here is NULL. See below:

But taking a closer look at the code, I'm wondering why those SMCD
related attributes are filled in smc_nl_fill_lgr_v2_common() which
should only fill the common attributes ?



[17567.395214] BUG: kernel NULL pointer dereference, address:
0000000000000000
[17567.395729] #PF: supervisor read access in kernel mode
[17567.396086] #PF: error_code(0x0000) - not-present page
[17567.396442] PGD 0 P4D 0 
[17567.396623] Oops: 0000 [#1] SMP NOPTI
[17567.396873] CPU: 7 PID: 34729 Comm: smcr Tainted: G        W   E
6.6.0-rc2-00669-gf4cfa8873d90-dirty #577
[17567.397528] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[17567.398272] RIP: 0010:smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0
[smc]
[17567.398734] Code: 21 0f 87 0e 01 00 00 0f 84 fc 00 00 00 8d 50 01 48
8d 4c 24 3f be 03 00 00 00 48 89 ef e8 28 c4 1a e1 85 c0 0f 85 72 fe ff
ff <49> 8b 45 00 4c 89 ef 48 8d 74 24 08 48 8b 40 68 ff d0 0f 1f 00 49
[17567.399950] RSP: 0018:ffffc90002adb820 EFLAGS: 00010246
[17567.400297] RAX: 0000000000000000 RBX: ffff8881cad2402c RCX:
0000000000000057
[17567.400769] RDX: 0000000000000000 RSI: ffffc90002adb85f RDI:
ffff8881cad24074
[17567.401237] RBP: ffff888107d4cd00 R08: 0020202020202020 R09:
2020202020202020
[17567.401709] R10: 2020202020202020 R11: 2020202020415955 R12:
ffff8882673e0000
[17567.402176] R13: 0000000000000000 R14: ffff8881cad23fe4 R15:
ffff88813fbe4b60
[17567.402650] FS:  00007f679f655740(0000) GS:ffff88842fdc0000(0000)
knlGS:0000000000000000
[17567.403179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17567.403561] CR2: 0000000000000000 CR3: 00000001680d2005 CR4:
0000000000370ee0
[17567.404029] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[17567.404501] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[17567.404968] Call Trace:
[17567.405140]  <TASK>
[17567.405287]  ? __die_body+0x1f/0x70
[17567.405533]  ? page_fault_oops+0x14c/0x440
[17567.405813]  ? exc_page_fault+0x69/0x120
[17567.406079]  ? asm_exc_page_fault+0x26/0x30
[17567.406361]  ? smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0 [smc]
[17567.406778]  smc_nl_fill_lgr_list.constprop.0+0x368/0x4e0 [smc]
[17567.407180]  smcr_nl_get_link+0x17/0x20 [smc]
[17567.407484]  genl_dumpit+0x32/0x90
[17567.407722]  netlink_dump+0x19d/0x3b0
[17567.407971]  __netlink_dump_start+0x1d3/0x290
[17567.408266]  genl_family_rcv_msg_dumpit.isra.0+0x7d/0xd0
[17567.408625]  ? __pfx_genl_start+0x10/0x10
[17567.408897]  ? __pfx_genl_dumpit+0x10/0x10
[17567.409172]  ? __pfx_genl_done+0x10/0x10
[17567.409437]  genl_rcv_msg+0x113/0x2a0
[17567.409690]  ? __pfx_smcr_nl_get_link+0x10/0x10 [smc]
[17567.410040]  ? __pfx_genl_rcv_msg+0x10/0x10
[17567.410312]  netlink_rcv_skb+0x58/0x110
[17567.410567]  genl_rcv+0x28/0x40
[17567.410777]  netlink_unicast+0x181/0x240
[17567.411033]  netlink_sendmsg+0x240/0x4a0
[17567.411288]  sock_sendmsg+0xb1/0xc0
[17567.411524]  ____sys_sendmsg+0x20f/0x300
[17567.411780]  ? copy_msghdr_from_user+0x62/0x80
[17567.412067]  ___sys_sendmsg+0x81/0xc0
[17567.412306]  ? folio_add_lru+0x2b/0x30
[17567.412555]  ? do_anonymous_page+0x18d/0x4e0
[17567.412837]  ? __handle_mm_fault+0x47f/0x7c0
[17567.413115]  __sys_sendmsg+0x4d/0x80
[17567.413349]  ? exit_to_user_mode_prepare+0x3c/0x190
[17567.413669]  do_syscall_64+0x3c/0x90
[17567.413908]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[17567.414234] RIP: 0033:0x7f679f79c177
[17567.414467] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[17567.415640] RSP: 002b:00007ffe6d08c168 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[17567.416119] RAX: ffffffffffffffda RBX: 00005619cb470390 RCX:
00007f679f79c177
[17567.416574] RDX: 0000000000000000 RSI: 00007ffe6d08c1a0 RDI:
0000000000000003
[17567.417026] RBP: 00005619cb4702a0 R08: 0000000000000004 R09:
0000000000000300
[17567.417481] R10: 0000000000000004 R11: 0000000000000246 R12:
00005619cb4704b0
[17567.417932] R13: 00007ffe6d08c1a0 R14: 0000000000000000 R15:
0000000000000000
[17567.418385]  </TASK>
[17567.418535] Modules linked in: smc_diag(E) smc(E) rpcrdma(E)
sunrpc(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E) target_core_mod(E)
ib_ipoib(E) ib_iser(E) libiscsi(E) scsi_transport_iscsi(E) mlx5_ib(E)
rfkill(E)
[17567.419722] CR2: 0000000000000000
[17567.419940] ---[ end trace 0000000000000000 ]---
[17567.420237] RIP: 0010:smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0
[smc]
[17567.420676] Code: 21 0f 87 0e 01 00 00 0f 84 fc 00 00 00 8d 50 01 48
8d 4c 24 3f be 03 00 00 00 48 89 ef e8 28 c4 1a e1 85 c0 0f 85 72 fe ff
ff <49> 8b 45 00 4c 89 ef 48 8d 74 24 08 48 8b 40 68 ff d0 0f 1f 00 49
[17567.421842] RSP: 0018:ffffc90002adb820 EFLAGS: 00010246
[17567.422176] RAX: 0000000000000000 RBX: ffff8881cad2402c RCX:
0000000000000057
[17567.422631] RDX: 0000000000000000 RSI: ffffc90002adb85f RDI:
ffff8881cad24074
[17567.423082] RBP: ffff888107d4cd00 R08: 0020202020202020 R09:
2020202020202020
[17567.423536] R10: 2020202020202020 R11: 2020202020415955 R12:
ffff8882673e0000
[17567.423987] R13: 0000000000000000 R14: ffff8881cad23fe4 R15:
ffff88813fbe4b60
[17567.424438] FS:  00007f679f655740(0000) GS:ffff88842fdc0000(0000)
knlGS:0000000000000000
[17567.424950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17567.425317] CR2: 0000000000000000 CR3: 00000001680d2005 CR4:
0000000000370ee0
[17567.425773] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[17567.426225] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[17567.426677] Kernel panic - not syncing: Fatal exception in interrupt
[17567.427583] Kernel Offset: disabled
[17567.427817] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---


Best regards,
Dust



> 
> 	nla_nest_end(skb, v2_attrs);
> 	return 0;

