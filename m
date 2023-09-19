Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6447A6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjISVMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjISVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:12:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17846B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=swiFRBqRq9+6CwNBGz4x7mo1QhHfmgph57cOBH5qHI4=; b=oQqsS3E68CLZHeTpJ6Di7GrSH4
        tMJdzFObPGTF0tByK4+Mtk1WwpsHwf5DEXLEQ3OkZJIjcp7TxcEX6a1ih3WCYuAHaxp09JbI7mjYx
        /j+MT5xZ/S/B5MBZMBxrxf0w+r1zdK2cyj0D2oWoVFPJZdoK0f2p2UtWENVXxE6DW/EU4UyaNc6Nx
        KGL6VUS6TmkMPFltljiinbDrxeThSLHPDC4HqfQQY86qxGj5XMIradjL/nDszioUczCz+TOtpHURs
        OCJ2sc1+oGd2ZdhUqk3grYRMIVokXPCcxxeiHvxdxpSq876XVLGaFzTPjjAyUjdE9LO9AADdTvNoR
        coRKKqUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qii11-001pey-3k; Tue, 19 Sep 2023 21:12:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3FC8300585; Tue, 19 Sep 2023 23:12:14 +0200 (CEST)
Date:   Tue, 19 Sep 2023 23:12:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Message-ID: <20230919211214.GE424@noisy.programming.kicks-ass.net>
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
 <20230919194337.GC424@noisy.programming.kicks-ass.net>
 <a5c505d1-730c-912c-3c83-1df83d8e264b@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c505d1-730c-912c-3c83-1df83d8e264b@foxvalley.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:56:15PM -0600, Dan Raymond wrote:
> > No, very much no.
> > 
> > This sticks tracing in the very rawest of raw output paths.
> 
> That's the point.  Tracing is a low level debug tool that can be
> used to debug the kernel itself.  If you don't trace all port I/O
> then you are bound to miss something important while debugging.
> 
> > This means I can no longer use early_console->write() to print to my
> > early_serial_console.
> 
> Why not?  Did you try it?

I have tried debugging the kernel for the last 15+ years. The only
reliable way to get something out of the machine is outb on the serial
port. Anything else is a waste of time..

Adding tracing to it (which relies on RCU, which might not be alive at
this point) which might itself be the problem, is a total no-go.

You do not wreck early_serial_console.

> > That is the one and only fully reliably output path we have. You're not
> > sticking tracing in it.
> 
> Keep in mind that tracing is optional.  It can be turned off using
> CONFIG_TRACEPOINTS.

Nobody ever does that. Also, tracepoints in general are useful.
