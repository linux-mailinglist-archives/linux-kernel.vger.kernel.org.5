Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3B7FD444
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjK2JyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjK2Jxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D93619AB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:53:39 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA5F72198B;
        Wed, 29 Nov 2023 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701251616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eoFLVBeLcmc4evqkljz3fngHIKUUCOgba17WIJPWQ+0=;
        b=DhAjX4+xb9egQ4e/kFsy8nAm5bsTgOIbdfZmAXEDiYGXpSW0aJyAjkbpr/AWyJD/WnkZ43
        VagLHVVyUW7GFZuPbUFq3SMfbAWeB6tbOPAy16pSLY0u0MIOEvip7gZLDuqTe54Go6ncKJ
        XqtmUJT5s40PAS1HTU/Hn+0fETbHHIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701251616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eoFLVBeLcmc4evqkljz3fngHIKUUCOgba17WIJPWQ+0=;
        b=AFGProdnynrmKZ4ksYdy2fXGxF280zC9G/ic+BPCyDtHe4ij6EsYeKmY2cmNaNbYBuFmtq
        PebK73ONoAXcrOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1FA1388B;
        Wed, 29 Nov 2023 09:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 8pWoKSAKZ2UrfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 09:53:36 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC v3 0/9] SLUB percpu array caches and maple tree nodes
Date:   Wed, 29 Nov 2023 10:53:25 +0100
Message-Id: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUKZ2UC/z2MQQ6CMBAAv0L27JJuIQU8mZj4AK/GQymLNCo0X
 SFGwt9tPHicSWZWEI6eBfbZCpEXL34aExS7DNxgxxuj7xKDVrog0jXKY24xcHRhRmfdwIJNWVL
 daEXUVZDCELn379/0AufTEa5J9nF64muIbP8/VZMiUxhd5UYrgw0urW3v9iCzcO4+sG1fIbWTd
 aAAAAA=
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[17];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,lists.infradead.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also in git [1]. Changes since v2 [2]:

- empty cache refill/full cache flush using internal bulk operations
- bulk alloc/free operations also use the cache
- memcg, KASAN etc hooks processed when the cache is used for the
  operation - now fully transparent
- NUMA node-specific allocations now explicitly bypass the cache

[1] https://git.kernel.org/vbabka/l/slub-percpu-caches-v3r2
[2] https://lore.kernel.org/all/20230810163627.6206-9-vbabka@suse.cz/

----

At LSF/MM I've mentioned that I see several use cases for introducing
opt-in percpu arrays for caching alloc/free objects in SLUB. This is my
first exploration of this idea, speficially for the use case of maple
tree nodes. The assumptions are:

- percpu arrays will be faster thank bulk alloc/free which needs
  relatively long freelists to work well. Especially in the freeing case
  we need the nodes to come from the same slab (or small set of those)

- preallocation for the worst case of needed nodes for a tree operation
  that can't reclaim due to locks is wasteful. We could instead expect
  that most of the time percpu arrays would satisfy the constained
  allocations, and in the rare cases it does not we can dip into
  GFP_ATOMIC reserves temporarily. So instead of preallocation just
  prefill the arrays.

- NUMA locality of the nodes is not a concern as the nodes of a
  process's VMA tree end up all over the place anyway.

Patches 1-4 are preparatory, but should also work as standalone fixes
and cleanups, so I would like to add them for 6.8 after review, and
probably rebasing on top of the current series in slab/for-next, mainly
SLAB removal, as it should be easier to follow than the necessary
conflict resolutions.

Patch 5 adds the per-cpu array caches support. Locking is stolen from
Mel's recent page allocator's pcplists implementation so it can avoid
disabling IRQs and just disable preemption, but the trylocks can fail in
rare situations - in most cases the locks are uncontended so the locking
should be cheap.

Then maple tree is modified in patches 6-9 to benefit from this. From
that, only Liam's patches make sense and the rest are my crude hacks.
Liam is already working on a better solution for the maple tree side.
I'm including this only so the bots have something for testing that uses
the new code. The stats below thus likely don't reflect the full
benefits that can be achieved from cache prefill vs preallocation.

I've briefly tested this with virtme VM boot and checking the stats from
CONFIG_SLUB_STATS in sysfs.

Patch 5:

slub per-cpu array caches implemented including new counters but maple
tree doesn't use them yet

/sys/kernel/slab/maple_node # grep . alloc_cpu_cache alloc_*path free_cpu_cache free_*path cpu_cache* | cut -d' ' -f1
alloc_cpu_cache:0
alloc_fastpath:20213
alloc_slowpath:1741
free_cpu_cache:0
free_fastpath:10754
free_slowpath:9232
cpu_cache_flush:0
cpu_cache_refill:0

Patch 7:

maple node cache creates percpu array with 32 entries,
not changed anything else

majority alloc/free operations are satisfied by the array, number of
flushed/refilled objects is 1/3 of the cached operations so the hit
ratio is 2/3. Note the flush/refill operations also increase the
fastpath/slowpath counters, thus the majority of those indeed come from
the flushes and refills.

alloc_cpu_cache:11880
alloc_fastpath:4131
alloc_slowpath:587
free_cpu_cache:13075
free_fastpath:437
free_slowpath:2216
cpu_cache_flush:4336
cpu_cache_refill:3216

Patch 9:

This tries to replace maple tree's preallocation with the cache prefill.
Thus should reduce all of the counters as many of the preallocations for
the worst-case scenarios are not needed in the end. But according to
Liam it's not the full solution, which probably explains why the
reduction is only modest.

alloc_cpu_cache:11540
alloc_fastpath:3756
alloc_slowpath:512
free_cpu_cache:12775
free_fastpath:388
free_slowpath:1944
cpu_cache_flush:3904
cpu_cache_refill:2742

---
Liam R. Howlett (2):
      tools: Add SLUB percpu array functions for testing
      maple_tree: Remove MA_STATE_PREALLOC

Vlastimil Babka (7):
      mm/slub: fix bulk alloc and free stats
      mm/slub: introduce __kmem_cache_free_bulk() without free hooks
      mm/slub: handle bulk and single object freeing separately
      mm/slub: free KFENCE objects in slab_free_hook()
      mm/slub: add opt-in percpu array cache of objects
      maple_tree: use slub percpu array
      maple_tree: replace preallocation with slub percpu array prefill

 include/linux/slab.h                    |   4 +
 include/linux/slub_def.h                |  12 +
 lib/maple_tree.c                        |  46 ++-
 mm/Kconfig                              |   1 +
 mm/slub.c                               | 561 +++++++++++++++++++++++++++++---
 tools/include/linux/slab.h              |   4 +
 tools/testing/radix-tree/linux.c        |  14 +
 tools/testing/radix-tree/linux/kernel.h |   1 +
 8 files changed, 578 insertions(+), 65 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231128-slub-percpu-caches-9441892011d7

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

