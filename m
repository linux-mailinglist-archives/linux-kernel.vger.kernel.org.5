Return-Path: <linux-kernel+bounces-83229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD6869083
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F828182E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FE146E7F;
	Tue, 27 Feb 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lupge9mM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B0145FF0;
	Tue, 27 Feb 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036718; cv=none; b=HU0AQ1f6rA8dt3YmODQ/pE0dWmAlL++xWB8IGNONIDlNeOiPNWBDvmmB/3p/wB4CBnaK4roR/Avnnmem2MnJIg1edbwHGB8y+86L3OdKix/mAHua7lMWp+YhYhwcHttZQ09v843vSor6DfnemRPQinCKRQ7WpQqOqEcIUbJ58tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036718; c=relaxed/simple;
	bh=aBf4qn7jya1cVaKMMd/kzd02KipjVxsYjZ/HKtUTBMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFmOrCfkNjBVcsswk+t4tROc1z5LtVSv54SJf/dhP3jkQ6iUo4vzjl+IkYl1Dw9/mjF9gTYWIRzlS2+AE5c8xfqwxXT+T12QMI/NxQY8YaCnkhXKeBxyBCPYB6EM9CDs3S975L3pciyucHons5hUj0zqd3R/LDgbTOP4ycORxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lupge9mM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Yv9h025167;
	Tue, 27 Feb 2024 12:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=WOHgVY/PntFVNf7qazMcY/FWhEytsvCAFYVY0jGBgvE=; b=Lu
	pge9mMiDgLJKz6KkiLsHlQ+4mIlYg2ZV+qZnfmwaC1ESadDuHYJ4/c7tImAqm48a
	8v1EDOT89voTdfwVDvLb5TnZx5D7r0KiUwjHmkTqog0sQFJI4B1p5dn/SP0aadID
	MMHgW8ku6RRptY4PBSl7bCLb2N1zNdEoiNuLFslWm7iCI6zbBIZkTzUZT9kCC4tv
	0o1wKTNvfbtmv9TDTYOuLRol6h4n+5x4z8NHDYd6W6agLKHWA/Z4XR9uiKuni2GO
	fFyS51DwdR9rw5AYLcCUV86lhT0h4TO5EVgSPli/tH09bi1aTSqBTtkSKo9b5ds+
	n+6gxmc7FarZAJAWzPoA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh85qry8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RCPAvo004041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:10 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 04:25:07 -0800
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH 9/9] media: qcom: camss: Decouple VFE from CSID
Date: Tue, 27 Feb 2024 14:24:15 +0200
Message-ID: <20240227122415.491-10-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227122415.491-1-quic_grosikop@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Oqo9_v47YFC8_zAZgl7YcxJNakHQKXzO
X-Proofpoint-GUID: Oqo9_v47YFC8_zAZgl7YcxJNakHQKXzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270097

From: Milen Mitkov <quic_mmitkov@quicinc.com>

Decouple the direct calls to VFE's vfe_get/put in the CSID subdev
in order to prepare for the introduction of IFE subdev.

Also decouple CSID base address from VFE since on the Titan platform
CSID register base address resides within VFE's base address.

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 .../media/platform/qcom/camss/camss-csid.c    | 16 +++--
 .../media/platform/qcom/camss/camss-csid.h    |  1 +
 drivers/media/platform/qcom/camss/camss.c     | 61 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h     |  8 +++
 4 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 5b23f5b8746d..858db5d4ca75 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -602,7 +602,6 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	struct csid_device *csid = v4l2_get_subdevdata(sd);
 	struct camss *camss = csid->camss;
 	struct device *dev = camss->dev;
-	struct vfe_device *vfe = &camss->vfe[csid->id];
 	int ret = 0;
 
 	if (on) {
@@ -611,7 +610,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		 * switching on the CSID. Do so unconditionally, as there is no
 		 * drawback in following the same powering order on older SoCs.
 		 */
-		ret = vfe_get(vfe);
+		ret = csid->res->parent_dev_ops->get(camss, csid->id);
 		if (ret < 0)
 			return ret;
 
@@ -663,7 +662,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		regulator_bulk_disable(csid->num_supplies,
 				       csid->supplies);
 		pm_runtime_put_sync(dev);
-		vfe_put(vfe);
+		csid->res->parent_dev_ops->put(camss, csid->id);
 	}
 
 	return ret;
@@ -1021,6 +1020,11 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 	csid->id = id;
 	csid->res = &res->csid;
 
