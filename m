Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DC77636F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHIPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHIPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:11:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A5210A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1hWM8PckxVZy/FdzezlkIxwbHFx4HslYBKnPJIunZS8=; b=Qfw2MhHcBlBkBVhgxsxOEFeHCd
        eLwMgoFynvh+30KxpUt5u8WugznEhdtVjziXE/OWKHXOqk3CI8Uy4HAUZFa9Y/JQ37MT1wQhXp+Z6
        WM/pWST4LhObQdS0TnhFadZ6lk5wbnRWhLLYYWd6pNnobSJ/FaQyZMC99AUuVmmDr2TPV6LjgbyT6
        w0Sapma+mApl0C/zPIgF6/BX/wN61FanxD5XcNcKuSavUANcdIzOrEaztQJrgA+3aJvOnE0wmLHWn
        szGBBpMgI5VaEHtNffTYr2w+nEQckNvMZq/49dVy/vcShm1Qk/r1KKaCHfHqj2Lj35g+8ioCzhvcN
        FsDrwRhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTkpk-006rJt-Ib; Wed, 09 Aug 2023 15:10:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D7F330003A;
        Wed,  9 Aug 2023 17:10:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E87932023C23F; Wed,  9 Aug 2023 17:10:47 +0200 (CEST)
Date:   Wed, 9 Aug 2023 17:10:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230809151047.GT212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
 <20230809135004.2xy76kqpptfqxsp5@treble>
 <20230809140644.GP212435@hirez.programming.kicks-ass.net>
 <20230809143000.tus4hqdaobk667eo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809143000.tus4hqdaobk667eo@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:30:00AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 04:06:44PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 09, 2023 at 09:50:04AM -0400, Josh Poimboeuf wrote:
> > > On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> > > > With the difference being that UNTRAIN_RET_VM uses
> > > > X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> > > > 
> > > > This cures VMEXIT doing potentially unret+IBPB or double IBPB.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
> > > >  arch/x86/kernel/cpu/bugs.c           |   17 ++++++++++++++++-
> > > >  arch/x86/kvm/svm/vmenter.S           |    7 ++-----
> > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > > 
> > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > @@ -299,6 +299,17 @@
> > > >  #endif
> > > >  .endm
> > > >  
> > > > +.macro UNTRAIN_RET_VM
> > > > +#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
> > > > +	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
> > > 
> > > Maybe can be simplified?
> > > 
> > 
> > See patches 9 and 10 :-)
> 
> Can still be further simplified to CONFIG_RETHUNK?

Hmm, probably, but my brain seems to be giving out. Let me do the whole
dinner and kids to bed thing and I'll look again later.
