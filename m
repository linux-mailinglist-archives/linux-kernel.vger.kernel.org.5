Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED977A14EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjIOEzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjIOEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:55:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE54271B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:55:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F4I63w005247;
        Fri, 15 Sep 2023 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dyCc/9M/AflBfZ+eCHDv8VnAouJWJfOcaUnGoqvP9AE=;
 b=LAmseET0+frBWx3ZmjRkOgdOs/F2bCaX3JSQiUDA5qxOe8wj5dVSkYwGUOVUMydBaTAh
 4jLfqwcv2v1z9dKVLjagWsf4foWduSY6LGUw2EC9Kf/YCQwtGyCXT2/Qk5CW/mnr1Hqt
 IUyH2tQqyA+h/dzx058c5mkH8FnNxhiSukbxzMnOsX78J2g8PWMl8shGSDJWH7RtpY8N
 QdKRTt7gLXH4iMfydxnVFkchaWwJRY2IE/kJX9bbzZhJAD6Isd49E/mde/TZejL+dIdQ
 ZKjQ0x5dOg7p/gVv8MFSMJTG1oqCaq1YDuRr9afQu+Gtg6ioMkEcaI8wdrHkqq/qrxmm GQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3n82ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 04:55:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F4t8lc032521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 04:55:08 GMT
Received: from hu-rsr-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 21:55:04 -0700
From:   Ramya SR <quic_rsr@quicinc.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Lyude Paul" <lyude@redhat.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jeff Layton <jlayton@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Ramya SR <quic_rsr@quicinc.com>
Subject: [PATCH v1] drm/dp/mst: fix missing modeset unlock for MST port detect
Date:   Fri, 15 Sep 2023 10:24:49 +0530
Message-ID: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ewsIXJlLnhdgJujr-Mv-x7OR1t87masr
X-Proofpoint-ORIG-GUID: ewsIXJlLnhdgJujr-Mv-x7OR1t87masr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_04,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modeset mutex unlock is missing in drm_dp_mst_detect_port function.
This will lead to deadlock if calling the function multiple times in
an atomic operation, for example, getting imultiple MST ports status
for a DP MST bonding scenario.

Signed-off-by: Ramya SR <quic_rsr@quicinc.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ed96cfc..d6512c4 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4154,7 +4154,7 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 
 	ret = drm_modeset_lock(&mgr->base.lock, ctx);
 	if (ret)
-		goto out;
+		goto fail;
 
 	ret = connector_status_disconnected;
 
@@ -4181,6 +4181,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 		break;
 	}
 out:
+	drm_modeset_unlock(&mgr->base.lock);
+fail:
 	drm_dp_mst_topology_put_port(port);
 	return ret;
 }
-- 
2.7.4

