Return-Path: <linux-kernel+bounces-22122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705AD82999E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B09328881A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB174C3C2;
	Wed, 10 Jan 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m4B5IG8m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC94C3B1;
	Wed, 10 Jan 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8cv3b014985;
	Wed, 10 Jan 2024 11:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2Q3Rc5OmH4sAbfrAO5UUqdKc4vZjN+nBrVtL9lEXiVc=; b=m4
	B5IG8m01TSw+iu1/AoULmTMykwETlMm04OB9+TJdK5lvkxcT8r9k2ejPBvhW4AvI
	oekvmJ9lHJWK2rlTo6JnCEvJL+RVIvmjsYSRFajSWPGlp5rG5Z3NsR2REvyXUNsM
	JTtJ8j60nry/HeFtN1sBMa8xCHx+21qKj2p305eo1142ikEvyAChYv3X1VhK5/cd
	Z9DOnhBS53kSxOYlUM7kjJhp3vHv9hc1vDjiI5xzXRDwI7XvAhXxPJTb7hKnOOi8
	tFvyvf9SL7PI94VK3N1PBqMwlHmguRoWBxWlw6O3mG/uBl6GHa/f1uy9cUSEH1sH
	lh328aBXhN5THzekZGrg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhg8g19r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABh6r9017178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:56 -0800
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
Subject: [PATCH net-next 12/20] net: ethernet: qualcomm: Add PPE RSS hash config
Date: Wed, 10 Jan 2024 19:40:24 +0800
Message-ID: <20240110114033.32575-13-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: aY60UDB6Ph4YU7Pmb7VFzLEnZH5e3sWL
X-Proofpoint-GUID: aY60UDB6Ph4YU7Pmb7VFzLEnZH5e3sWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

PPE RSS hash is generated by the configured seed based on the
packet content, which is used to select queue and can also be
passed to EDMA RX descriptor.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 53 ++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  | 97 ++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  | 22 +++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 44 +++++++++
 4 files changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index bce0a9137c9f..746ef42fea5d 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -1172,6 +1172,53 @@ static int ppe_port_ctrl_init(struct ppe_device *ppe_dev)
 	return 0;
 }
 
+static int ppe_rss_hash_init(struct ppe_device *ppe_dev)
+{
+	const struct ppe_queue_ops *ppe_queue_ops;
+	struct ppe_rss_hash_cfg hash_cfg;
+	int i, ret;
+	u16 fins[5] = {0x205, 0x264, 0x227, 0x245, 0x201};
+	u8 ips[4] = {0x13, 0xb, 0x13, 0xb};
+
+	ppe_queue_ops = ppe_queue_config_ops_get();
+	if (!ppe_queue_ops->rss_hash_config_set)
+		return -EINVAL;
+
+	hash_cfg.hash_seed = get_random_u32();
+	hash_cfg.hash_mask = 0xfff;
+	hash_cfg.hash_fragment_mode = false;
+
+	i = 0;
+	while (i < ARRAY_SIZE(fins)) {
+		hash_cfg.hash_fin_inner[i] = fins[i] & 0x1f;
+		hash_cfg.hash_fin_outer[i] = fins[i] >> 5;
+		i++;
+	}
+
+	hash_cfg.hash_protocol_mix = 0x13;
+	hash_cfg.hash_dport_mix = 0xb;
+	hash_cfg.hash_sport_mix = 0x13;
+	hash_cfg.hash_sip_mix[0] = 0x13;
+	hash_cfg.hash_dip_mix[0] = 0xb;
+
+	ret = ppe_queue_ops->rss_hash_config_set(ppe_dev,
+						 PPE_RSS_HASH_MODE_IPV4,
+						 hash_cfg);
+	if (ret)
+		return ret;
+
+	i = 0;
+	while (i < ARRAY_SIZE(ips)) {
+		hash_cfg.hash_sip_mix[i] = ips[i];
+		hash_cfg.hash_dip_mix[i] = ips[i];
+		i++;
+	}
+
+	return ppe_queue_ops->rss_hash_config_set(ppe_dev,
+						  PPE_RSS_HASH_MODE_IPV6,
+						  hash_cfg);
+}
+
 static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 {
 	int ret;
@@ -1184,7 +1231,11 @@ static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 	if (ret)
 		return ret;
 
-	return ppe_port_ctrl_init(ppe_dev);
+	ret = ppe_port_ctrl_init(ppe_dev);
+	if (ret)
+		return ret;
+
+	return ppe_rss_hash_init(ppe_dev);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
index b017983e7cbf..0398a36d680a 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -333,6 +333,102 @@ int ppe_counter_set(struct ppe_device *ppe_dev, int port, bool enable)
 			FIELD_PREP(PPE_PORT_EG_VLAN_TX_COUNTING_EN, enable));
 }
 
