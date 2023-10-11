Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4397C502D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbjJKKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:33:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38892;
        Wed, 11 Oct 2023 03:33:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B73i6U013577;
        Wed, 11 Oct 2023 10:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DpafdFtWu11m38+cEtxGwJLTunOdHVjJFSzjFbdeJU0=;
 b=S7q48uUs98qdDkUTNPFhKxINOpDkFk1Sv6VwbOkloJ9X0sf3bbEKNa8MLNn2UISOj79v
 5U9cD1taGN4WuzN4Sc3v53gHJN0+Cl7MLZWWcSLf7GYGRmAzcGW6rVtbSBt2Vaz9nCM8
 OxSNMs9kb2wEJ/ENZ52rUm5YD8z9UdK7Ysvw8F6RLz54gmSjUcEfZDseGWpImVCzmWCl
 f3YkrLRmJ1mdiRYHE/5v4/O+RhTe5gtFkJxpj6uDlt9egINSbwvfWPIa6MzZLdoO8mti
 AunA3U2ku3s221HrTKXctQuBZXSM6hVY2CM8oetK3Pz/b/Ff2EoD0DAHKe/oNynaQ+Ib Tg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tne0q1bf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:33:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BAX29g012153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:33:02 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 03:32:58 -0700
Message-ID: <c07af255-ee99-6bfb-1d03-a77cb58c934d@quicinc.com>
Date:   Wed, 11 Oct 2023 18:32:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local
 variables
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
 <22c91d69-328b-8221-f0fa-d6e1663ce074@quicinc.com>
 <CAMj1kXHKgrJR_pdDV23U_9q5Gft5Sydcus=tmXXM6anKvb7H5w@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CAMj1kXHKgrJR_pdDV23U_9q5Gft5Sydcus=tmXXM6anKvb7H5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KSkruSLOdWQYAnMkVKtj3DJKyiJBiSSv
