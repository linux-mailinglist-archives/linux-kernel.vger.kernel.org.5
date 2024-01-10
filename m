Return-Path: <linux-kernel+bounces-22123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50B8299A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E884288823
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701A4C62F;
	Wed, 10 Jan 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mnlnH7cg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EC4C3BA;
	Wed, 10 Jan 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAhKas012709;
	Wed, 10 Jan 2024 11:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rp1tehbVu0dK8Ds6XimmKlc9CnTFXnmy8s9snzZKEUs=; b=mn
	lnH7cgdvp+hhTMY3CIFVpuxFSuHlhunl32sHuXwUrJVX6egup/Lo39a03YpyVFs5
	aKhYIw8Vy0zrPrjEC4hHs2vIILRr9E7cuvQaBux16T1idPfQdHMTx/2LKM84HLoY
	WKauzqX15dOohGd/OQ76GNE9fswWfyfdttxS8ptbvsW0vZVjmIAZTVzDvYx0x6av
	fRlGIr+052N3ar3VNLbdSl4gMQM6AFuBAsv9XGVPt0wJhB6buzYBWjk2PpPiHfBs
	MyFIQM/k1ZjSimJjTbkFSRhRwZyQ4mQlVLmUiLD/ZzyQg+jzkrYtjgri55ToNvoA
	8tFwQfiWK9Y8kjMSJDvg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqyr4b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABhQ2g014636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:26 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:16 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 14/20] net: ethernet: qualcomm: Add PPE AC(admission control) function
Date: Wed, 10 Jan 2024 19:40:26 +0800
Message-ID: <20240110114033.32575-15-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n9hU3fBnt15hxpFMGT3--m-KJl3Ywy0l
X-Proofpoint-ORIG-GUID: n9hU3fBnt15hxpFMGT3--m-KJl3Ywy0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

The PPE AC function is for configuring the threshold to drop packet
from queue.

In addition, the back pressure from EDMA ring to PPE queue function
can be configured, which is used by the EDMA driver to enable the
back pressure feature.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  | 182 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  |  47 +++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h |  24 +++
 3 files changed, 253 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
index 0398a36d680a..b4f46ad2be59 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -429,6 +429,183 @@ static int ppe_rss_hash_config_set(struct ppe_device *ppe_dev,
 	return 0;
 }
 
