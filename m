Return-Path: <linux-kernel+bounces-64561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16285404B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C91C221B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051C6312D;
	Tue, 13 Feb 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iAskxFN1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7926AD4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867943; cv=none; b=ZNslQBPYCHcnpbN33Gk8cxJjuJpzN4jdmaQzZYx2J2OHq3M0yVFBkzuYlKtXB2ZBa72dznjkELdCNGUNiqX1AAyuKD0RN0itxgB8UeDz8kXWBJBBKAppehWn5dMCdzAjFgjkMiQFe2UVjqQ8tfJiI8Ur+WuMxjtjRkB1PewqTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867943; c=relaxed/simple;
	bh=yn2jIFuYtxrp548f32MUQf1lMPhkhV9hIjcwOWQhpgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+nVANyxKyVaORZWa7PqVtB4hGEAolp2FpVSt09Ey9chlEsirG0QZQGrSR6Cx8bMqd2Uy/9FwHxy/ne+pLn+jO69cdgdWatL47UhE74MEiIVMr/3ODA06tAvQAwQArj7Cgytz0Vev8mDLBrd8YvLCVZD2vo+EYitgdAWQXFPSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iAskxFN1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DNXbxo026523;
	Tue, 13 Feb 2024 23:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=VVastTY
	OjzYFoU+p3F/EWLE/+TiOzFug5zCVg4rEO/s=; b=iAskxFN1f60Lld7kVe4znNZ
	jFc+HBk1Lq1wUt074/hWQ976s3OGrneb+dod0+T+bRKB+626VNIF6/h0ZSkiTzKK
	YFI2NHG8ZqgC7Dr8ExFgf6o6PKa3gUSOx6i38w5oimnSonXbhs69tVaFwWFfwmLa
	+YkDR1NPFi7+iOJc8tEEn/8QlHc34HkgOm+RokYiLpSUv2GDad774sKLC2K3HA8n
	19hfe8P+KrkkE93Ut13YQHB9Wy5oiXddAlZHkd7OVI9/NSSYAEPfR8h2++erj5ES
	hY1EaDcn32AVe5TMcFGYS/6xn6l5fGPQHasWTED/lAZr/sWA/OHbjoO0IsaskAA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8j65r0pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:45:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DNjTfJ004213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:45:29 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 15:45:28 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin
	<tvrtko.ursulin@linux.intel.com>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>, <robdclark@gmail.com>,
        <freedreno@lists.freedesktop.org>, <dmitry.baryshkov@linaro.org>,
        <intel-gfx@lists.freedesktop.org>, <ville.syrjala@linux.intel.com>,
        <quic_jesszhan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <intel-xe@lists.freedesktop.org>
Subject: [PATCH] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
Date: Tue, 13 Feb 2024 15:45:13 -0800
Message-ID: <20240213234513.2411604-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uCTeSFkl4dzhDiTNPFOTpc3WpHtrIvw8
X-Proofpoint-ORIG-GUID: uCTeSFkl4dzhDiTNPFOTpc3WpHtrIvw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130187

intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
Lets move this to drm_dp_helper to achieve this.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 78 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 73 +----------------------
 include/drm/display/drm_dp_helper.h     |  3 +
 3 files changed, 84 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index b1ca3a1100da..066cfbbf7a91 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2916,6 +2916,84 @@ void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
 }
 EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
 