X-Proofpoint-ORIG-GUID: KSkruSLOdWQYAnMkVKtj3DJKyiJBiSSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_07,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110092
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2023 3:38 AM, Ard Biesheuvel wrote:
> On Thu, 28 Sept 2023 at 00:46, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>>
>> On 9/28/2023 8:40 AM, Aiqun(Maria) Yu wrote:
>>> On 9/27/2023 6:11 PM, Ard Biesheuvel wrote:
>>>> On Wed, 27 Sept 2023 at 09:44, Aiqun(Maria) Yu
>>>> <quic_aiquny@quicinc.com> wrote:
>>>>>
>>>>> On 9/27/2023 5:26 PM, Ard Biesheuvel wrote:
>>>>>> Hello Maria,
>>>>>>
>>>>>> On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Registers r7 is removed in clobber list, so compiler may choose r7 for
>>>>>>> local variables usage, while r7 will be actually updated by the
>>>>>>> inline asm
>>>>>>> code.
>>>>>>
>>>>>> The inline asm does not update R7, it preserves and restores it.
>>>>> That is the asm is updating r7 purposely and compiler still choose r7
>>>>> for the asm local varialbe and use it inside the asm code.
>>>>> So the change is to fix the issue when "r7 is removed from the clobber
>>>>> list of current asm code while actually r7 shouldn't be choosed for the
>>>>> current asm local variables".
>>>>> The issue is only reproducible when ftrace is not enabled, and r7 is
>>>>> removed from the current clobber list.
>>>>>
>>>>> Let me have the assemble code that will make you understand better.
>>>>>
>>>>> --the original code:
>>>>> "mov    r11, r7                 \n\t"
>>>>> ...
>>>>> "ldmia  %[regs], {r0-r7}        \n\t"
>>>>> "blx    %[fn]                   \n\t"
>>>>> ...
>>>>> "mov    r7, r11                 \n\t"
>>>>>
>>>>> --After compile to choose register for [fn] and [regs].
>>>>> mov     r11, r7
>>>>> ldr  r7, [r1, #16] //r7 used for store asi->insn_fn
>>>>> ...
>>>>> ldmia.w  ip, {r0, r1, r2, r3, r4, r5, r6, r7}
>>>>> blx r7
>>>>> ...
>>>>> mov r7,r11
>>>>>
>>>>> The current change is to avoid by fix the registers for local variable
>>>>> usage and not choose r7 for [fn].
>>>>>
>>>>
>>>> OK, I understand now, thanks.
>>>>
>>>> Would it help if we just always enabled frame pointers for this source
>>>> file?
>> The compiler(clang 17 here I am using) will still complain for "inline
>> asm clobber list contains reserved registers" when ftrace enabled.
>>
>> More over, the local variable have fixed registers was align with
>> current solution as well. we referenced other asm inlined function
>> inside kprobe folder, like __kprobes functions inside actions-common.c
>> files, it is also have similar solution to fixed register usage for
>> local variables which will be used inside similar inline asm code.
> 
> I tested the approach below, and it seems to work fine both with
> ftrace enabled and disabled. R7 is no longer selected by the compiler
> as an inline asm argument, but is still in charge of the register
> allocation.
Thx for the testing.
I have re-test with the clean change only, and it is working same as 
your result.
R7 can be reserved when with "-fno-omit-frame-pointer" added as CFLAG 
for this file.

The side effect of "-fno-omit-frame-pointer" is that, the additional 
instruction is added for those functions in this file, for example:

with "-fno-omit-frame-pointer", instructions will be like:
   push    {r4, r5, r6, r7, lr}
   add     r7, sp, #12
   stmdb   sp!, {r8, r9, sl, fp}
with "-fomit-frame-pointer", instructions will be like:
   stmdb   sp!, {r4, r5, r6, r7, r8, r9, fp, lr}

My worry is about the unnecessary code size and performance impact.
While myself is not deny the solution of "-fno-omit-frame-pointer", 
since in kernel there is other example use the similar solution.
> 
> With your approach, the compiler is still free to use R7, and we have
> had issues in the past where the compiler does not honour the register
> asm ("rX") assignment strictly.
If the compiler does not honour the register strictly, and don't have a 
specific rule, it is a problem in existing similar functionality as 
well. There is the register asm ("rX") usage across different similar 
functions.

example code like emulate_generic_r0_12_noflags() which is used similar 
specify fn regist in file actions-common.c:
	register void *rregs asm("r1") = regs;
	register void *rfn asm("lr") = asi->insn_fn; /**if the compiler 
choosing r0-r12, it will be a runtime error. **/

	__asm__ __volatile__ (
		"stmdb	sp!, {%[regs], r11}	\n\t"
		"ldmia	%[regs], {r0-r12}	\n\t"
...
		"blx	%[fn]			\n\t"
> 
> Could you please explain how you produced the "inline asm clobber list
> contains reserved registers" with this change?
> 
I was forget to remove "r7" in the clobber list and test along with this 
change and that's why the compiler is complaining "inline asm clobber 
list contains reserved registers".
Thx for the correction.

> 
> 
> 
> --- a/arch/arm/probes/kprobes/Makefile
> +++ b/arch/arm/probes/kprobes/Makefile
> @@ -8,6 +8,7 @@ test-kprobes-objs               := test-core.o
> 
>   ifdef CONFIG_THUMB2_KERNEL
>   obj-$(CONFIG_KPROBES)          += actions-thumb.o checkers-thumb.o
> +CFLAGS_actions-thumb.o         += -fno-omit-frame-pointer
>   test-kprobes-objs              += test-thumb.o
>   else
>   obj-$(CONFIG_KPROBES)          += actions-arm.o checkers-arm.o

Just come back from long vacation, so delayed response. Thx for the 
consideration.

-- 
Thx and BRs,
Aiqun(Maria) Yu

