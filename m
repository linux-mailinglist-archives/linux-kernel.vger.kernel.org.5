Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441A977613C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHINgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjHINgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:36:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527382126
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qvJyCH4RyOSoeLiwVOcFHSz0PusREL+nD+CkI4y87o0=; b=g4f26sN20pF8NWW2GiDjX1P+tH
        Z8I0clKJy8ygqtG2dnXvZok8vA8MZKTDv7RasgfJQKl5D57T7E/pC8peqUPnWX+iMW3Zw6d8vG059
        VsvSDXuf7UhpsT/4VgP0uXzuD6cMhdRJOOCVHfOcRHQAUQ2EM9tT0NrcZ51NqR0ftUXp1JwpQPRwM
        CuSLHFfBrIkpLSU+q3mdn72t77M/RZ5euJ9392dF31TPkjmiKOQd7v3xqUU0w5Tg2okzMHGPYMGXm
        UPZ+Jf6U3/gEvmoAAaKqNnLsjs9QDzyOp2GbXxot1FF6JGIKF0mtOnxzQ8lwR8tREfzmLb3StBJ2N
        fifHRTug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTjMK-005fPF-27;
        Wed, 09 Aug 2023 13:36:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDF9F30003A;
        Wed,  9 Aug 2023 15:36:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2ECF20208EAB; Wed,  9 Aug 2023 15:36:19 +0200 (CEST)
Date:   Wed, 9 Aug 2023 15:36:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Message-ID: <20230809133619.GL212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
 <64f94037-d370-aa83-f8d8-ae827f606f60@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f94037-d370-aa83-f8d8-ae827f606f60@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:10:42PM +0100, Andrew.Cooper3@citrix.com wrote:
> On 09/08/2023 8:12 am, Peter Zijlstra wrote:
> > Now that retbleed can do all that the srso knob did, and without the
> > dubious interactions with retbleed selections, remove it.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c |  188 ++-------------------------------------------
> >  drivers/base/cpu.c         |    8 -
> >  include/linux/cpu.h        |    2 
> >  3 files changed, 10 insertions(+), 188 deletions(-)
> 
> Not all of this can go, because ...
> 
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > ...
> > -static void __init srso_select_mitigation(void)
> > -{
> > -	bool has_microcode;
> > -
> > -	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
> > -		goto pred_cmd;
> > -
> > -	/*
> > -	 * The first check is for the kernel running as a guest in order
> > -	 * for guests to verify whether IBPB is a viable mitigation.
> > -	 */
> > -	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
> > -	if (!has_microcode) {
> > -		pr_warn("IBPB-extending microcode not applied!\n");
> > -		pr_warn(SRSO_NOTICE);
> > -	} else {
> > -		/*
> > -		 * Enable the synthetic (even if in a real CPUID leaf)
> > -		 * flags for guests.
> > -		 */
> > -		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> > -		setup_force_cpu_cap(X86_FEATURE_SBPB);
> 
> ... these (minus the virt bug caused by probing for microcode behaviour
> even when virtualised, and the enumeration bug caused by ignoring
> synthesis if host mitigations are off) are necessary for KVM.
> 
> https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
> 
> and here's one I prepared earlier
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2280b0ee2aed6e0fd4af3fa31bf99bc04d038bfe
> 
> but these bits need to get into guests for the guests to be able to
> figure out what to do.

Patch 6 adds these feature bits to retbleed_select_mitigation().


