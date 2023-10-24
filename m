Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122CC7D4C86
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJXJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJXJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:33:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB38325F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:32:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079fa1bbf8so6212208e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139965; x=1698744765; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Rw/jYGs06Fd+viAjMbCyeWD4YePZEfjBTa+fHZnvXM=;
        b=TKsliD6C9IGNPZuulIXHhGuONKlzR/xSncvnAoVJUMMGQ20QLqPDMc2kogryAxtmzt
         xIPFdy2v/ActgUg4XMdMgO1zdQe7k3Ar/3O4hYZ2qaf8FtIEtV9erG9x8+rpCtaAe1vj
         STd3FW2vELOP9I3Iar5ewRA16koAz0K8uzu2bWtBsJfk+etTo8XH815Zyd2or/HQiwoU
         kyWvssfSzNyhl/3+qOtzNNo6TfvjBpDA6U+nYifNGJkpw6EBfNbDwGOOlVutJnn00nmR
         Xtfq6G2HH0r071KzeX4G+bbEFZNgC5Wa8mkCX5zcUmBCg82Dm0++KGfks6ZJOuVDumvh
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139965; x=1698744765;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Rw/jYGs06Fd+viAjMbCyeWD4YePZEfjBTa+fHZnvXM=;
        b=oZvhrxj29urdAnfTLO08lsO+XYiWULm9Z3PfqeAerzxfIb48UpDNqiTtY23TGuZ5Cv
         OWevY2rn2MRZZX3NRB8Y1z1tmeA5n+q4ThQxoiQKYDyDQlrh8K00kxGEOaezYI08Hl6+
         2LxDtS3WtigDI1CspNlNA213uCji7gQfR2xR41gSAUxmuQNzo6ynrJs+pqidZOkFCK1L
         M3EJJr3/soEY9oBbKyaoIr4YBX6i/jfEE0AwJIG7HysR4h1NT/0EgKcyVvgyxtKNr4EF
         QPGyiIFRx6+YYsnfQobm/XF/LVY9KxvIwyAUzfwi9xjz6kAb/tE0cXjNF7XNTtGyjWx0
         RlMQ==
X-Gm-Message-State: AOJu0YxwsMMkYwEy06MVzmwoZr8N/MMLF0mTd2nCxlk2SBxh6ykWqMRj
        LLvcNMdORAklyIYigVGh73aZ/g==
X-Google-Smtp-Source: AGHT+IFxlTzrN8/W7frKk9B975akFVD/HyCjPVnWB73dVpbGyDcneRj0f2SEoX2NIvY9qHyCsm3pgg==
X-Received: by 2002:ac2:4202:0:b0:500:9214:b308 with SMTP id y2-20020ac24202000000b005009214b308mr8046002lfh.65.1698139965282;
        Tue, 24 Oct 2023 02:32:45 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id c12-20020ac25f6c000000b004fbc82dd1a5sm2063075lfc.13.2023.10.24.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:32:44 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:32:43 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 00/19] stackdepot: allow evicting stack traces
Message-ID: <20231024093243.GA3298341@mutt>
References: <cover.1698077459.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-23 18:22, andrey.konovalov@linux.dev wrote:
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
> 
> Implementing #1 in the stack depot is impossible with the current
> keep-forever approach. This series targets to address that. Issue #2 is
> left to be addressed in a future series.
> 
> This series changes the stack depot implementation to allow evicting
> unneeded stack traces from the stack depot. The users of the stack depot
> can do that via new stack_depot_save_flags(STACK_DEPOT_FLAG_GET) and
> stack_depot_put APIs.
> 
> Internal changes to the stack depot code include:
> 
> 1. Storing stack traces in fixed-frame-sized slots; the slot size is
>    controlled via CONFIG_STACKDEPOT_MAX_FRAMES (vs precisely-sized
>    slots in the current implementation);
> 2. Keeping available slots in a freelist (vs keeping an offset to the next
>    free slot);
> 3. Using a read/write lock for synchronization (vs a lock-free approach
>    combined with a spinlock).
> 
> This series also integrates the eviction functionality in the tag-based
> KASAN modes.
> 
> Despite wasting some space on rounding up the size of each stack record,
> with CONFIG_STACKDEPOT_MAX_FRAMES=32, the tag-based KASAN modes end up
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
> There is no measurable boot time performance impact of these changes for
> KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
> depot without performance optimizations is not suitable for intended use
> of those anyway), but I expect a similar result. Obtaining and copying
> stack trace frames when saving them into stack depot is what takes the
> most time.
> 
> This series does not yet provide a way to configure the maximum size of
> the stack depot externally (e.g. via a command-line parameter). This will
> be added in a separate series, possibly together with the performance
> improvement changes.
> 
> ---
> 
> Changes v2->v3:
> - Fix null-ptr-deref by using the proper number of entries for
>   initializing the stack table when alloc_large_system_hash()
>   auto-calculates the number (see patch #12).
> - Keep STACKDEPOT/STACKDEPOT_ALWAYS_INIT Kconfig options not configurable
>   by users.
> - Use lockdep_assert_held_read annotation in depot_fetch_stack.
> - WARN_ON invalid flags in stack_depot_save_flags.
> - Moved "../slab.h" include in mm/kasan/report_tags.c in the right patch.
> - Various comment fixes.
> 
> Changes v1->v2:
> - Rework API to stack_depot_save_flags(STACK_DEPOT_FLAG_GET) +
>   stack_depot_put.
> - Add CONFIG_STACKDEPOT_MAX_FRAMES Kconfig option.
> - Switch stack depot to using list_head's.
> - Assorted minor changes, see the commit message for each path.
> 
> Andrey Konovalov (19):
>   lib/stackdepot: check disabled flag when fetching
>   lib/stackdepot: simplify __stack_depot_save
>   lib/stackdepot: drop valid bit from handles
>   lib/stackdepot: add depot_fetch_stack helper
>   lib/stackdepot: use fixed-sized slots for stack records
>   lib/stackdepot: fix and clean-up atomic annotations
>   lib/stackdepot: rework helpers for depot_alloc_stack
>   lib/stackdepot: rename next_pool_required to new_pool_required
>   lib/stackdepot: store next pool pointer in new_pool
>   lib/stackdepot: store free stack records in a freelist
>   lib/stackdepot: use read/write lock
>   lib/stackdepot: use list_head for stack record links
>   kmsan: use stack_depot_save instead of __stack_depot_save
>   lib/stackdepot, kasan: add flags to __stack_depot_save and rename
>   lib/stackdepot: add refcount for records
>   lib/stackdepot: allow users to evict stack traces
>   kasan: remove atomic accesses to stack ring entries
>   kasan: check object_size in kasan_complete_mode_report_info
>   kasan: use stack_depot_put for tag-based modes

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Applied this patchset to linux-next tag next-20231023 and built an arm64
kernel and that
booted fine in QEMU.

Cheers,
Anders
