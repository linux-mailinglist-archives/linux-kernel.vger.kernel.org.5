Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CD76FD4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjHDJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHDJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:30:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C549D6;
        Fri,  4 Aug 2023 02:30:36 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Kf7Rj022221;
        Fri, 4 Aug 2023 02:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=YWX7p/R8nAwgkhS8iPb/5tbC0uBsrB5yfPI/yhltPh4=;
 b=Nfzm/25k75cd6XKXb0b3QMfXoAikczU6Pq9dY7zySqIeZsr7fzFklseFdRu+tsoBnq7p
 guN0lz6LWkPu+WhLxoTM30KsydRoq2wzKaLeUZm1N3e9sinh8NRfzNk9lv9enlnm9ygy
 IxydYi3L28OdrFFqn6Msjx50YllLhBHk1y7IBT/TlZktjwtFHaMT6Drrq1kyaRq7tfIV
 UAYnqJrPHMe/B/TUYzJNc6Vx3Sja57cJNzvBpovqywvWvZY6o9CoamDtkOToRKEOanij
 Rso0oO/myIhBp9aCBcXlxzyjeF+gqKnAKNjUDeiAxnwgquTdbygSHdAGL4Yfx5U7LdWs hQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s8kg29w4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 02:30:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 02:30:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 4 Aug 2023 02:30:27 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
        by maili.marvell.com (Postfix) with ESMTP id B06013F7074;
        Fri,  4 Aug 2023 02:30:22 -0700 (PDT)
From:   Sai Krishna <saikrishnag@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <richardcochran@gmail.com>
CC:     Sai Krishna <saikrishnag@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter atomic update feature
Date:   Fri, 4 Aug 2023 15:00:14 +0530
Message-ID: <20230804093014.2729634-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wSx5lTjbJ1YNG5n4d4hY-KrpQco2-YqT
X-Proofpoint-ORIG-GUID: wSx5lTjbJ1YNG5n4d4hY-KrpQco2-YqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_08,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the newer silicon versions in CN10K series supports a feature
where in the current PTP timestamp in HW can be updated atomically
without losing any cpu cycles unlike read/modify/write register.
This patch uses this feature so that PTP accuracy can be improved
while adjusting the master offset in HW. There is no need for SW
timecounter when using this feature. So removed references to SW
timecounter wherever appropriate.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  12 ++
 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 161 ++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/ptp.h   |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 177 ++++++++++++++----
 7 files changed, 313 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a8f3c8faf8af..407c220840d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -136,6 +136,7 @@ M(GET_HW_CAP,		0x008, get_hw_cap, msg_req, get_hw_cap_rsp)	\
 M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
 				msg_rsp)				\
 M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
+M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1437,6 +1438,12 @@ struct npc_get_kex_cfg_rsp {
 	u8 mkex_pfl_name[MKEX_NAME_LEN];
 };
 
