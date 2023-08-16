Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DCA77DD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbjHPJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbjHPJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:39:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE21985
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zEAERw5d72nzwIVpxA3rlrCtJzEM1sidmfJAttnLAfg=; b=aJvKfuS3qiGJo8mtooh2uybZjF
        5LC6N24K4Pso7MM+R7KyRhETxRv79vdwXm+VQudBwsr4buKqeolqsUhMSeBcbzMTxBnYdDyejZnwH
        3l20XjHXSSYWhhmhwiUeyQ1dR6+nhuuExi471Dn7yvq2HK0e1yo67yjLemejhsGYCWgeQYPs24FUm
        Dedxtfg9bmF6cWMouRCkCMJGQR0HHyiU/h0LBE9dJzdQB8Wpgdk1CWumLQXihH9HLy/kPD2c2tUaD
        5hlRVKB5C64goWA2f+Kzc+ft3CLdtMzlLCx4usXlBfD26qKCILbJZU13nx2O/8+fFhy8j0lHj8pn6
        iYXjS91g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWCzn-00Ctui-0n;
        Wed, 16 Aug 2023 09:39:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C9EE30020C;
        Wed, 16 Aug 2023 11:39:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D4092C8D7776; Wed, 16 Aug 2023 11:39:18 +0200 (CEST)
Date:   Wed, 16 Aug 2023 11:39:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, baron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230816093917.GC980931@hirez.programming.kicks-ass.net>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
 <20230816001032.n4jp2uek3gi654bq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816001032.n4jp2uek3gi654bq@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:10:32PM -0700, Josh Poimboeuf wrote:
> On Wed, Aug 16, 2023 at 01:08:09AM +0200, Peter Zijlstra wrote:
> >  bool __static_call_fixup(void *tramp, u8 op, void *dest)
> >  {
> > +	/*
> > +	 * Not all .return_sites are a static_call trampoline (most are not).
> > +	 * Check if the next 3 bytes are still kernel text, if not, then this
> 
> s/3/7 ?

Right, so what I meant was the 3 bytes after the return, which is 5+3,
but yeah, that can be said better.

> 
> > +	 * definitely is not a trampoline and we need not worry further.
> > +	 *
> > +	 * This avoids the memcmp() below tripping over pagefaults etc..
> > +	 */
> > +	if (!kernel_text_address(tramp+7))
> > +		return false;
> > +
> >  	if (memcmp(tramp+5, tramp_ud, 3)) {
> >  		/* Not a trampoline site, not our problem. */
> >  		return false;
> 
> kernel_text_address() can be quite heavyweight to call in a loop during
> module loading.  Maybe that doesn't matter much.  But it would be a lot
> faster to only call kernel_text_address() if tramp+7 is on the next
> page.

Oh, right, in those few configs where it doesn't use the tree. Sure can
do.
