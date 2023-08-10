Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A06778226
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjHJU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHJU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:26:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F8C2136
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oam5EYJFW/KNPsDLFG9QhtQ214SP/pK8sNDX8AOhfLU=; b=gXyiVnUw/EE76S0d/MGJBBNqps
        IVVayOXdl8w2En57GNoUSFvD6tGHb6AJW8dKqoxmhmSL3pENp2N54+F/MmPZfXMWo5Fc+QvFpO5Z/
        45qR7U+IN5/IUsiJXhYWfFztEmAncKQ8meCkxcJcwRgeF+Zd1w+0hu8Wb53Yf6cVXaOuPhUjvTFnk
        kPTkkHBbpt6InjPKR7UwiNl3OP7zZoYX2FtrGLJrtfLQ2ioqBYNuYiuaRVi7+TQTG1Ve3UdDQEhzd
        9O8/KJKBri07mRWO4QMn+nLbQB8VxyKc9SmvyOX7T4GYeC4XT5s4kXZRBYf+GIcr3uuFUy5EObjvk
        Dxp+rxGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUCDf-00EXcP-Pc; Thu, 10 Aug 2023 20:25:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23C7A30026C;
        Thu, 10 Aug 2023 22:25:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F2F2201CD2DB; Thu, 10 Aug 2023 22:25:19 +0200 (CEST)
Date:   Thu, 10 Aug 2023 22:25:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 23/30] x86/microcode: Provide new control functions
Message-ID: <20230810202519.GD212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.278309863@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810160806.278309863@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:38:00PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current all in one code is unreadable and really not suited for adding
> future features like uniform loading with package or system scope.
> 
> Provide a set of new control functions which split the handling of the
> primary and secondary CPUs. These will replace the current rendevouz all in
> one function in the next step. This is intentionally a separate change
> because diff makes an complete unreadable mess otherwise.
> 
> So the flow separates the primary and the secondary CPUs into their own
> functions, which use the control field in the per CPU ucode_ctrl struct.
> 
>    primary()			secondary()
>     wait_for_all()		 wait_for_all()
>     apply_ucode()		 wait_for_release()
>     release()			 apply_ucode()

This hard assumes SMT2, right? If someone were ever to do an x86 smt4
part then smt siblings 1,2,3 would all apply concurrently in secondary,
is that intended?

> +	/*
> +	 * Wait for primary threads to complete. If one of them hangs due
> +	 * to the update, there is no way out. This is non-recoverable
> +	 * because the CPU might hold locks or resources and confuse the
> +	 * scheduler, watchdogs etc. There is no way to safely evacuate the
> +	 * machine.
> +	 */
> +	if (!wait_for_ctrl())
> +		panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);

One way around this is to first hot-unplug the CPUs, then NMI prod them
into the rendevous, and only on-line them again if ucode update is
successful. On failure stick them in a (new) error state so that manual
online also fails and scream murder, like above.

But yeah, rather unlikely, and for another day etc..
