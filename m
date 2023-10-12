Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C437C789D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442918AbjJLVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJLVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:30:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655CA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:30:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2007FC433C7;
        Thu, 12 Oct 2023 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697146240;
        bh=yKRnRXKOfRmE25XMyAXq5WWfuyzH78vRJa2eFaPofP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrjFVlVulI8NyvKWHty4htvgfCyc+2h9h2fODc/g94+FbevWA2zHcWfyZXlv7IkFh
         Pnitx/QdldQhcWfKCYltDme63QDg2x8CfVDxL2Qp7h644hoLMePFyfIEgXCY9jQzTa
         yTrX1osr3u0pJbtgbFXprHtZ2ZwXb663L2AZxyLGO3wOf5FMxdhE/DUt2F+l/r81JZ
         LD+VgIujQsJqKbA9GM8Yht63K4AiTUX0N3la7IFYq7ar+4zww1RmUaEwyPU4cnsLqS
         wqagL4r55amWO8yWmbDf9iUv+uTkPt8KJg9KVPkfCyD+Tf0gNdBETEUYeOkIgBggcV
         EG9za3UQP2e5g==
Date:   Thu, 12 Oct 2023 14:30:38 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <20231012213038.pnq6eds53dbqxstj@treble>
References: <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
 <20231012013507.jrqnm35p7az6atov@treble>
 <ZSeP4vwQ9k/v63Cy@gmail.com>
 <20231012160801.blc2t37gfqhlah5h@treble>
 <ZSg0D0bRlzXdqZRS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSg0D0bRlzXdqZRS@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 07:59:43PM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Thu, Oct 12, 2023 at 08:19:14AM +0200, Ingo Molnar wrote:
> > > 
> > > * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > 
> > > > Though, another problem is that .text has a crazy amount of padding
> > > > which makes it always the same size, due to the SRSO alias mitigation
> > > > alignment linker magic.  We should fix that somehow.
> > > 
> > > We could emit a non-aligned end-of-text symbol (we might have it already),
> > > and have a script or small .c program in scripts/ or tools/ that looks
> > > at vmlinux and displays a user-friendly and accurate list of text and
> > > data sizes in the kernel?
> > > 
> > > And since objtool is technically an 'object files tool', and it already
> > > looks at sections & symbols, it could also grow a:
> > > 
> > > 	objtool size <objfile>
> > > 
> > > command that does the sane thing ... I'd definitely start using that, instead of 'size'.
> > > 
> > > /me runs :-)
> > 
> > Yeah, that's actually not a bad idea.
> > 
> > I had been thinking a "simple" script would be fine, but I'm realizing
> > the scope of this thing could grow over time.  In which case a script is
> > less than ideal.  And objtool already has the ability to do this pretty
> > easily.
> 
> Yeah, and speed actually matters here: I have scripts that generate object 
> comparisons between commits, and every second of runtime counts - and a 
> script would be slower and more fragile for something like allmodconfig 
> builds or larger disto configs.

Ah, good to know.

> BTW., maybe the right objtool subcommand would be 'objtool sections', with 
> an 'objtool sections size' sub-sub-command. Because I think this discussion 
> shows that it would be good to have a bit of visibility into the sanity of 
> our sections setup, with 'objtool sections check' for example doing a 
> sanity check on whether there's anything extra in the text section that 
> shouldn't be there? Or so ...

What would be an example of something "extra"?  A sanity check might fit
better alongside the other checks already being done by the main objtool
"subcommand" which gets run by the kernel build.

BTW, I actually removed subcommands a while ago when I overhauled
objtool's interface to make it easier to combine options.  That said,
I'm not opposed to re-adding them if we can find a sane way to do so.

Here's the current interface:

 Usage: objtool <actions> [<options>] file.o

Actions:
    -h, --hacks[=<jump_label,noinstr,skylake>]
                          patch toolchain bugs/limitations
    -i, --ibt             validate and annotate IBT
    -l, --sls             validate straight-line-speculation mitigations
    -m, --mcount          annotate mcount/fentry calls for ftrace
    -n, --noinstr         validate noinstr rules
    -o, --orc             generate ORC metadata
    -r, --retpoline       validate and annotate retpoline usage
    -s, --stackval        validate frame pointer rules
    -t, --static-call     annotate static calls
    -u, --uaccess         validate uaccess rules for SMAP
        --cfi             annotate kernel control flow integrity (kCFI) function preambles
        --dump[=<orc>]    dump metadata
        --prefix <n>      generate prefix symbols
        --rethunk         validate and annotate rethunk usage
        --unret           validate entry unret placement

Options:
    -v, --verbose         verbose warnings
        --backtrace       unwind on error
        --backup          create .orig files before modification
        --dry-run         don't write modifications
        --link            object is a linked object
        --mnop            nop out mcount call sites
        --module          object is part of a kernel module
        --no-unreachable  skip 'unreachable instruction' warnings
        --sec-address     print section addresses in warnings
        --stats           print statistics


Note how all the actions can be easily combined in a single execution
instance.

If we re-added subcommands, most of the existing functionality would be
part of a single subcommand.  It used to be called "check", but it's no
longer a read-only operation so that's misleading.  I'll call it "run"
for now.

Right now my preference would be to leave the existing interface as-is,
and then graft optional subcommands on top.  If no subcommand is
specified then it would default to the "run" subcommand.  It's a little
funky, but it would work well for the common case, where ~99% of the
functionality lives.  And it doesn't break existing setups and
backports.

For example:

  # current interface (no changes)
  objtool --mcount --orc --retpoline --uaccess vmlinux.o

  # same, with optional explicit "run" subcommand
  objtool run --mcount --orc --retpoline --uaccess vmlinux.o

  # new "size" subcommand
  obtool size [options] vmlinux.o.before vmlinux.o.after

-- 
Josh
