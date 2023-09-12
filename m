Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3479D80C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjILRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbjILRv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:56 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB82106;
        Tue, 12 Sep 2023 10:51:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CGUcdV031998;
        Tue, 12 Sep 2023 10:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=yWHW2+Yrgz39OFQO82zU+VT+2ng8M5E5hO7rCVbLwgE=;
 b=N2THbTkdbY/j1FdzFaeUWiR3GeedajDLuZY+pY9FX1pWxxWp+Yg1VAKmRGH5umoAtd9F
 IS2rATRCEpQvgDio0pm7eMQaMMF7+ZE/H4qq9IaiHS89Yu+RcUpFe4+iTC3cTa866eIZ
 1WyQnowY9FSZj8aCsuUlZSMr5VOOPuUdn4XLevhYoHJEWnhEB/qHsJtdA+2RP+79iIdb
 byO2f7kFybS4g+cBbFfImSueQcNiklKvqycfvnfkCnnmj9t9VkP+sxWpJ2sDKsk6duSi
 9aTp00P5fGKUPfBoBfLjXmz+sJ6VK1XNhsLjLKqMIn+RJOpE48ZxNqKJNLMtDEj1wW/x +g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t2kgetjxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 10:51:24 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Sep
 2023 10:51:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 12 Sep 2023 10:51:22 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
        by maili.marvell.com (Postfix) with ESMTP id C58703F70E8;
        Tue, 12 Sep 2023 10:51:18 -0700 (PDT)
From:   Sai Krishna <saikrishnag@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <richardcochran@gmail.com>
CC:     Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Enable PTP PPS output support
Date:   Tue, 12 Sep 2023 23:21:16 +0530
Message-ID: <20230912175116.581412-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Mu1M9YKmelK69x5Pz16mYv2VaKIjCOD-
X-Proofpoint-ORIG-GUID: Mu1M9YKmelK69x5Pz16mYv2VaKIjCOD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hkelam@marvell.com>

PTP block supports generating PPS output signal on GPIO pin. This patch
adds the support in the PTP PHC driver using standard periodic output
interface.

User can enable/disable/configure PPS by writing to the below sysfs entry

echo perout.index start.sec start.nsec period.sec period.nsec >
/sys/class/ptp/ptp0/period

Example to generate 50% duty cycle PPS signal:
echo 0 0 0 0 500000000 >  /sys/class/ptp/ptp0/period

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 86 +++++++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 31 +++++--
 3 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 6b5b06c2b4e9..c5bd7747fc0e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1574,7 +1574,7 @@ enum ptp_op {
 	PTP_OP_GET_CLOCK = 1,
 	PTP_OP_GET_TSTMP = 2,
 	PTP_OP_SET_THRESH = 3,
-	PTP_OP_EXTTS_ON = 4,
+	PTP_OP_PPS_ON = 4,
 	PTP_OP_ADJTIME = 5,
 	PTP_OP_SET_CLOCK = 6,
 };
@@ -1584,7 +1584,8 @@ struct ptp_req {
 	u8 op;
 	s64 scaled_ppm;
 	u64 thresh;
-	int extts_on;
+	u64 period;
+	int pps_on;
 	s64 delta;
 	u64 clk;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index ffbd22797163..bcc96eed2481 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -46,6 +46,7 @@
 
 #define PTP_PPS_HI_INCR				0xF60ULL
 #define PTP_PPS_LO_INCR				0xF68ULL
+#define PTP_PPS_THRESH_LO			0xF50ULL
 #define PTP_PPS_THRESH_HI			0xF58ULL
 
 #define PTP_CLOCK_LO				0xF08ULL
@@ -411,29 +412,12 @@ void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts)
 	}
 
 	clock_cfg |= PTP_CLOCK_CFG_PTP_EN;
-	clock_cfg |= PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK_CFG_PPS_INV;
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
 	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
 	clock_cfg |= (ATOMIC_SET << 26);
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
 
-	/* Set 50% duty cycle for 1Hz output */
-	writeq(0x1dcd650000000000, ptp->reg_base + PTP_PPS_HI_INCR);
-	writeq(0x1dcd650000000000, ptp->reg_base + PTP_PPS_LO_INCR);
-	if (cn10k_ptp_errata(ptp)) {
-		/* The ptp_clock_hi rollsover to zero once clock cycle before it
-		 * reaches one second boundary. so, program the pps_lo_incr in
-		 * such a way that the pps threshold value comparison at one
-		 * second boundary will succeed and pps edge changes. After each
-		 * one second boundary, the hrtimer handler will be invoked and
-		 * reprograms the pps threshold value.
-		 */
-		ptp->clock_period = NSEC_PER_SEC / ptp->clock_rate;
-		writeq((0x1dcd6500ULL - ptp->clock_period) << 32,
-		       ptp->reg_base + PTP_PPS_LO_INCR);
-	}
-
 	if (cn10k_ptp_errata(ptp))
 		clock_comp = ptp_calc_adjusted_comp(ptp->clock_rate);
 	else
@@ -465,20 +449,68 @@ static int ptp_set_thresh(struct ptp *ptp, u64 thresh)
 	return 0;
 }
 
