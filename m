Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6B7778A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjHJMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHJMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:38:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C792683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qjcwHXNSZFB3GDpj1vYwr7QB6rAz99yRYpEqM4iSpE4=; b=PUkcDF7WgSFW7MVBwU+3yqPDYQ
        UpjOSmsZfJENw5Sa2k9vHMGcTtef/K7UZ/tqgIfO71D4xPjET1wTcdpiHSvr+FTmpL778K77G4i2Y
        BMgoGVGChBVhfNK/ggOov+NOb/HR05yfFEYxgCq+gb34fyBMQC0kAcahNF50CV8MAaeu3diZIjh2C
        R28P8+0onqw6CwnnngPt3mVVDupys0/8Jot4OXvwh+W2GeMfObhpSTNO6qEzTOdl+rxB/XpBDXT4I
        rihaz8n5p53oFkRrc8whu0pAdGelZi/0wfgmY1B3kMeZPq0fDMnColcnGBxnn/5DA4mNCCOmXYMUI
        5TMIRTCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qU4vN-006UU2-0e;
        Thu, 10 Aug 2023 12:37:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 933FE30003A;
        Thu, 10 Aug 2023 14:37:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79F90202C598B; Thu, 10 Aug 2023 14:37:56 +0200 (CEST)
Date:   Thu, 10 Aug 2023 14:37:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230810123756.GY212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:51:48PM +0200, Borislav Petkov wrote:
> On Wed, Aug 09, 2023 at 09:12:20AM +0200, Peter Zijlstra wrote:
> > Where Zen1/2 flush the BTB using the instruction decoder trick
> > (test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in
> 
> BTB aliasing.
> 
> > AMD speak) stuffing to force a return mis-predict.
> 
> No it doesn't. It causes BTB aliasing which evicts any potentially
> poisoned entries.

It does; so zen1/2 use the decoder thing to flush BTB entry of the RET,
both retbleed and srso do.

Then zen3/4 use the aliassing trick to flush the BTB entry of the RET.

Then both srso options use RSB/RAP stuffing to force a mispredict there.
Retbleed doesn't do this.

retbleed is about BTB, srso does both BTB and RSB/RAP.

> > That is; the AMD retbleed is a form of Speculative-Type-Confusion
> > where the branch predictor is trained to use the BTB to predict the
> > RET address, while AMD inception/SRSO is a form of
> > Speculative-Type-Confusion where another instruction is trained to be
> > treated like a CALL instruction and poison the RSB (RAP).
> 
> Nope, Andy explained it already in the 0th message.

I'm still of the opinion that branch-type-confusion is an integral part
of setting up the srso RSB/RAP trickery. It just targets a different
predictor, RSB/RAP vs BTB.

> > Pick one of three options at boot.
> 
> Yes, provided microarchitecturally that works, I'm all for removing the
> __ret alternative.

So this patch doesn't actually change anything except one layer of
indirection.

Your thing does:

SYNC_FUNC_START(foo)
	...
	ALTERNATIVE "ret; int3",
		    "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
SYM_FUNC_END(foo)

SYM_FUNC_START(__x86_return_thunk)
	ALTERNATIVE("jmp __ret",
		    "call srso_safe_ret", X86_FEATURE_SRSO,
		    "call srso_alias_safe_ret", X86_FEATURE_SRSO_ALIAS);
	int3
SYM_FUNC_END(__x86_return_thunk)


So what was RET, jumps to __x86_return_thunk, which then jumps to the
actual return thunk.

After this patch things look equivalent to:

SYM_FUNC_START(foo)
	...
	ALTERNATIVE "ret; int3"
		    "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
		    "jmp srso_return_thunk, X86_FEATURE_SRSO
		    "jmp srsi_alias_return_thunk", X86_FEATURE_SRSO_ALIAS
SYM_FUNC_END(foo)

SYM_CODE_START(srso_return_thunk)
	UNWIND_HINT_FUNC
	ANNOTATE_NOENDBR
	call srso_safe_ret;
	ud2
SYM_CODE_END(srso_return_thunk)

SYM_CODE_START(srso_alias_return_thunk)
	UNWIND_HINT_FUNC
	ANNOTATE_NOENDBR
	call srso_alias_safe_ret;
	ud2
SYM_CODE_END(srso_alias_return_thunk)


Except of course we don't have an actual ALTERNATIVE at the ret site,
but .return_sites and rewriting things to either "ret; int3" or whatever
function is in x86_return_thunk.


Before this patch, only one ret thunk is used at any one time, after
this patch still only one ret thunk is used.

fundamentally, you can only ever use one ret.

IOW this patch changes nothing for SRSO, it still does a jump to a call.
But it does clean up retbleed, which you had as a jump to a jump, back
to just a jump, and it does get rid of that extra alternative layer yo
had by using the one we already have at .return_sites rewrite.

