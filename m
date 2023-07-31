Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81661768A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGaEKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGaEKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:10:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021DE9;
        Sun, 30 Jul 2023 21:10:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V1oKJ2029737;
        Mon, 31 Jul 2023 04:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=hynM0rrBEGiK6c4Xr6tP1yy2JtVdlWXVcqVf5JGtw8Y=;
 b=WIXICMzwyA2nJzhAkfuGKRYM5ZgGPt6GnK2Q5bzbhSOyxiYVQf7J9AttYQ4m4r2COOpl
 XznOfpKNnlYx+zRCwkqdMMrmloI5ai01tH70Rsg9UzhjiuWO4dsLASIhM0LrOmdcebTR
 10A2JS6j5k0Nd2zKjvC0SffIabE8p5R9CWfv/h8WKz2zrOoqBQl252Gf2BBsvvDj+zvH
 eARvy3y/qqNwGh+TSOdJ8WXZIR4XRBhPNZL/x/jBDyqGXV4SaUiN+4sRNxCGtlQp9g5J
 xTfKly2mb7sZagSFDIqd76mSf8vY/+9NeY3mnl3us5uCNFY4RegGTfa2gNMev9P734Xa ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ueujk8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:10:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V4AJnV002496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:10:19 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 30 Jul 2023 21:10:18 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH 0/4] soc: qcom: aoss: Introduce debugfs interface and cleanup things
Date:   Sun, 30 Jul 2023 21:10:09 -0700
Message-ID: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zQHpUAUYv7ItDM_IsOjNlsdx3UZ3fWpA
X-Proofpoint-ORIG-GUID: zQHpUAUYv7ItDM_IsOjNlsdx3UZ3fWpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=606
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Always On Processor supports a number useful commands for affecting
system resources during in various debug scenarious. Introduce a debugfs
interface for allowing the debugger/tester to send these commands.

While at it, let's make some improvements to the qmp_send() API.

Bjorn Andersson (3):
  soc: qcom: aoss: Move length requirements from caller
  soc: qcom: aoss: Format string in qmp_send()
  soc: qcom: aoss: Tidy up qmp_send() callers

Chris Lew (1):
  soc: qcom: aoss: Add debugfs interface for sending messages

 drivers/net/ipa/ipa_power.c        |  5 +-
 drivers/remoteproc/qcom_q6v5.c     |  8 +--
 drivers/soc/qcom/qcom_aoss.c       | 82 +++++++++++++++++++++---------
 include/linux/soc/qcom/qcom_aoss.h |  4 +-
 4 files changed, 61 insertions(+), 38 deletions(-)

-- 
2.25.1

