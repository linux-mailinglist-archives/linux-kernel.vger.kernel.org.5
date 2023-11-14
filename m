Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451E7EB03B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjKNMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjKNMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:50:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF65192
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EtM4Wf6wmF/h9qD3ggeAeZqT/sbRValNFVYjSFWKqBY=; b=YRUoUeUbC0Q4bOQj2gm+5tuAvx
        TF2j+tqdYaCmxYB5MLYi0g+IGLVa1mTrAjNMEF5dyNX7ub64XTraRpz3aluajjyKRRmely0zA09qj
        IBCVfUVgBMNH4uRuAzZvSNYOSwFFJZfeFHCI2iqmO5GhGgOxQ+0lc3e7XdLXpxaSo8FjQCRLr70z8
        rapNv+8OQFeARrFrIG9RRHOGUm9HM8tmR2bD8wQa09YutKp9Zm7aYEnViYsZBkBlhDdrg64w9sDqT
        85OccAcZzN5h8azGeKx8fqugyVqK8sCcZfIjt2g40Z5XoEsKpUiWb3vauiMwSKqJxb3jGnjJTH2P3
        W13c63Kg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2ss9-00816d-GK; Tue, 14 Nov 2023 12:50:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CB963007C8; Tue, 14 Nov 2023 13:50:29 +0100 (CET)
Date:   Tue, 14 Nov 2023 13:50:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114125028.GX3818@noisy.programming.kicks-ass.net>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:37:37PM +0100, Borislav Petkov wrote:

> > +#ifdef CONFIG_X86_64
> > +	/* ff 15 00 00 00 00   call   *0x0(%rip) */
> > +	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
> > +#else
> > +	/* ff 15 00 00 00 00   call   *0x0 */
> > +	target = *(void **)(*(s32 *)(instr + 2));
> > +#endif
> > +	if (!target)
> > +		target = bug;
> > +
> > +	/* (BUG_func - .) + (target - BUG_func) := target - . */
> > +	*(s32 *)(insn_buff + 1) += target - bug;
> 
> If I squint hard enough, this looks like it is replacing one call with
> another. We have a C macro alternative_call() which does exactly that.
> Why can't you define an asm version ALTERNATIVE_CALL and use it
> instead of using adding a new flag? We have 16 possible ones in total.

This loads the function target from the pv_ops table. We can't otherwise
do this.
