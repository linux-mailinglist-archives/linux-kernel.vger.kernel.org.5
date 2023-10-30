Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D467B7DB8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjJ3LWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3LV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:21:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A399C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:21:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U7LFEh027661;
        Mon, 30 Oct 2023 11:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : cc : to : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=hb8soEo5MiJ+Tr3DsBjVPHs7Ei9GkcNGjjskAx5lFno=;
 b=B0324/zqitOkt4AkS4KjI5crV4nLfKK2rAkLVj5hD1XEiiNe/+JsAAUV86v3eGSFWiy4
 t+HYcO8xfti/j0pTyumoQZHf5fB6D3NomhJ0Sod4GF0kUhdrXR5OadYLPvsDuoBI84j6
 1SyOv9AgGXZHTwTh5N1VN7S3d7EoDvbJYGXdD3PQj1Wnc/GHkF+zhnxHXmLkpUSohzQU
 c2tjggZdT7Ee9vBof/sTXmE0zLnJvUD+36lt/7r0mxHcvMrCQ8TagPor4Ba7nGwNgQpy
 UF+yi4e8/nHudfsxZZi98QbwYMJWts+WwcB3mVop7i3Bi/6hV/ncwI4LwBeArtRQLV4m dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jrfvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 11:21:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UBLrLB012100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 11:21:53 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 04:21:51 -0700
Message-ID: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
Date:   Mon, 30 Oct 2023 19:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Tingwei Zhang <quic_tingweiz@quicinc.com>
CC:     <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: How to pass software configuration to driver built as module in boot
 up phase
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ywil4ioxQgWmXBdK-9FCQzw4QPgjlzil
X-Proofpoint-ORIG-GUID: Ywil4ioxQgWmXBdK-9FCQzw4QPgjlzil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=569
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami, Greg and Rafael,

I have one driver that needs a bunch to software configuration like 1000 
settings. These settings can be different according to the use case.

They are required in boot up phase so we can't reply on user space to 
make the configuration.

Boot config is not preferred since we'd like to build that driver as 
dynamic load Kernel module.

Could you let me know if there's any mechanism in Kernel to do that?

-- 
Thanks,
Tingwei