+static int ppe_rss_hash_config_set(struct ppe_device *ppe_dev,
+				   int mode,
+				   struct ppe_rss_hash_cfg cfg)
+{
+	u32 val;
+	int i;
+
+	if (mode & PPE_RSS_HASH_MODE_IPV4) {
+		val = FIELD_PREP(PPE_RSS_HASH_MASK_IPV4_HASH_MASK, cfg.hash_mask) |
+				 FIELD_PREP(PPE_RSS_HASH_MASK_IPV4_FRAGMENT,
+					    cfg.hash_fragment_mode);
+		ppe_write(ppe_dev, PPE_RSS_HASH_MASK_IPV4, val);
+
+		val = FIELD_PREP(PPE_RSS_HASH_SEED_IPV4_VAL, cfg.hash_seed);
+		ppe_write(ppe_dev, PPE_RSS_HASH_SEED_IPV4, val);
+
+		for (i = 0; i < PPE_RSS_HASH_MIX_IPV4_NUM; i++) {
+			switch (i) {
+			case 0:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL,
+						 cfg.hash_sip_mix[0]);
+				break;
+			case 1:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL,
+						 cfg.hash_dip_mix[0]);
+				break;
+			case 2:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL,
+						 cfg.hash_protocol_mix);
+				break;
+			case 3:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL,
+						 cfg.hash_dport_mix);
+				break;
+			case 4:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL,
+						 cfg.hash_sport_mix);
+				break;
+			default:
+				break;
+			}
+			ppe_write(ppe_dev, PPE_RSS_HASH_MIX_IPV4 + i * PPE_RSS_HASH_MIX_IPV4_INC,
+				  val);
+		}
+
+		for (i = 0; i < PPE_RSS_HASH_MIX_IPV4_NUM; i++) {
+			val = FIELD_PREP(PPE_RSS_HASH_FIN_IPV4_INNER, cfg.hash_fin_inner[i]) |
+					 FIELD_PREP(PPE_RSS_HASH_FIN_IPV4_OUTER,
+						    cfg.hash_fin_outer[i]);
+			ppe_write(ppe_dev, PPE_RSS_HASH_FIN_IPV4 + i * PPE_RSS_HASH_FIN_IPV4_INC,
+				  val);
+		}
+	}
+
+	if (mode & PPE_RSS_HASH_MODE_IPV6) {
+		val = FIELD_PREP(PPE_RSS_HASH_MASK_HASH_MASK, cfg.hash_mask) |
+				 FIELD_PREP(PPE_RSS_HASH_MASK_FRAGMENT, cfg.hash_fragment_mode);
+		ppe_write(ppe_dev, PPE_RSS_HASH_MASK, val);
+
+		val = FIELD_PREP(PPE_RSS_HASH_SEED_VAL, cfg.hash_seed);
+		ppe_write(ppe_dev, PPE_RSS_HASH_SEED, val);
+
+		for (i = 0; i < PPE_RSS_HASH_MIX_NUM; i++) {
+			switch (i) {
+			case 0 ... 3:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_VAL, cfg.hash_sip_mix[i]);
+				break;
+			case 4 ... 7:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_VAL, cfg.hash_dip_mix[i - 4]);
+				break;
+			case 8:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_VAL, cfg.hash_protocol_mix);
+				break;
+			case 9:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_VAL, cfg.hash_dport_mix);
+				break;
+			case 10:
+				val = FIELD_PREP(PPE_RSS_HASH_MIX_VAL, cfg.hash_sport_mix);
+				break;
+			default:
+				break;
+			}
+			ppe_write(ppe_dev, PPE_RSS_HASH_MIX + i * PPE_RSS_HASH_MIX_INC, val);
+		}
+
+		for (i = 0; i < PPE_RSS_HASH_FIN_NUM; i++) {
+			val = FIELD_PREP(PPE_RSS_HASH_FIN_INNER, cfg.hash_fin_inner[i]) |
+					 FIELD_PREP(PPE_RSS_HASH_FIN_OUTER, cfg.hash_fin_outer[i]);
+
+			ppe_write(ppe_dev, PPE_RSS_HASH_FIN + i * PPE_RSS_HASH_FIN_INC, val);
+		}
+	}
+
+	return 0;
+}
+
 static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_scheduler_set = ppe_queue_scheduler_set,
 	.queue_scheduler_get = ppe_queue_scheduler_get,
@@ -340,6 +436,7 @@ static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_ucast_base_get = ppe_queue_ucast_base_get,
 	.queue_ucast_pri_class_set = ppe_queue_ucast_pri_class_set,
 	.queue_ucast_hash_class_set = ppe_queue_ucast_hash_class_set,
+	.rss_hash_config_set = ppe_rss_hash_config_set,
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
index ab64a760b60b..da0f37323042 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -12,6 +12,8 @@
 
 #define PPE_QUEUE_PRI_MAX		16
 #define PPE_QUEUE_HASH_MAX		256
