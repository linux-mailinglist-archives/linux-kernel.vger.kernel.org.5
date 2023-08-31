Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2B78E5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbjHaFkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjHaFkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:40:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4CE5B;
        Wed, 30 Aug 2023 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693460387;
        bh=8m/8Ci3sa8OLEyHjaXZEJTO2wXEm7Bvjz3TlOzE6bbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q2MEeOwr8M1AuORuEQ5KRfFTsIx+MHUC53Rtduh6gcGpX0Dor0A0mjF6kX6ZAYDxY
         huCG/u/O/1KEWUV74Xt62PpgalNhLxuG90jvRAqIPItY+4cNk0o+d3sgsR1IPWLROv
         kCP31+Nm86zCo0ldItGFP1lnJpUSN0/VOQKwdpqWQa6LnBcsFbUghWsnQUL/MSetvx
         QkjjQmLYsHGn50Xa6XoW75hIhcEztSupYHliuy+EAnntJ7pX2/FY9cZrG43M5O2f/X
         CXrP9HdE/rZhGCfH4SE3qbi1sGMQLcnAO6ZMi+tj9Og3NXeA57JZV4UME5UWmBSNgo
         HvE5CpHTw4Zjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rbqjt6xfsz4wxN;
        Thu, 31 Aug 2023 15:39:46 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
Date:   Thu, 31 Aug 2023 15:39:46 +1000
Message-ID: <87v8cv22jh.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
>  	Hi Liam,
>
> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
>> The current implementation of append may cause duplicate data and/or
>> incorrect ranges to be returned to a reader during an update.  Although
>> this has not been reported or seen, disable the append write operation
>> while the tree is in rcu mode out of an abundance of caution.
>>
>> During the analysis of the mas_next_slot() the following was
>> artificially created by separating the writer and reader code:
>>
>> Writer:                                 reader:
>> mas_wr_append
>>    set end pivot
>>    updates end metata
>>    Detects write to last slot
>>    last slot write is to start of slot
>>    store current contents in slot
>>    overwrite old end pivot
>>                                        mas_next_slot():
>>                                                read end metadata
>>                                                read old end pivot
>>                                                return with incorrect range
>>    store new value
>>
>> Alternatively:
>>
>> Writer:                                 reader:
>> mas_wr_append
>>    set end pivot
>>    updates end metata
>>    Detects write to last slot
>>    last lost write to end of slot
>>    store value
>>                                        mas_next_slot():
>>                                                read end metadata
>>                                                read old end pivot
>>                                                read new end pivot
>>                                                return with incorrect range
>>    set old end pivot
>>
>> There may be other accesses that are not safe since we are now updating
>> both metadata and pointers, so disabling append if there could be rcu
>> readers is the safest action.
>>
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> ("maple_tree: disable mas_wr_append() when other readers are
> possible") in v6.5, and is being backported to stable.
>
> On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> following warning:
>
>       clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
>       sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
>       /soc/timer@e803b000: used for clocksource
>       /soc/timer@e803c000: used for clock events
>      +------------[ cut here ]------------
>      +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
>      +Interrupts were enabled early
...
>
> I do not see this issue on any other platform
> (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
> RCU configuration.

There's something similar on pmac32 / mac99.

> Do you have a clue?

It seems something in the maple tree code is setting TIF_NEED_RESCHED,
and that causes a subsequent call to cond_resched() to call schedule()
and enable interrupts.

On pmac32 enabling CONFIG_DEBUG_ATOMIC_SLEEP fixes/hides the problem.
But I don't see why.

cheers
