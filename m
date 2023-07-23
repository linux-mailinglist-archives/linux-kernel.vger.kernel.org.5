Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355AE75E1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGWMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGWMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:32:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D47C4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:32:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690115533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlxPcacsL4aIT5BrUbojBctYLsVxzNajJmYLpnonv1E=;
        b=t6cYa/jwJ0GIQsOmaX+zgLHfougTOLub3zzT5qDk1VqsuZtJxemInE3fu7Z8wpn2OhHWxd
        XM+1dM4BBdWiNq4IwQUEDSRh1mqDeljqwhFX/IvFMzGcjIOucJ/z9oR3yX8cCaiftqzdEs
        pryaIwmKo1+VQRR9rdVmBHJR6WlnlhGcv48ZE7DZRRXDhkCuolvJaMUCAEDoc34H2VUbBA
        KNRrDSTPsv9Uzv+vnkHPqAUPJxNeEIJi0oRm7NAIaz1udtZLHFxVe+iHlp/XsNGX3YxcKK
        DDlQ6hqmGh1UrvxAeJ7M3WaXScQ1LKKkwr1z4IxX5h0CXZ9RCRVQleZE9o/JXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690115533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlxPcacsL4aIT5BrUbojBctYLsVxzNajJmYLpnonv1E=;
        b=GRi9fQZhXp6P8k3WKbaOwMGs7X52ahnC/bxEx/cToeT4wdqj7blUNQ0Yi/PSeI/vZ2eXN9
        eX98eHmak+C6c9AQ==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 53/58] x86/apic: Convert other overrides to
 apic_update_callback()
In-Reply-To: <BYAPR21MB168815CC86ADC0E33A19BCF7D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.237896259@linutronix.de>
 <BYAPR21MB168815CC86ADC0E33A19BCF7D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Sun, 23 Jul 2023 14:32:12 +0200
Message-ID: <87edkyvmer.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21 2023 at 17:49, Michael Kelley wrote:
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -624,8 +624,8 @@ late_initcall(setup_efi_kvm_sev_migratio
>>   */
>>  static void kvm_setup_pv_ipi(void)
>>  {
>> -	apic->send_IPI_mask = kvm_send_ipi_mask;
>> -	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
>> +	apic_update_callback(send_IPI_mask, kvm_send_ipi_mask);
>> +	apic_update_callback(send_IPI_mask_allbutself,
>> kvm_send_ipi_mask_allbutself);
>>  	pr_info("setup PV IPIs\n");
>>  }
>> 
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -1099,7 +1099,7 @@ void snp_set_wakeup_secondary_cpu(void)
>>  	 * required method to start APs under SNP. If the hypervisor does
>>  	 * not support AP creation, then no APs will be started.
>>  	 */
>> -	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
>> +	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
>
> I'm getting a build warning from the above:
>
> section mismatch in reference: snp_set_wakeup_secondary_cpu+0x35 (section: .text) -> __x86_apic_override (section: .init.data)

snp_set_wakeup_secondary_cpu() wants to be __init. So does
kvm_setup_pv_ipi(). Sigh.
