Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC26778281
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHJVFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:05:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC0211B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Eim2kl4hCvWSQcoe+9+XCUEac0rV2NfBKaqjbbKaG0=; b=tyl8jm9XKfQ/eYt0y/+CmcPxmW
        pf3URLpU9493hX6IyG1G1VZ+3LRp/TyeB6dnZaZWsoxsBtn5aTFZ9xFX8hRsTW3Kp1Z7wrC1j555/
        ncPoulIEB7r7kwITDOk6j3sFa0uRcNYe/K0PAwTt+gGDF2pJRuVLodWydXtnjIfbERvP2/AGL16LY
        B9YhRixPIoMfKLDfAGxPcyzGCCsO+pilSYHxPzveD4I2fkG+XblTJhMVdgBAQnUrcfxMlv/mDhKVD
        Q0X9PSGINMjEFGkV+FiG+ASmpDLyNFmTdRvdNAEXiacP0OeT35889wtvAMgSJD+26BE3ZZ94BRrsz
        NEfWDEXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUCqG-00EiQk-7w; Thu, 10 Aug 2023 21:05:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83A8A30020B;
        Thu, 10 Aug 2023 23:05:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69945206819A5; Thu, 10 Aug 2023 23:05:11 +0200 (CEST)
Date:   Thu, 10 Aug 2023 23:05:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <20230810210511.GH212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:50:17PM -0700, Ashok Raj wrote:
> On Thu, Aug 10, 2023 at 10:46:05PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
> > 
> > >  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> > > +		/*
> > > +		 * Offline CPUs sit in one of the play_dead() functions
> > > +		 * with interrupts disabled, but they still react on NMIs
> > > +		 * and execute arbitrary code. Also MWAIT being updated
> > > +		 * while the offline CPU sits there is not necessarily safe
> > > +		 * on all CPU variants.
> > > +		 *
> > > +		 * Mark them in the offline_cpus mask which will be handled
> > > +		 * by CPU0 later in the update process.
> > > +		 *
> > > +		 * Ensure that the primary thread is online so that it is
> > > +		 * guaranteed that all cores are updated.
> > > +		 */
> > >  		if (!cpu_online(cpu)) {
> > > +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> > > +				pr_err("CPU %u not online, loading aborted\n", cpu);
> > 
> > We could make the NMI handler do the ucode load, no? Also, you just need
> > any thread online, don't particularly care about primary thread or not
> > afaict.
> 
> Patch 25 does that load in NMI. You are right, we just need "a" CPU in each
> core online. 

Patch 25 does it for online CPUs, offline CPUs are having a separate
code path:

  microcode_nmi_handler()

vs

  microcode_offline_nmi_handler()
