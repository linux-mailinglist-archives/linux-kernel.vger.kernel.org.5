Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C799980BC50
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjLJRJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjLJRJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:09:11 -0500
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4AF4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:09:15 -0800 (PST)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1rCNIU-008G0x-Sa; Sun, 10 Dec 2023 18:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID;
        bh=wzssA5RDSeBhKXHdo/qPtI/xWxJzHpVHi6/0JT/R5Zw=; b=CF6SwrHmFowUxhyBZmiCB+ceIz
        rsjhzssV20ditnB3t/7+h/nrB8+nSP1ewtdrwRPEO7tiIh7+g0d1XVmP6pv7BAWBgEGYneYi+zBvs
        l210KysIyoJM51gH/9BJio5hfAaKzS5l0h2pb6m6MhIp3lA+KCoWfkL0iCxzX5XwXTp/SrKmfO8NE
        IOG0pvXQZlqDVJVEUud9D6F9EH4sR0dOGPn3T4K3K8H7lDgKWWnPd2YlRY/k5uybUgPVZNtnWj+ik
        xVmawcwyn3D+Tn4mSOUt047MJ74BWCn7G3/m9xXcvnBOJrE6dDHHIyQ+Qm0v9aBPiFR+pWAmXeITf
        jDMgIk4g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1rCNIT-0006TW-Ma; Sun, 10 Dec 2023 18:08:53 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        id 1rCNIM-00BOjU-3d; Sun, 10 Dec 2023 18:08:46 +0100
Message-ID: <c2da6e0b-aad1-4151-a8d3-07afb149b1c5@rbox.co>
Date:   Sun, 10 Dec 2023 18:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH 0/2] x86: UMIP emulation leaking kernel addresses
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231206004654.2986026-1-mhal@rbox.co>
 <20231209155308.GAZXSNZB9PPlcHBI4W@fat_crate.local>
Content-Language: pl-PL, en-GB
In-Reply-To: <20231209155308.GAZXSNZB9PPlcHBI4W@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/23 16:53, Borislav Petkov wrote:
> On Wed, Dec 06, 2023 at 01:43:43AM +0100, Michal Luczaj wrote:
>> Introducing a DPL check in insn_get_seg_base(), or even in get_desc(),
>> seems enough to prevent the decoder from disclosing data.
>>
>> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
>> index 558a605929db..4c1eea736519 100644
>> --- a/arch/x86/lib/insn-eval.c
>> +++ b/arch/x86/lib/insn-eval.c
>> @@ -725,6 +725,18 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
>>  	if (!get_desc(&desc, sel))
>>  		return -1L;
>>  
>> +	/*
>> +	 * Some segment selectors coming from @regs do not necessarily reflect
>> +	 * the state of CPU; see get_segment_selector(). Their values might
>> +	 * have been altered by ptrace. Thus, the instruction decoder can be
>> +	 * tricked into "dereferencing" a segment descriptor that would
>> +	 * otherwise cause a CPU exception -- for example due to mismatched
>> +	 * privilege levels. This opens up the possibility to expose kernel
>> +	 * space base address of DPL=0 segments.
>> +	 */
>> +	if (desc.dpl < (regs->cs & SEGMENT_RPL_MASK))
>> +		return -1L;
>> +
>>  	return get_desc_base(&desc);
>>  }
>>  
>> That said, I guess instead of trying to harden the decoder,
> 
> Well, here's what my CPU manual says:
> 
> "4.10.1 Accessing Data Segments
> 
> ...
> 
> The processor compares the effective privilege level with the DPL in the
> descriptor-table entry referenced by the segment selector. If the
> effective privilege level is greater than or equal to (numerically
> lower-than or equal-to) the DPL, then the processor loads the segment
> register with the data-segment selector. 
> 
> If the effective privilege level is lower than (numerically
> greater-than) the DPL, a general-protection exception (#GP) occurs and
> the segment register is not loaded.
> 
> ...
> 
> 4.10.2 Accessing Stack Segments
> 
> The processor compares the CPL with the DPL in the descriptor-table
> entry referenced by the segment selector. The two values must be equal.
> If they are not equal, a #GP occurs and the SS register is not loaded."
>
> So *actually* doing those checks in the insn decoder is the proper thing
> to do, IMNSVHO.

Are you suggesting checking only CPL vs. DPL or making sure the insn
decoder faithfully emulates all the other stuff CPU does? Like the desc.s
issue described below.

>> Now, I'm far from being competent, but here's an idea I've tried: tell
>> the #GP handler that UMIP-related exceptions come only as #GP(0):
>>
>>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
>> -		if (user_mode(regs) && fixup_umip_exception(regs))
>> +		if (user_mode(regs) && !error_code && fixup_umip_exception(regs))
>>  			goto exit;
>>  	}
> 
> And yap, as you've realized, that alone doesn't fix the leaking.

With this fix applied, I can't see any way to sufficiently confuse the
UMIP emulation with a non-ESPFIX bad IRET. It appears that #GP(selector)
takes precedence over #GP(0), so tripping IRET with any malformed selector
always ends up with #GP handler's error_code != 0, even if conditions were
met for #GP(0) just as well. Is there something I'm missing?

That said, there's still the case of #DF handler feeding #GP handler after
a fault in ESPFIX. Consider

	cs = (GDT_ENTRY_TSS << 3) | USER_RPL
	ss = (SOME_LDT_ENTRY << 3) | SEGMENT_LDT | USER_RPL
	ip = "sgdt %cs:(%reg)"

Attempting IRET with such illegal CS raises #GP(selector), but (because of
ESPFIX) this #GP is promoted to #DF where it becomes #GP(0). And UMIP
emulation is triggered.

UMIP emulator starts by fetching code from user. insn decoder does
`copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE)` where `ip` is
CS.base+IP and CS.base here is actually a (part of) GDT_ENTRY_TSS.base, a
kernel address. With IP under user's control, no fault while copying.

Next, insn_get_code_seg_params() concludes that, given TSS as a code
segment, address and operand size are both 16-bit. Prefix SGDT with size
overrides, and we're back to 32-bit. Then insn_get_addr_ref() and
copy_to_user() does the leaking.

I don't know if/how to deal with ESPFIX losing #GP's error code. As for
telling insn decoder that system segments aren't code:

--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -809,6 +809,10 @@ int insn_get_code_seg_params(struct pt_regs *regs)
        if (!get_desc(&desc, sel))
                return -EINVAL;

+       /* System segments are not code. */
+       if (!desc.s)
+               return -EINVAL;
+
        /*
         * The most significant byte of the Type field of the segment descriptor
         * determines whether a segment contains data or code. If this is a data

Is this something in the right direction?

(Note, get_segment_selector() is broken for selectors with the high bit
set. I'll send patch later.)

thanks,
Michal
