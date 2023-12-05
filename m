Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C9804B55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjLEHq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjLEHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:46:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8BCA;
        Mon,  4 Dec 2023 23:47:01 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B52oxUZ016853;
        Tue, 5 Dec 2023 07:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kbodZWM2evYVptkeKv/TRiiQ0iRhUvgSJ4NO6T5niTg=;
 b=AihshZxP8tvNzsiAh4KijSEOxhuGRyqcAFTy3GmTI4kIZF/Ykfk66R/2hcnheE5WmxKS
 ZRIu1EDRNzXhOkQl6LOJcYgZC6mY1e+AGdYg9WzLmwpolgVK88+QhwW6J6uhkDOP8Dxw
 hrZC9L++mK6n8MaRNidz00f8oh6xHvT8wKUBAaiuIBIUstoyB66iFmFLfR8xTPuJOh7K
 7l0ESFPGKsnkB2tIKNsnEr3BdskuaHsagcdmzKlEx0mPLnfUyThstKYlzEgDLfEgjLaS
 x6s+TKKigSCIjfkywhgY6npZsxfKBtbnzQO4DDtpi9WKIT/9bjaJD/FOBmgg2M+69Vtx DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us8wpk7up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:46:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B57kuuv020485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 07:46:56 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 23:46:51 -0800
Message-ID: <a715c4f1-dcba-4411-ae6b-20ce4ad849ac@quicinc.com>
Date:   Tue, 5 Dec 2023 15:46:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: Add lock to ensure the state atomization
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20231201152931.31161-1-quic_aiquny@quicinc.com>
 <6jlui5h7d2rs37sdvvwmii55mwhm5dzfo2m62hwt53mkx4z32a@aw5kcghe4bik>
 <4d85fda9-6e00-4bb4-b8a8-85c5e66635bf@quicinc.com>
 <wmpsnz3lhqsqglwkbr5ohrywqeufrjmtobhnprvf4o6iarc5x6@6jeuqck4n2nc>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <wmpsnz3lhqsqglwkbr5ohrywqeufrjmtobhnprvf4o6iarc5x6@6jeuqck4n2nc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WUG1ez1NYRNFYBRUY8Y2L2nHUUc4RZ2d
X-Proofpoint-ORIG-GUID: WUG1ez1NYRNFYBRUY8Y2L2nHUUc4RZ2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 12:46 AM, Bjorn Andersson wrote:
> On Mon, Dec 04, 2023 at 05:57:42PM +0800, Aiqun(Maria) Yu wrote:
>> On 12/2/2023 4:39 AM, Bjorn Andersson wrote:
>>> On Fri, Dec 01, 2023 at 11:29:31PM +0800, Maria Yu wrote:
>>>> Currently pinctrl_select_state is an export symbol and don't have
>>>> effective re-entrance protect design. And possible of pinctrl state
>>>> changed during pinctrl_commit_state handling. Add per pinctrl lock to
>>>> ensure the old state and new state transition atomization.
>>>> Move dev error print message right before old_state pinctrl_select_state
>>>> and out of lock protection to avoid console related driver call
>>>> pinctrl_select_state recursively.
>>>
>>> I'm uncertain about the validity of having client code call this api in
>>> a racy manner. I'm likely just missing something here... It would be
>>> nice if this scenario was described in a little bit more detail.
>> Hi Bjorn,
>>
>> we've got a customer dump that the real racy happened, and the system
>> frequently have printk message like:
>>    "not freeing pin xx (xxx) as part of deactivating group xxx - it is
>> already used for some other setting".
>> Finally the system crashed after the flood log.
>>
> 
> Sounds like we have a valid issue, but let's make sure that we
> describe the problem on its technical grounds in the commit that is
> upstreamed - if nothing else, so that others can determine if the
> solution matches their bug reports.
> 
>> We've inform the customer to check their own client code which called this
>> api, to have proper lock to avoid racy of per dev pinctrl_select_state call
>> from customer driver end.
>> For example:
>> LOCK;
>> pinctrl_select_state();
> 
> Placing a lock inside pinctrl_select_state() will not make this whole
> sequence atomic, so if the client driver needs to know that the state
> remains from here until the "other hardware behaviors" below, something
> more is needed.
Agree.
This is only an example to enforcing from the clients which call this 
API. while apparently not all clients ensured this kind of lock safe 
when to call pinctrl_select_state, so that's why placing a lock inside 
pinctrl_select_state to ensure atomic of per dev pinctrl at least.
> 
> Perhaps I'm misunderstanding what you're saying though?

> 
>> gpio pulling;
>> udelay();
>> check state;
>> other hardware behaviors;
>> UNLOCK;
>>
>> While it is still unnecessary the volatile re-load of p->state for the
>> interation and so I upstream a patch like link[2].
>>
>> while during the merge discussion, upstream maintainer suggest to have the
>> lock issue fixed, instead of only READ_ONCE for the interation.
>> I think it is also make sense since although current in-tree driver have
>> take care of each pinctrl_select_state call, since it is a export symbole
>> and we've see the similar issue continuously (a year back ago also we've
>> seen similar issue before[3]).
>>
> 
> I think you're correcting a real problem, in that two contexts calling
> pinctrl_select_state() seems to be able to cause non-deterministic
> results. But is the motivation "pinctrl_select_state() is an
> EXPORT_SYMBOL, so let's make it thread safe", or is the motivation
EXPORT_SYMBOL pinctrl_select_state, let's make it thread safe is a 
motivation here. As above reason explained.
> "during async probing of devices it's possible to end up in
> pinctrl_select_state() from multiple contexts simultaneously, so make it
> thread safe"?
> 
>> The whole serials discussion can be found link here:
>> [1] https://lore.kernel.org/lkml/e011b3e9-7c09-4214-8e9c-90e12c38bbaa@quicinc.com/
>> [2]
>> https://lore.kernel.org/lkml/20231115102824.23727-1-quic_aiquny@quicinc.com/
>> [3]
>> https://lore.kernel.org/lkml/20221027065408.36977-1-quic_aiquny@quicinc.com/
>>
>>>
>>> The recursive error print sounds like a distinct problem of its own,
>>> that warrants being introduced in a patch of its own. But as with the
>>> other part, I'm not able to spot a code path in the upstream kernel
>>> where this hppens, so please properly describe the scenario where
>>> touching the console would result back in another pinctrl_select_state().
>> For this part, I am thinking about a spin lock is introduced and have the
>> error log out of the lock will be safer.
>> The current patch disable irq during the lock, and some console driver rely
>> on interrupt to get tx dma/fifo ready.
> 
> Logging outside the region with interrupts disabled make total sense,
> I'm definitely in favor of this.
Fair enough.
> 
>> Also console driver will be a pinctrl client, so avoid unnecessary recursive
>> in theory.
> 
> I don't think a console driver should pinctrl_select_state() from its
> tx path, that's why I'm asking.
> 
Got you. I haven't seen in-tree console driver have tx path call 
pinctrl_select_state. Will re-vise the commit comments accordingly.
> But perhaps I'm missing some scenario, if so please describe this in the
> commit message.
> 

>> Just incase some out of tree concole driver was able to use the
>> pinctrl_select_state in console write related APIs as well.
> 
> If there is a valid usage pattern I think we should consider that, but
> we do not care about out-of-tree drivers misusing/abusing framework
> APIs.
Fair.
> 
> Regards,
> Bjorn

-- 
Thx and BRs,
Aiqun(Maria) Yu

