Return-Path: <linux-kernel+bounces-52014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DC8492CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6661F22C07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D849468;
	Mon,  5 Feb 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x1W+NMKw"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A941B641;
	Mon,  5 Feb 2024 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707104016; cv=none; b=JhXQG7uAyFJEnGYXNsOAL5Y1iWzb5nd956Nfm30ZmuT4wN+RTVm80xOyU1IHxssUzfi0vpbZ+AnttRLG/9VJMSNklP7D8zVb4m453f2HsbVBG3y6d5nJZzCxIBGR4wM9uGmBp9WKmpv1hB8MYvj+GGp128he16Jrx47Ii9GORs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707104016; c=relaxed/simple;
	bh=GusX03XsSYBVcrLgizOYTdDfBRDJW0TkmlPm0Gnju3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfjPOIX7BN9rOUXi3otc4P6agmKykTOFSn6TR5GAEQizl/Xz9rJioA+FE0/stRXV920shbkwd1IuLNzpMHt0UeKZudXJzk3QiS9a1+5FxXC59QV+Dqs9CjMZ7GVoKSl7V8o+5mhR3nL7X+vq7Stb0l9+skmUQhLnUU1iZ8SPc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x1W+NMKw; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707104010; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yfss92uzzak+nboLgiX+RB8TBpPy1BbgGZcPC6jc+JU=;
	b=x1W+NMKwZtKOQsVGOHm0bhip3/Q8Ua26R0F7ZkNVHVipfKWBvvzCt+jda7h4hPkYb+wZuD+iz6YN+jx3I+HpFmKwViYyGMhMRma4fQU4N0tlyTg08pCHYX4URyuGZbGzGwxHrG0D/lYKGfvnvOJTYSBAMVuWn8HzLyckhTSPJ04=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W02KNaG_1707103997;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W02KNaG_1707103997)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 11:33:29 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/smc: change the term virtual ISM to Emulated-ISM
Date: Mon,  5 Feb 2024 11:33:17 +0800
Message-Id: <20240205033317.127269-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to latest release of SMCv2.1[1], the term 'virtual ISM' has
been changed to 'Emulated-ISM' to avoid the ambiguity of the word
'virtual' in different contexts. So the names or comments in the code
need be modified accordingly.

[1] https://www.ibm.com/support/pages/node/7112343

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c   | 22 +++++++++++-----------
 net/smc/smc.h      |  4 ++--
 net/smc/smc_clc.c  |  6 +++---
 net/smc/smc_clc.h  |  2 +-
 net/smc/smc_core.c |  4 ++--
 net/smc/smc_ism.h  | 10 +++++-----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a2cb30af46cb..66763c74ab76 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1045,7 +1045,7 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 	int rc = SMC_CLC_DECL_NOSMCDDEV;
 	struct smcd_dev *smcd;
 	int i = 1, entry = 1;
-	bool is_virtual;
+	bool is_emulated;
 	u16 chid;
 
 	if (smcd_indicated(ini->smc_type_v1))
@@ -1057,12 +1057,12 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 		chid = smc_ism_get_chid(smcd);
 		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
 			continue;
-		is_virtual = __smc_ism_is_virtual(chid);
+		is_emulated = __smc_ism_is_emulated(chid);
 		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
 		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
-			if (is_virtual && entry == SMCD_CLC_MAX_V2_GID_ENTRIES)
+			if (is_emulated && entry == SMCD_CLC_MAX_V2_GID_ENTRIES)
 				/* It's the last GID-CHID entry left in CLC
-				 * Proposal SMC-Dv2 extension, but a virtual
+				 * Proposal SMC-Dv2 extension, but an Emulated-
 				 * ISM device will take two entries. So give
 				 * up it and try the next potential ISM device.
 				 */
@@ -1072,7 +1072,7 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 			ini->is_smcd = true;
 			rc = 0;
 			i++;
-			entry = is_virtual ? entry + 2 : entry + 1;
+			entry = is_emulated ? entry + 2 : entry + 1;
 			if (entry > SMCD_CLC_MAX_V2_GID_ENTRIES)
 				break;
 		}
@@ -1413,10 +1413,10 @@ static int smc_connect_ism(struct smc_sock *smc,
 		if (rc)
 			return rc;
 
-		if (__smc_ism_is_virtual(ini->ism_chid[ini->ism_selected]))
+		if (__smc_ism_is_emulated(ini->ism_chid[ini->ism_selected]))
 			ini->ism_peer_gid[ini->ism_selected].gid_ext =
 						ntohll(aclc->d1.gid_ext);
-		/* for non-virtual ISM devices, peer gid_ext remains 0. */
+		/* for non-Emulated-ISM devices, peer gid_ext remains 0. */
 	}
 	ini->ism_peer_gid[ini->ism_selected].gid = ntohll(aclc->d0.gid);
 
