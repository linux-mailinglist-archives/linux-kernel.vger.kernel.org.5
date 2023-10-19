Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CCE7CF184
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJSHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJSHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:43:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C28B6;
        Thu, 19 Oct 2023 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9mnHWCvj7nBYGABXmxzYKP27v8fhXB//VHIMzUSyq88=; b=H6QUdqDnlPSm/VF5tTCY9c5+9q
        cfJ/qQqVVzgQgYWw5CHwBWWlp+NLpSDdXbUdBEQxfLNfzrMkfPRc70ta90AND5CLwgcGNIcYJEP5P
        mn2oLwxct5c2miFqwQXnyemT3OvSoHYVoE1mRL2LvNG8CniQY9LA7YZy2yIqGfr6PDh29i/YBxQbj
        86r18rLJbioQBkhgdku4SVuIp/Td90YhLYLdEh0fvWVDjHW6wfFxTLKfAH4sHmYncpWadayzmG/Ba
        95wtue8RgD0XfcuLKOqUtsFRhnY/19ZNbB2idcbnSPrj1YEKOTDonoQr/UUZAVaiUKuDbhDef6B3S
        te8ogUZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtNh0-009gqh-2m;
        Thu, 19 Oct 2023 07:43:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8693D300392; Thu, 19 Oct 2023 09:43:42 +0200 (CEST)
Date:   Thu, 19 Oct 2023 09:43:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019074342.GL33217@noisy.programming.kicks-ass.net>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:37:47PM +0200, Borislav Petkov wrote:

> And here's the fix:
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 73be3931e4f0..50d64f5226f4 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -748,14 +748,20 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>                         continue;
>  
>                 op = insn.opcode.bytes[0];
> -               if (op == JMP32_INSN_OPCODE)
> +               if (op == JMP32_INSN_OPCODE || op == JMP8_INSN_OPCODE)
>                         dest = addr + insn.length + insn.immediate.value;
>  
> 
> I'd still prefer the revert, though, that close to the MW. We can work
> at those things later, at leisure.

Yet another fall-out from removing the section... When in it's own
section the compiler must emit long form jump because it doesn't know
where the target is.

Now, not so much.

Anyway, yes, that seems trivial enough as a fix.
