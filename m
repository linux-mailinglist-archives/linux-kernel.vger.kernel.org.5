Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55A7793FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHKQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjHKQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:11:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF410DE;
        Fri, 11 Aug 2023 09:11:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE8lKK008274;
        Fri, 11 Aug 2023 16:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T+wIitqVu6ytDiF8h1G0zm1EvusIJ4jblCwk9yLSF3g=;
 b=CeVmymOAElAJ2enLFi70QP14H0Xc10YPlmKWETKNKBiehGYE+NZ52suJog7XtZ8YPdMM
 o0Y0SWtplUJBk+VxR6D+U9AMjacNGJiRo4geCqlYW+dqEqrBeh8AwkDRp7sUvMt763sH
 H5lnmKeMytNqZACZzYhR6HzYFeJRgs397Au+ZbyCexrnBeTx0GV7jYnY8hKohHaTu1vm
 WWk8M9b1dLQANGAutmVQLzV5Bw40T64V9x9HYHW2FLNYtNz5XTmBlm8t4Uhxtmeg5Et6
 sI5ad6PafX7bVTXkL/NhLq5rbY9hJjoPxQQIQSZCRhOc/fVJxc38+Nd/iLOnODNPl/je mw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd904t73d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 16:11:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BGB0ZQ032520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 16:11:00 GMT
Received: from [10.50.43.50] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 09:10:56 -0700
Message-ID: <ffdc4c02-724a-2e8a-feff-6dd07b14b0f2@quicinc.com>
Date:   Fri, 11 Aug 2023 21:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] venus: hfi: add checks to handle capabilities from
 firmware
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-4-git-send-email-quic_vgarodia@quicinc.com>
 <59b61d65-a827-d252-cdc2-a256f99cb4d9@linaro.org>
 <a1713beb-e1bc-4118-ab58-b5d8e7fb3cbf@quicinc.com>
 <e763934d-dd4b-9cee-9992-eb24dce0435f@linaro.org>
 <f1bbcd06-f888-b466-1b7e-7034ab4004e7@quicinc.com>
 <2fe4e8f0-5aa5-a89b-2f42-e179b218e7cc@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <2fe4e8f0-5aa5-a89b-2f42-e179b218e7cc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2IEo5dJ_KmDnW5q8xR9J4_0GKBKkcPwo
X-Proofpoint-ORIG-GUID: 2IEo5dJ_KmDnW5q8xR9J4_0GKBKkcPwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=421 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110148
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 4:09 PM, Bryan O'Donoghue wrote:
> On 11/08/2023 09:51, Vikash Garodia wrote:
>>
>> On 8/11/2023 2:11 PM, Bryan O'Donoghue wrote:
>>> On 11/08/2023 06:54, Vikash Garodia wrote:
>>>> The case is all about rogue firmware. If there is a need to fill the same cap
>>>> again, that itself indicates that the payload from firmware is not correct. In
>>>> such cases, the old as well as new cap data are not reliable. Though the
>>>> authenticity of the data cannot be ensured, the check would avoid any OOB
>>>> during
>>>> such rogue firmware case.
>>>
>>> Then why favour the old cap report over the new ?
>>
>> When the driver hits the case for OOB, thats when it knows that something has
>> gone wrong. Keeping old or new, both are invalid values in such case, nothing to
>> favor any value.
>>
>> Regards,
>> Vikash
> 
> Is this hypothetical or a real bug you are actually working to mitigate ?

These are theoretical bugs, not reported during any video usecase so far. At the
same time, these are quite possible when the packets from firmware goes
different than expected.

> ---
> bod
