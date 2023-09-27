Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040CA7B00D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjI0JpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjI0JpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:45:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4FC0;
        Wed, 27 Sep 2023 02:45:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9F1SH031782;
        Wed, 27 Sep 2023 09:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h87acShbjMp5ebaCn3FHHF3U20YbySoZN9XrvNwUPHI=;
 b=JwIkpM3zbJJ0YiiRkbkVDddaScvslDXgKi7iZFSFRZOSSKcmigUAg6AtubTcsGOrXvwc
 js2rMuWQ2GdvlOVCy3yhdSfuW45EcK+dPup78gt0F5wKYPciAOcUk1WRni1Sac5DNBTx
 y+hdYB+K7OYw04vUri0Mz1hrHuzVDAs7vynGaVMwEFKm3qJbpGhVLkFtlRXrPm2I95u9
 ltCubW5B1YFAINOauGAQdL4eJ7sSQg4RII8Sj9boYNtbVd6sYbG36J0Q371jFTMNCWNz
 +0057qpvMZme4wj0YjwCzhwWeRvlEENVP2bI7OQkbmbmNZWGxWXm6SxI+mtSe+6EMP7/ CA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbv6630ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 09:44:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R9io6N031370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 09:44:50 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 02:44:44 -0700
Message-ID: <af59ec04-aa68-5a22-0f3f-f4872cefeb46@quicinc.com>
Date:   Wed, 27 Sep 2023 17:44:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local
 variables
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux@armlinux.org.uk>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_lijuang@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20230927055954.3755-1-quic_aiquny@quicinc.com>
 <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7EpDtY3dm1z25LOLtXJjrYN9FE6jTO46
X-Proofpoint-GUID: 7EpDtY3dm1z25LOLtXJjrYN9FE6jTO46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=957 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270080
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2023 5:26 PM, Ard Biesheuvel wrote:
> Hello Maria,
> 
> On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com> wrote:
>>
>> Registers r7 is removed in clobber list, so compiler may choose r7 for
>> local variables usage, while r7 will be actually updated by the inline asm
>> code.
> 
> The inline asm does not update R7, it preserves and restores it.
That is the asm is updating r7 purposely and compiler still choose r7 
for the asm local varialbe and use it inside the asm code.
So the change is to fix the issue when "r7 is removed from the clobber 
list of current asm code while actually r7 shouldn't be choosed for the 
current asm local variables".
The issue is only reproducible when ftrace is not enabled, and r7 is 
removed from the current clobber list.

Let me have the assemble code that will make you understand better.

--the original code:
"mov	r11, r7			\n\t"
...
"ldmia	%[regs], {r0-r7}	\n\t"
"blx	%[fn]			\n\t"
...
"mov	r7, r11			\n\t"

