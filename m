Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAE7783A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHJWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHJWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:30:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEBC273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lt9KkefrkrbwNsnwj3V0hBLexBYq5iVpcw8iPOeTiJ4=; b=UEbjrBSC/tt6Y+m6faORX6qpgQ
        2+s32yAI+4qils569BdIs6511gzSqPIbu+poQeWsMPLp0ImFv1SfxPbNHLYTfrZ23RfkZO/B04uOn
        mNG6sbIFt77cC/WZn6UMYftO+Kc4n5x9oy077DqGZNjFGlrcX4n3Z12Qgd6wOgcT0QOXl54xN9MFO
        Izf5zYsMMuziolZlD7TRFgDTfcSIMvQzSbXniWKGV7P1+TDikXIEYhu2bGhttXmmuS3HZHyrg5Zy8
        rcXMkek/RvdwDbKCYtYItQ6d2pnYKLNX/YxC7avfCQxEcO57jWflHsGEQ2mkzFb+97GJA1YTYHrM5
        FmilTFYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUEAI-006o4H-39;
        Thu, 10 Aug 2023 22:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0329430020B;
        Fri, 11 Aug 2023 00:29:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3BCC205FF904; Fri, 11 Aug 2023 00:29:57 +0200 (CEST)
Date:   Fri, 11 Aug 2023 00:29:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <20230810222957.GJ212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
 <20230810210511.GH212435@hirez.programming.kicks-ass.net>
 <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:49:39PM -0700, Ashok Raj wrote:
> On Thu, Aug 10, 2023 at 11:05:11PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 10, 2023 at 01:50:17PM -0700, Ashok Raj wrote:
> > > On Thu, Aug 10, 2023 at 10:46:05PM +0200, Peter Zijlstra wrote:
> > > > On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
> > > > 
> > > > >  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> > > > > +		/*
> > > > > +		 * Offline CPUs sit in one of the play_dead() functions
> > > > > +		 * with interrupts disabled, but they still react on NMIs
> > > > > +		 * and execute arbitrary code. Also MWAIT being updated
> > > > > +		 * while the offline CPU sits there is not necessarily safe
> > > > > +		 * on all CPU variants.
> > > > > +		 *
> > > > > +		 * Mark them in the offline_cpus mask which will be handled
> > > > > +		 * by CPU0 later in the update process.
> > > > > +		 *
> > > > > +		 * Ensure that the primary thread is online so that it is
> > > > > +		 * guaranteed that all cores are updated.
> > > > > +		 */
> > > > >  		if (!cpu_online(cpu)) {
> > > > > +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> > > > > +				pr_err("CPU %u not online, loading aborted\n", cpu);
> > > > 
> > > > We could make the NMI handler do the ucode load, no? Also, you just need
> > > > any thread online, don't particularly care about primary thread or not
> > > > afaict.
> > > 
> > > Patch 25 does that load in NMI. You are right, we just need "a" CPU in each
> > > core online. 
> > 
> > Patch 25 does it for online CPUs, offline CPUs are having a separate
> > code path:
> > 
> >   microcode_nmi_handler()
> > 
> > vs
> > 
> >   microcode_offline_nmi_handler()
> 
> Since the code enforces all primary CPUs to be ONLINE, the secondaries are the
> other thread of the same core. So they automatically get the update when
> primary does it. 
> 
> The secondaries are parked in NMI just to avoid the risk of executing code
> that might be patched by primary.
> 
> Or maybe you had something else in mind. 

Yeah, not placing constraints on who is online at all. Also, if both
siblings are offline, then onlining will re-load ucode anyway, no?