+	if (dev_WARN_ONCE(dev, !csid->res->parent_dev_ops,
+			  "Error: CSID depends on VFE/IFE device ops!\n")) {
+		return -EINVAL;
+	}
+
 	csid->res->hw_ops->subdev_init(csid);
 
 	/* Memory */
@@ -1031,9 +1035,11 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 		 * VFE to be initialized before CSID
 		 */
 		if (id >= 2) /* VFE/CSID lite */
-			csid->base = camss->vfe[id].base + VFE_480_LITE_CSID_OFFSET;
+			csid->base = csid->res->parent_dev_ops->get_base_address(camss, id)
+				+ VFE_480_LITE_CSID_OFFSET;
 		else
-			csid->base = camss->vfe[id].base + VFE_480_CSID_OFFSET;
+			csid->base = csid->res->parent_dev_ops->get_base_address(camss, id)
+				 + VFE_480_CSID_OFFSET;
 	} else {
 		csid->base = devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
 		if (IS_ERR(csid->base))
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index 0e385d17c250..8cdae98e4dca 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -157,6 +157,7 @@ struct csid_hw_ops {
 struct csid_subdev_resources {
 	bool is_lite;
 	const struct csid_hw_ops *hw_ops;
+	const struct parent_dev_ops *parent_dev_ops;
 	const struct csid_formats *formats;
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 244849db39dc..47df325a2ca9 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -32,6 +32,8 @@
 #define CAMSS_CLOCK_MARGIN_NUMERATOR 105
 #define CAMSS_CLOCK_MARGIN_DENOMINATOR 100
 
+static const struct parent_dev_ops vfe_parent_dev_ops;
+
 static const struct camss_subdev_resources csiphy_res_8x16[] = {
 	/* CSIPHY0 */
 	{
@@ -87,6 +89,7 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_1,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_1
 		}
 	},
@@ -109,6 +112,7 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_1,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_1
 		}
 	},
@@ -226,6 +230,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -248,6 +253,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -270,6 +276,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -292,6 +299,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	}
@@ -445,6 +453,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -470,6 +479,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -495,6 +505,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -520,6 +531,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	}
@@ -715,6 +727,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.csid = {
 			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -741,6 +754,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.csid = {
 			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -767,6 +781,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	}
@@ -960,6 +975,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -978,6 +994,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -995,6 +1012,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1012,6 +1030,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	}
@@ -1306,6 +1325,48 @@ void camss_pm_domain_off(struct camss *camss, int id)
 	}
 }
 
+static int vfe_parent_dev_ops_get(struct camss *camss, int id)
+{
+	int ret = -EINVAL;
+
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		ret = vfe_get(vfe);
+	}
+
+	return ret;
+}
+
+static int vfe_parent_dev_ops_put(struct camss *camss, int id)
+{
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		vfe_put(vfe);
+	}
+
+	return 0;
+}
+
+static void __iomem
+*vfe_parent_dev_ops_get_base_address(struct camss *camss, int id)
+{
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		return vfe->base;
+	}
+
+	return NULL;
+}
+
+static const struct parent_dev_ops vfe_parent_dev_ops = {
+	.get = vfe_parent_dev_ops_get,
+	.put = vfe_parent_dev_ops_put,
+	.get_base_address = vfe_parent_dev_ops_get_base_address
+};
+
 /*
  * camss_of_parse_endpoint_node - Parse port endpoint node
  * @dev: Device
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index fb997b94fd70..362a84bcb2bc 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -142,6 +142,12 @@ struct camss_clock {
 	u32 nfreqs;
 };
 
+struct parent_dev_ops {
+	int (*get)(struct camss *camss, int id);
+	int (*put)(struct camss *camss, int id);
+	void __iomem *(*get_base_address)(struct camss *camss, int id);
+};
+
 void camss_add_clock_margin(u64 *rate);
 int camss_enable_clocks(int nclocks, struct camss_clock *clock,
 			struct device *dev);
@@ -152,6 +158,8 @@ s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
 int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock);
 int camss_pm_domain_on(struct camss *camss, int id);
 void camss_pm_domain_off(struct camss *camss, int id);
+int camss_vfe_get(struct camss *camss, int id);
+void camss_vfe_put(struct camss *camss, int id);
 void camss_delete(struct camss *camss);
 
 #endif /* QC_MSM_CAMSS_H */
-- 
2.17.1


