Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8107C4AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJKGsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjJKGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:48:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF23D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:48:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so4861278b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697006883; x=1697611683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvJzdWEei3vm+cyllCn0Yt5sDu8HKo9ilXpS5O+OweM=;
        b=ofroL2l0fYaZ2t0zR+w388j7A+apxY8GlE7JPNRLhHpBK9jfeeKvTjPJ3ewsxNgnby
         hS5jsSf2RkDcfIYOkITKjkHEX2sOyS4TX1Mf9bUqprhxdox26rFsfg/ECkgRxpC9JOqK
         MbbExVLGIsnVXkl6Rk55PetSMcGYVbJMqJZwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006883; x=1697611683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvJzdWEei3vm+cyllCn0Yt5sDu8HKo9ilXpS5O+OweM=;
        b=H28b9RXKyqO2nR8NVGVd3FDu+ZXpLiMtTemg2dO4il8LrqLM8eKlzX3zqzmv7h1zGu
         e8DyCJ51pJlkOGt062O/waKeVBOUtj27gbwDYTzEcsQ5l4nA7NX/GRpFrlAOvuSFu3SP
         BXhuI9bLujvk72OgPZ42QW/1pKixpDqFblFHwqtYAeiFyCnyCdtpRT2UwF6RvqXWqZmT
         rr2NYL9nAJHGRVvSs/Tz9P6TbP5LeFfKT4edju0QsDkKkpMwVShikPphte5CA8Dqsmr0
         bLCFpISK/VxT/y1RIkxCdb5pEaOyKCgiUWRTmMK/a+MkK5nE7Oy1wQErMXBf9vlxKgAo
         L3Ww==
X-Gm-Message-State: AOJu0YxtG7ZUYMCYO9jsliCrtYGfG0bjeR9a40VcfX7+K5ezNclgDvfZ
        8GacDS64d7GRDXTygeBXIaG1Ag==
X-Google-Smtp-Source: AGHT+IHMFFJ8BY5hJmodl26ItAYFW5iH1BWsKoIxgpfPfgK3LK5LAk06yD6YAeUiE8pby38WdMDF4Q==
X-Received: by 2002:a05:6a20:258e:b0:159:c24f:5fa4 with SMTP id k14-20020a056a20258e00b00159c24f5fa4mr20581848pzd.1.1697006882943;
        Tue, 10 Oct 2023 23:48:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6f7e:c4cf:6e5d:fcff])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b00278ff752eacsm12200575pji.50.2023.10.10.23.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:48:02 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:47:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Bisected: [PATCH v7 2/8] hugetlb: restructure pool allocations
Message-ID: <20231011064756.GB2866435@google.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
 <20231006032012.296473-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006032012.296473-3-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/05 20:20), Mike Kravetz wrote:
> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> a low level allocator, prep the pages for usage as a hugetlb page and
> then add the resulting hugetlb page to the pool.
> 
> In the 'prep' stage, optional vmemmap optimization is done.  For
> performance reasons we want to perform vmemmap optimization on multiple
> hugetlb pages at once.  To do this, restructure the hugetlb pool
> allocation code such that vmemmap optimization can be isolated and later
> batched.
> 
> The code to allocate hugetlb pages from bootmem was also modified to
> allow batching.
> 
> No functional changes, only code restructure.

I'm afraid there are some functional changes.

