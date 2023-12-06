Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60496806C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbjLFKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbjLFKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:39:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E04C7;
        Wed,  6 Dec 2023 02:39:41 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68JCxc004087;
        Wed, 6 Dec 2023 10:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O6lzXcHn/rGUl971MrUkOTA15/uAlQhRI2IsHGhKpy4=;
 b=Gy2A7xkVmgcUsWMX6qnpV3riLaO08f2jUh4IyFJjwrYlhBQb13M2kwhJpUwQz0kkbzOd
 WqRoVWJlxB+PlAlhuaBtXhk5LnS3/Q5HdaGG5RrEY5O/3dVvL1DlkCBWb+RVUQ41udFP
 QzJ9HO+lr/MPATh1SGV4ZbWjP+IVqn0l8qWEo/3ZkQ3T9XZkYR7rqR1NZosBAij13uFl
 /j6lYAG2IrtATV3cMJA3QaeKJBjxW1UeHFiCe73AdoCdecP3Ohb2V0wIKQeymBpVg22Q
 93McKxlOE2oJPYJVxwIKzdS4071FFyyNDmFfq33rjqusHoZ2RLf/MsVx3gDK/5sahChL gQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ute971582-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 10:38:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6Acv1d009486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 10:38:57 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 02:38:53 -0800
Message-ID: <0d66efa6-7697-9314-b649-22cdc4d8fa59@quicinc.com>
Date:   Wed, 6 Dec 2023 16:08:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Atul Dhudase <quic_adhudase@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
 <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
 <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
 <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com>
 <SN4PR0201MB8806AF236D696E15CDC6400CF9A9A@SN4PR0201MB8806.namprd02.prod.outlook.com>
 <CAE-0n50kf82BLXPAAUN+kba9osA-gEetm96tS7aRVzUUNHbCgQ@mail.gmail.com>
 <CAD=FV=W7pjg=vfrkZg4i=YaKpoNT+_hX_3tgDz8VQiH+OquOTQ@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAD=FV=W7pjg=vfrkZg4i=YaKpoNT+_hX_3tgDz8VQiH+OquOTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: THxCwsxOmNU7qSAhhmmTYS1pOzhQRIDz
X-Proofpoint-ORIG-GUID: THxCwsxOmNU7qSAhhmmTYS1pOzhQRIDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060087
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 3:34 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 9, 2023 at 12:34 PM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Quoting Atul Dhudase (QUIC) (2023-11-07 07:27:54)
>>> Hi,
>>>
>>> On 11/7/2023 6:46 PM, Mukesh Ojha wrote:
>>>> On 11/7/2023 3:25 AM, Stephen Boyd wrote:
>>>>> Quoting Mukesh Ojha (2023-11-05 22:54:28)
>>>>>>
>>>>>>
>>>>>> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
>>>>>>> On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
>>>>>>>> While programming dis_cap_alloc and retain_on_pc, set a bit
>>>>>>>> corresponding to a specific SCID without disturbing the
>>>>>>>> previously configured bits.
>>>>>>>>
>>>>>>>
>>>>>>> As far as I can see, the only invocation of
>>>>>>> _qcom_llcc_cfg_program() comes from qcom_llcc_cfg_program(), which
>>>>>>> is only called once, from qcom_llcc_probe(), and here also seems
>>>>>>> to only be the single write to these two registers.
>>>>>>
>>>>>> It does not look to be single write but the write is for each slice
>>>>>> in the same register which was overriding other slices values.
>>>>>
>>>>> Can you add that detail to the commit text? What's the seriousness
>>>>> of the issue? Why should it be backported to stable? Is something
>>>>> seriously broken because a slice configuration is overwritten? Does
>>>>> it mean that some allocation made in a slice is being lost over
>>>>> power collapse (pc) when it shouldn't be?
>>>>
>>>> @Atul will update the commit text as per suggestion.
>>>>
>>>> And yes, without this change, retention feature will not work properly.
>>>>
>>>> -Mukesh
>>>
>>> Does this commit text make sense? If so, I will update patch accordingly.
>>>
>>> When configuring capacity based allocation and power collapse retention, writing to the same register for each slice caused overwriting of the values for other slices, leading to misconfiguration for majority of the slices.
>>> To address this, only modify the bits associated with each slice while retaining the values of the remaining bits, as they were prior to the Linux configuration.
>>
>> This commit text doesn't say what, if anything, is broken. Does it save
>> power when it didn't before? Why is it critical to backport this to
>> stable kernels? Was the driver overwriting other bits in this register
>> that were critical to power, performance, or correctness? Or was
>> everything working out because the last slice to be written was the only
>> important one?
> 
> Whatever happened to this patch? It seemed like it might be important
> and it never landed. I guess the only thing that was blocking it from
> landing was some commit text that explained _why_ it was important and
> that never got written.
> 
> I guess Bjorn was also worried that any bits that weren't updated by
> the kernel would now be left in their default state (however the
> bootloader left them). It would be good to indicate in the commit text
> if that matters and what is in those other bits.

Let me add that.
Completely missed to track this change., Thanks for reminding..

-Mukesh

> 
> 
> -Doug
