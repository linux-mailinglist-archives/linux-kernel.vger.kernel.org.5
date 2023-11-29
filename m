Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A787FCE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbjK2Fbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2Fbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:31:42 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF3E1998;
        Tue, 28 Nov 2023 21:31:48 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIdt78021079;
        Tue, 28 Nov 2023 21:31:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=JA91SD7EvIx23dD/cDptZbjLogm5BCISa3kWOh8jdw0=;
 b=JxIOJ66XodKrUtMuZxWIKR2ltEuuCKuhslenx3DoOGQ0ge5rCHrQR+bnLvzDG0k7NSpj
 EIAbfgb3fwuPYTNMepiGov/JfOSs3R+ppFKBHapX13cwTC4srb/F3dvzUhiFva0X5lEH
 BQCCZfs94N/j4vha7Gt3HgQUi7oNXWll/L2/p0LE3KUfPZ0kMo1blNsjAunv2Cn/kxxq
 am2Z8WcSiT8laLUonkCnJ0UQvuxayr6aXCsBV/tUDEIHvuhdZ8OP9LKsyAd1RMZycq39
 XTOPN+436gCGbR1i/CLz90D+iV4tn8uDUm6Fk5urbpA1n2y5x4jnJ1xDpXeecAG3Uu6i +w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3unn86a1tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 21:31:42 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 21:31:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 21:31:40 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 453D43F7043;
        Tue, 28 Nov 2023 21:31:40 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v1] octeon_ep: set backpressure watermark for RX queues
Date:   Tue, 28 Nov 2023 21:31:31 -0800
Message-ID: <20231129053131.2539669-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0UfkJ43Qs_OeM3zh32bZWObtEyvo8WkC
X-Proofpoint-GUID: 0UfkJ43Qs_OeM3zh32bZWObtEyvo8WkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_02,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set backpressure watermark for hardware RX queues. Backpressure
gets triggered when the available buffers of a hardware RX queue
falls below the set watermark. This backpressure will propagate
to packet processing pipeline in the OCTEON card, so that the host
receives fewer packets and prevents packet dropping at host.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c |  7 +++++++
 drivers/net/ethernet/marvell/octeon_ep/octep_config.h  | 10 ++++++++++
 .../ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h    |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index abb03e9119e7..098a0c5c4d1c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -258,6 +258,7 @@ static void octep_init_config_cnxk_pf(struct octep_device *oct)
 	conf->oq.refill_threshold = OCTEP_OQ_REFILL_THRESHOLD;
 	conf->oq.oq_intr_pkt = OCTEP_OQ_INTR_PKT_THRESHOLD;
 	conf->oq.oq_intr_time = OCTEP_OQ_INTR_TIME_THRESHOLD;
+	conf->oq.wmark = OCTEP_OQ_WMARK_MIN;
 
 	conf->msix_cfg.non_ioq_msix = CNXK_NUM_NON_IOQ_INTR;
 	conf->msix_cfg.ioq_msix = conf->pf_ring_cfg.active_io_rings;
@@ -378,6 +379,12 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val = ((u64)time_threshold << 32) |
 		  CFG_GET_OQ_INTR_PKT(oct->conf);
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+
+	/* set watermark for backpressure */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no));
+	reg_val &= ~0xFFFFFFFFULL;
+	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no), reg_val);
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index 4c937ba5589f..c528344a7d0c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -20,6 +20,9 @@
 /* Packet threshold for Tx queue interrupt */
 #define OCTEP_IQ_INTR_THRESHOLD     0x0
 
+/* Minimum watermark for backpressure */
+#define OCTEP_OQ_WMARK_MIN 256
+
 /* Rx Queue: maximum descriptors per ring */
 #define OCTEP_OQ_MAX_DESCRIPTORS   1024
 
@@ -67,6 +70,7 @@
 #define CFG_GET_OQ_REFILL_THRESHOLD(cfg)  ((cfg)->oq.refill_threshold)
 #define CFG_GET_OQ_INTR_PKT(cfg)          ((cfg)->oq.oq_intr_pkt)
 #define CFG_GET_OQ_INTR_TIME(cfg)         ((cfg)->oq.oq_intr_time)
+#define CFG_GET_OQ_WMARK(cfg)             ((cfg)->oq.wmark)
 
 #define CFG_GET_PORTS_MAX_IO_RINGS(cfg)    ((cfg)->pf_ring_cfg.max_io_rings)
 #define CFG_GET_PORTS_ACTIVE_IO_RINGS(cfg) ((cfg)->pf_ring_cfg.active_io_rings)
@@ -136,6 +140,12 @@ struct octep_oq_config {
 	 * default. The time is specified in microseconds.
 	 */
 	u32 oq_intr_time;
+
+	/* Water mark for backpressure.
+	 * Output queue sends backpressure signal to source when
+	 * free buffer count falls below wmark.
+	 */
+	u32 wmark;
 };
 
 /* Tx/Rx configuration */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index abe02df8af11..ea677f760ef0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -143,6 +143,9 @@
 #define    CNXK_SDP_R_OUT_SLIST_DBELL(ring)          \
 	(CNXK_SDP_R_OUT_SLIST_DBELL_START + ((ring) * CNXK_RING_OFFSET))
 
+#define    CNXK_SDP_R_OUT_WMARK(ring)         \
+	(CNXK_SDP_R_OUT_WMARK_START + ((ring) * CNXK_RING_OFFSET))
+
 #define    CNXK_SDP_R_OUT_CNTS(ring)          \
 	(CNXK_SDP_R_OUT_CNTS_START + ((ring) * CNXK_RING_OFFSET))
 
-- 
2.25.1

