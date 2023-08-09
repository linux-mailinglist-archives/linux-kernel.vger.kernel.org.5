Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB17767A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHISwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjHISwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:52:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E92E64
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:52:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691607140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVAZNBEf9TZB47u+PP18kH0WXGdLWzh3aUx3yXvqMOA=;
        b=Y/6nHyzHTQ7H1P2QNteCJHnHVsYaUeFbLHjl/gfzAF3q2OvfQ+8Ejl5EDrpEGRcJnyqTSs
        4DCe6d5QqKY7Z+20pz+/EHZ65eRftvaw59br/FfHjwCpg9bevBWuVFX8A4SJfm5xPfZTg3
        AWtcF2W7G+uV/BuXMMBdUbELF6G9RV1MJOntTUKw7M1kFx2dQbkYlw8k3FAWlKfnsfySv3
        cRnO/6oTFqo03/S79tEYRZQ/uI4663WuLOB9HqrtD9RAYwe3vNFMQEGW4VouE2gA1u5khT
        a0Xc7iRaVrgf8wijmmoX5otxsIMrMQ2D/tCx9LWO5OpmNd7l7+UNhYXDvrnFWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691607140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVAZNBEf9TZB47u+PP18kH0WXGdLWzh3aUx3yXvqMOA=;
        b=2Lst8U+dzkiLqSqIybdDkNYox+XXZcV24STjUE1iw2Qtu9xXh4UZYdENNN2Ug5ROv08bnH
        v3sHLgm4MtskHcAw==
To:     Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com, Vasant Hegde <vasant.hegde@amd.com>,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
In-Reply-To: <87fs4sjbw0.ffs@tglx>
References: <20230719051302.15801-1-vasant.hegde@amd.com> <87fs4sjbw0.ffs@tglx>
Date:   Wed, 09 Aug 2023 20:52:20 +0200
Message-ID: <87cyzwjbff.ffs@tglx>
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

On Wed, Aug 09 2023 at 20:42, Thomas Gleixner wrote:
> On Wed, Jul 19 2023 at 05:13, Vasant Hegde wrote:
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index e1aa2cd7734b..e5ca0689c4dd 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
>>  		if (cpu == this_cpu)
>>  			continue;
>>  		apicid = apic->cpu_present_to_apicid(cpu);
>> -		if (apicid == BAD_APICID)
>> +		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
>>  			continue;
>>  		send_init_sequence(apicid);
>>  	}

I think this papers over the underlying problem that this sends INIT to
an APIC which was never booted. The below is curing the root cause.

Thanks,

        tglx
---
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1356,7 +1356,7 @@ bool smp_park_other_cpus_in_init(void)
 	if (this_cpu)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
 		if (cpu == this_cpu)
 			continue;
 		apicid = apic->cpu_present_to_apicid(cpu);
