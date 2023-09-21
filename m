Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2A7A9A53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjIUSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjIUShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:37:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0DAB15D1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8FiCh+y4E98Zo5U/kfJCKQic4u/7gML7qDt1+4wDSpY=; b=tAOCSic5y8jvDpvNEmQ4NqIRs0
        4Qco9h11XXnRRSnU+USX+S+phHeRZ8pKrsu2PO79KxZPYHOliEqro20YVk7rbOkkrODLYBHCQuD8B
        DkotQB8dcqdq0DWlMmkR+776bOQw3ncssEdXKj9xoKYw0VpwyPSNcoGWhX2ftPT+aYRvhKrJnWmNc
        tkPkO/G42fcV936P7EwsBdjqGtYLYBjtokIwQCcxOqC8CwXQmbbzmhK10YN/OOB+4/R64mth2bzSi
        iciso8WQib+fFk13ZBcxtl39u3KMWDKZPrlxP9AC2ulZiRj/QxRHvYil5AM24d6zJM3DLkw2iR+wt
        rCyMHy7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjLiM-00Ceec-EW; Thu, 21 Sep 2023 15:35:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E62783002E3; Thu, 21 Sep 2023 17:35:37 +0200 (CEST)
Date:   Thu, 21 Sep 2023 17:35:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for
 annotations
Message-ID: <20230921153537.GG14803@noisy.programming.kicks-ass.net>
References: <20230920001728.1439947-1-maskray@google.com>
 <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:58:13AM -0700, Fangrui Song wrote:
> On Thu, Sep 21, 2023 at 12:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 19, 2023 at 05:17:28PM -0700, Fangrui Song wrote:
> > > .discard.retpoline_safe sections do not have the SHF_ALLOC flag.  These
> > > sections referencing text sections' STT_SECTION symbols with PC-relative
> > > relocations like R_386_PC32 [0] is conceptually not suitable.  Newer
> > > LLD will report warnings for REL relocations even for relocatable links
> > > [1].
> > >
> > >     ld.lld: warning: vmlinux.a(drivers/i2c/busses/i2c-i801.o):(.discard.retpoline_safe+0x120): has non-ABS relocation R_386_PC32 against symbol ''
> >
> > What, why ?!? Please explain more.
> 
> This can be read as a pedantic warning from the linker.
> 
> A location relocated by an R_386_PC32 relocation in
> .discard.retpoline_safe records an offset from the current location
> (non-allocable) to an text symbol.
> This offset is conceptually not suitable: in the ELF object file
> format's model, the non-SHF_ALLOC section is not part of the memory
> image, so
> we cannot say that the offset from the non-memory thing to a text
> symbol is a fixed value.

Bah, so why has this worked at all then? Clearly the linkers aren't very
strict about things.

Anyway, I think what we want is to just mark the section SHF_ALLOC. The
reason is that one of the plans we have is to collapse all the different
annotations into a single section and then have something like:

	struct objtoo_annotation {
		s32 location;
		u32 type;
	}

So that we can easily extend the annotations and don't need to add
yet-another-section-reader-function to objtool.

This is just one of the things we've not gotten around to yet. But as
is, we have:

	.discard.unreachable
	.discard.reachable
	.discard.func_stack_frame_non_standard
	.discard.ignore_alts
	.discard.unwind_hints
	.discard.noendbr
	.discard.retpoline_safe
	.discard.instr_end
	.discard.instr_begin
	.discard.validate_unret
	.discard.intra_function_calls

And with the exception of unwind_hints, they're all just trivial
location things.

The very last thing we need is yet more of that.

If we were to use absolute things, we get 12 byte entries and while that
probably wouldn't spell the end of the world, why make thing larger than
they have to be.

After all, its not like any of this actually survives the final link.
