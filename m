Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DF7B1023
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjI1Aqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1Aqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:46:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B3BF;
        Wed, 27 Sep 2023 17:46:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S05h01027384;
        Thu, 28 Sep 2023 00:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pXoEP3GCOOd/1473IAcm4hwedVer7jlELNLtv8gHaTM=;
 b=gi4Qhp8bzcVcworhAWypkdeuJkJwa78/HGkLAF2lF6guwx2aTJ2yEsIiRx9y8FnZkEZl
 PcwpJP0XDYoXgPUwYStti28izyV4crgkmrEzONTNRwkhaC/jI6T11fhEpZDNniYIGU38
 a7UxYKpEwSK7AVmRH7SlNnGUDoJrMfMkd0tQXkjcPmSz0J9d8BU155D7Uw3vmZyq3Jza
 Q3L+xCvq5hem9iLQI7vy05+uuCFAtbnYS+0hazva409BZDWZppdGOpBCUdUe5Ioz0rnD
 /2iUvVy0VzvyjDBnpjWXEFy23w4p8bX9iiv90IoZWOo2XljislXNmozxQBLAvBiL6dik yw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc43mu7jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 00:46:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S0jqPI021922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 00:45:52 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 17:45:48 -0700
Message-ID: <22c91d69-328b-8221-f0fa-d6e1663ce074@quicinc.com>
Date:   Thu, 28 Sep 2023 08:45:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local
 variables
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux@armlinux.org.uk>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_lijuang@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20230927055954.3755-1-quic_aiquny@quicinc.com>
 <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
 <af59ec04-aa68-5a22-0f3f-f4872cefeb46@quicinc.com>
 <CAMj1kXEUTOpATv_jbimGktSXBBweyfVNPpqWWJaJNp0U-zvg+w@mail.gmail.com>
 <29bf8f4c-44b8-ab22-aa66-3e3040012ee5@quicinc.com>
In-Reply-To: <29bf8f4c-44b8-ab22-aa66-3e3040012ee5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CRg0ADjLUfVWf_B31mPnjEAXjx96T0q1
X-Proofpoint-GUID: CRg0ADjLUfVWf_B31mPnjEAXjx96T0q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_16,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=897 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280005
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2023 8:40 AM, Aiqun(Maria) Yu wrote:
> On 9/27/2023 6:11 PM, Ard Biesheuvel wrote:
>> On Wed, 27 Sept 2023 at 09:44, Aiqun(Maria) Yu 
>> <quic_aiquny@quicinc.com> wrote:
>>>
>>> On 9/27/2023 5:26 PM, Ard Biesheuvel wrote:
>>>> Hello Maria,
>>>>
>>>> On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com> 
>>>> wrote:
>>>>>
>>>>> Registers r7 is removed in clobber list, so compiler may choose r7 for
>>>>> local variables usage, while r7 will be actually updated by the 
>>>>> inline asm
>>>>> code.
>>>>
>>>> The inline asm does not update R7, it preserves and restores it.
>>> That is the asm is updating r7 purposely and compiler still choose r7
>>> for the asm local varialbe and use it inside the asm code.
>>> So the change is to fix the issue when "r7 is removed from the clobber
>>> list of current asm code while actually r7 shouldn't be choosed for the
>>> current asm local variables".
>>> The issue is only reproducible when ftrace is not enabled, and r7 is
>>> removed from the current clobber list.
>>>
>>> Let me have the assemble code that will make you understand better.
>>>
>>> --the original code:
>>> "mov    r11, r7                 \n\t"
>>> ...
>>> "ldmia  %[regs], {r0-r7}        \n\t"
>>> "blx    %[fn]                   \n\t"
>>> ...
>>> "mov    r7, r11                 \n\t"
>>>
>>> --After compile to choose register for [fn] and [regs].
>>> mov     r11, r7
>>> ldr  r7, [r1, #16] //r7 used for store asi->insn_fn
>>> ...
>>> ldmia.w  ip, {r0, r1, r2, r3, r4, r5, r6, r7}
>>> blx r7
>>> ...
>>> mov r7,r11
>>>
>>> The current change is to avoid by fix the registers for local variable
>>> usage and not choose r7 for [fn].
>>>
>>
>> OK, I understand now, thanks.
>>
>> Would it help if we just always enabled frame pointers for this source 
>> file?
The compiler(clang 17 here I am using) will still complain for "inline
asm clobber list contains reserved registers" when ftrace enabled.

More over, the local variable have fixed registers was align with 
current solution as well. we referenced other asm inlined function 
inside kprobe folder, like __kprobes functions inside actions-common.c 
files, it is also have similar solution to fixed register usage for 
local variables which will be used inside similar inline asm code.
>>
>> --- a/arch/arm/probes/kprobes/Makefile
>> +++ b/arch/arm/probes/kprobes/Makefile
>> @@ -9,6 +9,7 @@ test-kprobes-objs               := test-core.o
>>   ifdef CONFIG_THUMB2_KERNEL
>>   obj-$(CONFIG_KPROBES)          += actions-thumb.o checkers-thumb.o
>>   test-kprobes-objs              += test-thumb.o
>> +KBUILD_CFLAGS                  += -fno-omit-frame-pointer
> I've tried this before, but it didn't work.
> The compiler(clang 17 here I am using) will still complain for "inline 
> asm clobber list contains reserved registers" when ftrace enabled.
>>   else
>>   obj-$(CONFIG_KPROBES)          += actions-arm.o checkers-arm.o
>>   obj-$(CONFIG_OPTPROBES)                += opt-arm.o
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

