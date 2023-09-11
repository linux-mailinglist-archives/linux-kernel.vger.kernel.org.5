Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E579B429
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjIKV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjIKJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:04:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285BCCC;
        Mon, 11 Sep 2023 02:04:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B7XMh6005610;
        Mon, 11 Sep 2023 09:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cWaDRN7ZWbf9bSgQ+TGVZpgFp59ybLzgWZRvwNOhHwM=;
 b=dHUY7rsTft988QuB2bb/z7gEprXGgOM4dN8MmnRIrSTENaD6lDGpFIhdhQ9VXX5Syu6C
 SIUwEZQ950rxUVNPrfgO3ZguZBxE9RB1/ifYb4uCOoKV5aRZYThrLpXIASsPGQDzy4Jq
 LfpCTpj7SWjo4UlrXlKuy1UHyzzVXL5fNzv1iugwdZXeAkuSodZhYwEOnVgTQNQIZf1U
 fwEhP7bwoGE485PphGW2GHvjllMebEgkN05pDtzT62CIn3L3XDiMXSp2wFF3dy+DZNKG
 UFt1/oU5nPBvg/BeVP1uJ5c37TRIWet75ij8iKUjlVPwNWZAtbvjO4hbpex9zR65SKzE 1w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xjmr56a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 09:04:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B94NZB004134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 09:04:23 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 02:04:20 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>,
        "# 5 . 16" <stable@vger.kernel.org>
Subject: usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails
Date:   Mon, 11 Sep 2023 14:34:15 +0530
Message-ID: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BBC4WeTFvO5MZ6S0ePRr4g_SRmYjLD0F
X-Proofpoint-GUID: BBC4WeTFvO5MZ6S0ePRr4g_SRmYjLD0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if ucsi_send_command() fails, then we bail out without
clearing EVENT_PENDING flag. So when the next connector change
event comes, ucsi_connector_change() won't queue the con->work,
because of which none of the new events will be processed.

Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
fails.

Cc: <stable@vger.kernel.org> # 5.16
Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index c6dfe3d..509c67c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
+		clear_bit(EVENT_PENDING, &con->ucsi->flags);
 		goto out_unlock;
 	}
 
-- 
2.7.4