+struct ptp_get_cap_rsp {
+	struct mbox_msghdr hdr;
+#define        PTP_CAP_HW_ATOMIC_UPDATE BIT_ULL(0)
+	u64 cap;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
@@ -1567,6 +1574,8 @@ enum ptp_op {
 	PTP_OP_GET_TSTMP = 2,
 	PTP_OP_SET_THRESH = 3,
 	PTP_OP_EXTTS_ON = 4,
+	PTP_OP_ADJTIME = 5,
+	PTP_OP_SET_CLOCK = 6,
 };
 
 struct ptp_req {
@@ -1575,11 +1584,14 @@ struct ptp_req {
 	s64 scaled_ppm;
 	u64 thresh;
 	int extts_on;
+	s64 delta;
+	u64 clk;
 };
 
 struct ptp_rsp {
 	struct mbox_msghdr hdr;
 	u64 clk;
+	u64 tsc;
 };
 
 struct npc_get_field_status_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index c55c2c441a1a..70256372bec6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -12,9 +12,9 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 
-#include "ptp.h"
 #include "mbox.h"
 #include "rvu.h"
+#include "ptp.h"
 
 #define DRV_NAME				"Marvell PTP Driver"
 
@@ -40,6 +40,7 @@
 #define PTP_CLOCK_CFG_TSTMP_EDGE		BIT_ULL(9)
 #define PTP_CLOCK_CFG_TSTMP_EN			BIT_ULL(8)
 #define PTP_CLOCK_CFG_TSTMP_IN_MASK		GENMASK_ULL(15, 10)
+#define PTP_CLOCK_CFG_ATOMIC_OP_MASK		GENMASK_ULL(28, 26)
 #define PTP_CLOCK_CFG_PPS_EN			BIT_ULL(30)
 #define PTP_CLOCK_CFG_PPS_INV			BIT_ULL(31)
 
@@ -53,36 +54,70 @@
 #define PTP_TIMESTAMP				0xF20ULL
 #define PTP_CLOCK_SEC				0xFD0ULL
 #define PTP_SEC_ROLLOVER			0xFD8ULL
+/* Atomic update related CSRs */
+#define PTP_FRNS_TIMESTAMP			0xFE0ULL
+#define PTP_NXT_ROLLOVER_SET			0xFE8ULL
+#define PTP_CURR_ROLLOVER_SET			0xFF0ULL
+#define PTP_NANO_TIMESTAMP			0xFF8ULL
+#define PTP_SEC_TIMESTAMP			0x1000ULL
 
 #define CYCLE_MULT				1000
 
+/* PTP atomic update operation type */
+enum atomic_opcode {
+	ATOMIC_SET = 1,
+	ATOMIC_INC = 3,
+	ATOMIC_DEC = 4
+};
+
 static struct ptp *first_ptp_block;
 static const struct pci_device_id ptp_id_table[];
 
-static bool is_ptp_dev_cnf10kb(struct ptp *ptp)
+static bool is_ptp_dev_cnf10ka(struct ptp *ptp)
 {
-	return ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP;
+	return (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP) ? true : false;
 }
 
-static bool is_ptp_dev_cn10k(struct ptp *ptp)
+static bool is_ptp_dev_cn10ka(struct ptp *ptp)
 {
-	return ptp->pdev->device == PCI_DEVID_CN10K_PTP;
+	return (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP) ? true : false;
 }
 
 static bool cn10k_ptp_errata(struct ptp *ptp)
 {
-	if (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP ||
-	    ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP)
+	if ((is_ptp_dev_cn10ka(ptp) &&
+	     ((ptp->pdev->revision & 0x0F) == 0x0 || (ptp->pdev->revision & 0x0F) == 0x1)) ||
+	    (is_ptp_dev_cnf10ka(ptp) &&
+	     ((ptp->pdev->revision & 0x0F) == 0x0 || (ptp->pdev->revision & 0x0F) == 0x1)))
 		return true;
+
 	return false;
 }
 
-static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
+static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)
 {
-	if (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP ||
-	    ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP)
+	struct ptp *ptp = rvu->ptp;
+	struct pci_dev *pdev;
+
+	if (is_rvu_otx2(rvu))
+		return false;
+
+	pdev = ptp->pdev;
+
+	/* On older silicon variants of CN10K, atomic update feature
+	 * is not available.
+	 */
+	if ((pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP &&
+	     (pdev->revision & 0x0F) == 0x0) ||
+	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP &&
+	     (pdev->revision & 0x0F) == 0x1) ||
+	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
+	     (pdev->revision & 0x0F) == 0x0) ||
+	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
+	     (pdev->revision & 0x0F) == 0x1))
+		return false;
+	else
 		return true;
-	return false;
 }
 
 static enum hrtimer_restart ptp_reset_thresh(struct hrtimer *hrtimer)
@@ -222,6 +257,65 @@ void ptp_put(struct ptp *ptp)
 	pci_dev_put(ptp->pdev);
 }
 
