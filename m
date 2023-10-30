Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678C7DBD57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJ3QD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjJ3QDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:03:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F7C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/oyNAiXWpZ5JJprTFG04LTsScOd2+1h5R3ZTfVajcGI=; b=MAlRFKX4p/EJRmz0P+6bdA56px
        RALxlwwQ2N7FRwNevolKddhGJDhJAwS4RNcbFxdK0rTgz9L0uWK6xNIqFUkmbC0v8HN1Tsw3h+mH0
        AkpLjvm0r8EHw6j7akSEcm19VDvMdjmKnEGdb3RdUPHHCoAUiT0DDc2B2zzkzuLQH3ln0Gj5eS88v
        hEtxA36XV+Zz+1MYaxbu0K9CHEVV1k46nePO94g3IGE+r7nLHLO/Pd9PNhUt8J2mnf+yf+2go5ArP
        UAuAzqdtiYQDqbznt7gLN1nvsAytcOIn+LLIcJwuCGemih/AhEiS921OI2gLaEYxIRtkFFidn26Rc
        9rkiQcLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxUjx-004zXt-4Z; Mon, 30 Oct 2023 16:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B12EC300478; Mon, 30 Oct 2023 17:03:44 +0100 (CET)
Date:   Mon, 30 Oct 2023 17:03:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        feng.tang@intel.com
Subject: Re: [PATCH] x86/tsc: Have tsc=recalibrate override things
Message-ID: <20231030160344.GA19106@noisy.programming.kicks-ass.net>
References: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:00:50PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> My brand-spanking new SPR supermicro workstation was reporting NTP
> failures:
> 
> Oct 30 13:00:26 spr ntpd[3517]: CLOCK: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: time stepped by 32.316775
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: frequency error 41699 PPM exceeds tolerance 500 PPM
> 
> CPUID provides:
> 
>     Time Stamp Counter/Core Crystal Clock Information (0x15):
>        TSC/clock ratio = 200/2
>        nominal core crystal clock = 25000000 Hz
>     Processor Frequency Information (0x16):
>        Core Base Frequency (MHz) = 0x9c4 (2500)
>        Core Maximum Frequency (MHz) = 0x12c0 (4800)
>        Bus (Reference) Frequency (MHz) = 0x64 (100)
> 
> and the kernel believes this. Since commit a7ec817d5542 ("x86/tsc: Add
> option to force frequency recalibration with HW timer") there is the
> tsc=recalibrate option, which forces the recalibrate.
> 
> This duely reports:
> 
> Oct 30 12:42:39 spr kernel: tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> Oct 30 12:42:39 spr kernel: tsc: Previous calibrated TSC freq:         2500.000 MHz
> Oct 30 12:42:39 spr kernel: tsc: TSC freq recalibrated by [HPET]:         2399.967 MHz

Arjan, can you please escalate this to our supermicro contact?
