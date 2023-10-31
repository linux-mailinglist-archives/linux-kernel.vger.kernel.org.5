Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624127DD935
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376862AbjJaXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjJaXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:20:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C5B9;
        Tue, 31 Oct 2023 16:20:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698794404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/p/v8DdsTAZhW4x3hK+e7JbziGQicpp1+UHXRj/vRA=;
        b=BnNetGtUP9ff8iPafgQ0VEqe6AlCzxod9HOd2S9FMBZZkDmTfyffLejEYXASGuzM2nm+LD
        4Ze3LU6JN8EJCZD4lYllj6x04CC7Hvbuh2UmWkn+QO/aXwAaQzcmWjR7qZUiBRYeDFqrcq
        5yxuA6w3Xxj812med+rzWFF5NNtWbpp9bIuw6eyjNkQdIe79t4klfKrby5Gj+jnJmekldx
        H+GiejPioQLRadAEx5eE8H6LW3s+VQG463dJROp2HEbnr6Ufv55Q1IG+p6pONcBqG7LEbw
        pxSj0lwtrX+PDIh2mrkOFyL4ueMmqOG5zIGNahjCxvpzSVxiUJkM1mbxRuNQhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698794404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/p/v8DdsTAZhW4x3hK+e7JbziGQicpp1+UHXRj/vRA=;
        b=ZtxTAzZTLE9riytuBh2qcv66tw7avJVdutgXfFYtV3iiwCG0lUneDYQHOW7Gb7uoAC7jl7
        NrgeDp7OsHRQNeAg==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
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
Subject: Re: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if
 used previously
In-Reply-To: <d7c3a03e-6f52-4bcf-aaae-668f6601ceb8@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <20231026170330.4657-2-mario.limonciello@amd.com> <87wmv721nm.ffs@tglx>
 <d7c3a03e-6f52-4bcf-aaae-668f6601ceb8@amd.com>
Date:   Wed, 01 Nov 2023 00:20:03 +0100
Message-ID: <878r7imlb0.ffs@tglx>
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

On Tue, Oct 31 2023 at 13:53, Mario Limonciello wrote:
> Thank you for looking this over.  I've reviewed it with the internal 
> team and confirmed there was a BIOS bug where the MSR wasn't restored 
> after the S3 cycle completed.  The BIOS team has fixed it.

Why am I not surprised?

Thanks for the heads up!

       tglx
