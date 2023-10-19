Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535927CFD00
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjJSOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbjJSOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:06 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492D13D;
        Thu, 19 Oct 2023 07:40:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC77040E0187;
        Thu, 19 Oct 2023 14:40:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GAEMYLTle8OJ; Thu, 19 Oct 2023 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697726400; bh=cZwK9x89mo9GWD6pGRjp0GF65LecA8F0ra0gDgvQOAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJC66fvVWHut2ol07FMXyRKJ30GGYSEgxoNT4iYGoeqk0EFqrvLPTlQ2U+eixE7Wz
         KTvzaYeiDipWe1D0F2ARjjaSwtOmPluZ/UEc6AwtbDC9xTf2+PuiUQGZPcS+T0TpfZ
         osJlGC/GLswi1keBwHKflD2N1PQ+tb4Jg3JBhfo2QGoj4qFyMMMr1q8KPj8aJcxJMx
         jSALpIEmCzhLdCZAvzpWv7ffUcZz3aXqZticBt10z1JD0qAVXbLpeYYkaGzULC54Op
         D21XiBY482pLXOtIu/3QYtF4tAHka/5R3erPKl/aDqoo0SsqH/Dak2bXhkyGgOJN8E
         qH7xIKBgPUzwaDGz+syM/3sf9aFjmchP8BPSGAwPvCQxlDeUqNUbrZnPNsKs0XRE8Z
         3/oKekt1F0T3UGwOtMvlfSRlPSPwpVwu/g5I3dFzgAAYk0NKmLYF658guhi7TQ44Rf
         CvtSb2t+mmfj9ACjMjdAKfwApuakt1LQMAMy1f22e28x7oLXk0mpUJqOp/kOlgHyTO
         ge7unMgtnetlVRct5LNSC3EoyHMkTdsQHV0RspGcG/PsrLI3MstNjPIZMQaTfKDoTI
         MCkrXK+CZXYg0tEONO62SsAC4Xk01JtscHpPpsAYGpAJP1704gfef44KVhEeekSzaQ
         MOeH4IrhBFV4n2bus4t7EIg4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E505940E01AF;
        Thu, 19 Oct 2023 14:39:51 +0000 (UTC)
Date:   Thu, 19 Oct 2023 16:39:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kaplan, David" <David.Kaplan@amd.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
References: <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:21:40PM +0000, Kaplan, David wrote:
> The return thunk is used for all functions though, including assembly
> coded functions which may use non-standard calling conventions and
> aren't visible to gcc.  I think the only safe thing would be to
> preserve all GPRs across the call to check_thunks.  Something like
> PUSH_REGS/call check_thunks/POP_REGS.

That call nop will be inside the return thunk. I.e., something like
this:

SYM_CODE_START(__x86_return_thunk)
        UNWIND_HINT_FUNC
        ANNOTATE_NOENDBR
        ANNOTATE_UNRET_SAFE
	ALTERNATIVE CALL nop, check_thunks, X86_FEATURE_ALWAYS
	ret
	int3
SYM_CODE_END(__x86_return_thunk)
EXPORT_SYMBOL(__x86_return_thunk)

I suspect that gcc doesn't know that there is a function call in the asm
there, which is also what you hint at - I need to ask a compiler guy.

But yeah, if it doesn't, then we'll need to push/pop regs as you
suggest.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
