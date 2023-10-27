Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDD7DA10F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjJ0Sy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjJ0Sy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDBBE1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GHW8GpRLKXZImDB81pOVvJ/9jgyWsESQUJWOV9akB3g=; b=lm3zj5Iecl4211otPzdQPtCbpq
        agT/2VOXy3i6RvdF7miEApY7pFBrrJlzURpn08ao0B7bu7Qt9yM+oP9C/hC/GK5+914ALOuA2Cs2G
        3hmxiRgv7wrvSj0LB6ZeuOUVnsCw6EPT9utkMEeysADpAclIDKCUI3keZ62enMiBSlSkwV/Rh2OUG
        edaNGjWhUdPg+22Q7qaZdLYgC8cgZqkPMeb56OGgOrkeV9OJGaG8m7WQLfS9xBQm4ANgd2bewtWJ8
        jBHVzycf0xmVpzK8TdVRcHh7GB4UbP5wy/2mH0mx+d0/kjYR/K1sUj6on1Pjoowog4uj5ENes3kA2
        LGBkw+6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwRxw-0051Jh-Ig; Fri, 27 Oct 2023 18:53:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1919F300392; Fri, 27 Oct 2023 20:53:51 +0200 (CEST)
Date:   Fri, 27 Oct 2023 20:53:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com
Subject: Re: [PATCH v2] x86/entry: Avoid redundant CR3 write on paranoid
 returns
Message-ID: <20231027185351.GD26550@noisy.programming.kicks-ass.net>
References: <20230920150443.1789000-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920150443.1789000-1-jackmanb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:04:43PM +0000, Brendan Jackman wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> This path gets used called from:
> 
> 1. #NMI return.
> 2. paranoid_exit (i.e. #MCE, #VC, #DB and #DF return)
> 
> Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
> RESTORE_CR3"), we never modify CR3 in any of these exceptions, except
> for switching from user to kernel pagetables under PTI. That means that
> most of the time when returning from an exception that interrupted the
> kernel no CR3 restore is necessary. Writing CR3 is expensive on some
> machines, so this commit avoids redundant writes.
> 
> I said "most of the time" because we might have interrupted the kernel
> entry before the user->kernel CR3 switch or the exit after the
> kernel->user switch. In the former case skipping the restore might
> actually be be fine, but definitely not the latter. So we do still need
> to check the saved CR3 and restore it if it's a user CR3.
> 
> To reflect the new behaviour RESTORE_CR3 is given a longer name, and a
> comment that was describing its behaviour at the call site is removed.
> We can also simplify the code around the SET_NOFLUSH_BIT invocation
> as we no longer need to branch to it from above.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> [Rewrote commit message; responded to review comments]
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Seems sensible, although I do wonder what made you care enough to
optimize the PTI paranoid path... :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
