Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C599677F795
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbjHQNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351361AbjHQNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:20:44 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4E2135;
        Thu, 17 Aug 2023 06:20:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vq.3QPh_1692278437;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vq.3QPh_1692278437)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 21:20:37 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/6] net/smc: add vendor unique experimental options area in clc handshake
Date:   Thu, 17 Aug 2023 21:20:28 +0800
Message-Id: <20230817132032.23397-3-guangguan.wang@linux.alibaba.com>
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

Add vendor unique experimental options area in clc handshake. In clc
accept and confirm msg, vendor unique experimental options use the
16-Bytes reserved field, which defined in struct smc_clc_fce_gid_ext
in previous version. Because of the struct smc_clc_first_contact_ext
is widely used and limit the scope of modification, this patch moves
the 16-Bytes reserved field out of struct smc_clc_fce_gid_ext, and
followed with the struct smc_clc_first_contact_ext in a new struct
names struct smc_clc_first_contact_ext_v2x.

For SMC-R first connection, in previous version, the struct smc_clc_
first_contact_ext and the 16-Bytes reserved field has already been
included in clc accept and confirm msg. Thus, this patch use struct
smc_clc_first_contact_ext_v2x instead of the struct smc_clc_first_
contact_ext and the 16-Bytes reserved field in SMC-R clc accept and
confirm msg is compatible with previous version.

For SMC-D first connection, in previous version, only the struct smc_
clc_first_contact_ext is included in clc accept and confirm msg, and
the 16-Bytes reserved field is not included. Thus, when the negotiated
smc release version is the version before v2.1, we still use struct
smc_clc_first_contact_ext for compatible consideration. If the negotiated
smc release version is v2.1 or later, use struct smc_clc_first_contact_
ext_v2x instead.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c  |  2 +-
 net/smc/smc_clc.c | 44 +++++++++++++++++++++++---------------------
 net/smc/smc_clc.h | 15 +++++++++++++--
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c99ac371b5b1..10bec585983f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1113,7 +1113,7 @@ static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc,
 
 #define SMC_CLC_MAX_ACCEPT_LEN \
 	(sizeof(struct smc_clc_msg_accept_confirm_v2) + \
-	 sizeof(struct smc_clc_first_contact_ext) + \
+	 sizeof(struct smc_clc_first_contact_ext_v2x) + \
 	 sizeof(struct smc_clc_msg_trail))
 
 /* CLC handshake during connect */
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 7c5627c6abcc..728f88616266 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -391,9 +391,7 @@ smc_clc_msg_acc_conf_valid(struct smc_clc_msg_accept_confirm_v2 *clc_v2)
 			return false;
 	} else {
 		if (hdr->typev1 == SMC_TYPE_D &&
-		    ntohs(hdr->length) != SMCD_CLC_ACCEPT_CONFIRM_LEN_V2 &&
-		    (ntohs(hdr->length) != SMCD_CLC_ACCEPT_CONFIRM_LEN_V2 +
-				sizeof(struct smc_clc_first_contact_ext)))
+		    ntohs(hdr->length) < SMCD_CLC_ACCEPT_CONFIRM_LEN_V2)
 			return false;
 		if (hdr->typev1 == SMC_TYPE_R &&
 		    ntohs(hdr->length) < SMCR_CLC_ACCEPT_CONFIRM_LEN_V2)
@@ -420,13 +418,19 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 	return true;
 }
 
