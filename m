Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA287594A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjGSLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGSLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:51:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B38170F;
        Wed, 19 Jul 2023 04:50:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689767455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7h+KH/omTFY2W2ky+xbCPhNySLWmWU60lnSpyss0CM=;
        b=viuCzRZD3USkMXyBZjlheY4+g9MGsrGUO29XYYvojVkrASWHqd1xmpdD2R+9W242qG7gFY
        DcpBhdeIUhD2Y5DNpDJYp/mNXI5NKOqPWD+KmyoqwXJPL+UX5cXlSawlcn4/ScdbHjyDDY
        K4DlUR2fXvgjH5yTycbVoUS4s7nhFqBv+3V9hRbzbo+njKKENGXtI7+bzXia8tmQfpqRt/
        /XUB0sdl6K6eYpp56eD9VUEkFEFnQnccQeBmLF9hSSmocrMDEcISdt5W1Cl99k7S0pMEYB
        sWZzt/InbBLE7ikkyBVKhKrKUK0+IWgGz04lJEn3Q4jAj6Cb7cZTijE5gBSgzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689767455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7h+KH/omTFY2W2ky+xbCPhNySLWmWU60lnSpyss0CM=;
        b=eY7emreGayYqGFikikjd9+TMgLI5w4icVeewdxgLSYOvQU3Wte+kGvZSsu3kqT1/1uV1vs
        7tJOxE+YrGH8zTAQ==
To:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
In-Reply-To: <87v8egwe9l.ffs@tglx>
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
 <87v8egwe9l.ffs@tglx>
Date:   Wed, 19 Jul 2023 13:50:55 +0200
Message-ID: <87mszsw25c.ffs@tglx>
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

On Wed, Jul 19 2023 at 09:29, Thomas Gleixner wrote:
> On Wed, Jul 19 2023 at 12:25, Sandipan Das wrote:
>> Depending on which CPU the CPUID instruction is executed, some leaves
>> can report different values. There are cases where it may be required
>> to know all possible values.
>> Add a new helper that executes CPUID on a particular CPU and returns
>> the EAX, EBX, ECX and EDX values.
>
> NAK.
>
> This madness has to stop. The correct thing is to parse the information
> in CPUID at the point where the CPU comes online and store it for easy
> consumption.
>
> I'm in the process of reworking the CPUID and topology evaluation and
> that's where these things need to be stored. I'm still fighting some
> nightmares with the already existing mess.
>
> Look at the mess people created over time here:
>
>      https://lore.kernel.org/lkml/20230717223049.327865981@linutronix.de
>
> No need to add more insanities to it. IOW, this has to wait for a week
> or two until I settled the remaining issues.

Actually you can do that today already. Either make it part of the CPUID
evaluation or use the perf hotplug callback mechanism which is invoked
early on the upcoming CPU and read that CPUID leaf.

