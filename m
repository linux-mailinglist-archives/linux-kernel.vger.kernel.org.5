Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEA7D0F06
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjJTLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377302AbjJTLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:45:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0A6597;
        Fri, 20 Oct 2023 04:44:01 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KAYH8u014089;
        Fri, 20 Oct 2023 04:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=lT/SSeJWOwvaoxmw8OJwj/hd5bY2fzUWYDEH7M+KLj0=;
 b=NiIk52O+vx/OnBko+OrSfLD6j39n4DMdZHCrGIZYriHqfOXM75od1gPgUApdOhKCGQxl
 eyYcwWHaM7Rdv4whtfkF9m1eJ103wd2BG/YAa8v0RoDK6ri5bOtnybaaIw64xwdDB8yX
 wNVq6NIldmHE2jq81aZ0PSXkI6ePr5e1WgaIH2GspdiG6OD1vLFzMTkx7tFgIgiyz1ic
 Y7y5db5J4Cvnhzi9Ezn8PGYj1ScdtjRwav41OdsSzgMUo5hH2MTefZTSWMf68DEu3bhy
 vnbVQDMfR4qajC64O8JEvule86FUyO7dXEniHkkfVHU8ZsjH4yanv5Et0XXUt1sok6uG IQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tubwyjar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 04:43:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 20 Oct
 2023 04:43:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 20 Oct 2023 04:43:07 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 7DF655B692C;
        Fri, 20 Oct 2023 04:43:07 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v4] octeon_ep: assert hardware structure sizes
Date:   Fri, 20 Oct 2023 04:43:01 -0700
Message-ID: <20231020114302.2334660-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jqrUGGDjF8UxTtIgPJMkC0ciSg5G0a8Y
X-Proofpoint-GUID: jqrUGGDjF8UxTtIgPJMkC0ciSg5G0a8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up structure defines related to hardware data to be
asserted to fixed sizes, as padding is not allowed
by hardware.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - Changed packed attributes to static assertions for fixed sizes
V3: https://lore.kernel.org/all/20231016092051.2306831-1-srasheed@marvell.com/
  - Updated changelog to indicate this is a cleanup
V2: https://lore.kernel.org/all/20231010194026.2284786-1-srasheed@marvell.com/
  - Updated changelog to provide more information
V1: https://lore.kernel.org/all/20231006120225.2259533-1-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h | 3 +++
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 782a24f27f3e..49feae80d7d2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -20,6 +20,7 @@ struct octep_oq_desc_hw {
 	dma_addr_t buffer_ptr;
 	u64 info_ptr;
 };
+static_assert(sizeof(struct octep_oq_desc_hw) == 16);
 
 #define OCTEP_OQ_DESC_SIZE    (sizeof(struct octep_oq_desc_hw))
 
@@ -39,6 +40,7 @@ struct octep_oq_resp_hw_ext {
 	/* checksum verified. */
 	u64 csum_verified:2;
 };
+static_assert(sizeof(struct octep_oq_resp_hw_ext) == 8);
 
 #define  OCTEP_OQ_RESP_HW_EXT_SIZE   (sizeof(struct octep_oq_resp_hw_ext))
 
@@ -50,6 +52,7 @@ struct octep_oq_resp_hw {
 	/* The Length of the packet. */
 	__be64 length;
 };
+static_assert(sizeof(struct octep_oq_resp_hw) == 8);
 
 #define OCTEP_OQ_RESP_HW_SIZE   (sizeof(struct octep_oq_resp_hw))
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 21e75ff9f5e7..86c98b13fc44 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -36,6 +36,7 @@ struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
 };
+static_assert(sizeof(struct octep_tx_sglist_desc) == 40);
 
 /* Each Scatter/Gather entry sent to hardwar hold four pointers.
  * So, number of entries required is (MAX_SKB_FRAGS + 1)/4, where '+1'
@@ -239,6 +240,7 @@ struct octep_instr_hdr {
 	/* Reserved3 */
 	u64 reserved3:1;
 };
+static_assert(sizeof(struct octep_instr_hdr) == 8);
 
 /* Hardware Tx completion response header */
 struct octep_instr_resp_hdr {
@@ -263,6 +265,7 @@ struct octep_instr_resp_hdr {
 	/* Opcode for the return packet  */
 	u64 opcode:16;
 };
+static_assert(sizeof(struct octep_instr_hdr) == 8);
 
 /* 64-byte Tx instruction format.
  * Format of instruction for a 64-byte mode input queue.
@@ -293,6 +296,7 @@ struct octep_tx_desc_hw {
 	/* Additional headers available in a 64-byte instruction. */
 	u64 exhdr[4];
 };
+static_assert(sizeof(struct octep_tx_desc_hw) == 64);
 
 #define OCTEP_IQ_DESC_SIZE (sizeof(struct octep_tx_desc_hw))
 #endif /* _OCTEP_TX_H_ */
-- 
2.25.1