-static int ptp_extts_on(struct ptp *ptp, int on)
+static int ptp_config_hrtimer(struct ptp *ptp, int on)
 {
 	u64 ptp_clock_hi;
 
-	if (cn10k_ptp_errata(ptp)) {
-		if (on) {
-			ptp_clock_hi = readq(ptp->reg_base + PTP_CLOCK_HI);
-			ptp_hrtimer_start(ptp, (ktime_t)ptp_clock_hi);
-		} else {
-			if (hrtimer_active(&ptp->hrtimer))
-				hrtimer_cancel(&ptp->hrtimer);
+	if (on) {
+		ptp_clock_hi = readq(ptp->reg_base + PTP_CLOCK_HI);
+		ptp_hrtimer_start(ptp, (ktime_t)ptp_clock_hi);
+	} else {
+		if (hrtimer_active(&ptp->hrtimer))
+			hrtimer_cancel(&ptp->hrtimer);
+	}
+
+	return 0;
+}
+
+static int ptp_pps_on(struct ptp *ptp, int on, u64 period)
+{
+	u64 clock_cfg;
+
+	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
+	if (on) {
+		if (cn10k_ptp_errata(ptp) && period != NSEC_PER_SEC) {
+			dev_err(&ptp->pdev->dev, "Supports max period value as 1 second\n");
+			return -EINVAL;
 		}
+
+		if (period > (8 * NSEC_PER_SEC)) {
+			dev_err(&ptp->pdev->dev, "Supports max period as 8 seconds\n");
+			return -EINVAL;
+		}
+
+		clock_cfg |= PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK_CFG_PPS_INV;
+		writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
+
+		writeq(0, ptp->reg_base + PTP_PPS_THRESH_HI);
+		writeq(0, ptp->reg_base + PTP_PPS_THRESH_LO);
+
+		/* Configure high/low phase time */
+		period = period / 2;
+		writeq(((u64)period << 32), ptp->reg_base + PTP_PPS_HI_INCR);
+		writeq(((u64)period << 32), ptp->reg_base + PTP_PPS_LO_INCR);
+	} else {
+		clock_cfg &= ~(PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK_CFG_PPS_INV);
+		writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
 	}
 
+	if (on && cn10k_ptp_errata(ptp)) {
+		/* The ptp_clock_hi rollsover to zero once clock cycle before it
+		 * reaches one second boundary. so, program the pps_lo_incr in
+		 * such a way that the pps threshold value comparison at one
+		 * second boundary will succeed and pps edge changes. After each
+		 * one second boundary, the hrtimer handler will be invoked and
+		 * reprograms the pps threshold value.
+		 */
+		ptp->clock_period = NSEC_PER_SEC / ptp->clock_rate;
+		writeq((0x1dcd6500ULL - ptp->clock_period) << 32,
+		       ptp->reg_base + PTP_PPS_LO_INCR);
+	}
+
+	if (cn10k_ptp_errata(ptp))
+		ptp_config_hrtimer(ptp, on);
+
 	return 0;
 }
 
@@ -613,8 +645,8 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct ptp_req *req,
 	case PTP_OP_SET_THRESH:
 		err = ptp_set_thresh(rvu->ptp, req->thresh);
 		break;
-	case PTP_OP_EXTTS_ON:
-		err = ptp_extts_on(rvu->ptp, req->extts_on);
+	case PTP_OP_PPS_ON:
+		err = ptp_pps_on(rvu->ptp, req->pps_on, req->period);
 		break;
 	case PTP_OP_ADJTIME:
 		ptp_atomic_adjtime(rvu->ptp, req->delta);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 3a72b0793d4a..63130ba37e9d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -175,7 +175,7 @@ static int ptp_set_thresh(struct otx2_ptp *ptp, u64 thresh)
 	return otx2_sync_mbox_msg(&ptp->nic->mbox);
 }
 
-static int ptp_extts_on(struct otx2_ptp *ptp, int on)
+static int ptp_pps_on(struct otx2_ptp *ptp, int on, u64 period)
 {
 	struct ptp_req *req;
 
@@ -186,8 +186,9 @@ static int ptp_extts_on(struct otx2_ptp *ptp, int on)
 	if (!req)
 		return -ENOMEM;
 
-	req->op = PTP_OP_EXTTS_ON;
-	req->extts_on = on;
+	req->op = PTP_OP_PPS_ON;
+	req->pps_on = on;
+	req->period = period;
 
 	return otx2_sync_mbox_msg(&ptp->nic->mbox);
 }
@@ -276,8 +277,8 @@ static int otx2_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 	switch (func) {
 	case PTP_PF_NONE:
 	case PTP_PF_EXTTS:
-		break;
 	case PTP_PF_PEROUT:
+		break;
 	case PTP_PF_PHYSYNC:
 		return -1;
 	}
@@ -340,6 +341,7 @@ static int otx2_ptp_enable(struct ptp_clock_info *ptp_info,
 {
 	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
 					    ptp_info);
+	u64 period = 0;
 	int pin;
 
 	if (!ptp->nic)
@@ -351,12 +353,24 @@ static int otx2_ptp_enable(struct ptp_clock_info *ptp_info,
 				   rq->extts.index);
 		if (pin < 0)
 			return -EBUSY;
-		if (on) {
-			ptp_extts_on(ptp, on);
+		if (on)
 			schedule_delayed_work(&ptp->extts_work, msecs_to_jiffies(200));
-		} else {
-			ptp_extts_on(ptp, on);
+		else
 			cancel_delayed_work_sync(&ptp->extts_work);
+
+		return 0;
+	case PTP_CLK_REQ_PEROUT:
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
+
+		if (rq->perout.index >= ptp_info->n_pins)
+			return -EINVAL;
+		if (on) {
+			period = rq->perout.period.sec * NSEC_PER_SEC +
+				 rq->perout.period.nsec;
+			ptp_pps_on(ptp, on, period);
+		} else {
+			ptp_pps_on(ptp, on, period);
 		}
 		return 0;
 	default:
@@ -411,6 +425,7 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
 		.name           = "OcteonTX2 PTP",
 		.max_adj        = 1000000000ull,
 		.n_ext_ts       = 1,
+		.n_per_out      = 1,
 		.n_pins         = 1,
 		.pps            = 0,
 		.pin_config     = &ptp_ptr->extts_config,
-- 
2.25.1

