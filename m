Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E37696FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGaNB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGaNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D810B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690808482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fZsP6/H3e55fqk3Oug8372dOI508LLAdydr7NnpCDk=;
        b=Vo1u554c1kFRdbqhyWKzA90nB2GHRNmSkjyVWYW6iCHi07heoGlQrxy6VEmsaBMwe38Y4m
        eYEyforduji0+KfoaRHGCO/NNy0x0KsQe1NqL+mfTdRKMtxk/vkgbg5tBmhYnqCccjm4MI
        978zLzZOpKkuD9OKglGshMcHAY0ymTjNdI7IHMOfmo9HsA/RqN8rXMb1mHVBS5vM+bt+Al
        Et6wudhbiOW7bWrZMKdb6J8x8k/BBm40qo3Jabe3lNKor0fCRuW9szRZ6UZvrdbwSYGum5
        2kQ9iqWBbHZgflztm2jeTAxz5oVYIV4SF8sHufAmWQKmRgvdNbaUHHvieM5Dgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690808482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fZsP6/H3e55fqk3Oug8372dOI508LLAdydr7NnpCDk=;
        b=hEsZWrnMhv3ZTuF6QxCM7REisZg9XUFhqq66JrHrhnvLP8yblIfgEkzgBhKZIQuR/D/6KL
        FkJfBRsDGmPRclDw==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
In-Reply-To: <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com>
Date:   Mon, 31 Jul 2023 15:01:22 +0200
Message-ID: <87v8e0nskd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 13:31, Juergen Gross wrote:
> On 24.07.23 15:35, Thomas Gleixner wrote:
>>   static void __init xen_apic_check(void)
>>   {
>> -	if (apic == &xen_pv_apic)
>> -		return;
>> -
>> -	pr_info("Switched APIC routing from %s to %s.\n", apic->name,
>> -		xen_pv_apic.name);
>> -	apic = &xen_pv_apic;
>> +	apic_install_driver(&xen_pv_apic);
>>   }
>> +
>>   void __init xen_init_apic(void)
>>   {
>>   	x86_apic_ops.io_apic_read = xen_io_apic_read;
>>   	/* On PV guests the APIC CPUID bit is disabled so none of the
>>   	 * routines end up executing. */
>>   	if (!xen_initial_domain())
>> -		apic = &xen_pv_apic;
>> +		apic_install_driver(&xen_pv_apic);
>
> This is working, but it produces a WARN() splat when booting as an unprivileged
> Xen PV guest from static_call patching (static_call_init() hasn't been called
> yet).

Duh, yes. It's too early.

> The diff below on top is fixing the issue:
>
> diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
> index 1838aefc632f..84f24268670b 100644
> --- a/arch/x86/xen/apic.c
> +++ b/arch/x86/xen/apic.c
> @@ -163,14 +163,18 @@ static void __init xen_apic_check(void)
>          apic_install_driver(&xen_pv_apic);
>   }
>
> +void __init xen_apic_install(void)
> +{
> +       /*
> +        * On PV guests the APIC CPUID bit is disabled so none of the
> +        * routines end up executing.
> +        */
> +       apic_install_driver(&xen_pv_apic);
> +}
> +
>   void __init xen_init_apic(void)
>   {
>          x86_apic_ops.io_apic_read = xen_io_apic_read;
> -       /* On PV guests the APIC CPUID bit is disabled so none of the
> -        * routines end up executing. */
> -       if (!xen_initial_domain())
> -               apic_install_driver(&xen_pv_apic);
> -
>          x86_platform.apic_post_init = xen_apic_check;
>   }
>   apic_driver(xen_pv_apic);

I wonder whether this explicit install is actually needed at all.
Shouldn't the driver be installed via the APIC probing mechanism
automagically?

Thanks,

        tglx
