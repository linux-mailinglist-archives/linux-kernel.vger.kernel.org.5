Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F570778727
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjHKFyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjHKFyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:54:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966922706;
        Thu, 10 Aug 2023 22:54:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5QkYA024546;
        Fri, 11 Aug 2023 05:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3WZXfN9/A9/SBkzmTHkyphuYtsR3zuWEo0ss6EEPu/Y=;
 b=fEyyMMmIxfz1eff4puMV4HqVsP8Xii2tr5q01sZdd9vEvOdWkAJEKSeuMiDxBF94tjdp
 5BnnsmVmGoZ580CAFFKDuRPqXOEZOPwb/CRUCAOHwGpr7UgBa/8Sc/rI81PvE7HIhDLc
 47wQq9WjsyrPx/1rqSmWn2fgZyD4M7xavhJN6eMAnuLwpwQe9/9g9V2zGZMkT3CE7miW
 hVVRpDFbu9X9hA9bejCu/dOZNqlKdP9Hqy8kruHZgse+4lxzGPCPkKIP5tx9Svntj5rI
 VSQK4l5hWf+2UlwiL0+Us0lk7HZlSeiPlXeC7WO8SYD0QuNpaaxfuQEjJiiowNoEgUOx uA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ya8kmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:54:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B5sU9C006803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:54:30 GMT
Received: from [10.50.43.50] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 22:54:26 -0700
Message-ID: <a1713beb-e1bc-4118-ab58-b5d8e7fb3cbf@quicinc.com>
Date:   Fri, 11 Aug 2023 11:24:23 +0530
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
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <59b61d65-a827-d252-cdc2-a256f99cb4d9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c9MrMjPmRuPmPtj2jOB88uY6X7wa5FXo
X-Proofpoint-ORIG-GUID: c9MrMjPmRuPmPtj2jOB88uY6X7wa5FXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110054
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2023 5:01 PM, Bryan O'Donoghue wrote:
> On 10/08/2023 03:25, Vikash Garodia wrote:
>> The hfi parser, parses the capabilities received from venus firmware and
>> copies them to core capabilities. Consider below api, for example,
>> fill_caps - In this api, caps in core structure gets updated with the
>> number of capabilities received in firmware data payload. If the same api
>> is called multiple times, there is a possibility of copying beyond the max
>> allocated size in core caps.
>> Similar possibilities in fill_raw_fmts and fill_profile_level functions.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c
>> b/drivers/media/platform/qcom/venus/hfi_parser.c
>> index 6cf74b2..9d6ba22 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
>> @@ -86,6 +86,9 @@ static void fill_profile_level(struct hfi_plat_caps *cap,
>> const void *data,
>>   {
>>       const struct hfi_profile_level *pl = data;
>>   +    if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
>> +        return;
>> +
>>       memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
>>       cap->num_pl += num;
>>   }
> 
> Why append and discard though ?
> 
> Couldn't we reset/reinitalise the relevant indexes in hfi_sys_init_done() ?
> 
> Can subsequent notifications from the firmware give a new capability set ?
> Presumably not.
> 
> IMO though instead of throwing away the new data, we should throw away the old
> data, no ?
The case is all about rogue firmware. If there is a need to fill the same cap
again, that itself indicates that the payload from firmware is not correct. In
such cases, the old as well as new cap data are not reliable. Though the
authenticity of the data cannot be ensured, the check would avoid any OOB during
such rogue firmware case.

Regards,
Vikash

> 
> ---
> bod
