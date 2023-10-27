Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6D7DA2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjJ0Vuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Vui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:50:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60451B5;
        Fri, 27 Oct 2023 14:50:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698443434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkILUqwqrraMqZjxG6n6efB1Hqc2b1hkA5CpetbdHWk=;
        b=KI86MEfEM4VXKns1K+hOAvzMDzwY0Z7KduIurPmGv74uYAz8Wj6pr4LMGKMZ12wBKAyA69
        genCcOSpV8EcqEk/YqaMbH+skffgSwgXznlk4+33cl/bq8Kh0hFa4ohvR6TCCdydaOP1e7
        r42MNuXZSMt11NKYvOOWjjBCsJbOHSSjRo1grwvAGjsS9qb6mKTz8AgUTbVM0bjOMI9LxX
        imo4GABJWUjo6Qw/nfJsT9nq4MwLgYR3DSjwP04kHMxlJN80bvVmpt3heAwcSbVIRyAwtq
        dgwJk1Y3sCLBVXwAJOpzQweT4vWRIZk3iWXRb0th6stOqv/6beZ1yJY6drRF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698443434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkILUqwqrraMqZjxG6n6efB1Hqc2b1hkA5CpetbdHWk=;
        b=xcZk7Apxiyk+Poe14k36DHbPGxwC4I61RejgcN6QurYm3dvvgCmkzqRwHDgft9ncStH4Cd
        AW8UZd9HvNf1duCA==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fixes for s3 with parallel bootup
In-Reply-To: <de56ddad-ee57-4ff0-b384-522c05e88c91@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <87zg0327i4.ffs@tglx> <de56ddad-ee57-4ff0-b384-522c05e88c91@amd.com>
Date:   Fri, 27 Oct 2023 23:50:33 +0200
Message-ID: <87r0lf20ra.ffs@tglx>
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

On Fri, Oct 27 2023 at 14:29, Mario Limonciello wrote:
> On 10/27/2023 14:24, Thomas Gleixner wrote:
>> On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
>>> Parallel bootup on systems that use x2apic broke suspend to ram.
>>> This series ensures x2apic is re-enabled at startup and fixes an exposed
>>> pre-emption issue.
>> 
>> The PMU issue has absolutely nothing to do with parallel bootup.
>> 
>> Can you please describe stuff coherently?
>
> They are both issues found with S3 testing.
> The PMU issue wasn't being observed with cpuhp.parallel=0.

It does not matter whether you cannot observe it under a certain
conditions. What matters is the proper analysis of the root cause and
that is clearly neither related to suspend nor cpuhp.parallel=0.

Stop this 'fix the symptom' approach before it becomes a habit.

Thanks,

        tglx