-static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_nr)
+static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
+			    struct smc_init_info *ini)
 {
+	int ret = sizeof(*fce);
+
 	memset(fce, 0, sizeof(*fce));
-	fce->os_type = SMC_CLC_OS_LINUX;
-	fce->release = release_nr;
-	memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
-	(*len) += sizeof(*fce);
+	fce->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
+	fce->fce_v2_base.release = ini->release_nr;
+	memcpy(fce->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
+	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1)
+		ret = sizeof(struct smc_clc_first_contact_ext);
+
+	return ret;
 }
 
 /* check if received message has a correct header length and contains valid
@@ -986,13 +990,13 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				       u8 *eid, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
+	struct smc_clc_first_contact_ext_v2x fce;
 	struct smc_clc_msg_accept_confirm *clc;
-	struct smc_clc_first_contact_ext fce;
 	struct smc_clc_fce_gid_ext gle;
 	struct smc_clc_msg_trail trl;
+	int i, len, fce_len;
 	struct kvec vec[5];
 	struct msghdr msg;
-	int i, len;
 
 	/* send SMC Confirm CLC msg */
 	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
@@ -1018,8 +1022,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 			if (eid && eid[0])
 				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
-			if (first_contact)
-				smc_clc_fill_fce(&fce, &len, ini->release_nr);
+			if (first_contact) {
+				fce_len = smc_clc_fill_fce(&fce, ini);
+				len += fce_len;
+			}
 			clc_v2->hdr.length = htons(len);
 		}
 		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
@@ -1063,15 +1069,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact) {
-				smc_clc_fill_fce(&fce, &len, ini->release_nr);
-				fce.v2_direct = !link->lgr->uses_gateway;
-				memset(&gle, 0, sizeof(gle));
+				fce_len = smc_clc_fill_fce(&fce, ini);
+				len += fce_len;
+				fce.fce_v2_base.v2_direct = !link->lgr->uses_gateway;
 				if (clc->hdr.type == SMC_CLC_CONFIRM) {
+					memset(&gle, 0, sizeof(gle));
 					gle.gid_cnt = ini->smcrv2.gidlist.len;
 					len += sizeof(gle);
 					len += gle.gid_cnt * sizeof(gle.gid[0]);
-				} else {
-					len += sizeof(gle.reserved);
 				}
 			}
 			clc_v2->hdr.length = htons(len);
@@ -1094,7 +1099,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				   sizeof(trl);
 	if (version > SMC_V1 && first_contact) {
 		vec[i].iov_base = &fce;
-		vec[i++].iov_len = sizeof(fce);
+		vec[i++].iov_len = fce_len;
 		if (!conn->lgr->is_smcd) {
 			if (clc->hdr.type == SMC_CLC_CONFIRM) {
 				vec[i].iov_base = &gle;
@@ -1102,9 +1107,6 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				vec[i].iov_base = &ini->smcrv2.gidlist.list;
 				vec[i++].iov_len = gle.gid_cnt *
 						   sizeof(gle.gid[0]);
-			} else {
-				vec[i].iov_base = &gle.reserved;
-				vec[i++].iov_len = sizeof(gle.reserved);
 			}
 		}
 	}
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index b923e89acafb..bd75382f374d 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -147,7 +147,9 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 struct smc_clc_msg_smcd {	/* SMC-D GID information */
 	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
 	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
-	u8 reserved[28];
+	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
+	u8 vendor_exp_options[5];
+	u8 reserved[20];
 };
 
 struct smc_clc_smcd_v2_extension {
@@ -231,8 +233,17 @@ struct smc_clc_first_contact_ext {
 	u8 hostname[SMC_MAX_HOSTNAME_LEN];
 };
 
+struct smc_clc_first_contact_ext_v2x {
+	struct smc_clc_first_contact_ext fce_v2_base;
+	u8 reserved3[4];
+	__be32 vendor_exp_options;
+	u8 reserved4[8];
+} __packed;		/* format defined in
+			 * IBM Shared Memory Communications Version 2 (Third Edition)
+			 * (https://www.ibm.com/support/pages/node/7009315)
+			 */
+
 struct smc_clc_fce_gid_ext {
-	u8 reserved[16];
 	u8 gid_cnt;
 	u8 reserved2[3];
 	u8 gid[][SMC_GID_SIZE];
-- 
2.24.3 (Apple Git-128)