+/**
+ * drm_dp_vsc_sdp_pack() - pack a given vsc sdp into generic dp_sdp
+ * @vsc: vsc sdp initialized according to its purpose as defined in
+ *       table 2-118 - table 2-120 in DP 1.4a specification
+ * @sdp: valid handle to the generic dp_sdp which will be packed
+ * @size: valid size of the passed sdp handle
+ *
+ * Returns length of sdp on success and error code on failure
+ */
+ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
+			    struct dp_sdp *sdp, size_t size)
+{
+	size_t length = sizeof(struct dp_sdp);
+
+	if (size < length)
+		return -ENOSPC;
+
+	memset(sdp, 0, size);
+
+	/*
+	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
+	 * VSC SDP Header Bytes
+	 */
+	sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
+	sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
+	sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
+	sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
+
+	if (vsc->revision == 0x6) {
+		sdp->db[0] = 1;
+		sdp->db[3] = 1;
+	}
+
+	/*
+	 * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
+	 * Format as per DP 1.4a spec and DP 2.0 respectively.
+	 */
+	if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
+		goto out;
+
+	/* VSC SDP Payload for DB16 through DB18 */
+	/* Pixel Encoding and Colorimetry Formats  */
+	sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
+	sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
+
+	switch (vsc->bpc) {
+	case 6:
+		/* 6bpc: 0x0 */
+		break;
+	case 8:
+		sdp->db[17] = 0x1; /* DB17[3:0] */
+		break;
+	case 10:
+		sdp->db[17] = 0x2;
+		break;
+	case 12:
+		sdp->db[17] = 0x3;
+		break;
+	case 16:
+		sdp->db[17] = 0x4;
+		break;
+	default:
+		WARN(1, "Missing case %d\n", vsc->bpc);
+		return -EINVAL;
+	}
+
+	/* Dynamic Range and Component Bit Depth */
+	if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
+		sdp->db[17] |= 0x80;  /* DB17[7] */
+
+	/* Content Type */
+	sdp->db[18] = vsc->content_type & 0x7;
+
+out:
+	return length;
+}
+EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
+
 /**
  * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
  * @dpcd: DisplayPort configuration data
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f5ef95da5534..e94db51aeeb7 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4110,73 +4110,6 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
 	return false;
 }
 
-static ssize_t intel_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
-				     struct dp_sdp *sdp, size_t size)
-{
-	size_t length = sizeof(struct dp_sdp);
-
-	if (size < length)
-		return -ENOSPC;
-
-	memset(sdp, 0, size);
-
-	/*
-	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
-	 * VSC SDP Header Bytes
-	 */
-	sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
-	sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
-	sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
-	sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
-
-	if (vsc->revision == 0x6) {
-		sdp->db[0] = 1;
-		sdp->db[3] = 1;
-	}
-
-	/*
-	 * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
-	 * Format as per DP 1.4a spec and DP 2.0 respectively.
-	 */
-	if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
-		goto out;
-
-	/* VSC SDP Payload for DB16 through DB18 */
-	/* Pixel Encoding and Colorimetry Formats  */
-	sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
-	sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
-
-	switch (vsc->bpc) {
-	case 6:
-		/* 6bpc: 0x0 */
-		break;
-	case 8:
-		sdp->db[17] = 0x1; /* DB17[3:0] */
-		break;
-	case 10:
-		sdp->db[17] = 0x2;
-		break;
-	case 12:
-		sdp->db[17] = 0x3;
-		break;
-	case 16:
-		sdp->db[17] = 0x4;
-		break;
-	default:
-		MISSING_CASE(vsc->bpc);
-		break;
-	}
-	/* Dynamic Range and Component Bit Depth */
-	if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
-		sdp->db[17] |= 0x80;  /* DB17[7] */
-
-	/* Content Type */
-	sdp->db[18] = vsc->content_type & 0x7;
-
-out:
-	return length;
-}
-
 static ssize_t
 intel_dp_hdr_metadata_infoframe_sdp_pack(struct drm_i915_private *i915,
 					 const struct hdmi_drm_infoframe *drm_infoframe,
@@ -4269,8 +4202,8 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
 
 	switch (type) {
 	case DP_SDP_VSC:
-		len = intel_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
-					    sizeof(sdp));
+		len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
+					  sizeof(sdp));
 		break;
 	case HDMI_PACKET_TYPE_GAMUT_METADATA:
 		len = intel_dp_hdr_metadata_infoframe_sdp_pack(dev_priv,
@@ -4297,7 +4230,7 @@ void intel_write_dp_vsc_sdp(struct intel_encoder *encoder,
 	struct dp_sdp sdp = {};
 	ssize_t len;
 
-	len = intel_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
+	len = drm_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
 
 	if (drm_WARN_ON(&dev_priv->drm, len < 0))
 		return;
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 863b2e7add29..f8db34a2f7a5 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -813,4 +813,7 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
 		       int bpp_x16, unsigned long flags);
 int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
 
+ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
+			    struct dp_sdp *sdp, size_t size);
+
 #endif /* _DRM_DP_HELPER_H_ */
-- 
2.34.1


