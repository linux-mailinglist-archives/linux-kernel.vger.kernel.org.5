Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB27BA32C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjJEPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjJEPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C84487B;
        Thu,  5 Oct 2023 07:00:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3952W2dc025110;
        Thu, 5 Oct 2023 03:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YgSAKNHFq5jbRY7R83OXV1B6phsZNcYMcc/4gfNrvdU=;
 b=mXYwaAZaxZsE9NkY4BHLDAjNGPLxqsn6YKP3MY6wiKatSxr+4OpVXujYVgP5IS3enC8J
 /CXamoAIJOe73vHRUtyGUJv7icw3CnJ5UTHiMfYemwuvaMJBPjRtvjPpaHxfzYpBXGS/
 JXcXwkn8BPd6KtfiEOhio5nwD5d6cviHD0J29lOQbF8Ob32uyn4KER0n1MIO26gkdzvC
 /nzHtVzmmYbvBiIYgKI1zsR8E+n/KIyIED8mai89rUfumtJhBiVURcrQBb8URoGyFSa7
 hKjF/+cL3cZBSkxS1KS8jymXt9UvN1RYnHXcS+n8+KTM/nnzn0w33oLY1bQndGgPfKXH DA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th2d6tjab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 03:25:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3953PLJI009554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 03:25:21 GMT
Received: from [10.110.20.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 4 Oct
 2023 20:25:20 -0700
Message-ID: <5abc0596-aeb7-dabb-8b26-c4864bb8329c@quicinc.com>
Date:   Wed, 4 Oct 2023 20:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/4] firmware: arm_scmi: Add polling support for
 completion in smc
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-2-quic_nkela@quicinc.com>
 <20231003103317.pjfmf6uisahowmom@bogus>
 <1c58a05b-1337-0287-225f-5a73b4c6828e@quicinc.com>
 <20231004161140.uzqb4eapyo6gd7xm@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231004161140.uzqb4eapyo6gd7xm@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XXbWZCtpES_bU1hP8UMvXALQDHBI103k
X-Proofpoint-GUID: XXbWZCtpES_bU1hP8UMvXALQDHBI103k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=861 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050027
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2023 9:11 AM, Sudeep Holla wrote:
> On Tue, Oct 03, 2023 at 08:53:20AM -0700, Nikunj Kela wrote:
>> On 10/3/2023 3:33 AM, Sudeep Holla wrote:
>>> On Mon, Sep 11, 2023 at 12:43:56PM -0700, Nikunj Kela wrote:
>>>> Currently, the return from the smc call assumes the completion of
>>>> the scmi request. However this may not be true in virtual platforms
>>>> that are using hvc doorbell.
>>>>
>>> Hmm, it is expectation from SMCCC for the fast calls. Is you HVC FID
>>> not a fast call. AFAIK, only TOS use yielding calls. Are you using them
>>> here ? If not, this must complete when the SMC/HVC returns. We added
>>> support for platforms indicating the same via interrupt.
>>>
>>> I would like to avoid adding this build config. Why does it require polling ?
>>> Broken firmware ? I would add a compatible for that. Or if the qcom always
>>> wants to do this way, just make it specific to the qcom compatible.
>>>
>>> I would avoid a config flag as it needs to be always enabled for single
>>> image and affects other platforms as well. So please drop this change.
>>> If this is absolutely needed, just add additional property which DT
>>> maintainers may not like as it is more like a policy or just make it
>>> compatible specific.
>>>
>>> --
>>> Regards,
>>> Sudeep
>> We are using Fast call FID. We are using completion IRQ for all the scmi
>> instances except one where we need to communicate with the server when GIC
>> is in suspended state in HLOS. We will need to poll the channel for
>> completion in that use case. I am open to suggestions.
> IIUC, for the sake of that one corner case, you have added the polling
> Kconfig and will be enabled for all the case and even on other platforms
> in a single Image. I think we could be something better, no ?
>
> Please share details on that one corner case.
> Is it in the scmi drivers already ? If so, specifics please.
> If no, again provide details on how you plan to use. We do have ways
> to make a polling call, but haven't mixed it with interrupt based calls
> for a reason, but we can revisit if it makes sense.
>
> --
> Regards,
> Sudeep

Ok. I will discard this patch for now from this series and will explore 
alternative ways instead of polling that might work in our usecase. If 
required, will provide you with more details in a separate patch. Thanks!

