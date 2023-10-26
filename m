Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB377D7E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbjJZISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJZISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:18:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59680CE;
        Thu, 26 Oct 2023 01:18:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q5TEMK013439;
        Thu, 26 Oct 2023 08:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ifqRCltxvTbgUWdpLs0nzht25Xok/zc8SeaY70fDy6c=;
 b=W7ckUmtjr2xFLVILRmckgUukpPzDRJO5mpZAw7fGehliNwtJ0LTok6y490c+nFx/gsZj
 sWmcpWM0WmyQO1BQaosUrBJRr7v0+rrCGcd1v7hl6CvgZt1Z+FgRi5YtzHZShqA4vxXQ
 B4g50m2E/dyYIoIP0mmbryzH9VE+EfFTGAL/+3SeoTp+FyCLDSRMu9rPPgJDMmRnpHQn
 1xNFuxwsAs4vJI0FdA3KFR97fSDQMKarcF27RoHF3frwLdmr7r2BmdQ1PmpxVbSmHkgR
 qLX3eaqSZGRJgSl8J4HVtHge4uJlr5qiqMUOyGD+80ThYjkzNCe6WabKuZpkJwKUjrh0 mQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyfwfrn5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8I8rP001665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:08 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:18:06 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/5] Add multimode invoke request IOCTL support
Date:   Thu, 26 Oct 2023 13:47:57 +0530
Message-ID: <1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mDOyyB9U6z_WDW91J8kGPlpejr9S3cp_
X-Proofpoint-GUID: mDOyyB9U6z_WDW91J8kGPlpejr9S3cp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_06,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=524 clxscore=1015
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to support multimode invocation ioctl request. This
ioctl call facilitates multiple types of requests from user including
CRC check, performance counters, shared context bank usage, etc.
This series also carries patch to save and restore interrupted
context.

Ekansh Gupta (5):
  misc: fastrpc: Add fastrpc multimode invoke request support
  misc: fastrpc: Add CRC support for remote buffers
  misc: fastrpc: Capture kernel and DSP performance counters
  misc: fastrpc: Add support to save and restore interrupted
  misc: fastrpc: Add support to allocate shared context bank

 drivers/misc/fastrpc.c      | 491 ++++++++++++++++++++++++++++++++++++--------
 include/uapi/misc/fastrpc.h |  52 +++++
 2 files changed, 458 insertions(+), 85 deletions(-)

-- 
2.7.4

