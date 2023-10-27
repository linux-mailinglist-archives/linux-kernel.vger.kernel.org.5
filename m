Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699B7DA142
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjJ0TY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0TYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036B1A6;
        Fri, 27 Oct 2023 12:24:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698434691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6gnZpsQuWc7QehQoZvEcvl+2gz1FD+UGg7ogB7c+Mw=;
        b=fztehdxZgXdYiuafxUo0BfgKIezeZzAeY128OpSvoDNhdoFlFLazsML0vZRHoiZJ40ArvJ
        qhAaZCKvSnVJFErH+aU9kf1ojRtZSV2wjicVOm6U+YExMn7l3Dp7PkgY1I4/IVur/tAvgw
        4qIM+LPr/fO9o0l9VDxjAUlLE46OLJ/0OibI2idTKI4CiDl8PG00saEEwtehr6/wPdUtnx
        J0xQVNOVZEmKVv9sTYKCWpGuB4UXrYQnO0KQQ4ERF1AztZBKy7w5zBZKEsLcH86cUtvUC6
        3M9ii5AywCRefRvANIAiT8DKV3Zz1Ox548hXrrjdTYNm7kfsUAZvrrEcTTDt8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698434691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6gnZpsQuWc7QehQoZvEcvl+2gz1FD+UGg7ogB7c+Mw=;
        b=pv7w3r2F7uuzJtN4Rc2L0gETerL1TJKOQDhA0+r2uQg45RN0nmClkiMNs/zJXDADeCU6L2
        2jym8hNyfoJFKeCA==
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
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 0/2] Fixes for s3 with parallel bootup
In-Reply-To: <20231026170330.4657-1-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
Date:   Fri, 27 Oct 2023 21:24:51 +0200
Message-ID: <87zg0327i4.ffs@tglx>
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

On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
> Parallel bootup on systems that use x2apic broke suspend to ram.
> This series ensures x2apic is re-enabled at startup and fixes an exposed
> pre-emption issue.

The PMU issue has absolutely nothing to do with parallel bootup.

Can you please describe stuff coherently?
