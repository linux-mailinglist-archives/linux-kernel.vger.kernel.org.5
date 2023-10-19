Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F327CFC42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbjJSOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbjJSOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:15:35 -0400
X-Greylist: delayed 71571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 07:15:32 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC843126;
        Thu, 19 Oct 2023 07:15:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB51C40E01B1;
        Thu, 19 Oct 2023 14:15:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yc603s0_Sao9; Thu, 19 Oct 2023 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697724928; bh=AvTen/Ml62tmp1Mem7EkFWKLUmw/SFRMP/MUyGnMe9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HePWEr8ratskmxLmxjDUBwmb08QxisK8uWR2d/H5KInbJN7W2FsE+NQ4U++nrVRRg
         veCuoIUyFsI8j4+fF1KLimIhctX1o+ng/xFN9RajYP0O5H4oeo8W5vfdgvvXhATfph
         yNO/xgiCLH6voylP8XQfeIG8xMyNCaedsVcNiGsErVMVylpZtOluqSC6W6dFGHbMvr
         BqAhAzexrnQuK/1j2Sd8+wCwKt3TUEizI/Mn2KfaodihT3Sx10T4Hotm/RjH5b9fhN
         ECAMDY84eF/HX3ALFfTVtdSXvDZucuLYdiY8veFIHS7k1xdkIgEex5oaiSOF/8R1LA
         7sqOaM0mQHK391seRHJljQUCGVRJtj0rt5CAzXYEdy484afIJOXq7rZjH00oakTNDC
         M8NoOjOggbOdbea/tsMRHUO3PtRfwhPquPpsehoLQvUvwbm2BqmaPul23NtjIJyBIl
         0mu97YMUKJvEfX6KjppHQLI3FCvk9MF0eSBNKXK5h5X3aCdUL4lshdsIGmExVzK8jN
         NI6RWB5XWcrxLYgHKl5P5VT/QJBC6jP5GMOu5vH64F/6NX3QI775AsD6GsrOGMiSON
         /L1PHi3czxH7s2Jvz8f4OgUZ8tehxO+X9er0ix16KS9n50D9uMyqBwFvJvz4fDmw1e
         frs/VbH800iqRQEzq69AnGiw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 034BD40E0196;
        Thu, 19 Oct 2023 14:15:19 +0000 (UTC)
Date:   Thu, 19 Oct 2023 16:15:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019065928.mrvhtfaya22p2uzw@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:59:28PM -0700, Josh Poimboeuf wrote:
> One last idea, since the return thunk is used everywhere (even non-ABI
> compliant functions) it might be possible the "call check_thunks" (and
> its call to warn_printk) is clobbering some registers which some code
> (exception handling entry code?) doesn't appreciate.

Yeah, that is still unclean, I'd say. gcc doesn't know that we patch in
a CALL insn in the alternative. What should work is to have

	alternative_call

there which alternates between two calls and gcc knows there's a call so
it can act accordingly wrt callee-* regs.

Considering how __x86_return_thunk is there only until alternatives have
run, we could do something like

	ALTERNATIVE_CALL nop, check_thunks

where nop is a function which doesn't do anything.

I say "ALTERNATIVE_CALL" because we don't have a _CALL asm macro yet.

And then in check_thunks() we can do all kinds of screaming, tainting
and setting mitigation status to vulnerable, etc.

Anyway something along those lines.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
