Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60280D764
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbjLKSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjLKSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:38:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70949B4;
        Mon, 11 Dec 2023 10:39:03 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBDuPok018880;
        Mon, 11 Dec 2023 18:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type; s=
        qcppdkim1; bh=UJ+moKUv1S7YSXYgF/ipZCUTTzlE7oZQ5n8SVsEa5vw=; b=I5
        xH+xSa7gfpkoaPjmE2kS9pnjUFyIgJbij2qhgKdN4a3ngrtIRVXNDPU2LBIw199W
        VPhkG+b+65t/uDKnDcc4trPudFTf7qVL4KwTQrzHqQAgbgOP+jebfUFqLteATtS9
        ZQz0ePhNsSiz89fi5g9UGrIk/edFFkh+biKwZlKnwxK9AASkq2Mba4H1X2rtJdUB
        KNi/fxGFZrI+7g1/3dEjyvTSPC0npCWRjL8XUDPxhbpFRlGoS6Byvd6XxzsZdoCn
        VA4S+PJjCwNw4U4IMpEmSMS7sbDmVZve7McoN0PDm5qgt7Akq9WHphSXXTpvztYC
        3N4qzTOwYoyQdgquRmdg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux20erwqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:38:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBIcqcJ027160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:38:52 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:38:52 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/msm/dpu: improve DSC allocation
Date:   Mon, 11 Dec 2023 10:38:43 -0800
Message-ID: <1702319923-24518-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zg0760vCivnZ_q3Lmo_UpegsXb3KhrwG
X-Proofpoint-ORIG-GUID: zg0760vCivnZ_q3Lmo_UpegsXb3KhrwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=879 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A DCE (Display Compression Engine) contains two DSC hard slice
encoders. Each DCE start with even DSC encoder index followed by
an odd DSC encoder index. Each encoder can work independently.
But Only two DSC encoders from same DCE can be paired to work
together to support merge mode. In addition, the DSC with even
index have to mapping to even pingpong index and DSC with odd
index have to mapping to odd pingpong index at its data path.
This patch improve DSC allocation mechanism with consideration
of above factors.

Changes in V3:
-- add dpu_rm_pingpong_dsc_check()
-- for pair allocation use i += 2 at for loop

Changes in V2:
    -- split _dpu_rm_reserve_dsc() into _dpu_rm_reserve_dsc_single() and
       _dpu_rm_reserve_dsc_pair()

Fixes: f2803ee91a41 ("drm/msm/disp/dpu1: Add DSC support in RM")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 171 ++++++++++++++++++++++++++++++---
 1 file changed, 155 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 17ecf23..43598ee 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -470,33 +470,172 @@ static int _dpu_rm_reserve_ctls(
 	return 0;
 }
 
-static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
+static int _dpu_rm_pingpong_dsc_check(int dsc_idx,
+				      uint32_t enc_id,
+				      uint32_t *pp_to_enc_id,
+				      int pp_max,
+				      bool pair)
+{
+	int pp_idx;
+
+	/*
+	 * find the pingpong index which had been reserved
+	 * previously at layer mixer allocation
+	 */
+	for (pp_idx = 0; pp_idx < pp_max; pp_idx++) {
+		if (pp_to_enc_id[pp_idx] == enc_id)
+			break;
+	}
+
+	/*
+	 * dsc even index must map to pingpong even index
+	 * dsc odd index must map to pingpong odd index
+	 */
+	if ((dsc_idx & 0x01) != (pp_idx & 0x01))
+		return -ENAVAIL;
+
+	if (pair) {
+		/*
+		 * delete pp_idx so that same pp_id can not be paired with
+		 * next dsc_id
+		 */
+		pp_to_enc_id[pp_idx] = 0xffff;
+	}
+
+	return 0;
+
+}
+
+static int _dpu_rm_reserve_dsc_single(struct dpu_rm *rm,
 			       struct dpu_global_state *global_state,
-			       struct drm_encoder *enc,
+			       uint32_t enc_id,
 			       const struct msm_display_topology *top)
 {
-	int num_dsc = top->num_dsc;
-	int i;
+	int num_dsc = 0;
+	int i, ret;
+	int dsc_id[DSC_MAX - DSC_0];
+	uint32_t *pp_enc_id = global_state->pingpong_to_enc_id;
+	int pp_max = PINGPONG_MAX - PINGPONG_0;
 
-	/* check if DSC required are allocated or not */
-	for (i = 0; i < num_dsc; i++) {
-		if (!rm->dsc_blks[i]) {
-			DPU_ERROR("DSC %d does not exist\n", i);
-			return -EIO;
-		}
+	memset(dsc_id, 0, sizeof(dsc_id));
 
-		if (global_state->dsc_to_enc_id[i]) {
-			DPU_ERROR("DSC %d is already allocated\n", i);
-			return -EIO;
-		}
+	for (i = 0; i < ARRAY_SIZE(rm->dsc_blks) && num_dsc >= top->num_dsc; i++) {
+		if (!rm->dsc_blks[i])
+			continue;
+
+		if (global_state->dsc_to_enc_id[i])	/* used */
+			continue;
+
+		ret = _dpu_rm_pingpong_dsc_check(i, enc_id, pp_enc_id, pp_max, false);
+		if (!ret)
+			dsc_id[num_dsc++] = DSC_0 + i;	/* found, start from DSC_0 */
 	}
 
-	for (i = 0; i < num_dsc; i++)
-		global_state->dsc_to_enc_id[i] = enc->base.id;
+	if (num_dsc < top->num_dsc) {
+		DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
+						num_dsc, top->num_dsc);
+		return -ENAVAIL;
+	}
+
+	/* allocate dsc */
+	for (i = 0; i < top->num_dsc; i++) {
+		int id;
+
+		id = dsc_id[i];
+		if (id >= DSC_0)
+			global_state->dsc_to_enc_id[id - DSC_0] = enc_id;
+	}
 
 	return 0;
 }
 