+static int ppe_queue_ac_threshold_set(struct ppe_device *ppe_dev,
+				      int queue,
+				      struct ppe_queue_ac_threshold ac_threshold)
+{
+	union ppe_ac_uni_queue_cfg_u uni_queue_cfg;
+
+	if (queue >= PPE_AC_UNI_QUEUE_CFG_TBL_NUM)
+		return -EINVAL;
+
+	memset(&uni_queue_cfg, 0, sizeof(uni_queue_cfg));
+	ppe_read_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+		     PPE_AC_UNI_QUEUE_CFG_TBL_INC * queue,
+		     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+
+	uni_queue_cfg.bf.wred_en = ac_threshold.wred_enable;
+	uni_queue_cfg.bf.color_aware = ac_threshold.color_enable;
+	uni_queue_cfg.bf.shared_dynamic = ac_threshold.dynamic;
+	uni_queue_cfg.bf.shared_weight = ac_threshold.shared_weight;
+	uni_queue_cfg.bf.shared_ceiling = ac_threshold.ceiling;
+	uni_queue_cfg.bf.gap_grn_grn_min = ac_threshold.green_min_off;
+	uni_queue_cfg.bf.gap_grn_yel_max = ac_threshold.yel_max_off;
+	uni_queue_cfg.bf.gap_grn_yel_min_0 = ac_threshold.yel_min_off & 0x3ff;
+	uni_queue_cfg.bf.gap_grn_yel_min_1 = (ac_threshold.yel_min_off >> 10) & BIT(0);
+	uni_queue_cfg.bf.gap_grn_red_max = ac_threshold.red_max_off;
+	uni_queue_cfg.bf.gap_grn_red_min = ac_threshold.red_min_off;
+	uni_queue_cfg.bf.red_resume_0 = ac_threshold.red_resume_off & 0x1ff;
+	uni_queue_cfg.bf.red_resume_1 = ac_threshold.red_resume_off >> 9 & GENMASK(1, 0);
+	uni_queue_cfg.bf.yel_resume = ac_threshold.yel_resume_off;
+	uni_queue_cfg.bf.grn_resume = ac_threshold.green_resume_off;
+
+	return ppe_write_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+			     PPE_AC_UNI_QUEUE_CFG_TBL_INC * queue,
+			     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+}
+
+static int ppe_queue_ac_threshold_get(struct ppe_device *ppe_dev,
+				      int queue,
+				      struct ppe_queue_ac_threshold *ac_threshold)
+{
+	union ppe_ac_uni_queue_cfg_u uni_queue_cfg;
+
+	if (queue >= PPE_AC_UNI_QUEUE_CFG_TBL_NUM)
+		return -EINVAL;
+
+	memset(&uni_queue_cfg, 0, sizeof(uni_queue_cfg));
+	ppe_read_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+		     PPE_AC_UNI_QUEUE_CFG_TBL_INC * queue,
+		     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+
+	ac_threshold->wred_enable = uni_queue_cfg.bf.wred_en;
+	ac_threshold->color_enable = uni_queue_cfg.bf.color_aware;
+	ac_threshold->dynamic = uni_queue_cfg.bf.shared_dynamic;
+	ac_threshold->shared_weight = uni_queue_cfg.bf.shared_weight;
+	ac_threshold->ceiling = uni_queue_cfg.bf.shared_ceiling;
+	ac_threshold->green_min_off = uni_queue_cfg.bf.gap_grn_grn_min;
+	ac_threshold->yel_max_off = uni_queue_cfg.bf.gap_grn_yel_max;
+	ac_threshold->yel_min_off = (uni_queue_cfg.bf.gap_grn_yel_min_0 & 0x3ff) |
+				    (uni_queue_cfg.bf.gap_grn_yel_min_1 << 10 & BIT(0));
+	ac_threshold->red_max_off = uni_queue_cfg.bf.gap_grn_red_max;
+	ac_threshold->red_min_off = uni_queue_cfg.bf.gap_grn_red_min;
+	ac_threshold->red_resume_off = (uni_queue_cfg.bf.red_resume_0 & 0x1ff) |
+				       (uni_queue_cfg.bf.red_resume_1 << 9 & GENMASK(1, 0));
+	ac_threshold->yel_resume_off = uni_queue_cfg.bf.yel_resume;
+	ac_threshold->green_resume_off = uni_queue_cfg.bf.grn_resume;
+
+	return 0;
+}
+
+static int ppe_queue_ac_ctrl_set(struct ppe_device *ppe_dev,
+				 u32 index,
+				 struct ppe_queue_ac_ctrl ac_ctrl)
+{
+	union ppe_ac_uni_queue_cfg_u uni_queue_cfg;
+	union ppe_ac_mul_queue_cfg_u mul_queue_cfg;
+	union ppe_ac_grp_cfg_u	grp_cfg;
+	int ret;
+
+	memset(&grp_cfg, 0, sizeof(grp_cfg));
+	memset(&uni_queue_cfg, 0, sizeof(uni_queue_cfg));
+	memset(&mul_queue_cfg, 0, sizeof(mul_queue_cfg));
+
+	ret = FIELD_GET(PPE_QUEUE_AC_VALUE_MASK, index);
+	if (FIELD_GET(PPE_QUEUE_AC_TYPE_MASK, index) == PPE_QUEUE_AC_TYPE_GROUP) {
+		ppe_read_tbl(ppe_dev, PPE_AC_GRP_CFG_TBL +
+			     PPE_AC_GRP_CFG_TBL_INC * ret,
+			     grp_cfg.val, sizeof(grp_cfg.val));
+
+		grp_cfg.bf.ac_en = ac_ctrl.ac_en;
+		grp_cfg.bf.force_ac_en = ac_ctrl.ac_fc_en;
+
+		ppe_write_tbl(ppe_dev, PPE_AC_GRP_CFG_TBL +
+			      PPE_AC_GRP_CFG_TBL_INC * ret,
+			      grp_cfg.val, sizeof(grp_cfg.val));
+	} else {
+		if (ret > PPE_QUEUE_AC_UCAST_MAX) {
+			ppe_read_tbl(ppe_dev, PPE_AC_MUL_QUEUE_CFG_TBL +
+				     PPE_AC_MUL_QUEUE_CFG_TBL_INC * ret,
+				     mul_queue_cfg.val, sizeof(mul_queue_cfg.val));
+
+			mul_queue_cfg.bf.ac_en = ac_ctrl.ac_en;
+			mul_queue_cfg.bf.force_ac_en = ac_ctrl.ac_fc_en;
+
+			ppe_write_tbl(ppe_dev, PPE_AC_MUL_QUEUE_CFG_TBL +
+				      PPE_AC_MUL_QUEUE_CFG_TBL_INC * ret,
+				      mul_queue_cfg.val, sizeof(mul_queue_cfg.val));
+		} else {
+			ppe_read_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+				     PPE_AC_UNI_QUEUE_CFG_TBL_INC * ret,
+				     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+
+			uni_queue_cfg.bf.ac_en = ac_ctrl.ac_en;
+			uni_queue_cfg.bf.force_ac_en = ac_ctrl.ac_fc_en;
+
+			ppe_write_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+				      PPE_AC_UNI_QUEUE_CFG_TBL_INC * ret,
+				      uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+		}
+	}
+
+	return 0;
+}
+
+static int ppe_queue_ac_ctrl_get(struct ppe_device *ppe_dev,
+				 u32 index,
+				 struct ppe_queue_ac_ctrl *ac_ctrl)
+{
+	union ppe_ac_uni_queue_cfg_u uni_queue_cfg;
+	union ppe_ac_mul_queue_cfg_u mul_queue_cfg;
+	union ppe_ac_grp_cfg_u	grp_cfg;
+	int ret;
+
+	memset(&grp_cfg, 0, sizeof(grp_cfg));
+	memset(&uni_queue_cfg, 0, sizeof(uni_queue_cfg));
+	memset(&mul_queue_cfg, 0, sizeof(mul_queue_cfg));
+
+	ret = FIELD_GET(PPE_QUEUE_AC_VALUE_MASK, index);
+	if (FIELD_GET(PPE_QUEUE_AC_TYPE_MASK, index) == PPE_QUEUE_AC_TYPE_GROUP) {
+		ppe_read_tbl(ppe_dev, PPE_AC_GRP_CFG_TBL +
+			     PPE_AC_GRP_CFG_TBL_INC * ret,
+			     grp_cfg.val, sizeof(grp_cfg.val));
+
+		ac_ctrl->ac_en = grp_cfg.bf.ac_en;
+		ac_ctrl->ac_fc_en = grp_cfg.bf.force_ac_en;
+	} else {
+		if (ret > PPE_QUEUE_AC_UCAST_MAX) {
+			ppe_read_tbl(ppe_dev, PPE_AC_MUL_QUEUE_CFG_TBL +
+				     PPE_AC_MUL_QUEUE_CFG_TBL_INC * ret,
+				     mul_queue_cfg.val, sizeof(mul_queue_cfg.val));
+
+			ac_ctrl->ac_en = mul_queue_cfg.bf.ac_en;
+			ac_ctrl->ac_fc_en = mul_queue_cfg.bf.force_ac_en;
+		} else {
+			ppe_read_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+				     PPE_AC_UNI_QUEUE_CFG_TBL_INC * ret,
+				     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+
+			ac_ctrl->ac_en = uni_queue_cfg.bf.ac_en;
+			ac_ctrl->ac_fc_en = uni_queue_cfg.bf.force_ac_en;
+		}
+	}
+
+	return 0;
+}
+
+static int ppe_ring_queue_map_set(struct ppe_device *ppe_dev,
+				  int ring_id,
+				  u32 *queue_map)
+{
+	union ppe_ring_q_map_cfg_u ring_q_map;
+
+	memset(&ring_q_map, 0, sizeof(ring_q_map));
+
+	memcpy(ring_q_map.val, queue_map, sizeof(ring_q_map.val));
+	return ppe_write_tbl(ppe_dev, PPE_RING_Q_MAP_TBL + PPE_RING_Q_MAP_TBL_INC * ring_id,
+			     ring_q_map.val, sizeof(ring_q_map.val));
+}
+
 static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_scheduler_set = ppe_queue_scheduler_set,
 	.queue_scheduler_get = ppe_queue_scheduler_get,
