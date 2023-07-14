Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05D7532B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjGNHMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjGNHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:12:06 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B75126B3;
        Fri, 14 Jul 2023 00:12:03 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLUaIW030039;
        Fri, 14 Jul 2023 00:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=2VAntrQVQdg6kTOfJ6Hsq9QnlUnKBgtTrA2Zv4f/Joc=;
 b=Aq90xGrfq0ItUQmZkNRwOH1aVhIVLRewnPpERjMylJzMjA8qTRTvEjJ3PpG+ctqaBKQ1
 MyvMX26zJ8FHVZsymI2Hqddfb9ujbmoOpgCWWlyobWXwdZMqF/HY4W3mzjpTel0wWxks
 Avnd+bATK0SHX22vIABgscIlo5uEUJJKTImAJxgtlHRsM7z9bJvB812+Y1LE8cxald7+
 prfDq4vAuXtelCn8+kDa8crwOq0if0XWZfxZM7/2SY/nP5XUG+dz37UZLMT6zGMLbXPZ
 Gd1ZKnlSdFR0vfFf75lS4uGx3/DXlojJTUvrauCwFJBdOKOK1iACBce7ADRsmKetVAoj Qw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptx9svs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 00:11:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 00:11:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 00:11:52 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 9F1DD3F7064;
        Fri, 14 Jul 2023 00:11:49 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 1/3] octeontx2-af: Fix hash extraction mbox message
Date:   Fri, 14 Jul 2023 12:41:39 +0530
Message-ID: <20230714071141.2428144-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714071141.2428144-1-sumang@marvell.com>
References: <20230714071141.2428144-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ca1P_EOUSzQHNYs3OHrQRXQuwo0jQSI7
X-Proofpoint-ORIG-GUID: Ca1P_EOUSzQHNYs3OHrQRXQuwo0jQSI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, hash extraction mbox message response supports only the
secret key which is not a complete solution. This patch adds support
to extract both hash mask and hash control along with the secret key.
These are needed to use hash reduction of 128 bit IPv6 address to 32 bit.
Hash mask decides on the bits from the 128 bit IPv6 address which should
be used for 32 bit hash calculation. After generating the 32 bit hash,
hash control decides how many bits from the 32 bit hash can be taken
into consideration. 

Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 16 ++--
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 80 +++++++++++--------
 .../marvell/octeontx2/af/rvu_npc_hash.h       | 13 +--
 3 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 5727d67e0259..f43f162e8a99 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -245,9 +245,9 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011, npc_read_base_steer_rule,            \
 M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,                     \
 				   npc_mcam_get_stats_req,              \
 				   npc_mcam_get_stats_rsp)              \
-M(NPC_GET_SECRET_KEY, 0x6013, npc_get_secret_key,                     \
-				   npc_get_secret_key_req,              \
-				   npc_get_secret_key_rsp)              \
+M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,             \
+				   npc_get_field_hash_info_req,              \
+				   npc_get_field_hash_info_rsp)              \
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
@@ -1524,14 +1524,20 @@ struct npc_mcam_get_stats_rsp {
 	u8 stat_ena; /* enabled */
 };
 
-struct npc_get_secret_key_req {
+struct npc_get_field_hash_info_req {
 	struct mbox_msghdr hdr;
 	u8 intf;
 };
 
-struct npc_get_secret_key_rsp {
+struct npc_get_field_hash_info_rsp {
 	struct mbox_msghdr hdr;
 	u64 secret_key[3];
+#define NPC_MAX_HASH 2
+#define NPC_MAX_HASH_MASK 2
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_MASK(0..1) */
+	u64 hash_mask[NPC_MAX_INTF][NPC_MAX_HASH][NPC_MAX_HASH_MASK];
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_RESULT_CTRL */
+	u64 hash_ctrl[NPC_MAX_INTF][NPC_MAX_HASH];
 };
 
 enum ptp_op {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 20ebb9c95c73..79e649917ffa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -78,25 +78,25 @@ static u32 rvu_npc_toeplitz_hash(const u64 *data, u64 *key, size_t data_bit_len,
 	return hash_out;
 }
 
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx)
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx)
 {
 	u64 hash_key[3];
 	u64 data_padded[2];
 	u32 field_hash;
 
-	hash_key[0] = secret_key[1] << 31;
-	hash_key[0] |= secret_key[2];
-	hash_key[1] = secret_key[1] >> 33;
-	hash_key[1] |= secret_key[0] << 31;
-	hash_key[2] = secret_key[0] >> 33;
+	hash_key[0] = rsp.secret_key[1] << 31;
+	hash_key[0] |= rsp.secret_key[2];
+	hash_key[1] = rsp.secret_key[1] >> 33;
+	hash_key[1] |= rsp.secret_key[0] << 31;
+	hash_key[2] = rsp.secret_key[0] >> 33;
 
-	data_padded[0] = mkex_hash->hash_mask[intf][hash_idx][0] & ldata[0];
-	data_padded[1] = mkex_hash->hash_mask[intf][hash_idx][1] & ldata[1];
+	data_padded[0] = rsp.hash_mask[intf][hash_idx][0] & ldata[0];
+	data_padded[1] = rsp.hash_mask[intf][hash_idx][1] & ldata[1];
 	field_hash = rvu_npc_toeplitz_hash(data_padded, hash_key, 128, 159);
 
-	field_hash &= mkex_hash->hash_ctrl[intf][hash_idx] >> 32;
-	field_hash |= mkex_hash->hash_ctrl[intf][hash_idx];
+	field_hash &= FIELD_GET(GENMASK(63, 32), rsp.hash_ctrl[intf][hash_idx]);
+	field_hash |= FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
 	return field_hash;
 }
 
@@ -238,8 +238,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask)
 {
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
-	struct npc_get_secret_key_req req;
-	struct npc_get_secret_key_rsp rsp;
+	struct npc_get_field_hash_info_req req;
+	struct npc_get_field_hash_info_rsp rsp;
 	u64 ldata[2], cfg;
 	u32 field_hash;
 	u8 hash_idx;
@@ -250,7 +250,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 
 	req.intf = intf;
-	rvu_mbox_handler_npc_get_secret_key(rvu, &req, &rsp);
+	if (rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp))
+		return;
 
 	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
 		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
