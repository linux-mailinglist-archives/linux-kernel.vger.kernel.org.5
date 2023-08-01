Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D483476AACF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHAIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHAIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:23:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A16E0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:23:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690878195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNPi1oOU5M8df8YEQLwunRsvnR4t3k5RWznSjqk62pY=;
        b=ZprAeylkenkCRZ6Y3VuvgzII88TrO0euVIP30q5AQ1B1wA/T0XnMczjFNuQVpEGvFPaG+D
        rCx3CRFAdWHYOdbz3G1vkTA/9u8MEXmR6sOOZn04PSTmWoNYmUnt8M/SmTZMGkkk43yqGJ
        6KLd4eAsai0Ex43EqEI4OMuoHMjUp0OZukgWVZBqoEjQ2DUr+aLpdMyOpZ6y/ftuw6P7qz
        mFzgTh/RX7tm+WXrbSQUdcJY3iwTL/jkHilDauzDJfWVMPP671vW55rhOIyM8ZEF7BpdG5
        ThtG3nd8PZq5N+wXutvynXAR3+1lwdC74niDBcDVBbUBqOVMqQ1fLQItEv8FVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690878195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNPi1oOU5M8df8YEQLwunRsvnR4t3k5RWznSjqk62pY=;
        b=6cYwlSK5ZosWje+OVrjHn3FPDmR8NWD4j2lWK19NwzyKdHUlYmVIoxrqsJJyEMi8Ki2McE
        dGhkEtDv2g2lG6Bg==
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
In-Reply-To: <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com> <87o7jrkyjf.ffs@tglx>
 <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com>
Date:   Tue, 01 Aug 2023 10:23:14 +0200
Message-ID: <87il9zkw7h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2023 at 09:37, Juergen Gross wrote:
> On 01.08.23 09:32, Thomas Gleixner wrote:
>> On Tue, Aug 01 2023 at 09:08, Juergen Gross wrote:
>>> On 01.08.23 08:49, Juergen Gross wrote:
>>>    void __init xen_init_apic(void)
>>>    {
>>>           x86_apic_ops.io_apic_read = xen_io_apic_read;
>>> -       /* On PV guests the APIC CPUID bit is disabled so none of the
>>> -        * routines end up executing. */
>>> -       if (!xen_initial_domain())
>>> -               apic_install_driver(&xen_pv_apic);
>>> -
>>>           x86_platform.apic_post_init = xen_apic_check;
>> 
>> I don't think this one is needed.
>
> Indeed.

Can you send a real patch please which I can add to that pile at the
right place?

Thanks,

        tglx
