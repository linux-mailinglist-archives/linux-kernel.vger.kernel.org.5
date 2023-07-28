Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7183D7672AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjG1RDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjG1RDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:03:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16735AD;
        Fri, 28 Jul 2023 10:03:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE1WhI030541;
        Fri, 28 Jul 2023 17:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=tZUnSiy9Oye5E/RByOQOkRvai7Pn+8Oq3sb2mHyuJd0=;
 b=LZcLOD8eoSEBE69Er8Yx7cy8WDrvc02MApN44tE3I9n9adaHXOIq/Bx+hCJb5GeNWRbt
 6YjBwhCN0qAROleJ9LAw/Q8qLMKL2i7CkWk7sde5KR/uQh0t4nuq9iaCN24pY4JYvjRY
 x8tREbOMr8tACrogHmucrOL6A6nl/Y0dL5fXCzKiycFECWir3u9NYAevxJyUCjDNKBf0
 6iMQF7ytVxQaWajsBGXtXwfIuFdsiukGgiH6F442d67ltgoha0EGZ5lnXDlvmH4PmloF
 vPqBXccLqNONn5P2DHVkvv3Nnrq0oo/Nx+XEbRevgstWqZX0RCmOesLK1xxGnetknzf/ uA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3ufutu27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 17:02:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SH2r3v000718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 17:02:53 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 10:02:53 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Fri, 28 Jul 2023 10:02:12 -0700
Subject: [PATCH RFC v5 03/10] drm: Add solid fill pixel source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230728-solid-fill-v5-3-053dbefa909c@quicinc.com>
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
In-Reply-To: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690563772; l=2092;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=5AoLmSKmccZMrTDwexjp7orCY4q6SQsDRDcB/sswwJo=;
 b=4TlSRpI1VRYUtrQOXd7PwPoKqlecvQmt15QLN9GLGzS8a064zfqcyRjHr7PnHHI20+YyQpOT7
 rSWqA8tMe/ACGHBBoAVAMb8xvvShP+90ddImfLgJa8p/DA1mOjQMxK6
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O3ik67PdT8FF0yfHybBKZw4SgLPxDpKE
X-Proofpoint-ORIG-GUID: O3ik67PdT8FF0yfHybBKZw4SgLPxDpKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=869 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280154
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "SOLID_FILL" as a valid pixel source. If the pixel_source property is
set to "SOLID_FILL", it will display data from the drm_plane "solid_fill"
blob property.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_blend.c | 10 +++++++++-
 include/drm/drm_plane.h     |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index c632dfcd8a9b..34b1fd3e2310 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -200,6 +200,9 @@
  *	"FB":
  *		Framebuffer source set by the "FB_ID" property.
  *
+ *	"SOLID_FILL":
+ *		Solid fill color source set by the "solid_fill" property.
+ *
  * solid_fill:
  *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
  *	contains pixel data that drivers can use to fill a plane.
@@ -657,6 +660,9 @@ EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
  * "FB":
  *	Framebuffer pixel source
  *
+ * "SOLID_FILL":
+ * 	Solid fill color pixel source
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
@@ -668,8 +674,10 @@ int drm_plane_create_pixel_source_property(struct drm_plane *plane,
 	static const struct drm_prop_enum_list enum_list[] = {
 		{ DRM_PLANE_PIXEL_SOURCE_NONE, "NONE" },
 		{ DRM_PLANE_PIXEL_SOURCE_FB, "FB" },
+		{ DRM_PLANE_PIXEL_SOURCE_SOLID_FILL, "SOLID_FILL" },
 	};
-	static const unsigned int valid_source_mask = BIT(DRM_PLANE_PIXEL_SOURCE_FB);
+	static const unsigned int valid_source_mask = BIT(DRM_PLANE_PIXEL_SOURCE_FB) |
+						      BIT(DRM_PLANE_PIXEL_SOURCE_SOLID_FILL);
 	int i;
 
 	/* FB is supported by default */
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index abf1458fa099..234fee3d5a95 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -43,6 +43,7 @@ enum drm_scaling_filter {
 enum drm_plane_pixel_source {
 	DRM_PLANE_PIXEL_SOURCE_NONE,
 	DRM_PLANE_PIXEL_SOURCE_FB,
+	DRM_PLANE_PIXEL_SOURCE_SOLID_FILL,
 	DRM_PLANE_PIXEL_SOURCE_MAX
 };
 

-- 
2.41.0

