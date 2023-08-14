Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09877B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjHNGeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjHNGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:34:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB53E58;
        Sun, 13 Aug 2023 23:34:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5xMeO030172;
        Mon, 14 Aug 2023 06:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8sFcUBqscEAtTfXD1uBYjjPigAsx8tDFUS0y/Zs0+28=;
 b=hdq0CFrz7vAl9Q29cMnhUr+9CJ9qyUrHzPH/rItODeLcYQjgpwu4ZtVS9gQWHRsPjSJN
 b7VeeNnA45Op39SMsWiuxdB/y62oeM8z7gu8VjSFA11cq4Wpl1y958Rje/Cywdot/F5a
 bLiQSlubfxD15uBgncH4GXL3DDZZdH29nc7wcN/iEVTi58Try8JsN3nuMzpUZGwU5FV5
 ++kggc9QdkQmho7EB/oiNP/QqijVN27SpgVS5FhwHmd8FLjPOa8ET2Y8msEx/16+H20c
 ZEHFSYRKSs+I43cgIw8oge4m4/zRkRMgFZZVPydbuE/TnJw/J3XS2Gq4OfYK47m08eXc vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se40rk0n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 06:34:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37E6YOpG022690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 06:34:24 GMT
Received: from [10.50.5.32] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 13 Aug
 2023 23:34:20 -0700
Message-ID: <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
Date:   Mon, 14 Aug 2023 12:04:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
 <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qs27kyNOHaoN28RHM1rXlZMa5A3_sFwE
X-Proofpoint-GUID: Qs27kyNOHaoN28RHM1rXlZMa5A3_sFwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=579 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140059
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/2023 12:21 AM, Bryan O'Donoghue wrote:
> On 11/08/2023 17:02, Vikash Garodia wrote:
>>
>>
>> On 8/11/2023 4:11 PM, Bryan O'Donoghue wrote:
>>> On 11/08/2023 09:49, Vikash Garodia wrote:
>>>>
>>>> On 8/11/2023 2:12 PM, Bryan O'Donoghue wrote:
>>>>> On 11/08/2023 07:04, Vikash Garodia wrote:
>>>>>>
>>>>>> On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
>>>>>>> On 10/08/2023 03:25, Vikash Garodia wrote:
>>>>>>>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>>>>>>>> MAX_CODEC_NUM)
>>>>>>>> +        return;
>>>>>>>> +
>>>>>>>
>>>>>>> Shouldn't this be >= ?
>>>>>> Not needed. Lets take a hypothetical case when core->dec_codecs has
>>>>>> initial 16
>>>>>> (0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit
>>>>>> count
>>>>>> would be 32. The codec loop after this check would run on caps array index
>>>>>> 0-31.
>>>>>> I do not see a possibility for OOB access in this case.
>>>>>>
>>>>>>>
>>>>>>> struct hfi_plat_caps caps[MAX_CODEC_NUM];
>>>>>>>
>>>>>>> ---
>>>>>>> bod
>>>>>>>
>>>>>
>>>>> Are you not doing a general defensive coding pass in this series ie
>>>>>
>>>>> "[PATCH v2 2/4] venus: hfi: fix the check to handle session buffer
>>>>> requirement"
>>>>
>>>> In "PATCH v2 2/4", there is a possibility if the check does not consider "=".
>>>> Here in this patch, I do not see a possibility.
>>>>
>>>>>
>>>>> ---
>>>>> bod
>>>
>>> But surely hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) ==
>>> MAX_CODEC_NUM is an invalid offset ?
>>
>> No, it isn't. Please run through the loop with the bitmasks added upto 32 and
>> see if there is a possibility of OOB.
> 
> IDK Vikash, the logic here seems suspect.
> 
> We have two loops that check for up to 32 indexes per loop. Why not have a
> capabilities index that can accommodate all 64 bits ?
Max codecs supported can be 32, which is also a very high number. At max the
hardware supports 5-6 codecs, including both decoder and encoder. 64 indices is
would not be needed.

> Why is it valid to have 16 encoder bits and 16 decoder bits but invalid to have
> 16 encoder bits with 17 decoder bits ? While at the same time valid to have 0
> encoder bits but 17 decoder bits ?
The addition of the encoder and decoder should be 32. Any combination which adds
to it, would go through. For ex, (17 dec + 15 enc) OR (32 dec + 0 enc) OR (0 dec
+ 32 enc) etc are valid combination theoretically, though there are only few
decoders and encoders actually supported by hardware.

Regards,
Vikash