[...]
# good: [9e6c86c616f7d4b166c12f1ea9b69831f85c4a86] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
git bisect good 9e6c86c616f7d4b166c12f1ea9b69831f85c4a86
# bad: [1d50db09471e2a67272cee6e004ffed380ac571b] Merge branch 'master' of git://linuxtv.org/mchehab/media-next.git
git bisect bad 1d50db09471e2a67272cee6e004ffed380ac571b
# good: [80b14e865ea20ddc20aae61e2c106ebb03257cd3] bcachefs: Lower BCH_NAME_MAX to 512
git bisect good 80b14e865ea20ddc20aae61e2c106ebb03257cd3
# bad: [31d068de8a0de2c44168bbd8a62da21a7bc76051] Merge branch 'for-linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
git bisect bad 31d068de8a0de2c44168bbd8a62da21a7bc76051
# bad: [0bb194b29fa6296a74b989e0f7f2db4fc11d8012] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
git bisect bad 0bb194b29fa6296a74b989e0f7f2db4fc11d8012
# good: [62001c9bf6aad59dc800c16613e5440b9226c252] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git
git bisect good 62001c9bf6aad59dc800c16613e5440b9226c252
# good: [21d856352ab78daffb9d05296b87b570f3afac33] Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 21d856352ab78daffb9d05296b87b570f3afac33
# good: [7fded33c6971b6c8e87cbbf48e74536aacca2991] perf test: Add pmu-event test for "Compat" and new event_field.
git bisect good 7fded33c6971b6c8e87cbbf48e74536aacca2991
# good: [4c37b665186a5e2907bf0308474ac3f15eb847da] compiler.h: move __is_constexpr() to compiler.h
git bisect good 4c37b665186a5e2907bf0308474ac3f15eb847da
# bad: [3424f8f382bd4d30e01eaf316823321ef7bd1560] mm: delete checks for xor_unlock_is_negative_byte()
git bisect bad 3424f8f382bd4d30e01eaf316823321ef7bd1560
# bad: [b5c6a60fe5b0339ba9c54f9f871db5c4a0e47906] iomap: protect read_bytes_pending with the state_lock
git bisect bad b5c6a60fe5b0339ba9c54f9f871db5c4a0e47906
# bad: [bfae92330ddc44968c628c0085082d25061495a4] hugetlb: batch PMD split for bulk vmemmap dedup
git bisect bad bfae92330ddc44968c628c0085082d25061495a4
# bad: [fb59f2cb8956f3888d2e0b438cc503565aa3c405] hugetlb: perform vmemmap optimization on a list of pages
git bisect bad fb59f2cb8956f3888d2e0b438cc503565aa3c405
# bad: [bfb41d6b2fe148c939366957ea9cb9aa72d59c4c] hugetlb: restructure pool allocations
git bisect bad bfb41d6b2fe148c939366957ea9cb9aa72d59c4c
# first bad commit: [bfb41d6b2fe148c939366957ea9cb9aa72d59c4c] hugetlb: restructure pool allocations

bfb41d6b2fe148c939366957ea9cb9aa72d59c4c is the first bad commit

commit bfb41d6b2fe148c939366957ea9cb9aa72d59c4c
Author: Mike Kravetz
Date:   Thu Oct 5 20:20:04 2023 -0700

    hugetlb: restructure pool allocations


Bugs-on linux-next:

