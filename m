Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD17AF880
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjI0DPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjI0DNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:13:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EA45B8A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:31:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R1nCpD018214;
        Wed, 27 Sep 2023 02:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=peb/wEh4aLvTcBbPCkjvhg3tNqsxYvxJGo6l400qDEs=;
 b=eb/TiHIUXE3ZM3Ea1Bz5unvy5gUBqrxnMcXrHXmsS/KbomjHvPh3apdvOcwcYOLwH7YG
 pJ/Sc0l12dg42l1L2MvglTcYbiJOzbOvhDXX94jUkpvfDhvFCsFMNngWde5U9BtQgeNs
 Xzg7iwxG6dX3XL30plLM5haCvRPqXd3uLHNJrECNC9i5LfS6Zq34fxQbp5UA7ytacBrY
 PbJ/gqSRmfFihX+A8MtKLt6x8QKVXXO1DCdDXGfX2Kf6//5N9lAzGbeuhMpWsQ4L+S2k
 D6z0xYF6mOW8ESEBXsi2qadC0hwOiXKpBlyJ0qnFF8rwlV/RRm+ore2PVM0i2y9FPGIP kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc8v4884t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 02:31:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R2UXSM012160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 02:30:33 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 19:30:31 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <saravanak@google.com>
Subject: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in device_links_purge()
Date:   Wed, 27 Sep 2023 10:30:10 +0800
Message-ID: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IIKWMKOihG95-9g4tskyKgdRiQ2CsE9n
X-Proofpoint-ORIG-GUID: IIKWMKOihG95-9g4tskyKgdRiQ2CsE9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_19,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
only adds it once after fwnode links creation in fw_devlink_parse_fwnode().
After that even device links being purged, the flag will not be cleared.

Fwnode links are converted to device links and will not be added back
forever in normal case. Essentially if a device is registered and
unregisted (also deleted) before it is probed (due to missing fwlink
dependencies, abort in device_links_check_suppliers), the fwlink is not
setup next when device is newly created again. This means the probe gets
called without meeting all dependencies.

It usuallly happens in the case of a glue driver. Of_platform_populate()
allows us to populate subnodes. We may do it in ancestor node probing
function, then check subnode's probing status because there may be chances
that suppliers of subnode are not ready. We may further need to do
of_platform_depopulate(which purges device links) and in some time
of_platform_populate() again. Such case we miss fwnode links(so that device
links) during second time of populating subnodes.

Fix it by Clearing FWNODE_FLAG_LINKS_ADDED flag in purging device link
func, indicates both fwnode links and device links are absent.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b7d7f41..2a1975d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1630,6 +1630,10 @@ static void device_links_purge(struct device *dev)
 		__device_link_del(&link->kref);
 	}
 
+	/* Clear flags in fwnode. Give a chance to create fwnode link again */
+	if (dev->fwnode)
+		dev->fwnode->flags &= ~FWNODE_FLAG_LINKS_ADDED;
+
 	device_links_write_unlock();
 }
 
-- 
2.7.4

