Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FED7B6D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJCPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjJCPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:53:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C859E;
        Tue,  3 Oct 2023 08:53:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393EM5rc032204;
        Tue, 3 Oct 2023 15:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k/hSMubV2CSZSBSLDKar3QNIq194wMLgReotx7drAPA=;
 b=gJUJ7NE2RTwH24kjjoOL9M0H5zAgGZdaYZ5OVNIIb8nLb/Kr6p/LGgA3JkAjxGG5xZTw
 yMzxppy7yExprEApenFSkDLoJBuSctrWr/lCofdyi6/GY3TTPrr0bx0MzEB+CFPU4km4
 vAdqZmT6Su7McBxP5Hc9LEFv5dYwFqrUWtlpoGYIJsrfDm93bKNWGAlV66BIVwWBwnY9
 o7Dfue17VQ7FAGDxtjclIdLsSchVnzscH7syqqbvZBS6zx38OmpfY+0eqUkIt3H4RDM5
 zT3EQ7SWgGIdsUXSCEENb9TnnfYf5kQQt4//OrNq11TEOi35m32SXXZBpTBSizQXCwcB +Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjj9f2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 15:53:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393FrMdc031729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 15:53:22 GMT
Received: from [10.110.20.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 08:53:21 -0700
Message-ID: <1c58a05b-1337-0287-225f-5a73b4c6828e@quicinc.com>
Date:   Tue, 3 Oct 2023 08:53:20 -0700
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
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231003103317.pjfmf6uisahowmom@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4MX0BOBsUn_jb1OK_dO6Y06XJ-gFn0XA
X-Proofpoint-ORIG-GUID: 4MX0BOBsUn_jb1OK_dO6Y06XJ-gFn0XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=865 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030119
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/2023 3:33 AM, Sudeep Holla wrote:
> On Mon, Sep 11, 2023 at 12:43:56PM -0700, Nikunj Kela wrote:
>> Currently, the return from the smc call assumes the completion of
>> the scmi request. However this may not be true in virtual platforms
>> that are using hvc doorbell.
>>
> Hmm, it is expectation from SMCCC for the fast calls. Is you HVC FID
> not a fast call. AFAIK, only TOS use yielding calls. Are you using them
> here ? If not, this must complete when the SMC/HVC returns. We added
> support for platforms indicating the same via interrupt.
>
> I would like to avoid adding this build config. Why does it require polling ?
> Broken firmware ? I would add a compatible for that. Or if the qcom always
> wants to do this way, just make it specific to the qcom compatible.
>
> I would avoid a config flag as it needs to be always enabled for single
> image and affects other platforms as well. So please drop this change.
> If this is absolutely needed, just add additional property which DT
> maintainers may not like as it is more like a policy or just make it
> compatible specific.
>
> --
> Regards,
> Sudeep
We are using Fast call FID. We are using completion IRQ for all the scmi 
instances except one where we need to communicate with the server when 
GIC is in suspended state in HLOS. We will need to poll the channel for 
completion in that use case. I am open to suggestions.
