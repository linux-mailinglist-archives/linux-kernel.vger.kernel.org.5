Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D4798476
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjIHIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:54:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59B1BEA;
        Fri,  8 Sep 2023 01:54:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3888pS56030341;
        Fri, 8 Sep 2023 08:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=q9s9v96wDMX4jHjojn/Hh1/cvT2BZYbPHDTPhvzg6uo=;
 b=CUwmhUl8lPlUiWVGaTtKl5QJzR5pn60dCk/uUv6Du9uWTjuV02M+f3mrhuU0oCJA9Yi7
 KtK8dRnTmvaY0b8wSutlSs4Br08J7wqBVMr4hJEKNAUOvivjKelSdRaQUeRkyGWKRaKA
 O6TZ6de2xaWzQRU+1IVsO8C12sszPwy0J+5hDIWA+WAVF3AbVFa73q9tnYnghCxjYWKR
 3o3aguJSVN8xX7G9dh91F0MUjnk0tNm7q2ruFucKlFLQeg19SyqpO9uZO9OUQhnyGd4n
 4k1IqNcJ/MRCieTHd1msoDrNV43n/56k8Mm3AAmZmi8U5UCPHUUFj1OWVdPQzhF3SnNv Rw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy7m0k7p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:53:41 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3888rcTh028772;
        Fri, 8 Sep 2023 08:53:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kugv5-1;
        Fri, 08 Sep 2023 08:53:38 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3888rcLv028767;
        Fri, 8 Sep 2023 08:53:38 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3888rcQm028765;
        Fri, 08 Sep 2023 08:53:38 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id DCD2E4DE7; Fri,  8 Sep 2023 16:53:36 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_ziqichen@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: qcom: dt-bindings: Add MCQ ESI property
Date:   Fri,  8 Sep 2023 16:53:23 +0800
Message-Id: <1694163203-39123-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 94ua46SlIBwaMT2Kv43d9JZx19qco7F2
X-Proofpoint-ORIG-GUID: 94ua46SlIBwaMT2Kv43d9JZx19qco7F2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080081
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the description for the qcom,esi-affinity-mask.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index bdfa86a..323595f 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -97,6 +97,10 @@ properties:
     description:
       GPIO connected to the RESET pin of the UFS memory device.
 
+  qcom,esi-affinity-mask:
+    description:
+       UFS MCQ ESI affinity mask. Affine ESI on registration according to this CPU mask.
+
 required:
   - compatible
   - reg
-- 
2.7.4

