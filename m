Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD09758F07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGSH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjGSH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:29:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969B1BF0;
        Wed, 19 Jul 2023 00:29:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689751750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=la+1VWYWfra+WJMEPV43d5Bl0i3qTH4jzK21UuR8mBk=;
        b=EB49R7zQgA6Uzs6HCSv99HSzzKTppk2lR1AVjLRmTpaZQNNzBCSCpI5K9VkdAGzJhnsj84
        e7d9eiuLln9yXUDBvYa8uY8kjsWuu3S1Te633nupJTI52GTGLAQ2hgNyXH9Ms9rxU5yZ9F
        SfxrcoLnr76fXo5h0NMyYfxjVg/0ZAUQ+eDF3y0fRzYEkNOKBotMOD5qxkbRfsseZmSzkg
        FnJ8w3xDHMBwL2zPSZhkk9b0N5WtGHNdQTnFi6XmMC5fUXvEIPh9yC6QF7Asiz+iDO1+kO
        w00P1zWxipwvoecHJ7rQfWFqyhdsTPitx1u9geXyC9bPtn7xQAfRrLn4zf9doQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689751750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=la+1VWYWfra+WJMEPV43d5Bl0i3qTH4jzK21UuR8mBk=;
        b=xACXekdWaVw7qaz9GC31yStZGzpi0Z6RJOkiZkhvoyK4FvcBcLVnGuvcwjsIDb0lJ1Zwkq
        05IWgICZsBgAVeBQ==
To:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
In-Reply-To: <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
Date:   Wed, 19 Jul 2023 09:29:10 +0200
Message-ID: <87v8egwe9l.ffs@tglx>
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

On Wed, Jul 19 2023 at 12:25, Sandipan Das wrote:
> Depending on which CPU the CPUID instruction is executed, some leaves
> can report different values. There are cases where it may be required
> to know all possible values.
>
> E.g. for AMD Zen 4 processors, the ActiveUmcMask field from leaf
> 0x80000022 ECX, which provides a way to determine the active memory
> controllers, can have different masks on CPUs belonging to different
> sockets as each socket can follow a different DIMM population scheme.
> Each memory channel is assigned a memory controller (UMC) and if no
> DIMMs are attached to a channel, the corresponding memory controller
> is inactive. There are performance monitoring counters exclusive to
> each memory controller which need to be represented under separate
> PMUs. So, it will be necessary to know the active memory controllers
> on each socket during the initialization of the UMC PMUs irrespective
> of where the uncore driver's module init runs.
>
> Add a new helper that executes CPUID on a particular CPU and returns
> the EAX, EBX, ECX and EDX values.

NAK.

This madness has to stop. The correct thing is to parse the information
in CPUID at the point where the CPU comes online and store it for easy
consumption.

I'm in the process of reworking the CPUID and topology evaluation and
that's where these things need to be stored. I'm still fighting some
nightmares with the already existing mess.

Look at the mess people created over time here:

     https://lore.kernel.org/lkml/20230717223049.327865981@linutronix.de

No need to add more insanities to it. IOW, this has to wait for a week
or two until I settled the remaining issues.

Thanks

        tglx
