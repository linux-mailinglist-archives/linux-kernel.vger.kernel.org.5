Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82B7C605C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjJKWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJKWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:35:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B9A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/rH5k2R7fy3EeoPgRJEoHWfNJ/FGZ9dJZ3C37UjXiug=; b=Z6IWx8ByB3DoEZ2EIT+qjX8EQa
        ZxbWN/kHMTDoa81yCjS+9XYW39v1HJtZvs8H8OfAnYGTr9BWf7eRHBk8k1B7BxtuwlU4w5F9FjWWh
        4KDJvxkeS4nFPl/xOSR0ipDBBiDQ9WdIQEfBDT+Z1ylgBBuFge/EzwnV7IsZa6ea789lnBk9jDFwF
        uFRj4qf/vm2MlLY+5d2ZnO0LY2x+Cay4YbhnOfmyOWPLbPyp/txQDW5/ADsw9YQb0aCCI4G0nubYN
        Cdgakk0iJYklupjo9DKOdh30WQUQdMUVuEx3H3ouEwmA4ZMijq69m/aZMF45NmJEENFZNHoILhcfk
        GeTLzaPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqhnM-000ZjG-23;
        Wed, 11 Oct 2023 22:35:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB88D30036C; Thu, 12 Oct 2023 00:35:13 +0200 (CEST)
Date:   Thu, 12 Oct 2023 00:35:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231011223513.GH6307@noisy.programming.kicks-ass.net>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011162843.grv6kixw4ides6uw@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:28:43AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 11, 2023 at 09:41:42AM +0200, Peter Zijlstra wrote:
> > > +++ b/tools/objtool/check.c
> > > @@ -1610,6 +1610,15 @@ static int add_jump_destinations(struct objtool_file *file)
> > >  			return -1;
> > >  		}
> > >  
> > > +		/*
> > > +		 * Since retpolines are in the same section as the return
> > > +		 * thunk, they might not use a relocation when branching to it.
> > > +		 */
> > > +		if (jump_dest->sym && jump_dest->sym->return_thunk) {
> > > +			add_return_call(file, insn, true);
> > > +			continue;
> > > +		}
> > 
> > *urgh*... I mean, yes, that obviously works, but should we not also have
> > the retpoline thingy for consistency? That case makes less sense though
> > :/
> 
> Consistency with what? 

the reloc case; specifically, I was thinking something along these
lines:

		if (jump-dest->sym && jump_dest->sym->retpoline_thunk) {
			add_retpoline_call(file, insn);
			continue;
		}

Then both reloc and immediate versions are more or less the same.

> The extra section seems pointless but maybe I'm missing something.

By having the section things are better delineated I suppose, be it
retpolines or rethunks, all references should be to inside the section
(and thus have a reloc) while within the section there should never be a
reference to itself.

I'm not sure it's worth much, but then we can have the above two cases
issue a WARN instead of fixing it up.

I don't care too deeply, I can't make up my mind either way. But perhaps
keeping the section is easier on all the backports, it's easy to forget
a tiny objtool patch like this.
