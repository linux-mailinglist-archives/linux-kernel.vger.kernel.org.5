Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1B7577BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGRJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjGRJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:20:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3E1BD9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vP4BnR5+UAXwr8ccPiRkOnhSD7l2j2ds39isA271TN8=; b=s/KfSexuRTjWdBD071KgTlnt8E
        3od+BhOLl2HE+XHESj4QHkiLYUJOShnKqQldO6LG2OqADpQYoZDCUyA9nsZJGEo2psw3nCBhd0IcI
        C79MNBOhH7oN2vL2D60mxP2ZDqWKESAyFRE+HTTQ+nkN6ggS9YmYlnlk8kh4f6gG5RYTR9BYF/WdN
        O299Gpy3IEGN5jLWh4GFAuISWqBkSvtwUKZ6H4c0/dznvAsVpd9zbTMqSVhJrszHobBOZk2GPaCRb
        KBVxMDa29zh055CDmU4yfcrHOE3c+PqpcwOSQuxeq/XdE02V87uZNPmj1+Zec5q+8XjZU+qJq50Cg
        BU+asd6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLgs6-004m2E-6x; Tue, 18 Jul 2023 09:19:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2C0530012F;
        Tue, 18 Jul 2023 11:19:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99AEB213727BB; Tue, 18 Jul 2023 11:19:50 +0200 (CEST)
Date:   Tue, 18 Jul 2023 11:19:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 57/58] x86/apic: Provide static call infrastructure for
 APIC callbacks
Message-ID: <20230718091950.GA3472843@hirez.programming.kicks-ass.net>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.476875329@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717223226.476875329@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:16:03AM +0200, Thomas Gleixner wrote:
> Declare and define the static calls for the hotpath APIC callbacks. Note
> this deliberately uses STATIC_CALL_NULL() because otherwise it would be
> required to have the definitions in the 32bit and the 64bit default APIC
> implementations and it's hard to keep the calls in sync. The other option
> would be to have stub functions for each callback type. Not pretty either
> 
> So the NULL capable calls are used and filled in during early boot after
> the static key infrastructure has been initialized. The calls will be
> static_call() except for the wait_irc_idle() callback which is valid to be
> NULL for X2APIC systems.
> 
> Update the calls when a new APIC driver is installed and when a callback
> override is invoked.
> 
> Export the trampolines for the two calls which are used in KVM and MCE
> error inject modules.
> 
> Test the setup and let the next step convert the inline wrappers to make it
> effective.

Perhaps preserve some of that in a comment?


> --- a/arch/x86/kernel/apic/init.c
> +++ b/arch/x86/kernel/apic/init.c
> @@ -5,6 +5,28 @@
>  
>  #include "local.h"
>  

/*
 * Uses DEFINE_STATIC_CALL_NULL() to avoid having to provide a (stub)
 * function at this time.
 *
 * All except wait_icr_idle *MUST* be set before usage.
 */

> +#define DEFINE_APIC_CALL(__cb)						\
> +	DEFINE_STATIC_CALL_NULL(apic_call_##__cb, *apic->__cb)
> +
> +DEFINE_APIC_CALL(eoi);
> +DEFINE_APIC_CALL(native_eoi);
> +DEFINE_APIC_CALL(icr_read);
> +DEFINE_APIC_CALL(icr_write);
> +DEFINE_APIC_CALL(read);
> +DEFINE_APIC_CALL(send_IPI);
> +DEFINE_APIC_CALL(send_IPI_mask);
> +DEFINE_APIC_CALL(send_IPI_mask_allbutself);
> +DEFINE_APIC_CALL(send_IPI_allbutself);
> +DEFINE_APIC_CALL(send_IPI_all);
> +DEFINE_APIC_CALL(send_IPI_self);
> +DEFINE_APIC_CALL(wait_icr_idle);
> +DEFINE_APIC_CALL(wakeup_secondary_cpu);
> +DEFINE_APIC_CALL(wakeup_secondary_cpu_64);
> +DEFINE_APIC_CALL(write);
> +
> +EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_mask);
> +EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_self);
