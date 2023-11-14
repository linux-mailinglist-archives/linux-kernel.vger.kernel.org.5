Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287BF7EB1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKNOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKNOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:18:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AECA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7duO4gPNFFFjkCQqPoix25b9GKJcYpvqIEJLF9AbZkQ=; b=HybZ87qwbZ9zBNrOkylyD2D+eI
        CDIXlefh3MWoojhahVwoCKsrRE5fr0W65DW+4Zau8FIgmsE2YX5EMyQW/o3KOYZOeYv2JqVODzL1s
        ZaLUEaHSOs/cLkwcAurgfLNU/Nd/xwsYCndA+QMAeShllzEs5m813+eZpaOvLC7I4j5WRGsfGwahq
        9cJb4pFaVA1/wZLcvelBNgps3WUeDWoyvFLKvRwVQyErxi68PMduiB1lfl5cFR7ZPNehNls892+tq
        dEkzWhQzd6cwNWvnTCoibITYpRNzN/q0AdijLEBHDQ3dk2yXmTQJGgj5ajoQEdaBwmpB2sViYFNpt
        mup23a+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2uFN-008PbO-Tz; Tue, 14 Nov 2023 14:18:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96955300581; Tue, 14 Nov 2023 15:18:33 +0100 (CET)
Date:   Tue, 14 Nov 2023 15:18:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114141833.GX8262@noisy.programming.kicks-ass.net>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
 <20231114125028.GX3818@noisy.programming.kicks-ass.net>
 <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 02:47:15PM +0100, Borislav Petkov wrote:
> On Tue, Nov 14, 2023 at 01:50:28PM +0100, Peter Zijlstra wrote:
> > This loads the function target from the pv_ops table. We can't otherwise
> > do this.
> 
> On Tue, Nov 14, 2023 at 01:56:37PM +0100, Juergen Gross wrote:
> > It is replacing an _indirect_ call with a _direct_ one, taking the
> > call target from the pointer used by the indirect call.
> 
> Then this is not just a ALT_FLAG_CALL. This is something special. The
> flag definition needs a better name along with an explanation what it
> does, perhaps best with an example from the final vmlinux - not from the
> object file:
> 
> call   *0x0(%rip)
> 
> ==>
> 
> call   *0x0
> 
> where the offsets haven't been linked in yet.

Well, a random absolute address isn't going to be any better or worse
than 0. But perhaps adding the relocation as a comment helps?


   ff 15 00 00 00 00       call   *0x0(%rip)  #  R_X86_64_PC32    pv_ops+0x4
into:
   e8 00 00 00 00 90	   call   +0          #  R_X86_64_PC32 *(pv_ops+0x04)


> If this is going into the generic infrastructure, then it better be
> explained properly so that other stuff can potentially use it too.

ALT_FLAG_DEREFERENCE_INDIRECT_CALL ?

I'm going to already raise my hand and say that's too long ;-)
