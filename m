Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2276F62C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjHCXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHCXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:35:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863683A80
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:35:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691105712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNIZsz7Uy9J+9e7wlUTJZ/RfSxx4OLys5HkfkLE141U=;
        b=o/X3JDrK5yV7fjGa4Jwt95K2D/cF9DcRu3fMjlyCtNQAmgCV5hCXkLcq/gMnBCrSkt/g0W
        3jspwlTdyOSpSMYYR+GSYZernyt+ZZhZcb5ZiUJR9EJVZC78s7OMICMPSrIfwm8feIYV43
        3wk9jUT3jk22E2t3tLA8jTgijbfbvZ1CcRGpbJKtiNx5rtlIxcfmkGQlXsc3d1l3kCaeIc
        mNIB5xLS42w7yWdGViV47Fbr+cS67Z4TC5qoABU95VxYZf9MFnm06ahiF4R96SzHV/w/uX
        NYviDEf2USn1MvHhxgAn1P22XXblsypBTrcnMKFh8KStp5iLac1YV7ZB0e1XWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691105712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNIZsz7Uy9J+9e7wlUTJZ/RfSxx4OLys5HkfkLE141U=;
        b=01kYXFgWiFCY7BZe8PLkpjAQhA8tlu54QvS6F+1tynueajsBsCAB3Je70idPLreirCN8xr
        2a6stnAHOW4MgzDQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V3 12/60] x86/of: Fix the APIC address registration
In-Reply-To: <973ae60f-15cd-19a3-7314-d165696b833c@intel.com>
References: <20230801103042.936020332@linutronix.de>
 <20230801103815.818545643@linutronix.de>
 <973ae60f-15cd-19a3-7314-d165696b833c@intel.com>
Date:   Fri, 04 Aug 2023 01:35:11 +0200
Message-ID: <87r0oj1yz4.ffs@tglx>
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

On Thu, Aug 03 2023 at 15:42, Dave Hansen wrote:
> On 8/1/23 03:46, Thomas Gleixner wrote:
>> The device tree APIC parser tries to force enable the local APIC when it is
>> not set in CPUID. apic_force_enable() registers the boot CPU apic on
>> success.
>
> I went looking for how this registration happens.  I was expecting to
> see something apic_force_enable() do something similar to
> register_lapic_address().
>
> But the apic_force_enable()=>apic_verify() call chain is pretty shallow
> and I'm not seeing a lot of overlap.

apic_verify() ends up invoking register_lapic_address() on success, no?