+static void ptp_atomic_update(struct ptp *ptp, u64 timestamp)
+{
+	u64 regval, curr_rollover_set, nxt_rollover_set;
+
+	/* First setup NSECs and SECs */
+	writeq(timestamp, ptp->reg_base + PTP_NANO_TIMESTAMP);
+	writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
+	writeq(timestamp / NSEC_PER_SEC,
+	       ptp->reg_base + PTP_SEC_TIMESTAMP);
+
+	nxt_rollover_set = roundup(timestamp, NSEC_PER_SEC);
+	curr_rollover_set = nxt_rollover_set - NSEC_PER_SEC;
+	writeq(nxt_rollover_set, ptp->reg_base + PTP_NXT_ROLLOVER_SET);
+	writeq(curr_rollover_set, ptp->reg_base + PTP_CURR_ROLLOVER_SET);
+
+	/* Now, initiate atomic update */
+	regval = readq(ptp->reg_base + PTP_CLOCK_CFG);
+	regval &= ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
+	regval |= (ATOMIC_SET << 26);
+	writeq(regval, ptp->reg_base + PTP_CLOCK_CFG);
+}
+
+static void ptp_atomic_adjtime(struct ptp *ptp, s64 delta)
+{
+	bool neg_adj = false, atomic_inc_dec = false;
+	u64 regval, ptp_clock_hi;
+
+	if (delta < 0) {
+		delta = -delta;
+		neg_adj = true;
+	}
+
+	/* use atomic inc/dec when delta < 1 second */
+	if (delta < NSEC_PER_SEC)
+		atomic_inc_dec = true;
+
+	if (!atomic_inc_dec) {
+		ptp_clock_hi = readq(ptp->reg_base + PTP_CLOCK_HI);
+		if (neg_adj) {
+			if (ptp_clock_hi > delta)
+				ptp_clock_hi -= delta;
+			else
+				ptp_clock_hi = delta - ptp_clock_hi;
+		} else {
+			ptp_clock_hi += delta;
+		}
+		ptp_atomic_update(ptp, ptp_clock_hi);
+	} else {
+		writeq(delta, ptp->reg_base + PTP_NANO_TIMESTAMP);
+		writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
+
+		/* initiate atomic inc/dec */
+		regval = readq(ptp->reg_base + PTP_CLOCK_CFG);
+		regval &= ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
+		regval |= neg_adj ? (ATOMIC_DEC << 26) : (ATOMIC_INC << 26);
+		writeq(regval, ptp->reg_base + PTP_CLOCK_CFG);
+	}
+}
+
 static int ptp_adjfine(struct ptp *ptp, long scaled_ppm)
 {
 	bool neg_adj = false;
@@ -277,8 +371,9 @@ static int ptp_get_clock(struct ptp *ptp, u64 *clk)
 	return 0;
 }
 
-void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts)
+void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts)
 {
+	struct ptp *ptp = rvu->ptp;
 	struct pci_dev *pdev;
 	u64 clock_comp;
 	u64 clock_cfg;
@@ -297,8 +392,14 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts)
 	ptp->clock_rate = sclk * 1000000;
 
 	/* Program the seconds rollover value to 1 second */
-	if (is_ptp_dev_cnf10kb(ptp))
+	if (is_tstmp_atomic_update_supported(rvu)) {
+		writeq(0, ptp->reg_base + PTP_NANO_TIMESTAMP);
+		writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
+		writeq(0, ptp->reg_base + PTP_SEC_TIMESTAMP);
+		writeq(0, ptp->reg_base + PTP_CURR_ROLLOVER_SET);
+		writeq(0x3b9aca00, ptp->reg_base + PTP_NXT_ROLLOVER_SET);
 		writeq(0x3b9aca00, ptp->reg_base + PTP_SEC_ROLLOVER);
+	}
 
 	/* Enable PTP clock */
 	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