@@ -2117,10 +2117,10 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
 		if (smc_ism_get_chid(smcd) == proposed_chid &&
 		    !smc_ism_cantalk(proposed_gid, ISM_RESERVED_VLANID, smcd)) {
 			ini->ism_peer_gid[*matches].gid = proposed_gid->gid;
-			if (__smc_ism_is_virtual(proposed_chid))
+			if (__smc_ism_is_emulated(proposed_chid))
 				ini->ism_peer_gid[*matches].gid_ext =
 							proposed_gid->gid_ext;
-				/* non-virtual ISM's peer gid_ext remains 0. */
+				/* non-Emulated-ISM's peer gid_ext remains 0. */
 			ini->ism_dev[*matches] = smcd;
 			(*matches)++;
 			break;
@@ -2170,10 +2170,10 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 		smcd_gid.gid = ntohll(smcd_v2_ext->gidchid[i].gid);
 		smcd_gid.gid_ext = 0;
 		chid = ntohs(smcd_v2_ext->gidchid[i].chid);
-		if (__smc_ism_is_virtual(chid)) {
+		if (__smc_ism_is_emulated(chid)) {
 			if ((i + 1) == smc_v2_ext->hdr.ism_gid_cnt ||
 			    chid != ntohs(smcd_v2_ext->gidchid[i + 1].chid))
-				/* each virtual ISM device takes two GID-CHID
+				/* each Emulated-ISM device takes two GID-CHID
 				 * entries and CHID of the second entry repeats
 				 * that of the first entry.
 				 *
diff --git a/net/smc/smc.h b/net/smc/smc.h
index df64efd2dee8..18c8b7870198 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -56,11 +56,11 @@ enum smc_state {		/* possible states of an SMC socket */
 };
 
 enum smc_supplemental_features {
-	SMC_SPF_VIRT_ISM_DEV	= 0,
+	SMC_SPF_EMULATED_ISM_DEV	= 0,
 };
 
 #define SMC_FEATURE_MASK \
-	(BIT(SMC_SPF_VIRT_ISM_DEV))
+	(BIT(SMC_SPF_EMULATED_ISM_DEV))
 
 struct smc_link_group;
 
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 9a13709bea1c..e55026c7529c 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -952,8 +952,8 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 				gidchids[entry].chid =
 					htons(smc_ism_get_chid(ini->ism_dev[i]));
 				gidchids[entry].gid = htonll(smcd_gid.gid);
-				if (smc_ism_is_virtual(smcd)) {
-					/* a virtual ISM device takes two
+				if (smc_ism_is_emulated(smcd)) {
+					/* an Emulated-ISM device takes two
 					 * entries. CHID of the second entry
 					 * repeats that of the first entry.
 					 */
@@ -1055,7 +1055,7 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 		clc->d1.chid = htons(chid);
 		if (eid && eid[0])
 			memcpy(clc->d1.eid, eid, SMC_MAX_EID_LEN);
-		if (__smc_ism_is_virtual(chid))
+		if (__smc_ism_is_emulated(chid))
 			clc->d1.gid_ext = htonll(smcd_gid.gid_ext);
 		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
 		if (first_contact) {
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index a9f9bdd26dcd..7cc7070b9772 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -175,7 +175,7 @@ struct smc_clc_msg_proposal {	/* clc proposal message sent by Linux */
 #define SMCD_CLC_MAX_V2_GID_ENTRIES	8 /* max # of CHID-GID entries in CLC
 					   * proposal SMC-Dv2 extension.
 					   * each ISM device takes one entry and
-					   * each virtual ISM takes two entries.
+					   * each Emulated-ISM takes two entries
 					   */
 
 struct smc_clc_msg_proposal_area {
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e4c858411207..9b84d5897aa5 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1535,7 +1535,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
 	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
 		if ((!peer_gid->gid ||
 		     (lgr->peer_gid.gid == peer_gid->gid &&
-		      !smc_ism_is_virtual(dev) ? 1 :
+		      !smc_ism_is_emulated(dev) ? 1 :
 		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
 		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
 			if (peer_gid->gid) /* peer triggered termination */
@@ -1881,7 +1881,7 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 	    lgr->smcd != smcismdev)
 		return false;
 
-	if (smc_ism_is_virtual(smcismdev) &&
+	if (smc_ism_is_emulated(smcismdev) &&
 	    lgr->peer_gid.gid_ext != peer_gid->gid_ext)
 		return false;
 
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index ffff40c30a06..165cd013404b 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,7 +15,7 @@
 
 #include "smc.h"
 
-#define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+#define SMC_EMULATED_ISM_CHID_MASK	0xFF00
 #define SMC_ISM_IDENT_MASK		0x00FFFF
 
 struct smcd_dev_list {	/* List of SMCD devices */
@@ -66,10 +66,10 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
-static inline bool __smc_ism_is_virtual(u16 chid)
+static inline bool __smc_ism_is_emulated(u16 chid)
 {
 	/* CHIDs in range of 0xFF00 to 0xFFFF are reserved
-	 * for virtual ISM device.
+	 * for Emulated-ISM device.
 	 *
 	 * loopback-ism:	0xFFFF
 	 * virtio-ism:		0xFF00 ~ 0xFFFE
@@ -77,11 +77,11 @@ static inline bool __smc_ism_is_virtual(u16 chid)
 	return ((chid & 0xFF00) == 0xFF00);
 }
 
-static inline bool smc_ism_is_virtual(struct smcd_dev *smcd)
+static inline bool smc_ism_is_emulated(struct smcd_dev *smcd)
 {
 	u16 chid = smcd->ops->get_chid(smcd);
 
-	return __smc_ism_is_virtual(chid);
+	return __smc_ism_is_emulated(chid);
 }
 
 #endif
-- 
2.32.0.3.g01195cf9f


