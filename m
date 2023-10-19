Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE507CF74C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjJSLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjJSLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:45:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0E12F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:45:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697715948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WkIseThtqqkqJdqE76wGJCr8yEVr/2wrAgKQK4g43g=;
        b=NjRZD3mgYBR/EeYyoe4q65yYpso4lxg0KgDFPHilF0RYDXjKDhqU8FeZfOsOEt3twtFiqq
        oYftZPR4msfIsNnK+PABDSKJrOekIANn8dJMCsYhy+jIuxq7lPy11CnwPihF33NgF6pWi1
        alfZFbPzPKPuK4UM+ELlV67ZS9Zs0VESm8mhui0cyr4Dan2GztLfNc7pbExTncsL5Kdkve
        3oLgYopkLvnlwdPRvSUQxN9KeTNI6OkG3xj7hTg1zR+H2NlMm5ezXsN4JOaW8CkKVCfz9Z
        OQasGawJBpDiLJuBmtnfDCE2MrbAe8GyWwaAwf6A+2PBN6ttEYq5z0IPEiR3Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697715948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WkIseThtqqkqJdqE76wGJCr8yEVr/2wrAgKQK4g43g=;
        b=CBE2B6CtltTOfcFiZ4T3D7y7eohi+GshuTdABTLDmANJeP7xhi9+UFECSVAe3QkRSz+4/p
        0rUNX+ie5qTzGUAw==
To:     Al Viro <viro@zeniv.linux.org.uk>,
        gus Gusenleitner Klaus <gus@keba.com>
Cc:     Al Viro <viro@ftp.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
In-Reply-To: <20231019063925.GX800259@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
Date:   Thu, 19 Oct 2023 13:45:48 +0200
Message-ID: <87wmvi3ker.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023 at 07:39, Al Viro wrote:
> On Thu, Oct 19, 2023 at 07:14:27AM +0100, Al Viro wrote:
>> > > Here's our situation:
>> > > Our device gets pinged by a third party manufacturer robot controller.
>> > > We have updated the kernel in our device to 5.15 from 4.9, the robot
>> > > controller is kept unchanged. At 4.9, our device's ping reply is accepted
>> > > by the robot controller, at 5.15 it's not.
>> > > 
>> > > Wireshark shows a bad checksum warning:
>> > >  'Checksum: 0x0000 incorrect, should be 0xffff' 
>> > > 
>> > 
>> > Lovely.  I think I see what's going on, give me a few to think about it...
>> 
>> The real source of trouble was switching csum_and_copy_{to,from}_user()
>> to reporting faults as 0.  And yes, it's broken.  Bugger...
>
> I really hate the idea of bringing back the old horrors and splitting
> _nocheck and _user variants ;-/  Especially since we don't care (and
> never had, really) where in the EFAULT case had the damn thing faulted
> and what csum had it managed to accumulate prior to that point.
>
> The only callers are csum_and_copy_..._iter() and they discard
> the entire iovec segment if fault happens; all users of
> csum_and_copy_from_iter() are actually discarding everything in
> that case (reverting iterator to the point where it had been
> prior to the call).
>
> And they are all thread-synchronous.  Hell, it's tempting to steal
> a thread flag, clear it before the call of those suckers, set it in
> exception handlers in those and check in csum_and_copy_..._iter()
> after the call...  Let me see how ugly something of that sort would
> be...

Eew. That's horrible.

The checksum is strictly 16bit. __wsum is 32bit (for whatever
reason). So you can differentiate between error and valid checksum
easily by using bit 16-31 as indicator for fail or success, no?

Something like the incomplete below.

Thanks,

        tglx

---
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -194,6 +194,9 @@ SYM_FUNC_START(csum_partial_copy_generic
 .Lende:
 	testq %r10, %r10
 	js  .Lwas_odd
+
+.Lsuccess:
+	orl $0xFF00, %eax
 .Lout:
 	movq 0*8(%rsp), %rbx
 	movq 1*8(%rsp), %r12
@@ -247,7 +250,7 @@ SYM_FUNC_START(csum_partial_copy_generic
 
 .Lwas_odd:
 	roll $8, %eax
-	jmp .Lout
+	jmp .Lsuccess
 
 	/* Exception: just return 0 */
 .Lfault:
