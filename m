Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E614478FBB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjIAKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjIAKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:20:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A4CEB;
        Fri,  1 Sep 2023 03:20:43 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3813sOTC017516;
        Fri, 1 Sep 2023 10:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=iu/KISp09kiIoNcVq9gHvJxa/zUXV6Lpnj7rqa4qOxQ=;
 b=oEDy0PZxpuXyf3L+OT00o7XsEWMf3cJUzKFE/cv4xxbqvs/2DBfI27nzxPwOenRZp/us
 R8EFBOkau3MCGkROwcUZ0L2MsqxAMcua40Ev65Da5FsFhh+K4OE/KsgV8h3YVs28CE1X
 6AwKBAcD4/3fHCQVfJRg4lhibZqYsqxySQm//sdPrHTLBxFBFvVLnn55T33s1JbXWK9T
 UbNm7MFwGL10TmyViYBTM/SsXTS58FTrEs2fewOcCht7+iazwtSWMwCiu64QhLRcLN1p
 b0CJ4we6TPoaNTr31655gU2Nh7l6BsSfa26g/ByzaQwY9hnN7S/VAceTcaa90nYwBDux xA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3su89e8sb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 10:20:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381AKXLm026322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 10:20:33 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 03:20:30 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH net-next 0/2] net: qrtr: Few qrtr fixes
Date:   Fri, 1 Sep 2023 15:50:19 +0530
Message-ID: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FSbyiQMfNKLBp1HBmG1AAR9E_cPhGjX5
X-Proofpoint-GUID: FSbyiQMfNKLBp1HBmG1AAR9E_cPhGjX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=443 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 fixes a race condition between qrtr driver and ns opening and
sending data to a control port.

Patch #2 address the issue with legacy targets sending the SSR
notifications using DEL_PROC control message.

Sricharan Ramabadhran (1):
  net: qrtr: Add support for processing DEL_PROC type control message

Vignesh Viswanathan (1):
  net: qrtr: Prevent stale ports from sending

 include/uapi/linux/qrtr.h |  1 +
 net/qrtr/af_qrtr.c        | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

-- 
2.7.4

