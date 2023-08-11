Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691E87793C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjHKQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:02:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA562712;
        Fri, 11 Aug 2023 09:02:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE8tlJ003488;
        Fri, 11 Aug 2023 16:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Vtcrm6TGoZeha/hA7zUOsnUwE/o4vL/NhmGMJB0DCrM=;
 b=AD1JNN+5CKB0cSks1RDrHXr8NdnQmaq8VyWH3SmHRtbWu3lGH17Fp4KtH9pfevazJZEa
 qdZMqZCtmljKjJVhIPDNhxQnFOGDQBtt6fy8Ya81Bf9FLuBvYTY8YO3CD4ebPxLP+M78
 cGCPbgNUwS9iBnzCAZvilTjX9CIlLGJTfdmlHrlAtl0reEPDnJGcjIs/0Mh6SPhJMcEC
 E5cML3LXjNG6uEzzNJOzmJymKzvDMNwK1n6a63l1nD6Y1V/6f/EGm1tFqeyIyDdbsF2W
 FvpGiq5j+UEGB9pitoGrm9nzIAePKGPh9k/wSvYd3OTAMO/UWzWJAtsMtKk0sELqCSd/ HQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ywt4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 16:02:47 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BG2klO021382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 16:02:46 GMT
Received: from [10.50.43.50] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 09:02:42 -0700
Message-ID: <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
Date:   Fri, 11 Aug 2023 21:32:39 +0530
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
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ybwBM6XWvryys9pOtFMvjAcK1xl7V8qy
X-Proofpoint-ORIG-GUID: ybwBM6XWvryys9pOtFMvjAcK1xl7V8qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=517 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110147
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 4:11 PM, Bryan O'Donoghue wrote:
> On 11/08/2023 09:49, Vikash Garodia wrote:
>>
>> On 8/11/2023 2:12 PM, Bryan O'Donoghue wrote:
>>> On 11/08/2023 07:04, Vikash Garodia wrote:
>>>>
>>>> On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
>>>>> On 10/08/2023 03:25, Vikash Garodia wrote:
>>>>>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>>>>>> MAX_CODEC_NUM)
>>>>>> +        return;
>>>>>> +
>>>>>
>>>>> Shouldn't this be >= ?
>>>> Not needed. Lets take a hypothetical case when core->dec_codecs has initial 16
>>>> (0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit
>>>> count
>>>> would be 32. The codec loop after this check would run on caps array index
>>>> 0-31.
>>>> I do not see a possibility for OOB access in this case.
>>>>
>>>>>
>>>>> struct hfi_plat_caps caps[MAX_CODEC_NUM];
>>>>>
>>>>> ---
>>>>> bod
>>>>>
>>>
>>> Are you not doing a general defensive coding pass in this series ie
>>>
>>> "[PATCH v2 2/4] venus: hfi: fix the check to handle session buffer requirement"
>>
>> In "PATCH v2 2/4", there is a possibility if the check does not consider "=".
>> Here in this patch, I do not see a possibility.
>>
>>>
>>> ---
>>> bod
> 
> But surely hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) ==
> MAX_CODEC_NUM is an invalid offset ?

No, it isn't. Please run through the loop with the bitmasks added upto 32 and
see if there is a possibility of OOB.

> 
> ---
> bod
