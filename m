Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264D764E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjG0I4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjG0Izp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:55:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB56EAB;
        Thu, 27 Jul 2023 01:36:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R815AH017015;
        Thu, 27 Jul 2023 08:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=jzs5shYSZEN3HBx98PZkGJRGQooHn1deSpD5bbutirM=;
 b=NLtOTyQaZzR0Xc/GLpiPbZ1OIeSVHszrNAonEyjuxANWihwxBPatJVwnklho/BuDZyz6
 qW64LRjCfyBP/iYdPODtvwmuoqziJygn5SdViJ/+NxK+RvWYoOzIBbxoB9MVnuDzmmid
 u9PvDyyica8MLkQcHCmvDnGyNeAw/Eaz/79YSZvlVYSO4mG9MWBMqtmyWkWDJPH6OaTS
 ba1jW6aNk1eyiak6TTkEZp9fnNPJDJcEYESxqkVGnabl9o8jJYF4218R9NZzKinUZras
 OkGAIEja1uSWHE0SjvHusGvM2rSqFJf6GD+iBCcpwobvOTqRge7kc2u+7pPi1RB1fssn ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3mpt03a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:36:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R8a8PR021443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:36:09 GMT
Received: from tjiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 01:36:05 -0700
From:   Tim Jiang <quic_tjiang@quicinc.com>
To:     <johan@kernel.org>
CC:     <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <johan.hedberg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_tjiang@quicinc.com>, <quic_bgodavar@quicinc.com>,
        <quic_hemantg@quicinc.com>
Subject: [PATCH v14 0/2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
Date:   Thu, 27 Jul 2023 16:35:53 +0800
Message-ID: <20230727083555.1023992-1-quic_tjiang@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2vdeeyeQZhtH8ctKjW23tOctWw7f6X7S
X-Proofpoint-GUID: 2vdeeyeQZhtH8ctKjW23tOctWw7f6X7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=763
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for qualcomm bluetooth soc qca2066

Changes in v14
 - remove stray newline

Changes in v13
 - change the subject name for patch 1/2, and move the qca066 type code to patch 2/2.
 - correct log style and sort qca2066 btsoc type for patch 2/2

Changes in v12
 - fix compile error issue for patch 1/2

Changes in v11
 - reverse two patches order

Changes in v10
 - break out btsoc type print into seperate patch

Changes in v2-v9
 - solve review comments for code style and commit message context


Tim Jiang (2):
  Bluetooth: hci_qca: adjust qca btsoc type print expression
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066

 drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h   |  4 +-
 drivers/bluetooth/hci_qca.c | 41 ++++++++++++++++++--
 3 files changed, 114 insertions(+), 7 deletions(-)

-- 
2.41.0

