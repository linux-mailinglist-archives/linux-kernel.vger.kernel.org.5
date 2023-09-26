Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C37AF03C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjIZQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjIZQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:06:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C310A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:06:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695744390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZBZ0e5+Bkgdgf988Ah3z6IPgN+5AIZaHT83aY7rkg4=;
        b=ngxI5hT9cnVfL2fZfo1OLXiEaem7mpFJ40QWHCUz3q4miCE20RY5yyIuHA7wJAX2+R3w14
        9xQ1+ZY6iuKZJ10sGey4fWxIuaoiGyd6rBTHxdYv8sMhUElTSOmYy68aF1YPtIAy/DhWGy
        h4NcZU/wsLOKeMxqR/EldV7zpFkyLVpGkSpYsNMS7O9KGuRqWVY6tMoTU67TcbpHhRwwuR
        IVsEGGQJg+5QHCPztTWhJZO/FLa/pNsH72/AIh2RPrXjiuFyC8az5Q5qmrNIpUwkZFgm/I
        s0ToeqMwelCGDHKlOqqPBo4IzQfUIT8ipF0QygZWYWRX4Rm9537MzLVjjlDPkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695744390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZBZ0e5+Bkgdgf988Ah3z6IPgN+5AIZaHT83aY7rkg4=;
        b=PgNNE8PXx/UT3eydhsqc9VUSLkhJ4yEG2supI0jNuHXCT0exy7IcxjUjADs3HMPe+miUrJ
        B6MenI7gTR8ou1Dw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 21/30] x86/microcode: Add per CPU result state
In-Reply-To: <20230924062934.GLZQ/XThoM7jsrjmrt@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.082789879@linutronix.de>
 <20230924062934.GLZQ/XThoM7jsrjmrt@fat_crate.local>
Date:   Tue, 26 Sep 2023 11:09:01 +0200
Message-ID: <87sf71fgia.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24 2023 at 08:29, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 09:58:16AM +0200, Thomas Gleixner wrote:
>> +struct ucode_ctrl {
>
> microcode_ctrl
>
> I know "ucode" is shorter but we already call everything new-er
> "microcode_" and this'll cause confusion.

That starts to get silly. The struct is used only in the microcode realm
and nothing which is globally visible. ucode is a pretty obvious and
established shortcut. But so what....

>> +	enum ucode_state	result;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
>
> You could do
>
> static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
>
> so that the naming is different too.

And that solves what?

>>  static atomic_t late_cpus_in, late_cpus_out;
>>  
>>  static bool wait_for_cpus(atomic_t *cnt)
>> @@ -344,23 +349,19 @@ static bool wait_for_cpus(atomic_t *cnt)
>>  	return false;
>>  }
>>  
>> -/*
>> - * Returns:
>> - * < 0 - on error
>> - *   0 - success (no update done or microcode was updated)
>> - */
>> -static int __reload_late(void *info)
>> +static int ucode_load_cpus_stopped(void *unused)
>
> No need for "ucode_" prefixes to static functions.

What's the problem with that prefix? The function name clearly says what
this is doing.

>>  {
>>  	int cpu = smp_processor_id();
>> -	enum ucode_state err;
>> -	int ret = 0;
>> +	enum ucode_state ret;
>>  
>>  	/*
>>  	 * Wait for all CPUs to arrive. A load will not be attempted unless all
>>  	 * CPUs show up.
>>  	 * */
>> -	if (!wait_for_cpus(&late_cpus_in))
>> -		return -1;
>> +	if (!wait_for_cpus(&late_cpus_in)) {
>> +		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
>> +		return 0;
>
> So the only value this function returns is 0 now.
> stop_machine_cpuslocked() still does pay attention at ret so I guess it
> should return non-null/negative on error or so?

Nope, because stop_machine_cpuslocked() does not usefully accumulate
results from all involved CPUs. But it can return errors related to the
invocation itself, which is a completely different story.

That's why ucode_ctrl.result is per CPU and has to be evaluated
separately.

>> -	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
>> +	stop_machine_cpuslocked(ucode_load_cpus_stopped, NULL, cpu_online_mask);
>> +
>> +	/* Analyze the results */
>> +	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
>> +		switch (per_cpu(ucode_ctrl.result, cpu)) {
>> +		case UCODE_UPDATED:	updated++; break;
>> +		case UCODE_TIMEOUT:	timedout++; break;
>> +		case UCODE_OK:		siblings++; break;
>> +		default:		failed++; break;
>> +		}
>
> Align vertically.

Align what?

>> +	}
>>  
>>  	if (microcode_ops->finalize_late_load)
>> -		microcode_ops->finalize_late_load(ret);
>> +		microcode_ops->finalize_late_load(!updated);
>>  
>> -	if (!ret) {
>> -		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
>> -			old, boot_cpu_data.microcode);
>> -		microcode_check(&prev_info);
>> -		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>> -	} else {
>> -		pr_info("Reload failed, current microcode revision: 0x%x\n",
>> -			boot_cpu_data.microcode);
>> +	if (!updated) {
>> +		/* Nothing changed. */
>> +		if (!failed && !timedout)
>> +			return 0;
>> +		pr_err("Microcode update failed: %u CPUs failed %u CPUs timed out\n",
>> +		       failed, timedout);
>> +		return -EIO;
>>  	}
>> -	return ret;
>> +
>> +	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>> +	pr_info("Microcode load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
>> +	if (failed || timedout) {
>> +		pr_err("Microcode load incomplete. %u CPUs timed out or failed\n",
>> +		       num_online_cpus() - (updated + siblings));
>> +	}
>> +	pr_info("Microcode revision: 0x%x -> 0x%x\n", old_rev, boot_cpu_data.microcode);
>
> You don't need "Microcode" in those strings - the pr_info has already
> "microcode:" as prefix.

True.

>> @@ -448,9 +463,12 @@ static int microcode_reload_late(void)
>>   *    behaviour is undefined. The default play_dead() implementation on
>>   *    modern CPUs is using MWAIT, which is also not guaranteed to be safe
>>   *    against a microcode update which affects MWAIT.
>> + *
>> + * 2) Initialize the per CPU control structure
>>   */
>> -static bool ensure_cpus_are_online(void)
>> +static bool ucode_setup_cpus(void)
>
> s/ucode_//

and setup_cpus() then tells what?