[    0.827640] ------------[ cut here ]------------
[    0.828608] kernel BUG at mm/hugetlb.c:3180!
[    0.829812] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    0.830610] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4+ #164
[    0.830610] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.830610] RIP: 0010:gather_bootmem_prealloc+0x1c5/0x1d0
[    0.830610] Code: 48 89 e6 4c 89 ff e8 aa 13 83 fe 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 11 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b e8 64 f9 04 ff 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41 57
[    0.830610] RSP: 0000:ffffc90000017b00 EFLAGS: 00010297
[    0.830610] RAX: ffffc90000017b00 RBX: ffffea0000000000 RCX: ffffffff83847358
[    0.830610] RDX: ffffffff83847358 RSI: fffffffffffffec8 RDI: 0000000000000000
[    0.830610] RBP: 0000000000000000 R08: ffff8881030bc708 R09: ffff8881030bc710
[    0.830610] R10: 0000000000000001 R11: 000077791a770248 R12: ffffffff82224228
[    0.830610] R13: 0000000000000001 R14: ffffffff82ae6630 R15: ffffffff83847220
[    0.830610] FS:  0000000000000000(0000) GS:ffff888661e00000(0000) knlGS:0000000000000000
[    0.830610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.830610] CR2: ffff88867ffff000 CR3: 0000000002246001 CR4: 0000000000770ef0
[    0.830610] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.830610] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.830610] PKRU: 55555554
[    0.830610] Call Trace:
[    0.830610]  <TASK>
[    0.830610]  ? __die_body+0x67/0xb0
[    0.830610]  ? die+0xa0/0xc0
[    0.830610]  ? do_trap+0xa8/0x180
[    0.830610]  ? gather_bootmem_prealloc+0x1c5/0x1d0
[    0.830610]  ? do_error_trap+0xc6/0x110
[    0.830610]  ? gather_bootmem_prealloc+0x1c5/0x1d0
[    0.830610]  ? handle_invalid_op+0x25/0x30
[    0.830610]  ? gather_bootmem_prealloc+0x1c5/0x1d0
[    0.830610]  ? exc_invalid_op+0x2f/0x40
[    0.830610]  ? asm_exc_invalid_op+0x16/0x20
[    0.830610]  ? gather_bootmem_prealloc+0x1c5/0x1d0
[    0.830610]  ? __alloc_bootmem_huge_page+0x120/0x120
[    0.830610]  hugetlb_init+0x14a/0x280
[    0.830610]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
[    0.830610]  ? __alloc_bootmem_huge_page+0x120/0x120
[    0.830610]  do_one_initcall+0xce/0x2d0
[    0.830610]  ? __lock_acquire+0x5db/0x2d40
[    0.830610]  ? ida_alloc_range+0xaf/0x3e0
[    0.830610]  ? proc_register+0x4e/0x1b0
[    0.830610]  ? __kmem_cache_alloc_node+0x2f/0x200
[    0.830610]  ? lock_is_held_type+0xdd/0x150
[    0.830610]  ? do_initcalls+0x1c/0x70
[    0.830610]  ? parse_args+0x16f/0x340
[    0.830610]  do_initcall_level+0xab/0x110
[    0.830610]  ? kernel_init+0x16/0x190
[    0.830610]  do_initcalls+0x3f/0x70
[    0.830610]  kernel_init_freeable+0x15c/0x1d0
[    0.830610]  ? rest_init+0x1f0/0x1f0
[    0.830610]  kernel_init+0x16/0x190
[    0.830610]  ret_from_fork+0x2f/0x40
[    0.830610]  ? rest_init+0x1f0/0x1f0
[    0.830610]  ret_from_fork_asm+0x11/0x20
[    0.830610]  </TASK>
[    0.830610] Modules linked in:
[    0.830614] ---[ end trace 0000000000000000 ]---
[    0.831896] RIP: 0010:gather_bootmem_prealloc+0x1c5/0x1d0
[    0.833386] Code: 48 89 e6 4c 89 ff e8 aa 13 83 fe 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 11 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b e8 64 f9 04 ff 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41 57
[    0.833947] RSP: 0000:ffffc90000017b00 EFLAGS: 00010297
[    0.835384] RAX: ffffc90000017b00 RBX: ffffea0000000000 RCX: ffffffff83847358
[    0.837279] RDX: ffffffff83847358 RSI: fffffffffffffec8 RDI: 0000000000000000
[    0.839237] RBP: 0000000000000000 R08: ffff8881030bc708 R09: ffff8881030bc710
[    0.840613] R10: 0000000000000001 R11: 000077791a770248 R12: ffffffff82224228
[    0.842567] R13: 0000000000000001 R14: ffffffff82ae6630 R15: ffffffff83847220
[    0.843946] FS:  0000000000000000(0000) GS:ffff888661e00000(0000) knlGS:0000000000000000
[    0.846170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.847279] CR2: ffff88867ffff000 CR3: 0000000002246001 CR4: 0000000000770ef0
[    0.849242] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.850613] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.852581] PKRU: 55555554
[    0.853336] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.853944] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
