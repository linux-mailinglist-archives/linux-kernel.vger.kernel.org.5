Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556AA7860A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjHWTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbjHWTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:32:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2457E6E;
        Wed, 23 Aug 2023 12:32:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NILVIM009687;
        Wed, 23 Aug 2023 19:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=suEvO7+ABHAjuQwapVJ52LY01lBYq7RJdxxWaP+OpSw=;
 b=PvjogdxCSzSb9xmzso4fsYxIQPRb2GjfvPY0OXDlMTHSaVtT/deaouAjbn5D+GvwD+WQ
 E2NEz1UU3lrUcQZ75gbpEOT5B1wjdR1yTZEmpcyFl3g8nBW1CI1moqBSPyBheQvVAb13
 Xr8W6n6jYMttsct3m01S7RmNyzQFyPuvmk8R1t1u4SSP5KFY+GBpuitfT6OisgNeQEEJ
 DoMmbzsnj3ABid1sL4Hf0FMgYIrp440J+TGYEL1uP3+3wDivNJBfzHTdMqpvtyEEa6sx
 ieXNuy5tt5cFGfdqfVJClHNt5+BTDfKU93+6uUT6g0arJrJ+L8FjS3yx3dqpyiF9RAVO qg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2extt3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:32:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NJWBf8001196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:32:11 GMT
Received: from [10.110.124.126] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 12:32:07 -0700
Message-ID: <272adfa0-c053-f737-5714-cbeac706dc76@quicinc.com>
Date:   Wed, 23 Aug 2023 12:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
Content-Language: en-US
To:     Ninad Naik <quic_ninanaik@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
 <06cb9718-ed64-8604-0bde-fff6d56ef3dd@quicinc.com>
 <08803101-5c26-449e-a142-927ec5304be2@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <08803101-5c26-449e-a142-927ec5304be2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ek31lOTpxagQwH8-g_0u75PzkU6JSkKv
X-Proofpoint-ORIG-GUID: ek31lOTpxagQwH8-g_0u75PzkU6JSkKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=719
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230176
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2023 4:16 AM, Ninad Naik wrote:
>>>   ret = map_addr_range(&parent, "uefi-log", xbl_data);
>>
>> Here you are calling it as uefi-log. Is it xbl-log or uefi-log? Please 
>> decide first.
>>
>>
> The reason for using "uefi-log" here is because this node name is in 
> accordance to the sa8775p.dtsi as seen in [2]
> 
> [2] 
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sa8775p.dtsi#L354
> 
> So, in the next revision while adding the device tree bindings and 
> corresponding compatible string, should this node name be changed as well?

Yes, please keep it consistent.

-- 
---Trilok Soni

