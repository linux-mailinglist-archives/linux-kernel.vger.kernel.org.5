Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2952D78BD84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjH2E0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjH2EZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:25:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7B10C;
        Mon, 28 Aug 2023 21:25:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T4Lkib004991;
        Tue, 29 Aug 2023 04:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pMRL5fBuoDXNC/4J1+DZhAQbuuCS+74GbSNivNoRr+A=;
 b=U/hGGk6ulCju4O9V9vSbaZqXkhO1pRRXNrKXNMshUKAnLPCINLdSS19YJZNkjiPDMpTj
 iGOlanhhafdcuRfKhUY67QO6ONZDZkZ+UMR/YukVGdtWyxYUWP/5EAfwQw4ciUMX++E0
 1LV+lCN+AjSM0UqT5pzCLmcs/YI7Yuq9l5StMQ6e1rsM5GlCwHgQ6xOX6o7YGb/pTwVz
 xW+DKQ1BZ2T+6PYcV4uc2oimoPwkZxszrbvykZC26x9+jNRwJQa8IQBKQoCsldAI/HT6
 JisGU1SuSRoXY1tyJqb3p1J6a0j3191Sho5ajo3+TgCtyJpRfTCjul1KOMGCzlPc/JKZ DA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybq95gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 04:25:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T4Pjfq029303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 04:25:45 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 21:25:42 -0700
Message-ID: <65c6e900-04eb-d256-6a45-21272eec5c4a@quicinc.com>
Date:   Tue, 29 Aug 2023 09:55:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marc Zyngier <maz@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
 <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
 <CAA8EJppmn5hM5=zdkQoaGAYghw822vP8YoW0wQsNmAZY0v7dtA@mail.gmail.com>
 <865y4zfppf.wl-maz@kernel.org>
 <CAA8EJppkJ1s=yjruBm0mntGQ4NBGut2jMLFRtZr6KquA5zn+=Q@mail.gmail.com>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <CAA8EJppkJ1s=yjruBm0mntGQ4NBGut2jMLFRtZr6KquA5zn+=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: my4yV4p3RPOehVoYnAej4cSNiSt3qW1W
X-Proofpoint-GUID: my4yV4p3RPOehVoYnAej4cSNiSt3qW1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_01,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290038
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/28/2023 3:48 PM, Dmitry Baryshkov wrote:
> On Mon, 28 Aug 2023 at 13:04, Marc Zyngier <maz@kernel.org> wrote:
>> On Mon, 28 Aug 2023 10:46:10 +0100,
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>> On Mon, 28 Aug 2023 at 12:36, Maulik Shah (mkshah)
>>> <quic_mkshah@quicinc.com> wrote:
>>>> Hi Dmitry,
>>>>
>>>> This patch may be useful if there was a case where some PDCs don't have
>>>> version register populated/available,
>>>> In all PDC versions, version register is always available but due to reg
>>>> size not good enough in device tree for SM8150 it failed to read.
>>>>
>>>> reg size in device node must be expanded if its too small to access all
>>>> registers and i think
>>>> additional check in driver to check if size is good enough would not be
>>>> of much use.
>>> Unfortunately, it doesn't work this way. DT files are ABI. Even if we
>>> change the DT, the kernel should continue working with the older
>>> version.
>>> Thus, we have to add such bandaid code, which will keep the kernel
>>> from crashing if old DT was used.
>> You're missing the point: all existing PDC HW have version register.
>> The fact that the DT is crap doesn't invalidate this simple fact. It
>> is thus perfectly possible for the driver to *ignore* the crap and do
>> the right thing by expanding the size of the mapping, rather than
>> falling back to the non-versioned code.
> Ah. Interesting idea. If that's the overall consensus I can send v2
> doing this. Not sure what is better though.
if expanding register size and reading version register looks too hacky 
the other way is to have "qcom,pdc-v3.2" compatible for newer targets 
post which don't need to read version register to figure out as the 
compatible string is enough to tell if v3.2 HW behavior needs to apply.

I am ok with either approach but biased towards using version register 
rather than compatibles.

Thanks,
Maulik
>> There is definitely precedents for this sort of behaviour, such as the
>> ARM GICv2 probe code.