@@ -266,44 +267,46 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 				 * is hashed to 32 bit value.
 				 */
 				case NPC_LT_LC_IP6:
+					/* ld[0] == hash_idx[0] == Source IPv6
+					 * ld[1] == hash_idx[1] == Destination IPv6
+					 */
 					if (features & BIT_ULL(NPC_SIP_IPV6)) {
 						u32 src_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(src_ip, pkt->ip6src, IPV6_WORDS);
-						ldata[0] = (u64)src_ip[0] << 32 | src_ip[1];
-						ldata[1] = (u64)src_ip[2] << 32 | src_ip[3];
+						ldata[1] = (u64)src_ip[0] << 32 | src_ip[1];
+						ldata[0] = (u64)src_ip[2] << 32 | src_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_SIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6src, &pkt->ip6src,
 						       sizeof(pkt->ip6src));
 						memcpy(&omask->ip6src, &mask->ip6src,
 						       sizeof(mask->ip6src));
-						break;
-					}
-
-					if (features & BIT_ULL(NPC_DIP_IPV6)) {
+					} else if ((features & BIT_ULL(NPC_DIP_IPV6)) &&
+						   !hash_idx) {
 						u32 dst_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(dst_ip, pkt->ip6dst, IPV6_WORDS);
-						ldata[0] = (u64)dst_ip[0] << 32 | dst_ip[1];
-						ldata[1] = (u64)dst_ip[2] << 32 | dst_ip[3];
+						ldata[1] = (u64)dst_ip[0] << 32 | dst_ip[1];
+						ldata[0] = (u64)dst_ip[2] << 32 | dst_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_DIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6dst, &pkt->ip6dst,
 						       sizeof(pkt->ip6dst));
 						memcpy(&omask->ip6dst, &mask->ip6dst,
 						       sizeof(mask->ip6dst));
 					}
+
 					break;
 				}
 			}
@@ -311,13 +314,13 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 }
 
-int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
-					struct npc_get_secret_key_req *req,
-					struct npc_get_secret_key_rsp *rsp)
+int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
+					     struct npc_get_field_hash_info_req *req,
+					     struct npc_get_field_hash_info_rsp *rsp)
 {
+	int hash_idx, hash_mask_idx, blkaddr;
 	u64 *secret_key = rsp->secret_key;
 	u8 intf = req->intf;
-	int blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
@@ -329,6 +332,19 @@ int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
 	secret_key[1] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY1(intf));
 	secret_key[2] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY2(intf));
 
+	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++)
+		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH_MASK; hash_mask_idx++) {
+			rsp->hash_mask[NIX_INTF_RX][hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, hash_idx, hash_mask_idx);
+			rsp->hash_mask[NIX_INTF_TX][hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, hash_idx, hash_mask_idx);
+		}
+
+	for (hash_idx = 0; hash_idx < NPC_MAX_INTF; hash_idx++)
+		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH; hash_mask_idx++)
+			rsp->hash_ctrl[hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_CTRL(hash_idx, hash_mask_idx);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index 3efeb09c58de..bbc7a0e95e48 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -12,9 +12,6 @@
 #define RVU_NPC_HASH_SECRET_KEY1 0xa9d5af4c9fbc87b4
 #define RVU_NPC_HASH_SECRET_KEY2 0x5954c9e7
 
-#define NPC_MAX_HASH 2
-#define NPC_MAX_HASH_MASK 2
-
 #define KEX_LD_CFG_USE_HASH(use_hash, bytesm1, hdr_ofs, ena, flags_ena, key_ofs) \
 			    ((use_hash) << 20 | ((bytesm1) << 16) | ((hdr_ofs) << 8) | \
 			     ((ena) << 7) | ((flags_ena) << 6) | ((key_ofs) & 0x3F))
@@ -35,6 +32,12 @@
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
 
+#define GET_KEX_LD_HASH_CTRL(intf, ld)  \
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
+
+#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx))
+
 struct npc_mcam_kex_hash {
 	/* NPC_AF_INTF(0..1)_LID(0..7)_LT(0..15)_LD(0..1)_CFG */
 	bool lid_lt_ld_hash_en[NPC_MAX_INTF][NPC_MAX_LID][NPC_MAX_LT][NPC_MAX_LD];
@@ -56,8 +59,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask);
 void npc_config_secret_key(struct rvu *rvu, int blkaddr);
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr);
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx);
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx);
 
 static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	.lid_lt_ld_hash_en = {
-- 
2.25.1