+#define PPE_RSS_HASH_MODE_IPV4		BIT(0)
+#define PPE_RSS_HASH_MODE_IPV6		BIT(1)
 
 /* PPE hardware QoS configurations used to dispatch the packet passed
  * through PPE, the scheduler supports DRR(deficit round robin with the
@@ -148,6 +150,23 @@ struct ppe_servcode_cfg {
 	int offset_sel;
 };
 
+/* PPE RSS hash can be configured to generate the hash value based on
+ * 5 tuples of packet, the generated hash value is used to decides the
+ * final queue ID.
+ */
+struct ppe_rss_hash_cfg {
+	u32 hash_mask;
+	bool hash_fragment_mode;
+	u32 hash_seed;
+	u8 hash_sip_mix[4];
+	u8 hash_dip_mix[4];
+	u8 hash_protocol_mix;
+	u8 hash_sport_mix;
+	u8 hash_dport_mix;
+	u8 hash_fin_inner[5];
+	u8 hash_fin_outer[5];
+};
+
 /* The operations are used to configure the PPE queue related resource */
 struct ppe_queue_ops {
 	int (*queue_scheduler_set)(struct ppe_device *ppe_dev,
@@ -176,6 +195,9 @@ struct ppe_queue_ops {
 					  int profile_id,
 					  int rss_hash,
 					  int class_offset);
+	int (*rss_hash_config_set)(struct ppe_device *ppe_dev,
+				   int mode,
+				   struct ppe_rss_hash_cfg hash_cfg);
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 3e61de54f921..b42089599cc9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -19,6 +19,50 @@
 #define PPE_RX_FIFO_CFG_INC					4
 #define PPE_RX_FIFO_CFG_THRSH					GENMASK(2, 0)
 
+#define PPE_RSS_HASH_MASK					0xb4318
+#define PPE_RSS_HASH_MASK_NUM					1
+#define PPE_RSS_HASH_MASK_INC					4
+#define PPE_RSS_HASH_MASK_HASH_MASK				GENMASK(20, 0)
+#define PPE_RSS_HASH_MASK_FRAGMENT				BIT(28)
+
+#define PPE_RSS_HASH_SEED					0xb431c
+#define PPE_RSS_HASH_SEED_NUM					1
+#define PPE_RSS_HASH_SEED_INC					4
+#define PPE_RSS_HASH_SEED_VAL					GENMASK(31, 0)
+
+#define PPE_RSS_HASH_MIX					0xb4320
+#define PPE_RSS_HASH_MIX_NUM					11
+#define PPE_RSS_HASH_MIX_INC					4
+#define PPE_RSS_HASH_MIX_VAL					GENMASK(4, 0)
+
+#define PPE_RSS_HASH_FIN					0xb4350
+#define PPE_RSS_HASH_FIN_NUM					5
+#define PPE_RSS_HASH_FIN_INC					4
+#define PPE_RSS_HASH_FIN_INNER					GENMASK(4, 0)
+#define PPE_RSS_HASH_FIN_OUTER					GENMASK(9, 5)
+
+#define PPE_RSS_HASH_MASK_IPV4					0xb4380
+#define PPE_RSS_HASH_MASK_IPV4_NUM				1
+#define PPE_RSS_HASH_MASK_IPV4_INC				4
+#define PPE_RSS_HASH_MASK_IPV4_HASH_MASK			GENMASK(20, 0)
+#define PPE_RSS_HASH_MASK_IPV4_FRAGMENT				BIT(28)
+
+#define PPE_RSS_HASH_SEED_IPV4					0xb4384
+#define PPE_RSS_HASH_SEED_IPV4_NUM				1
+#define PPE_RSS_HASH_SEED_IPV4_INC				4
+#define PPE_RSS_HASH_SEED_IPV4_VAL				GENMASK(31, 0)
+
+#define PPE_RSS_HASH_MIX_IPV4					0xb4390
+#define PPE_RSS_HASH_MIX_IPV4_NUM				5
+#define PPE_RSS_HASH_MIX_IPV4_INC				4
+#define PPE_RSS_HASH_MIX_IPV4_VAL				GENMASK(4, 0)
+
+#define PPE_RSS_HASH_FIN_IPV4					0xb43b0
+#define PPE_RSS_HASH_FIN_IPV4_NUM				5
+#define PPE_RSS_HASH_FIN_IPV4_INC				4
+#define PPE_RSS_HASH_FIN_IPV4_INNER				GENMASK(4, 0)
+#define PPE_RSS_HASH_FIN_IPV4_OUTER				GENMASK(9, 5)
+
 #define PPE_BM_TDM_CFG_TBL					0xc000
 #define PPE_BM_TDM_CFG_TBL_NUM					128
 #define PPE_BM_TDM_CFG_TBL_INC					0x10
-- 
2.42.0


