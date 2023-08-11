Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07606778A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjHKJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjHKJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:37:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E83C0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:36:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691746613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZYjFfz1bwCo59gNGTrSPl6TjkdV/FBgZNeoD4PLlQI=;
        b=d4C2zLm9eRHmKD/S5hkf0GDZ+PI9WEYaI+NUB0g6yUpaDL3VWcMZIw2uI4/SuandtNbZe1
        xf+ujBGIb6UV5pr+J5ENLr5bXhkZ85hqjQIENeG5ShkUa67S1yhfPvKrxcFWdEHXm5HbSW
        tbLxCUC5NMXu/jnCPSGPSFDrruLTQOJI1HhLCjpRy4y9Tx9eNc6Xm55QhKtK3g/4rCxdgp
        1+Tm3FzLs6F0ybPLqPLO9aUW5eMOjoc7TITJvlXm4iwnCOHYxS0QtIhpRXLPgKdw3qW1VE
        cMVDqMRTZorL/1aiiaGM3Lec/IXiiLwJiNM35Nv/3Jiq1nkUrL0wAl6F/CAHyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691746613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZYjFfz1bwCo59gNGTrSPl6TjkdV/FBgZNeoD4PLlQI=;
        b=LluljunDprMFkeyznxgdeA/pyAnX8KjdCMywa/7YAQSySJQzgtjEZs5ncuQFTzvqJyHeTK
        g5Z5biqD4RwA0bBw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
In-Reply-To: <20230810204605.GF212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Aug 2023 11:36:53 +0200
Message-ID: <874jl5j4y2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2023 at 22:46, Peter Zijlstra wrote:

> On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
>
>>  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
>> +		/*
>> +		 * Offline CPUs sit in one of the play_dead() functions
>> +		 * with interrupts disabled, but they still react on NMIs
>> +		 * and execute arbitrary code. Also MWAIT being updated
>> +		 * while the offline CPU sits there is not necessarily safe
>> +		 * on all CPU variants.
>> +		 *
>> +		 * Mark them in the offline_cpus mask which will be handled
>> +		 * by CPU0 later in the update process.
>> +		 *
>> +		 * Ensure that the primary thread is online so that it is
>> +		 * guaranteed that all cores are updated.
>> +		 */
>>  		if (!cpu_online(cpu)) {
>> +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
>> +				pr_err("CPU %u not online, loading aborted\n", cpu);
>
> We could make the NMI handler do the ucode load, no? Also, you just need
> any thread online, don't particularly care about primary thread or not
> afaict.

Yes, we could. But I did not go there because it's a fricking nightmare
vs. the offline state and noinstr.

OTOH, it's not really required. Right now we mandate that _all_ present
cores have at least one sibling online. For simplicity (and practical
reasons - think "nosmt") we require the "primary" thread to be online.

Microcode is strict per core, no matter how many threads are there. We
would not need any of this mess if Intel would have synchronized the
threads on microcode update like AMD does. This is coming with future
CPUs which advertise "uniform" update with a scope ranging from core,
package to systemwide.

Even today, the only exercise what online SMT siblings do after the
primary thread updated the microcode is verification that update
happened which creates consistent software state. But in principle the
secondaries could just do nothing and everything would work (+/-
hardware,firmware bugs).

Sure we could lift that requirement, but why making this horrorshow even
more complex than it is already ?

There is zero point to support esoteric usecases just because we
can. The realistic use case is a server with all threads online or SMT
disabled via command line or sysfs. Anything else is just a pointless
exercise.

Thanks,

        tglx
