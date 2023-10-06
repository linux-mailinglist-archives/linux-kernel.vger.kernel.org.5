Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5D7BBF70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjJFTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:00:23 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4983
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:00:21 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 396IxRWb3218218
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 6 Oct 2023 11:59:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 396IxRWb3218218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1696618769;
        bh=X10h9J5+8xclf3CIzFlm1F1rPBhZ3K0Y0x/q2MKTwuw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EzORMut2FyGa9lR2P5RJTkFRVHcKh4Ute0otYht4dqAyKrWgcStNXxnHupOVPJUZv
         eHeGQznmlPdeNbzCGMnMENi2su7NOy0k4bMvQ3D2Jb0E+/swaunNx34pTQdzStvXUu
         YNHxFoBnm0FW307K5tOamTgywQkoMA9bXl1y5uJKpw3tHU9v08Q7wQyKHufkFvcG9/
         sITRF728JoZuy7Stz/vqIewiS41S1S6Tpn4BUCt2t6fI9SiGIyZZCxleYBpEWljZhI
         m3nrvu2bKIFItdRiM5q3T98G6k6WsH9Zc0OONAmPnl8GdiHm6rWzX0oB5xQEz0DGQQ
         Hln0DWnorEHDg==
Message-ID: <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
Date:   Fri, 6 Oct 2023 11:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
To:     Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
 <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <ZR8an4+JbkLS8/Ol@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 13:20, Ingo Molnar wrote:
> 
> * Brian Gerst <brgerst@gmail.com> wrote:
> 
>> Looking at the compiled output, the only suboptimal code appears to be
>> the canonical address test, where the C code uses the CL register for
>> the shifts instead of immediates.
>>
>>   180:   e9 00 00 00 00          jmp    185 <do_syscall_64+0x85>
>>                          181: R_X86_64_PC32      .altinstr_aux-0x4
>>   185:   b9 07 00 00 00          mov    $0x7,%ecx
>>   18a:   eb 05                   jmp    191 <do_syscall_64+0x91>
>>   18c:   b9 10 00 00 00          mov    $0x10,%ecx
>>   191:   48 89 c2                mov    %rax,%rdx
>>   194:   48 d3 e2                shl    %cl,%rdx
>>   197:   48 d3 fa                sar    %cl,%rdx
>>   19a:   48 39 d0                cmp    %rdx,%rax
>>   19d:   75 39                   jne    1d8 <do_syscall_64+0xd8>
> 
> Yeah, it didn't look equivalent - so I guess we want a C equivalent for:
> 
> -       ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
> -               "shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
> 
> instead of the pgtable_l5_enabled() runtime test that
> __is_canonical_address() uses?
> 

I don't think such a thing (without simply duplicate the above as an 
alternative asm, which is obviously easy enough, and still allows the 
compiler to pick the register used) would be possible without immediate 
patching support[*].

Incidentally, this is a question for Uros: is there a reason this is a 
mov to %ecx and not just %cl, which would save 3 bytes?

Incidentally, it is possible to save one instruction and use only *one* 
alternative immediate:

	leaq (%rax,%rax),%rdx
	xorq %rax,%rdx
	shrq $(63 - LA),%rdx		# Yes, 63, not 64
	# ZF=1 if canonical

This works because if bit [x] is set in the output, then bit [x] and 
[x-1] in the input are different (bit [-1] considered to be zero); and 
by definition a bit is canonical if and only if all the bits [63:LA] are 
identical, thus bits [63:LA+1] in the output must all be zero.

The first two instructions are pure arithmetic and can thus be done in C:

	bar = foo ^ (foo << 1);

... leaving only one instruction needing to be patched at runtime.

	-hpa



[*] which is a whole bit of infrastructure that I know first-hand is 
extremely complex[**] -- I had an almost-complete patchset done at one 
time, but it has severely bitrotted. The good part is that it is 
probably a lot easier to do today, with the alternatives-patching 
callback routines available.

[**] the absolute best would of course be if such infrastructure could 
be compiler-supported (probably as part as some really fancy support for 
alternatives/static branch), but that would probably be a nightmare to 
do in the compiler or a plugin.