@@ -437,6 +614,11 @@ static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_ucast_pri_class_set = ppe_queue_ucast_pri_class_set,
 	.queue_ucast_hash_class_set = ppe_queue_ucast_hash_class_set,
 	.rss_hash_config_set = ppe_rss_hash_config_set,
+	.queue_ac_threshold_set = ppe_queue_ac_threshold_set,
+	.queue_ac_threshold_get = ppe_queue_ac_threshold_get,
+	.queue_ac_ctrl_set = ppe_queue_ac_ctrl_set,
+	.queue_ac_ctrl_get = ppe_queue_ac_ctrl_get,
+	.ring_queue_map_set = ppe_ring_queue_map_set,
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
index da0f37323042..9d069d73e257 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -14,6 +14,12 @@
 #define PPE_QUEUE_HASH_MAX		256
 #define PPE_RSS_HASH_MODE_IPV4		BIT(0)
 #define PPE_RSS_HASH_MODE_IPV6		BIT(1)
+#define PPE_QUEUE_AC_TYPE_QUEUE			0
+#define PPE_QUEUE_AC_TYPE_GROUP			1
+#define PPE_QUEUE_AC_UCAST_MAX			255
+#define PPE_QUEUE_AC_VALUE_MASK			GENMASK(23, 0)
+#define PPE_QUEUE_AC_TYPE_MASK			GENMASK(31, 24)
+#define PPE_RING_MAPPED_BP_QUEUE_WORD_COUNT	10
 
 /* PPE hardware QoS configurations used to dispatch the packet passed
  * through PPE, the scheduler supports DRR(deficit round robin with the
@@ -167,6 +173,32 @@ struct ppe_rss_hash_cfg {
 	u8 hash_fin_outer[5];
 };
 
+/* PPE queue threshold config for the admission control, the threshold
+ * decides the length of queue, the threshold can be configured statically
+ * or dynamically changed with the free buffer.
+ */
+struct ppe_queue_ac_threshold {
+	bool color_enable;
+	bool wred_enable;
+	bool dynamic;
+	int shared_weight;
+	int green_min_off;
+	int yel_max_off;
+	int yel_min_off;
+	int red_max_off;
+	int red_min_off;
+	int green_resume_off;
+	int yel_resume_off;
+	int red_resume_off;
+	int ceiling;
+};
+
+/* Admission control status of PPE queue. */
+struct ppe_queue_ac_ctrl {
+	bool ac_en;
+	bool ac_fc_en;
+};
+
 /* The operations are used to configure the PPE queue related resource */
 struct ppe_queue_ops {
 	int (*queue_scheduler_set)(struct ppe_device *ppe_dev,
@@ -198,6 +230,21 @@ struct ppe_queue_ops {
 	int (*rss_hash_config_set)(struct ppe_device *ppe_dev,
 				   int mode,
 				   struct ppe_rss_hash_cfg hash_cfg);
+	int (*queue_ac_threshold_set)(struct ppe_device *ppe_dev,
+				      int queue,
+				      struct ppe_queue_ac_threshold ac_threshold);
+	int (*queue_ac_threshold_get)(struct ppe_device *ppe_dev,
+				      int queue,
+				      struct ppe_queue_ac_threshold *ac_threshold);
+	int (*queue_ac_ctrl_set)(struct ppe_device *ppe_dev,
+				 u32 index,
+				 struct ppe_queue_ac_ctrl ac_ctrl);
+	int (*queue_ac_ctrl_get)(struct ppe_device *ppe_dev,
+				 u32 index,
+				 struct ppe_queue_ac_ctrl *ac_ctrl);
+	int (*ring_queue_map_set)(struct ppe_device *ppe_dev,
+				  int ring_id,
+				  u32 *queue_map);
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index b42089599cc9..ef12037ffed5 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -238,6 +238,30 @@ union ppe_mru_mtu_ctrl_cfg_u {
 #define PPE_L0_COMP_CFG_TBL_SHAPER_METER_LEN			GENMASK(1, 0)
 #define PPE_L0_COMP_CFG_TBL_DRR_METER_LEN			GENMASK(3, 2)
 
+#define PPE_RING_Q_MAP_TBL					0x42a000
+#define PPE_RING_Q_MAP_TBL_NUM					24
+#define PPE_RING_Q_MAP_TBL_INC					0x40
+
+/* The queue bitmap for the back pressure from EDAM RX ring to PPE queue */
+struct ppe_ring_q_map_cfg {
+	u32 queue_bitmap_0;
+	u32 queue_bitmap_1;
+	u32 queue_bitmap_2;
+	u32 queue_bitmap_3;
+	u32 queue_bitmap_4;
+	u32 queue_bitmap_5;
+	u32 queue_bitmap_6;
+	u32 queue_bitmap_7;
+	u32 queue_bitmap_8;
+	u32 queue_bitmap_9:12,
+	    res0:20;
+};
+
+union ppe_ring_q_map_cfg_u {
+	u32 val[10];
+	struct ppe_ring_q_map_cfg bf;
+};
+
 #define PPE_DEQ_OPR_TBL						0x430000
 #define PPE_DEQ_OPR_TBL_NUM					300
 #define PPE_DEQ_OPR_TBL_INC					0x10
-- 
2.42.0