@@ -320,6 +421,10 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts)
 	clock_cfg |= PTP_CLOCK_CFG_PTP_EN;
 	clock_cfg |= PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK_CFG_PPS_INV;
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
+	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
+	clock_cfg &= ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
+	clock_cfg |= (ATOMIC_SET << 26);
+	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
 
 	/* Set 50% duty cycle for 1Hz output */
 	writeq(0x1dcd650000000000, ptp->reg_base + PTP_PPS_HI_INCR);
@@ -350,7 +455,7 @@ static int ptp_get_tstmp(struct ptp *ptp, u64 *clk)
 {
 	u64 timestamp;
 
-	if (is_ptp_dev_cn10k(ptp)) {
+	if (is_ptp_dev_cn10ka(ptp) || is_ptp_dev_cnf10ka(ptp)) {
 		timestamp = readq(ptp->reg_base + PTP_TIMESTAMP);
 		*clk = (timestamp >> 32) * NSEC_PER_SEC + (timestamp & 0xFFFFFFFF);
 	} else {
@@ -414,14 +519,12 @@ static int ptp_probe(struct pci_dev *pdev,
 		first_ptp_block = ptp;
 
 	spin_lock_init(&ptp->ptp_lock);
-	if (is_ptp_tsfmt_sec_nsec(ptp))
-		ptp->read_ptp_tstmp = &read_ptp_tstmp_sec_nsec;
-	else
-		ptp->read_ptp_tstmp = &read_ptp_tstmp_nsec;
-
 	if (cn10k_ptp_errata(ptp)) {
+		ptp->read_ptp_tstmp = &read_ptp_tstmp_sec_nsec;
 		hrtimer_init(&ptp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		ptp->hrtimer.function = ptp_reset_thresh;
+	} else {
+		ptp->read_ptp_tstmp = &read_ptp_tstmp_nsec;
 	}
 
 	return 0;
@@ -521,6 +624,12 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct ptp_req *req,
 	case PTP_OP_EXTTS_ON:
 		err = ptp_extts_on(rvu->ptp, req->extts_on);
 		break;
+	case PTP_OP_ADJTIME:
+		ptp_atomic_adjtime(rvu->ptp, req->delta);
+		break;
+	case PTP_OP_SET_CLOCK:
+		ptp_atomic_update(rvu->ptp, (u64)req->clk);
+		break;
 	default:
 		err = -EINVAL;
 		break;
@@ -528,3 +637,17 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct ptp_req *req,
 
 	return err;
 }
+
+int rvu_mbox_handler_ptp_get_cap(struct rvu *rvu, struct msg_req *req,
+				 struct ptp_get_cap_rsp *rsp)
+{
+	if (!rvu->ptp)
+		return -ENODEV;
+
+	if (is_tstmp_atomic_update_supported(rvu))
+		rsp->cap |= PTP_CAP_HW_ATOMIC_UPDATE;
+	else
+		rsp->cap &= ~BIT_ULL_MASK(0);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h b/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
index b9d92abc3844..0268a5e0b8bc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
@@ -25,7 +25,7 @@ struct ptp {
 
 struct ptp *ptp_get(void);
 void ptp_put(struct ptp *ptp);
-void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts);
+void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts);
 
 extern struct pci_driver ptp_driver;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 73df2d564545..22c395c7d040 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3322,7 +3322,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&rvu->rswitch.switch_lock);
 
 	if (rvu->fwdata)
-		ptp_start(rvu->ptp, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_clk_rate,
+		ptp_start(rvu, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_clk_rate,
 			  rvu->fwdata->ptp_ext_tstamp);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e8e65fd7888d..c4d999ef5ab4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -17,6 +17,7 @@
 #include "mbox.h"
 #include "npc.h"
 #include "rvu_reg.h"
+#include "ptp.h"
 
 /* PCI device IDs */
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
@@ -26,6 +27,7 @@
 #define PCI_SUBSYS_DEVID_98XX                  0xB100
 #define PCI_SUBSYS_DEVID_96XX                  0xB200
 #define PCI_SUBSYS_DEVID_CN10K_A	       0xB900
+#define PCI_SUBSYS_DEVID_CNF10K_A	       0xBA00
 #define PCI_SUBSYS_DEVID_CNF10K_B              0xBC00
 #define PCI_SUBSYS_DEVID_CN10K_B               0xBD00
 
@@ -634,6 +636,16 @@ static inline bool is_rvu_otx2(struct rvu *rvu)
 		midr == PCI_REVISION_ID_95XXMM || midr == PCI_REVISION_ID_95XXO);
 }
 
+static inline bool is_cnf10ka_a0(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A &&
+	    (pdev->revision & 0x0F) == 0x0)
+		return true;
+	return false;
+}
+
 static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)
 {
 	u64 npc_const3;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 25e99fd2e3fd..ee37235e6f09 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -326,6 +326,7 @@ struct otx2_ptp {
 	struct ptp_pin_desc extts_config;
 	u64 (*convert_rx_ptp_tstmp)(u64 timestamp);
 	u64 (*convert_tx_ptp_tstmp)(u64 timestamp);
+	u64 (*ptp_tstamp2nsec)(const struct timecounter *time_counter, u64 timestamp);
 	struct delayed_work synctstamp_work;
 	u64 tstamp;
 	u32 base_ns;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 896b2f9bac34..839d7a07939d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -10,6 +10,62 @@
 #include "otx2_common.h"
 #include "otx2_ptp.h"
 
+static bool is_tstmp_atomic_update_supported(struct otx2_ptp *ptp)
+{
+	struct ptp_get_cap_rsp *rsp;
+	struct msg_req *req;
+	int err;
+
+	if (!ptp->nic)
+		return 0;
+
+	mutex_lock(&ptp->nic->mbox.lock);
+	req = otx2_mbox_alloc_msg_ptp_get_cap(&ptp->nic->mbox);
+	if (!req)
+		return 0;
+
+	err = otx2_sync_mbox_msg(&ptp->nic->mbox);
+	if (err)
+		return 0;
+
+	rsp = (struct ptp_get_cap_rsp *)otx2_mbox_get_rsp(&ptp->nic->mbox.mbox, 0,
+							  &req->hdr);
+	mutex_unlock(&ptp->nic->mbox.lock);
+
+	if (IS_ERR(rsp))
+		return false;
+
+	if (rsp->cap & PTP_CAP_HW_ATOMIC_UPDATE)
+		return true;
+
+	return false;
+}
+
+static int otx2_ptp_hw_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
+{
+	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
+					    ptp_info);
+	struct otx2_nic *pfvf = ptp->nic;
+	struct ptp_req *req;
+	int rc;
+
+	if (!ptp->nic)
+		return -ENODEV;
+
+	mutex_lock(&pfvf->mbox.lock);
+	req = otx2_mbox_alloc_msg_ptp_op(&ptp->nic->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+	req->op = PTP_OP_ADJTIME;
+	req->delta = delta;
+	rc = otx2_sync_mbox_msg(&ptp->nic->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+
+	return rc;
+}
+
 static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)
 {
 	struct ptp_req *req;
@@ -37,6 +93,49 @@ static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)
 	return rsp->clk;
 }
 
+static int otx2_ptp_hw_gettime(struct ptp_clock_info *ptp_info,
+			       struct timespec64 *ts)
+{
+	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
+					    ptp_info);
+	u64 tstamp;
+
+	tstamp = otx2_ptp_get_clock(ptp);
+
+	*ts = ns_to_timespec64(tstamp);
+	return 0;
+}
+
+static int otx2_ptp_hw_settime(struct ptp_clock_info *ptp_info,
+			       const struct timespec64 *ts)
+{
+	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
+					    ptp_info);
+	struct otx2_nic *pfvf = ptp->nic;
+	struct ptp_req *req;
+	u64 nsec;
+	int rc;
+
+	if (!ptp->nic)
+		return -ENODEV;
+
+	nsec = timespec64_to_ns(ts);
+
+	mutex_lock(&pfvf->mbox.lock);
+	req = otx2_mbox_alloc_msg_ptp_op(&ptp->nic->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->op = PTP_OP_SET_CLOCK;
+	req->clk = nsec;
+	rc = otx2_sync_mbox_msg(&ptp->nic->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+
+	return rc;
+}
+
 static int otx2_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 {
 	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
@@ -124,21 +223,15 @@ static u64 ptp_tstmp_read(struct otx2_ptp *ptp)
 	return rsp->clk;
 }
 
-static void otx2_get_ptpclock(struct otx2_ptp *ptp, u64 *tstamp)
-{
-	struct otx2_nic *pfvf = ptp->nic;
-
-	mutex_lock(&pfvf->mbox.lock);
-	*tstamp = timecounter_read(&ptp->time_counter);
-	mutex_unlock(&pfvf->mbox.lock);
-}
-
-static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
+static int otx2_ptp_tc_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 {
 	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
 					    ptp_info);
 	struct otx2_nic *pfvf = ptp->nic;
 
+	if (!ptp->nic)
+		return -ENODEV;
+
 	mutex_lock(&pfvf->mbox.lock);
 	timecounter_adjtime(&ptp->time_counter, delta);
 	mutex_unlock(&pfvf->mbox.lock);
@@ -146,32 +239,33 @@ static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 	return 0;
 }
 
