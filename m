Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2878DE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjH3S50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbjH3Hqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:46:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEDCD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A2CC211F0;
        Wed, 30 Aug 2023 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693381599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EanoFzDaTgMOXfxRNHB3pneacsX9gjh73UwzM6zHsNY=;
        b=RGKsMd137LZvFuwE2UMMnEwPTDchyrEcqjNhU8q/CQRBO9QhsUQCYaCLOSBV8lXjYk/wt5
        zwin6CRrkjyorL+MrsY6txHoednnKHUlC/jFeJ9Lg3LfdrUiuIqwewQH4Kz8NC1pfj6j5c
        Moff718SbPh0UzkCjd+XLwIO+x9xogg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693381599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EanoFzDaTgMOXfxRNHB3pneacsX9gjh73UwzM6zHsNY=;
        b=cIVPYGUGjHHR1r+owsycvW3ch6HxCt7bozmDHlJasyzELFISfGRZoT/mFQJKTgsRxEwyaQ
        NgmSP4RkIYQbQ4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EF0A1353E;
        Wed, 30 Aug 2023 07:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cD+pCt/z7mTlYQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 30 Aug 2023 07:46:39 +0000
Message-ID: <3948766e-5ebd-5e13-3c0d-f5e30c3ed724@suse.cz>
Date:   Wed, 30 Aug 2023 09:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 00/15] stackdepot: allow evicting stack traces
Content-Language: en-US
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 19:11, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, the stack depot grows indefinitely until it reaches its
> capacity. Once that happens, the stack depot stops saving new stack
> traces.
> 
> This creates a problem for using the stack depot for in-field testing
> and in production.
> 
> For such uses, an ideal stack trace storage should:
> 
> 1. Allow saving fresh stack traces on systems with a large uptime while
>    limiting the amount of memory used to store the traces;
> 2. Have a low performance impact.

I wonder if there's also another thing to consider for the future:

3. With the number of stackdepot users increasing, each having their
distinct set of stacks from others, would it make sense to create separate
"storage instance" for each user instead of putting everything in a single
shared one?

In any case, evicting support is a good development, thanks!

> Implementing #1 in the stack depot is impossible with the current
> keep-forever approach. This series targets to address that. Issue #2 is
> left to be addressed in a future series.
> 
> This series changes the stack depot implementation to allow evicting
> unneeded stack traces from the stack depot. The users of the stack depot
> can do that via a new stack_depot_evict API.
> 
> Internal changes to the stack depot code include:
> 
> 1. Storing stack traces in 32-frame-sized slots (vs precisely-sized slots
>    in the current implementation);
> 2. Keeping available slots in a freelist (vs keeping an offset to the next
>    free slot);
> 3. Using a read/write lock for synchronization (vs a lock-free approach
>    combined with a spinlock).
> 
> This series also integrates the eviction functionality in the tag-based
> KASAN modes. (I will investigate integrating it into the Generic mode as
> well in the following iterations of this series.)
> 
> Despite wasting some space on rounding up the size of each stack record
> to 32 frames, with this change, the tag-based KASAN modes end up
> consuming ~5% less memory in stack depot during boot (with the default
> stack ring size of 32k entries). The reason for this is the eviction of
> irrelevant stack traces from the stack depot, which frees up space for
> other stack traces.
> 
> For other tools that heavily rely on the stack depot, like Generic KASAN
> and KMSAN, this change leads to the stack depot capacity being reached
> sooner than before. However, as these tools are mainly used in fuzzing
> scenarios where the kernel is frequently rebooted, this outcome should
> be acceptable.
> 
> There is no measurable boot time performace impact of these changes for
> KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
> depot without performance optimizations is not suitable for intended use
> of those anyway), but I expect a similar result. Obtaining and copying
> stack trace frames when saving them into stack depot is what takes the
> most time.
> 
> This series does not yet provide a way to configure the maximum size of
> the stack depot externally (e.g. via a command-line parameter). This will
> either be added in the following iterations of this series (if the used
> approach gets approval) or will be added together with the performance
> improvement changes.
> 
> Andrey Konovalov (15):
>   stackdepot: check disabled flag when fetching
>   stackdepot: simplify __stack_depot_save
>   stackdepot: drop valid bit from handles
>   stackdepot: add depot_fetch_stack helper
>   stackdepot: use fixed-sized slots for stack records
>   stackdepot: fix and clean-up atomic annotations
>   stackdepot: rework helpers for depot_alloc_stack
>   stackdepot: rename next_pool_required to new_pool_required
>   stackdepot: store next pool pointer in new_pool
>   stackdepot: store free stack records in a freelist
>   stackdepot: use read/write lock
>   stackdepot: add refcount for records
>   stackdepot: add backwards links to hash table buckets
>   stackdepot: allow users to evict stack traces
>   kasan: use stack_depot_evict for tag-based modes
> 
>  include/linux/stackdepot.h |  11 ++
>  lib/stackdepot.c           | 361 ++++++++++++++++++++++++-------------
>  mm/kasan/tags.c            |   7 +-
>  3 files changed, 249 insertions(+), 130 deletions(-)
> 

