Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6C76D0C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjHBPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjHBPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:00:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C92103;
        Wed,  2 Aug 2023 08:00:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372DnRW6025456;
        Wed, 2 Aug 2023 14:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=nqKKN7meQbdRNJo9KlOngNjsLMfb0nu5TkjgpFuhl4o=;
 b=MzbueZdP+ltGTq63fOi0dvI5wWkJvJEqIYHICaoVv88EoqfSINXKW2COYNou7Sh/3Oiw
 c3luWqCI2P3Kt/oIRnlMxZjsveu4NY6D0AfPO9DZ4yF8SnrEaKbm2Puv+dOWncPy/9sv
 IVQtPqLjbvGeV3GOV869qdV9IiBCIRrnqvRdeN/Z6I3qIn5TQq9T98Gg17VaVLK6p6Fc
 Bse2pz9y7AcPnporLAzpmxjH1pQurljRGsjA4V5FkVdMkd+U5KIItr+p+PC5Vd52gQ1v
 Z/b0aSVcD9xmbdDcc+s3MyVv7Kf0pGfFjTj/KAkEUilS9MOTVsFBazUPfuo4+MQmRul+ QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s760c2n8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:59:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372ExuPZ018039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:59:56 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:59:55 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <ogabbay@kernel.org>, <jacek.lawrynowicz@linux.intel.com>,
        <stanislaw.gruszka@linux.intel.com>, <quic_carlv@quicinc.com>,
        <quic_ajitpals@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Markus.Elfring@web.de>,
        "Pranjal Ramajor Asha Kanojiya" <quic_pkanojiy@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2] accel/qaic: Fix slicing memory leak
Date:   Wed, 2 Aug 2023 08:59:37 -0600
Message-ID: <20230802145937.14827-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vGiXcTrgX75lrD_nxlkN8ZH58tXCyAzw
X-Proofpoint-ORIG-GUID: vGiXcTrgX75lrD_nxlkN8ZH58tXCyAzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_10,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

The temporary buffer storing slicing configuration data from user is only
freed on error.  This is a memory leak.  Free the buffer unconditionally.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---

v2: reword commit text

 drivers/accel/qaic/qaic_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index e9a1cb779b30..6b6d981a71be 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1021,6 +1021,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 	bo->dbc = dbc;
 	srcu_read_unlock(&dbc->ch_lock, rcu_id);
 	drm_gem_object_put(obj);
+	kfree(slice_ent);
 	srcu_read_unlock(&qdev->dev_lock, qdev_rcu_id);
 	srcu_read_unlock(&usr->qddev_lock, usr_rcu_id);
 
-- 
2.40.1

