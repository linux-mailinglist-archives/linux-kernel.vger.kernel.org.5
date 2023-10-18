Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962347CE0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345188AbjJRPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjJRPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:13:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC63EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:12:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697641977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWbCD44fa8QVirKg52i0pJ2hVvUN78k4QH9nUIrzJHg=;
        b=GL9uRMXnFSpPUnyQNAWR7y2CRX+ET2BiPsHirmg3JfZFt+XKLeq9cdmHVUkI/110VEtK4Q
        pgmlehtrcyBA02gLsQE7HSv4QBwWBLKZxw6TmyxEtQwaHoWtq4IEFs2dgfzPGNtFOmqMPL
        52ys2nP9mZ9XxWwdEfvB0K3Nlt3UGwe4puHtMmZ7Pa2/MByBtmnnLEwa8lE1jVm1lz7ckW
        fEA3z1sh4iAmCeNE5isRI1iVu2YKrD4u/+N7TUwhe0rhviRr+7xk+ksvIArHBjrM2BVyR9
        IZk/VKcfgCxVIRDEObsJavElEWWtHLl2YXf7eUbhtwqYPmYXwVILQBbPjvufNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697641977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWbCD44fa8QVirKg52i0pJ2hVvUN78k4QH9nUIrzJHg=;
        b=FwbseROgTqJr+slcTXr6QCw5kB9AwpvNLuGlrlaWhPiaxUFmDaCblnY5WR9SdZp5svE8+c
        Hf1y5Ht4/GfeDqCA==
To:     Eric Dumazet <edumazet@google.com>,
        gus Gusenleitner Klaus <gus@keba.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] amd64: Fix csum_partial_copy_generic()
In-Reply-To: <CANn89iLSKJroojadGD2hvec8EyeUA5TPMKd=PmBzCJ7h2HF0zA@mail.gmail.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <CANn89iLSKJroojadGD2hvec8EyeUA5TPMKd=PmBzCJ7h2HF0zA@mail.gmail.com>
Date:   Wed, 18 Oct 2023 17:12:57 +0200
Message-ID: <87h6mo3qx2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2023 at 09:36, Eric Dumazet wrote:
> On Wed, Oct 18, 2023 at 8:18=E2=80=AFAM gus Gusenleitner Klaus <gus@keba.=
com> wrote:
>>
>> The checksum calculation is wrong in case of an source buffer
>> containing zero bytes only. The expected return value is 0, the
>> actual return value is 0xfffffff.
>>
>> This problem occurs when a ICMP echo reply is sent that has set
>> zero identifier, sequence number and data.
>>
>> Signed-off-by: Klaus Gusenleitner <gus@keba.com>
>> ---
>>  arch/x86/lib/csum-copy_64.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
>> index d9e16a2cf285..c8391b4f3dea 100644
>> --- a/arch/x86/lib/csum-copy_64.S
>> +++ b/arch/x86/lib/csum-copy_64.S
>> @@ -44,7 +44,7 @@ SYM_FUNC_START()
>>         movq  %r13, 3*8(%rsp)
>>         movq  %r15, 4*8(%rsp)
>>
>> -       movl  $-1, %eax
>> +       movl  $0, %eax

I don't think this is correct. See below.

>>         xorl  %r9d, %r9d
>>         movl  %edx, %ecx
>>         cmpl  $8, %ecx
>> --
>> 2.30.2
>>
>
> Lets CC Noah Goldstein <goldstein.w.n@gmail.com> (I thought Noah wrote
> some kunit tests, maybe I am wrong)
>
> When was this bug added ?

AFAICT, this was introduced with:

daf52375c19f ("amd64: switch csum_partial_copy_generic() to new calling con=
ventions")

> A Fixes: tag is very much needed, and would be a needed step to CC the
> original author.

Cc'ed Al.

So the change in question is:

-	movl  %ecx, %eax        // Original code stores ECX in EAX
+	movl  $-1, %eax         // EAX is preset with -1

ECX (RCX) was the 4th parameter of the original ASM function call:

extern __visible __wsum csum_partial_copy_generic(const void *src, const vo=
id *dst,
                                        int len, __wsum sum,
                                        int *src_err_ptr, int *dst_err_ptr);

I.e. it handed @sum into the function which means a caller provided
seed.

With the above patch the ASM function call was changed to

extern __visible __wsum csum_partial_copy_generic(const void *src, void *ds=
t, int len);

I.e. the seed parameter was removed. AFAICT, all callers back then initiali=
zed
the seed parameter to 0 via the various wrapper interfaces which end up the=
re.

Al?

Thanks,

        tglx