-static int otx2_ptp_gettime(struct ptp_clock_info *ptp_info,
-			    struct timespec64 *ts)
+static int otx2_ptp_tc_gettime(struct ptp_clock_info *ptp_info,
+			       struct timespec64 *ts)
 {
 	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
 					    ptp_info);
 	u64 tstamp;
 
-	otx2_get_ptpclock(ptp, &tstamp);
+	mutex_lock(&ptp->nic->mbox.lock);
+	tstamp = timecounter_read(&ptp->time_counter);
+	mutex_unlock(&ptp->nic->mbox.lock);
 	*ts = ns_to_timespec64(tstamp);
 
 	return 0;
 }
 
-static int otx2_ptp_settime(struct ptp_clock_info *ptp_info,
-			    const struct timespec64 *ts)
+static int otx2_ptp_tc_settime(struct ptp_clock_info *ptp_info,
+			       const struct timespec64 *ts)
 {
 	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
 					    ptp_info);
-	struct otx2_nic *pfvf = ptp->nic;
 	u64 nsec;
 
 	nsec = timespec64_to_ns(ts);
 
-	mutex_lock(&pfvf->mbox.lock);
+	mutex_lock(&ptp->nic->mbox.lock);
 	timecounter_init(&ptp->time_counter, &ptp->cycle_counter, nsec);
