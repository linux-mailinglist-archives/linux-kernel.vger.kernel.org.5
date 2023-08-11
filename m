Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE1779748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHKSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHKSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6930DC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691779673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEXEFCPFrqRQrjxHQ3PIoyRZxwjD4HNZdhhYwTXt60M=;
        b=LDa+NjgOgbSSm6Kip7uTb/jGS+mFjCXIxku2SaHv+/GghsyXaV2XBhQDGAmsHFjbef4WBa
        qpLALwyCtAM4GBOxDT5Vj8LlZj2p2SzEw6H43A9ZuBmHrIpiW6EOhYeucW/oXdmfdXwfsz
        TucMHg3Hd/4nT4B6nw053crc8PzImd8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-5f6BQd4WM6qllt61u7DuIw-1; Fri, 11 Aug 2023 14:47:52 -0400
X-MC-Unique: 5f6BQd4WM6qllt61u7DuIw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9c22c3d68so13804791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779671; x=1692384471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEXEFCPFrqRQrjxHQ3PIoyRZxwjD4HNZdhhYwTXt60M=;
        b=jS12Wvj/ZVkkBmYG6AkGIQzdwcCNppvG2nzl72TVAEadhxnew1sLjqlGgLj4NL5OX5
         8audMI8mPrezZsSfPU+orTl2HzXEKe3z2rRyJ09KLUgR5W19uCKgamdl35HcxxMdhBaJ
         AmieubWFyIZGQ/7KjXZpQuss7yCd6xFzsam6lfA4hEVIvRaELHukJjX5FCMmyBNT0sYD
         N/6YWKcs0z7C/VS1NxP5qh+74x+LNFJKPr3k/nbhBUbMTavAa0m5yXcexsuEBGXSP5RV
         DzDdYzztC6Vi64YADxsVk2S1SH+CW2HYDEcy6ljnpONyxGt0V64YKSiYvVY84fbJ7PbX
         kgFA==
X-Gm-Message-State: AOJu0YxIPVRzIECz72pzMZ5eHTxf9MtWn8SjscjofPdJTAYXFi6t5l5n
        DpDOjzrmlhjVok9SkITiKwRgjftz7a6ulG2xX07uFkGkcLeMr0qkSM+5mjxs5JvnXnSteDBRlaC
        VMoVk+d/OAsaILpdQ/S76rPA=
X-Received: by 2002:a05:651c:1184:b0:2b9:b7ad:71a6 with SMTP id w4-20020a05651c118400b002b9b7ad71a6mr1850770ljo.25.1691779670828;
        Fri, 11 Aug 2023 11:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRKU8eXgWqIaxB3yF8voye7hWXuvXZkVPuENsirIcdchZOBOk7jnIUpT4EjOQQFoDt3T3x/A==
X-Received: by 2002:a05:651c:1184:b0:2b9:b7ad:71a6 with SMTP id w4-20020a05651c118400b002b9b7ad71a6mr1850764ljo.25.1691779670488;
        Fri, 11 Aug 2023 11:47:50 -0700 (PDT)
Received: from [192.168.1.86] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id u20-20020a2e2e14000000b002ba123cb784sm967450lju.99.2023.08.11.11.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:47:49 -0700 (PDT)
Message-ID: <8edc91f9-ce20-9528-a496-5b6e650bb63f@redhat.com>
Date:   Fri, 11 Aug 2023 21:47:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/retpoline: Don't clobber RFLAGS during
 srso_safe_ret()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Srikanth Aithal <sraithal@amd.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230811155255.250835-1-seanjc@google.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20230811155255.250835-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/23 18:52, Sean Christopherson wrote:
> Use 'lea' instead of 'add' when adjusting %rsp in srso_safe_ret() so as to
> avoid clobbering flags.  Drop one of the INT3 instructions to account for
> the LEA consuming one more byte than the ADD.
>
> KVM's emulator makes indirect calls into a jump table of sorts, where
> the destination of each call is a small blob of code that performs fast
> emulation by executing the target instruction with fixed operands.
>
> E.g. to emulate ADC, fastop() invokes adcb_al_dl():
>
>    adcb_al_dl:
>        0xffffffff8105f5f0 <+0>:  adc    %dl,%al
>        0xffffffff8105f5f2 <+2>:  jmp    0xffffffff81a39270 <__x86_return_thunk>
>
> A major motivation for doing fast emulation is to leverage the CPU to
> handle consumption and manipulation of arithmetic flags, i.e. RFLAGS is
> both an input and output to the target of the call.  fastop() collects
> the RFLAGS result by pushing RFLAGS onto the stack and popping them back
> into a variable (held in RDI in this case)
>
>    asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
>
>        0xffffffff81062be7 <+71>: mov    0xc0(%r8),%rdx
>        0xffffffff81062bee <+78>: mov    0x100(%r8),%rcx
>        0xffffffff81062bf5 <+85>: push   %rdi
>        0xffffffff81062bf6 <+86>: popf
>        0xffffffff81062bf7 <+87>: call   *%rsi
>        0xffffffff81062bf9 <+89>: nop
>        0xffffffff81062bfa <+90>: nop
>        0xffffffff81062bfb <+91>: nop
>        0xffffffff81062bfc <+92>: pushf
>        0xffffffff81062bfd <+93>: pop    %rdi
>
> and then propagating the arithmetic flags into the vCPU's emulator state:
>
>      ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
>
>        0xffffffff81062be0 <+64>:  and    $0xfffffffffffff72a,%r9
>        0xffffffff81062bfe <+94>:  and    $0x8d5,%edi
>        0xffffffff81062c0d <+109>: or     %rdi,%r9
>        0xffffffff81062c1a <+122>: mov    %r9,0x10(%r8)
>
> The failures can be most easily reproduced by running the "emulator" test
> in KVM-Unit-Tests.
>
> If you're feeling a bit of deja vu, see commit b63f20a778c8
> ("x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386").
>
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Closes: https://lore.kernel.org/all/de474347-122d-54cd-eabf-9dcc95ab9eae@amd.com
> Cc: stable@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> Those that fail to learn from history are doomed to repeat it. :-D
>
>   arch/x86/lib/retpoline.S | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 2cff585f22f2..132cedbf9e57 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -164,7 +164,7 @@ __EXPORT_THUNK(srso_untrain_ret_alias)
>   /* Needs a definition for the __x86_return_thunk alternative below. */
>   SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
>   #ifdef CONFIG_CPU_SRSO
> -	add $8, %_ASM_SP
> +	lea 8(%_ASM_SP), %_ASM_SP
>   	UNWIND_HINT_FUNC
>   #endif
>   	ANNOTATE_UNRET_SAFE
> @@ -239,7 +239,7 @@ __EXPORT_THUNK(zen_untrain_ret)
>    * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
>    * above. On kernel entry, srso_untrain_ret() is executed which is a
>    *
> - * movabs $0xccccccc308c48348,%rax
> + * movabs $0xccccc30824648d48,%rax
>    *
>    * and when the return thunk executes the inner label srso_safe_ret()
>    * later, it is a stack manipulation and a RET which is mispredicted and
> @@ -252,11 +252,10 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>   	.byte 0x48, 0xb8
>   
>   SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
> -	add $8, %_ASM_SP
> +	lea 8(%_ASM_SP), %_ASM_SP
>   	ret
>   	int3
>   	int3
> -	int3
>   	lfence
>   	call srso_safe_ret
>   	int3
>
> base-commit: 25aa0bebba72b318e71fe205bfd1236550cc9534

Don't we have the same kind of problems with __x86_return_skl ?

--Mika

