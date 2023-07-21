Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1C75BE97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGUGQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGUGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:15:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54193C15;
        Thu, 20 Jul 2023 23:13:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5XuW0019069;
        Thu, 20 Jul 2023 23:12:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=APeRNgbfGO2jo1KVzokBPZU8oZQoNi8YlOWoGkv1zNE=;
 b=J8H1MlDCYqS9O+F8NoX8XOm0bFz9ddaTRQnsBVU6chrsF0ldm5xJNv2tM6eU4ozUJeMB
 uDQMiL+Q6sCjaxzhKMlwM+0t0vYrbrmdtp+ltjYpqV4/ul5aFuF18TJgdhHV2WrVhIc1
 DLChtlXHKWF6uL7zykXs65DLXZmbPk3/4FQsRVlEm2Sj12RNglc14JkRqaq/d/vbIcmu
 YHkP26SSRw1NnlK/iQlRXc5pHfTUzCJ3i7LrZz0KAjcoiOc1EEBQC3xJftbgwKO5v1/9
 ze59MU+c29zgORuijCAA9e0Nb30RsEiqZZRCDCXUT0PETDo6eH4pE3R1pYM35CICmSpJ 9Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh5eghvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 23:12:33 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:12:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:12:29 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 5E24B3F7062;
        Thu, 20 Jul 2023 23:12:26 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V4] octeontx2-af: Fix hash extraction enable configuration
Date:   Fri, 21 Jul 2023 11:42:22 +0530
Message-ID: <20230721061222.2632521-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QotFYO-M0RGqUTEQEChP_JTgiMxQuK27
X-Proofpoint-ORIG-GUID: QotFYO-M0RGqUTEQEChP_JTgiMxQuK27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, hash extraction support is enabled for all the silicons.
Because of which we are facing initialization issues when the silicon
does not support hash extraction. During creation of the hardware
parsing table for IPv6 address, we need to consider if hash extraction
is enabled then extract only 32 bit, otherwise 128 bit needs to be
extracted. This patch fixes the issue and configures the hardware parser
based on the availability of the feature.

Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
v4 changes:
- Made a single patch since the other patches are already merged.

v3 changes:
- Rebased the patchset on top of 'main' branch

v2 changes:
- Fixed review comment from Jakub Kicinski
  1. Updated detailed commit messages

 .../marvell/octeontx2/af/rvu_npc_hash.c       | 43 ++++++++++++++++++-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  8 ++--
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 6fe67f3a7f6f..7e20282c12d0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -218,13 +218,54 @@ void npc_config_secret_key(struct rvu *rvu, int blkaddr)
 
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 {
+	struct npc_mcam_kex_hash *mh = rvu->kpu.mkex_hash;
 	struct hw_cap *hwcap = &rvu->hw->cap;
+	u8 intf, ld, hdr_offset, byte_len;
 	struct rvu_hwinfo *hw = rvu->hw;
-	u8 intf;
+	u64 cfg;
 
+	/* Check if hardware supports hash extraction */
 	if (!hwcap->npc_hash_extract)
 		return;
 
+	/* Check if IPv6 source/destination address
+	 * should be hash enabled.
+	 * Hashing reduces 128bit SIP/DIP fields to 32bit
+	 * so that 224 bit X2 key can be used for IPv6 based filters as well,
+	 * which in turn results in more number of MCAM entries available for
+	 * use.
+	 *
+	 * Hashing of IPV6 SIP/DIP is enabled in below scenarios
+	 * 1. If the silicon variant supports hashing feature
+	 * 2. If the number of bytes of IP addr being extracted is 4 bytes ie
+	 *    32bit. The assumption here is that if user wants 8bytes of LSB of
+	 *    IP addr or full 16 bytes then his intention is not to use 32bit
+	 *    hash.
+	 */
+	for (intf = 0; intf < hw->npc_intfs; intf++) {
+		for (ld = 0; ld < NPC_MAX_LD; ld++) {
+			cfg = rvu_read64(rvu, blkaddr,
+					 NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf,
+								       NPC_LID_LC,
+								       NPC_LT_LC_IP6,
+								       ld));
+			hdr_offset = FIELD_GET(NPC_HDR_OFFSET, cfg);
+			byte_len = FIELD_GET(NPC_BYTESM, cfg);
+			/* Hashing of IPv6 source/destination address should be
+			 * enabled if,
+			 * hdr_offset == 8 (offset of source IPv6 address) or
+			 * hdr_offset == 24 (offset of destination IPv6)
+			 * address) and the number of byte to be
+			 * extracted is 4. As per hardware configuration
+			 * byte_len should be == actual byte_len - 1.
+			 * Hence byte_len is checked against 3 but nor 4.
+			 */
+			if ((hdr_offset == 8 || hdr_offset == 24) && byte_len == 3)
+				mh->lid_lt_ld_hash_en[intf][NPC_LID_LC][NPC_LT_LC_IP6][ld] = true;
+		}
+	}
+
+	/* Update hash configuration if the field is hash enabled */
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		npc_program_mkex_hash_rx(rvu, blkaddr, intf);
 		npc_program_mkex_hash_tx(rvu, blkaddr, intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index a1c3d987b804..57a09328d46b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -70,8 +70,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_RX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
@@ -79,8 +79,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_TX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
-- 
2.25.1

