Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953857A8797
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjITOxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjITOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:53:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D791
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZerJcnOhEvUGAjVvFDnt+ED8Lu+58HuQE4rkQfwGHOA=; b=oK8vRjz6Cd8f7av9WAZ5MrtvDW
        ibgh94KLBV8bt3XT/9afi1rlEMXon7JYGg022FAXhUQZjpxFY0xwx6vKCjVnzWjaj1Wf05zIekyP+
        7Tdo8to/IC62m6luX7US+MvBnpB5L+C5sRZGxmzkbD1eLLHMxatdmUuwEwjYb1jgWR+CK6y35zJk/
        Jqpg71tlE334dkhfQmcvC+yZTUBqEThAiih5oPlNhMoCKZFNJgWxLQFXYYZItL9o229FD8LorfdgL
        PQsAN960x2p15PJgxMjFr6zjsjVxfLazY91uScz7lkmL9lJrXIg3ghzbHk6i7YEspFdVx8Fq2lCyU
        ooWAy3kA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiyYv-00EfZI-0q;
        Wed, 20 Sep 2023 14:52:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EBD4300348; Wed, 20 Sep 2023 16:52:22 +0200 (CEST)
Date:   Wed, 20 Sep 2023 16:52:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [RFC PATCH 3/3] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20230920145222.GB6687@noisy.programming.kicks-ass.net>
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608140333.4083-4-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:03:33PM +0200, Juergen Gross wrote:
> Instead of stacking alternative and paravirt patching, use the new
> ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> handling.
> 
> This eliminates the need to be careful regarding the sequence of
> alternative and paravirt patching.
> 
> For call depth tracking callthunks_setup() needs to be adapted to patch
> calls at alternative patching sites instead of paravirt calls.
> 
> Remove the no longer needed paravirt patching and related code.

I think this becomes easier if you first convert the paravirt sites to
alternatives, such that .parainstructions is empty, and then in a
subsequent patch remove all the paravirt infrastructure that is unused.


> +#define SAVE_FLAGS	ALTERNATIVE_2 "PARA_IRQ_save_fl;", ALT_CALL_INSTR, \
> +				      ALT_CALL_ALWAYS, "pushf; pop %rax;", \
> +				      ALT_NOT(X86_FEATURE_XENPV)

I find this more readable when written as:

#define SAVE_FLAGS	ALTERNATIVE_2 "PARA_IRQ_save_fl;",		\
				      ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
				      "pushf; pop %rax;", ALT_NOT(X86_FEATURE_XENPV)

(and perhaps ALT_NOT_XEN is in order, there's a ton of those)

If you base this on top of the nested alternative patches, another
helper might be:

#define __PV_ALTERNATIVE(old) __ALTERNATIVE(old, ALT_CALL_INSTR, ALT_CALL_ALWAYS)

So that you can then write:

#define SAVE_FLAGS	__ALTERNATIVE(__PV_ALTERNATIVE("PARA_IRQ_save_fl;"),
				      "pushf; pop %rax;", ALT_NOT_XEN)

But perhaps I'm over-cooking things now..