-	mutex_unlock(&pfvf->mbox.lock);
+	mutex_unlock(&ptp->nic->mbox.lock);
 
 	return 0;
 }
@@ -190,6 +284,12 @@ static int otx2_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 	return 0;
 }
 
+static u64 otx2_ptp_hw_tstamp2time(const struct timecounter *time_counter, u64 tstamp)
+{
+	/* On HW which supports atomic updates, timecounter is not initialized */
+	return tstamp;
+}
+
 static void otx2_ptp_extts_check(struct work_struct *work)
 {
 	struct otx2_ptp *ptp = container_of(work, struct otx2_ptp,
@@ -204,7 +304,7 @@ static void otx2_ptp_extts_check(struct work_struct *work)
 	if (tstmp != ptp->last_extts) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = 0;
-		event.timestamp = timecounter_cyc2time(&ptp->time_counter, tstmp);
+		event.timestamp = ptp->ptp_tstamp2nsec(&ptp->time_counter, tstmp);
 		ptp_clock_event(ptp->ptp_clock, &event);
 		new_thresh = tstmp % 500000000;
 		if (ptp->thresh != new_thresh) {
@@ -229,7 +329,7 @@ static void otx2_sync_tstamp(struct work_struct *work)
 	tstamp = otx2_ptp_get_clock(ptp);
 	mutex_unlock(&pfvf->mbox.lock);
 
-	ptp->tstamp = timecounter_cyc2time(&pfvf->ptp->time_counter, tstamp);
+	ptp->tstamp = ptp->ptp_tstamp2nsec(&ptp->time_counter, tstamp);
 	ptp->base_ns = tstamp % NSEC_PER_SEC;
 
 	schedule_delayed_work(&ptp->synctstamp_work, msecs_to_jiffies(250));
@@ -302,15 +402,6 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
 
 	ptp_ptr->nic = pfvf;
 
-	cc = &ptp_ptr->cycle_counter;
-	cc->read = ptp_cc_read;
-	cc->mask = CYCLECOUNTER_MASK(64);
-	cc->mult = 1;
-	cc->shift = 0;
-
-	timecounter_init(&ptp_ptr->time_counter, &ptp_ptr->cycle_counter,
-			 ktime_to_ns(ktime_get_real()));
-
 	snprintf(ptp_ptr->extts_config.name, sizeof(ptp_ptr->extts_config.name), "TSTAMP");
 	ptp_ptr->extts_config.index = 0;
 	ptp_ptr->extts_config.func = PTP_PF_NONE;
@@ -324,13 +415,33 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
 		.pps            = 0,
 		.pin_config     = &ptp_ptr->extts_config,
 		.adjfine        = otx2_ptp_adjfine,
-		.adjtime        = otx2_ptp_adjtime,
-		.gettime64      = otx2_ptp_gettime,
-		.settime64      = otx2_ptp_settime,
 		.enable         = otx2_ptp_enable,
 		.verify         = otx2_ptp_verify_pin,
 	};
 
+	/* Check whether hardware supports atomic updates to timestamp */
+	if (is_tstmp_atomic_update_supported(ptp_ptr)) {
+		ptp_ptr->ptp_info.adjtime = otx2_ptp_hw_adjtime;
+		ptp_ptr->ptp_info.gettime64 = otx2_ptp_hw_gettime;
+		ptp_ptr->ptp_info.settime64 = otx2_ptp_hw_settime;
+
+		ptp_ptr->ptp_tstamp2nsec = otx2_ptp_hw_tstamp2time;
+	} else {
+		ptp_ptr->ptp_info.adjtime = otx2_ptp_tc_adjtime;
+		ptp_ptr->ptp_info.gettime64 = otx2_ptp_tc_gettime;
+		ptp_ptr->ptp_info.settime64 = otx2_ptp_tc_settime;
+
+		cc = &ptp_ptr->cycle_counter;
+		cc->read = ptp_cc_read;
+		cc->mask = CYCLECOUNTER_MASK(64);
+		cc->mult = 1;
+		cc->shift = 0;
+		ptp_ptr->ptp_tstamp2nsec = timecounter_cyc2time;
+
+		timecounter_init(&ptp_ptr->time_counter, &ptp_ptr->cycle_counter,
+				 ktime_to_ns(ktime_get_real()));
+	}
+
 	INIT_DELAYED_WORK(&ptp_ptr->extts_work, otx2_ptp_extts_check);
 
 	ptp_ptr->ptp_clock = ptp_clock_register(&ptp_ptr->ptp_info, pfvf->dev);
@@ -387,7 +498,7 @@ int otx2_ptp_tstamp2time(struct otx2_nic *pfvf, u64 tstamp, u64 *tsns)
 	if (!pfvf->ptp)
 		return -ENODEV;
 
-	*tsns = timecounter_cyc2time(&pfvf->ptp->time_counter, tstamp);
+	*tsns = pfvf->ptp->ptp_tstamp2nsec(&pfvf->ptp->time_counter, tstamp);
 
 	return 0;
 }
-- 
2.25.1

