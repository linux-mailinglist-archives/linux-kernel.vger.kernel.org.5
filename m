Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755075B1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjGTPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGTPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:02:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25D26B0;
        Thu, 20 Jul 2023 08:02:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDvC0c015644;
        Thu, 20 Jul 2023 15:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=FYnhndaHLlAGmLEwmFnlF+PlGmmJDrC7zOccjmvv0Ig=;
 b=bNJZCV8km0MA3TGnvB7XAF0q4+WBwSqzYX+OxOHh1hHroP/y70LKurGGuB6/s9N7b/pr
 NeSGxgMxOqD9WCxFKisALmobilS8zbscpjlYLyjGEs0+ClXL5qUuuvGb5gLHs89xIlpC
 pP1c2651viN0x9iYYfBR7HVz21KdvVbNKxcoiYqZbeigvJzoznw+eWPlz+YplEOxNsXt
 t1N8DwVphtkBAy7I1DF/YXjfahhbRE6wwaAUiHPirwDHb6pUbIdlgh6OQHLZRCBVu01y
 5P0UD1j3bIz/v7VoJBo9BV4BYuel5cZz1WkfUfgn2HUFo7GB/K0KX5uFQw2IIHKk4w6+ hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4he6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 15:02:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KF2UZK013352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 15:02:30 GMT
Received: from [10.216.27.20] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 08:02:28 -0700
Message-ID: <0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com>
Date:   Thu, 20 Jul 2023 20:32:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Feedback on Qualcomm's minidump (debug) solution for end user device
 crash
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AxElWK3GY2mplQQdNjQr_H9fI-OmIpbb
X-Proofpoint-ORIG-GUID: AxElWK3GY2mplQQdNjQr_H9fI-OmIpbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=553 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samsung/MTK/Any other SOC vendors,

This is to bring to your notice that, we (Qualcomm) are working on 
upstreaming our minidump solution which is to address the problem of
debugging on field device crashes where collecting entire ddr dump
would not be feasible and collecting minimal data from the ddr would
help in debug direction or even help in root causing issue.

We have recently posted v4 version here [1]

Based on comments[2], community is more worried about, if each SOC
vendor come up with their own dumping method today or in future and
whether it can have a common solution to a similar problem faced by
other SOC vendor.

We wanted to take your feedback if you also encounter a similar problem
or maintain something similar solution in downstream which can be 
upstreamed. This will help us in a way to have a common solution in
upstream.

[1]
https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/

[2]
https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com/

-Mukesh