--After compile to choose register for [fn] and [regs].
mov	r11, r7
ldr  r7, [r1, #16] //r7 used for store asi->insn_fn
...
ldmia.w  ip, {r0, r1, r2, r3, r4, r5, r6, r7}
blx r7
...
mov r7,r11

The current change is to avoid by fix the registers for local variable 
usage and not choose r7 for [fn].


> 
>> This caused the runtime behavior wrong.
> 
> Could you explain how, exactly? In which cases is the preserve/restore
> of R7 failing to achieve the intended result?

explained above.

> 
>> While those kind of reserved registers cannot be set to clobber list
>> because of error like "inline asm clobber list contains reserved
>> registers".
>> To both working for reserved register case and non-reserved register case,
>> explicitly assign register for local variables which will be used as asm
>> input.
>>
> 
> If we make this change, could we remove the references to R7 altogether?
R7 needed to be prepared for use when blx to the final fn for kprobe 
functional as my understanding.
could you elaborate more on this question?

> 
>> Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   arch/arm/probes/kprobes/actions-thumb.c | 32 ++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/probes/kprobes/actions-thumb.c b/arch/arm/probes/kprobes/actions-thumb.c
>> index 51624fc263fc..f667b2f00b3e 100644
>> --- a/arch/arm/probes/kprobes/actions-thumb.c
>> +++ b/arch/arm/probes/kprobes/actions-thumb.c
>> @@ -442,8 +442,10 @@ static unsigned long __kprobes
>>   t16_emulate_loregs(probes_opcode_t insn,
>>                     struct arch_probes_insn *asi, struct pt_regs *regs)
>>   {
>> -       unsigned long oldcpsr = regs->ARM_cpsr;
>> -       unsigned long newcpsr;
>> +       register unsigned long oldcpsr asm("r8") = regs->ARM_cpsr;
>> +       register unsigned long newcpsr asm("r9");
>> +       register void *rregs asm("r10") = regs;
>> +       register void *rfn asm("lr") = asi->insn_fn;
>>
>>          __asm__ __volatile__ (
>>                  "msr    cpsr_fs, %[oldcpsr]     \n\t"
>> @@ -454,10 +456,10 @@ t16_emulate_loregs(probes_opcode_t insn,
>>                  "mov    r7, r11                 \n\t"
>>                  "mrs    %[newcpsr], cpsr        \n\t"
>>                  : [newcpsr] "=r" (newcpsr)
>> -               : [oldcpsr] "r" (oldcpsr), [regs] "r" (regs),
>> -                 [fn] "r" (asi->insn_fn)
>> +               : [oldcpsr] "r" (oldcpsr), [regs] "r" (rregs),
>> +                 [fn] "r" (rfn)
>>                  : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r11",
>> -                 "lr", "memory", "cc"
>> +                 "memory", "cc"
>>                  );
>>
>>          return (oldcpsr & ~APSR_MASK) | (newcpsr & APSR_MASK);
>> @@ -525,6 +527,9 @@ static void __kprobes
>>   t16_emulate_push(probes_opcode_t insn,
>>                  struct arch_probes_insn *asi, struct pt_regs *regs)
>>   {
>> +       register void *rfn asm("lr") = asi->insn_fn;
>> +       register void *rregs asm("r10") = regs;
>> +
>>          __asm__ __volatile__ (
>>                  "mov    r11, r7                 \n\t"
>>                  "ldr    r9, [%[regs], #13*4]    \n\t"
>> @@ -534,9 +539,9 @@ t16_emulate_push(probes_opcode_t insn,
>>                  "str    r9, [%[regs], #13*4]    \n\t"
>>                  "mov    r7, r11                 \n\t"
>>                  :
>> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
>> +               : [regs] "r" (rregs), [fn] "r" (rfn)
>>                  : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r8", "r9", "r11",
>> -                 "lr", "memory", "cc"
>> +                 "memory", "cc"
>>                  );
>>   }
>>
>> @@ -561,6 +566,9 @@ static void __kprobes
>>   t16_emulate_pop_nopc(probes_opcode_t insn,
>>                  struct arch_probes_insn *asi, struct pt_regs *regs)
>>   {
>> +       register void *rfn asm("lr") = asi->insn_fn;
>> +       register void *rregs asm("r8") = regs;
>> +
>>          __asm__ __volatile__ (
>>                  "mov    r11, r7                 \n\t"
>>                  "ldr    r9, [%[regs], #13*4]    \n\t"
>> @@ -570,9 +578,9 @@ t16_emulate_pop_nopc(probes_opcode_t insn,
>>                  "str    r9, [%[regs], #13*4]    \n\t"
>>                  "mov    r7, r11                 \n\t"
>>                  :
>> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
>> +               : [regs] "r" (rregs), [fn] "r" (rfn)
>>                  : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
>> -                 "lr", "memory", "cc"
>> +                 "memory", "cc"
>>                  );
>>   }
>>
>> @@ -581,6 +589,8 @@ t16_emulate_pop_pc(probes_opcode_t insn,
>>                  struct arch_probes_insn *asi, struct pt_regs *regs)
>>   {
>>          register unsigned long pc asm("r8");
>> +       register void *rfn asm("lr") = asi->insn_fn;
>> +       register void *rregs asm("r10") = regs;
>>
>>          __asm__ __volatile__ (
>>                  "mov    r11, r7                 \n\t"
>> @@ -591,9 +601,9 @@ t16_emulate_pop_pc(probes_opcode_t insn,
>>                  "str    r9, [%[regs], #13*4]    \n\t"
>>                  "mov    r7, r11                 \n\t"
>>                  : "=r" (pc)
>> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
>> +               : [regs] "r" (rregs), [fn] "r" (rfn)
We have encounter the runtime issue when compiler choose r7 for store 
"asi->insn_fn" here for example above.

>>                  : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
>> -                 "lr", "memory", "cc"
>> +                 "memory", "cc"
>>                  );
>>
>>          bx_write_pc(pc, regs);
>>
>> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
>> --
>> 2.17.1
>>

-- 
Thx and BRs,
Aiqun(Maria) Yu

