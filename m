Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855379A4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjIKHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjIKHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:46:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9135118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:45:24 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5tGxA015622;
        Mon, 11 Sep 2023 07:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Kq0nzV3tF4NGc85Z6LT87KJ8rNggnuoA+X0wB3VS7UM=;
 b=XmEqaG0WrExS9dp33rWk9D8M4MthGj0zB2FlZAuJDvUnUXfBo2EjA2metJ08skqo4uHb
 3NUJv1BnUICgdO44BEOqUwqmD+sZWsxS3gP18iO9AMLtJVM2UO7ky8MX5BcL0ywzFrSu
 XoSTc5RSwr6qwRi54ZoG0WpLgc9K+xZCzUStG74rjB1LyNsoLkUdNIBlJxCsQk5+g7Mj
 yTyNPrZ5eoldAZtLBunxbex6oApGLvv6WodGl4UQqU5KLxm++cb5myoNseLkLuoqddis
 nUB8ijZ1dGeNjJDMMdB7wXJAEe9sXhKjFjnMo4V/idcNDYXr9EmoX2JbS6KNPY1+7/gF fA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0edmk8nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 07:44:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B7i5Ze018672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 07:44:05 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 00:44:03 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_tingweiz@quicinc.com>
Subject: [PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in device_links_purge()
Date:   Mon, 11 Sep 2023 15:43:48 +0800
Message-ID: <1694418228-23586-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FI5UaTgfvf0yVUWN4nHA5fWeWLIx26DG
X-Proofpoint-GUID: FI5UaTgfvf0yVUWN4nHA5fWeWLIx26DG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110069
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

Fix it by Clearing FWNODE_FLAG_LINKS_ADDED flag in purging device link func,
indicating both fwnode links and device links are absent.

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

