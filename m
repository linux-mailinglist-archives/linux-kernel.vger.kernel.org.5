Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5445B7C624E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjJLBfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJLBfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:35:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA8398
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:35:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16D4C433C7;
        Thu, 12 Oct 2023 01:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697074509;
        bh=5DoR2YU1D4xX1VebPXyELha2/iiGbD4A+95ErHCMFTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7oI5VfnN5Rp9fwb0qglShcsQIGWyf4nXG/2Ol784P1SLYZTdDgWhweoWiLjDBi2U
         mFi6CQ+nrIJTHtSfSR1RWc2dJn35V4C38xV71gz6ycXUg9laJVJu+HNdDqWy8kXcjM
         K5BGTvXytNrfQrhihQRmZS1pIe3Ok97yvwrdHJjY1gxRdFw9UF006RWTJDM1kZ5jLe
         GHnnN8OEhnk3X6Kue4Iga64X9bH2uOK6inzk+s1pzaTbtaVnYcMXQgS+HvkmLwpZMh
         C6qXuIDi6uLZZRXPnvAmwztk2ymIbVRM6Ys/1zNh24rE/wWZ6opdim7U14GTOUkz12
         QbM69cgmhHM8w==
Date:   Wed, 11 Oct 2023 18:35:07 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20231012013507.jrqnm35p7az6atov@treble>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:15:15PM -0700, H. Peter Anvin wrote:
> On 10/11/23 15:37, Ingo Molnar wrote:
> > 
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > > The only drawback is a larger binary size:
> > > > 
> > > >    text    data     bss     dec     hex filename
> > > > 25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
> > > > 25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o
> > > > 
> > > > that increases by 31k (0.123%), probably due to 1578 rdgsbase alternatives.
> > > 
> > > I'm actually surprised that it increases the text size. The 'rdgsbase'
> > > instruction should be smaller than a 'mov %gs', so I would have
> > > expected the *data* size to increase due to the alternatives tables,
> > > but not the text size.
> > > 
> > > [ Looks around ]
> > > 
> > > Oh. It's because we put the altinstructions into the text section.
> > > That's kind of silly, but whatever.
> > 
> > Yeah, we should probably move .altinstructions from init-text to .init.data
> > or so? Contains a bunch of other sections too that don't get executed
> > directly ... and in fact has some non-code data structures too, such as ...
> > ".apicdrivers". :-/
> > 
> > I suspect people put all that into .text because it was the easiest place
> > to modify in the x86 linker script, and linker scripts are arguably scary.
> > 
> 
> Well, it's more than that; "size" considers all non-writable sections to be
> "text".

Indeed, I added a printf to "size", it shows that all the following
sections are "text":

  .text
  .pci_fixup
  .tracedata
  __ksymtab
  __ksymtab_gpl
  __ksymtab_strings
  __init_rodata
  __param
  __ex_table
  .notes
  .orc_header
  .orc_unwind_ip
  .orc_unwind
  .init.text
  .altinstr_aux
  .x86_cpu_dev.init
  .parainstructions
  .retpoline_sites
  .return_sites
  .call_sites
  .altinstructions
  .altinstr_replacement
  .exit.text
  .smp_locks

I can't fathom why it doesn't just filter based on the EXECINSTR section
flag.

"size" is probably worse than useless, as many of these sections can
change size rather arbitrarily, especially .orc_* and .*_sites.

I can't help but wonder how many hasty optimizations have been made over
the years based on the sketchy output of this tool.

It should be trivial to replace the use of "size" with our own
"text_size" script which does what we want, e.g., filter on EXECINSTR.

Here are the current EXECINSTR sections:

  ~/git/binutils-gdb/binutils $ readelf -WS /tmp/vmlinux |grep X
    [ 1] .text             PROGBITS        ffffffff81000000 200000 1200000 00  AX  0   0 4096
    [21] .init.text        PROGBITS        ffffffff833b7000 27b7000 091b50 00  AX  0   0 16
    [22] .altinstr_aux     PROGBITS        ffffffff83448b50 2848b50 00176a 00  AX  0   0  1
    [30] .altinstr_replacement PROGBITS        ffffffff8372661a 2b2661a 0028b9 00  AX  0   0  1
    [32] .exit.text        PROGBITS        ffffffff83728f10 2b28f10 0030c7 00  AX  0   0 16

As Ingo mentioned, we could make .altinstr_replacement non-executable.
That confuses objtool, but I think we could remedy that pretty easily.

Though, another problem is that .text has a crazy amount of padding
which makes it always the same size, due to the SRSO alias mitigation
alignment linker magic.  We should fix that somehow.

-- 
Josh
