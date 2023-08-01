Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209476A959
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjHAGmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjHAGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:41:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1822108
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:41:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690872105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBmFkPqdo0aoTqt5xpuNYhr8rIxwQXREZDwVW4ghi7A=;
        b=uzM3+h7FIIWrT0bR6Ry7DlQPN0wY7/RCrFczwOLs1doln2n841WCpcrQCrhD64STWPPhpI
        iy0mhMl8dCHNjH7K0/SUkFxleJlFj28x/hJaBs11X3yuAPNTnhFx1BRu+cucG06a9AZ693
        tqvTRxCb5VTflr1BYHI+oJ0PwBBPm4zlZ2GtI96SLSXRzuYCg6uUVKSbNDaH1N0gqTXnfL
        AagP1aev5GbDMSR0whWpKpUVMZFwJ8EBxVd8/bWiqm2ON31n5JLe91nLEQDCXN8jrHSbys
        fJ1LtwwG2E8T3XE+ek7S6PEi2tZUuax1EcEAXgTCTmuRlGCWthx+QDG23hwoVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690872105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBmFkPqdo0aoTqt5xpuNYhr8rIxwQXREZDwVW4ghi7A=;
        b=HsLkurgmYEixfFvyupoR/PvAD2XFNGzHKi1I4WyQGOW9rHpG3o9vWXnQI9kSAnwZzxruon
        7wLU+8YLw0QQHMCg==
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
In-Reply-To: <87pm48nktc.ffs@tglx>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
Date:   Tue, 01 Aug 2023 08:41:45 +0200
Message-ID: <87v8dzl0wm.ffs@tglx>
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

On Mon, Jul 31 2023 at 17:48, Thomas Gleixner wrote:

> On Mon, Jul 31 2023 at 15:10, Juergen Gross wrote:
>> On 31.07.23 15:01, Thomas Gleixner wrote:
>>>>    apic_driver(xen_pv_apic);
>>> 
>>> I wonder whether this explicit install is actually needed at all.
>>> Shouldn't the driver be installed via the APIC probing mechanism
>>> automagically?
>>
>> Only in case x86_init.irq.intr_mode_init is set appropriately. Today it is
>> a nop for Xen PV, but that can be changed. I'll have a look.
>
> You could simply set that callback to default_setup_apic_routing() and
> be done with it.

Doesn't work because XEN overrides it already. So sure, lets just go
with the solution you proposed. One more ugly or less in XEN/PV does not
really matter much :)

Let me grab this and put it into the right position in the queue.

Thanks,

        tglx

