Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D267C62BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJLC2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLC2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:28:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58EA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:28:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E7CC433C8;
        Thu, 12 Oct 2023 02:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697077680;
        bh=DwSnruvDLZm2BACGE5bcI0YnmOUBahsH9xaKnk3vS+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnsv7l2WXcL3pG8KFtdXJnoUNOGrD2Ic/YSDaBErHPazFutftPaAZ7lIW7mXTO/U+
         hBOZufAmlNnapiq5AR2ZWcjabwXHK3k0M/noG+5Vwr/V7R+FvGmnErMatj3UAf4wnc
         lVykjX1VLhx4SIeARTuUiOXap5RFTi85kAg+5cIFEHNuG/LsUkrFsr55z9fkvXqR/B
         u5OeCvJl/RblqvSe50ozQIqxjPcxpVUO0H6J6u7Z5QlfJXzM/c4cbX3dfCm4ivDfwu
         5DY+Ks/Nr854nygn8hziJSxR1ZCXaM0/Un1iq4BlJuaiRKGXmQpXmara8URagIlw3q
         XpljyyiS8nE5Q==
Date:   Wed, 11 Oct 2023 19:27:58 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231012022758.lf62lgf5jx5xrno7@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
 <20231011223513.GH6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011223513.GH6307@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:35:13AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2023 at 09:28:43AM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 11, 2023 at 09:41:42AM +0200, Peter Zijlstra wrote:
> > > > +++ b/tools/objtool/check.c
> > > > @@ -1610,6 +1610,15 @@ static int add_jump_destinations(struct objtool_file *file)
> > > >  			return -1;
> > > >  		}
> > > >  
> > > > +		/*
> > > > +		 * Since retpolines are in the same section as the return
> > > > +		 * thunk, they might not use a relocation when branching to it.
> > > > +		 */
> > > > +		if (jump_dest->sym && jump_dest->sym->return_thunk) {
> > > > +			add_return_call(file, insn, true);
> > > > +			continue;
> > > > +		}
> > > 
> > > *urgh*... I mean, yes, that obviously works, but should we not also have
> > > the retpoline thingy for consistency? That case makes less sense though
> > > :/
> > 
> > Consistency with what? 
> 
> the reloc case; specifically, I was thinking something along these
> lines:
> 
> 		if (jump-dest->sym && jump_dest->sym->retpoline_thunk) {
> 			add_retpoline_call(file, insn);
> 			continue;
> 		}
> 
> Then both reloc and immediate versions are more or less the same.

Ok, I see.  If somebody were to do a {JMP,CALL}_NOSPEC somewhere in
retpoline.S, it would break similarly.

It doesn't hurt to add that to the patch, that way retpoline/rethunk
site detection is all handled the same.

> > The extra section seems pointless but maybe I'm missing something.
> 
> By having the section things are better delineated I suppose, be it
> retpolines or rethunks, all references should be to inside the section
> (and thus have a reloc) while within the section there should never be
> a reference to itself.

As far as delineating things goes, a good argument could be made to
instead do that on the source code level.  i.e., put the rethunk code in
rethunk.S rather than retpoline.S.  Incidentally, that would also fix
this problem.

From an object code standpoint, objtool is the only one who cares about
the relocs.  It's a good idea to make objtool more robust against
non-relocs regardless, as the reloc assumption could always be broken
later by LTO.

BTW, I wonder if we can also get rid of .text..__x86.indirect_thunk and
just put most of the retpoline/rethunk code in .text (other than than
the SRSO aliasing hacks which still need special placement).

-- 
Josh