+static int _dpu_rm_reserve_dsc_pair(struct dpu_rm *rm,
+			       struct dpu_global_state *global_state,
+			       uint32_t enc_id,
+			       const struct msm_display_topology *top)
+{
+	int num_dsc = 0;
+	int i, ret;
+	int dsc_id[DSC_MAX - DSC_0];
+	uint32_t pp_to_enc_id[PINGPONG_MAX - PINGPONG_0];
+	uint32_t *dsc_enc_id = global_state->dsc_to_enc_id;
+	int pp_max = PINGPONG_MAX - PINGPONG_0;
+
+	memset(dsc_id, 0, sizeof(dsc_id));
+
+	/* only start from even dsc index */
+	for (i = 0; i < ARRAY_SIZE(rm->dsc_blks) && num_dsc >= top->num_dsc; i += 2) {
+		if (!rm->dsc_blks[i] || !rm->dsc_blks[i + 1])
+			continue;
+
+		/* consective dsc index to be paired */
+		if (dsc_enc_id[i] || dsc_enc_id[i + 1])	/* used */
+			continue;
+
+		/* fill working copy with pingpong list */
+		memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id, sizeof(pp_to_enc_id));
+
+		ret = _dpu_rm_pingpong_dsc_check(i, enc_id, pp_to_enc_id, pp_max, true);
+		if (ret)
+			continue;
+
+		ret = _dpu_rm_pingpong_dsc_check(i + 1, enc_id, pp_to_enc_id, pp_max, true);
+		if (ret)
+			continue;
+
+		/* pair found, start from DSC_0 */
+		dsc_id[num_dsc++] = DSC_0 + i;
+		dsc_id[num_dsc++] = DSC_0 + i + 1;
+	}
+
+	if (num_dsc < top->num_dsc) {
+		DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
+						num_dsc, top->num_dsc);
+		return -ENAVAIL;
+	}
+
+	/* allocate dsc */
+	for (i = 0; i < top->num_dsc; i++) {
+		int id;
+
+		id = dsc_id[i];
+		if (id >= DSC_0)
+			global_state->dsc_to_enc_id[id - DSC_0] = enc_id;
+	}
+
+	return 0;
+}
+
+static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
+			       struct dpu_global_state *global_state,
+			       struct drm_encoder *enc,
+			       const struct msm_display_topology *top)
+{
+	uint32_t enc_id = enc->base.id;
+
+	if (!top->num_dsc || !top->num_intf)
+		return 0;
+
+	/*
+	 * Truth:
+	 * 1) every layer mixer only connects to one pingpong
+	 * 2) no pingpong split -- which is two layer mixers shared one pingpong
+	 * 3) each DSC engine contains two dsc encoders
+	 *    -- index(0,1), index (2,3),... etc
+	 * 4) dsc pair can only happens with same DSC engine
+	 * 5) odd pingpong connect to odd dsc
+	 * 6) even pingpong connect to even dsc
+	 * 7) pair: encoder +--> pp_idx_0 --> dsc_idx_0
+			    +--> pp_idx_1 --> dsc_idx_1
+	 */
+
+	/* num_dsc should be either 1, 2 or 4 */
+	if (top->num_dsc > top->num_intf)	/* merge mode */
+		return _dpu_rm_reserve_dsc_pair(rm, global_state, enc_id, top);
+	else
+		return _dpu_rm_reserve_dsc_single(rm, global_state, enc_id, top);
+}
+
 static int _dpu_rm_make_reservation(
 		struct dpu_rm *rm,
 		struct dpu_global_state *global_state,
-- 
2.7.4

