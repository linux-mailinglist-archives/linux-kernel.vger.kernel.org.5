Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926E7C04CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjJJTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjJJTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:40:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B02B6;
        Tue, 10 Oct 2023 12:40:47 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AIbeat020001;
        Tue, 10 Oct 2023 12:40:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=o0VXMIuJ7GsxmOrhDanvGNS6hKQ9z9T+3DPeNsTiG0g=;
 b=UgzsQCQDEfDSpCZaGUF5PhDFn0MypOE/niG3/bn+RbQlpIdBcXmP4xMbwTRM54DO7Hpc
 8aJW8AMPsIqMT9p7W1fgR8SO3z9wm3JBxrDYobBTjrApd6yzlWuxIno3aTRcWxld7tGu
 sBOcMuD38nmB/7CMmzVkohyG3w3EDarUAPdGcTWqZQbD2ZagMuTREzbWKxc+PudJMU1w
 mvweikzieAiXc8KhVGkdBJ3ZDMfZT+RrBeohKIoI2kWobqtPtgntzvCQ7x5+Tqq33ki7
 R5TenPBg4j8Nz+EXOOr4H7EjHnt/OLOtYDZ4bJxgrR7DV9ZeZojC1+lXe7Lb0h5tXgYM ag== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tnc2ar6fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 12:40:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 10 Oct
 2023 12:40:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 10 Oct 2023 12:40:30 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id B8BF65B6924;
        Tue, 10 Oct 2023 12:40:29 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
        <hgani@marvell.com>, <kuba@kernel.org>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <srasheed@marvell.com>,
        <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: [net-next PATCH v2] octeon_ep: pack hardware structures
Date:   Tue, 10 Oct 2023 12:40:26 -0700
Message-ID: <20231010194026.2284786-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <PH0PR18MB47341BB93B1CCC7E6E91AC53C7CDA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47341BB93B1CCC7E6E91AC53C7CDA@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _Ve6LXV43AbFyDLYJYCCBBWp-J49Vcmx
X-Proofpoint-ORIG-GUID: _Ve6LXV43AbFyDLYJYCCBBWp-J49Vcmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add packed attribute to structures correlating to hardware
data, as padding is not allowed by hardware.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V1 -> V2: Updated changelog

 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h | 6 +++---
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 782a24f27f3e..ca42ddb77491 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -19,7 +19,7 @@
 struct octep_oq_desc_hw {
 	dma_addr_t buffer_ptr;
 	u64 info_ptr;
-};
+} __packed;
 
 #define OCTEP_OQ_DESC_SIZE    (sizeof(struct octep_oq_desc_hw))
 
@@ -38,7 +38,7 @@ struct octep_oq_resp_hw_ext {
 
 	/* checksum verified. */
 	u64 csum_verified:2;
-};
+} __packed;
 
 #define  OCTEP_OQ_RESP_HW_EXT_SIZE   (sizeof(struct octep_oq_resp_hw_ext))
 
@@ -49,7 +49,7 @@ struct octep_oq_resp_hw_ext {
 struct octep_oq_resp_hw {
 	/* The Length of the packet. */
 	__be64 length;
-};
+} __packed;
 
 #define OCTEP_OQ_RESP_HW_SIZE   (sizeof(struct octep_oq_resp_hw))
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 21e75ff9f5e7..74189e5a7d33 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -35,7 +35,7 @@
 struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
-};
+} __packed;
 
 /* Each Scatter/Gather entry sent to hardwar hold four pointers.
  * So, number of entries required is (MAX_SKB_FRAGS + 1)/4, where '+1'
@@ -238,7 +238,7 @@ struct octep_instr_hdr {
 
 	/* Reserved3 */
 	u64 reserved3:1;
-};
+} __packed;
 
 /* Hardware Tx completion response header */
 struct octep_instr_resp_hdr {
@@ -262,7 +262,7 @@ struct octep_instr_resp_hdr {
 
 	/* Opcode for the return packet  */
 	u64 opcode:16;
-};
+} __packed;
 
 /* 64-byte Tx instruction format.
  * Format of instruction for a 64-byte mode input queue.
@@ -292,7 +292,7 @@ struct octep_tx_desc_hw {
 
 	/* Additional headers available in a 64-byte instruction. */
 	u64 exhdr[4];
-};
+} __packed;
 
 #define OCTEP_IQ_DESC_SIZE (sizeof(struct octep_tx_desc_hw))
 #endif /* _OCTEP_TX_H_ */
-- 
2.25.1

