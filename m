Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18141777E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjHJQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44F90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6DE21872;
        Thu, 10 Aug 2023 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691685392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Rrrk6AXmKlg6kfpz/5HE6qHTHNnXNplMWbRQ/ZhwN54=;
        b=b+B/bO774hqjJtmgG2U1kU1fwu3PXO72QjCRfxodkZj80x5FARs431Cl2R5w4bTPenkdyp
        wia/gyoIWkgkv64jbtwpFLD75iiQ6sQWJu0AiFVEER98L50NmPELQpTop1jGnhTCJ5VXez
        70UtOrDd2uexrRVvXZcaYJicuDdbbt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691685392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Rrrk6AXmKlg6kfpz/5HE6qHTHNnXNplMWbRQ/ZhwN54=;
        b=jMSVsxc9EUS0W7CDyngB9IDEjhZYVNY3LHcgSZNYtpUkpcVehUzb/4cnYmJb397PiERDZ8
        2GywFRdCz0AmQVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F13F138E0;
        Thu, 10 Aug 2023 16:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TkfPChAS1WSEPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 16:36:32 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 0/7] SLUB percpu array caches and maple tree nodes
Date:   Thu, 10 Aug 2023 18:36:28 +0200
Message-ID: <20230810163627.6206-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also in git [1]. Changes since v1 [2]:

- fix a few bugs
- SLAB marked as BROKEN so bots dont complain about missing functions
- incorporate Liam's patches, which allows getting rid of preallocations
  in mas_prealloc() completely. This has reduced the allocation stats
  further, with the whole series.

More notes wrt v1 RFC feedback:

- locking is still done as in v1, as it allows remote draining, which
  should be added before this is suitable for merging
- there's currently no bulk freeing/refill of the percpu array, which
  will eventually be added, but I expect most perf gain for the maple
  tree use case to come from the avoided preallocations anyway

----

At LSF/MM I've mentioned that I see several use cases for introducing
opt-in percpu arrays for caching alloc/free objects in SLUB. This is my
first exploration of this idea, speficially for the use case of maple
tree nodes. We have brainstormed this use case on IRC last week with
Liam and Matthew and this how I understood the requirements:

- percpu arrays will be faster thank bulk alloc/free which needs
  relatively long freelists to work well. Especially in the freeing case
  we need the nodes to come from the same slab (or small set of those)

- preallocation for the worst case of needed nodes for a tree operation
  that can't reclaim due to locks is wasteful. We could instead expect
  that most of the time percpu arrays would satisfy the constained
  allocations, and in the rare cases it does not we can dip into
  GFP_ATOMIC reserves temporarily. Instead of preallocation just prefill
  the arrays.

- NUMA locality is not a concern as the nodes of a process's VMA tree
  end up all over the place anyway.

So this RFC patchset adds such percpu array in Patch 2. Locking is
stolen from Mel's recent page allocator's pcplists implementation so it
can avoid disabling IRQs and just disable preemption, but the trylocks
can fail in rare situations.

Then maple tree is modified in patches 3-6 to benefit from this. This is
done in a very crude way as I'm not so familiar with the code.

I've briefly tested this with virtme VM boot and checking the stats from
CONFIG_SLUB_STATS in sysfs.

Patch 2:

slub changes implemented including new counters alloc_cpu_cache
and free_cpu_cache but maple tree doesn't use them yet

(none):/sys/kernel/slab/maple_node # grep . alloc_cpu_cache alloc_*path free_cpu_cache free_*path | cut -d' ' -f1
alloc_cpu_cache:0
alloc_fastpath:54842
alloc_slowpath:8142
free_cpu_cache:0
free_fastpath:32336
free_slowpath:23484

Patch 3:

maple node cache creates percpu array with 32 entries,
not changed anything else

-> some allocs/free satisfied by the array

alloc_cpu_cache:11956
alloc_fastpath:40675
alloc_slowpath:7308
free_cpu_cache:12082
free_fastpath:23617
free_slowpath:17956

Patch 4:

maple tree nodes bulk alloc/free converted to loop of normal alloc to use
percpu array more, because bulk alloc bypasses it

-> majority alloc/free now satisfied by percpu array

alloc_cpu_cache:54673
alloc_fastpath:4491
alloc_slowpath:737
free_cpu_cache:54759
free_fastpath:332
free_slowpath:4723

Patch 5+6:

mas_preallocate() just prefills the percpu array, doesn't preallocate anything
mas_store_prealloc() gains a retry loop with mas_nomem(mas, GFP_ATOMIC | __GFP_NOFAIL)

-> major drop of alloc/free
(the prefills are included in the accounting)

alloc_cpu_cache:15036
alloc_fastpath:4651
alloc_slowpath:656
free_cpu_cache:15102
free_fastpath:299
free_slowpath:4835

It would be interesting to see how it affects the workloads that saw
regressions from the maple tree introduction, as the slab operations
were suspected to be a major factor and now they should be both reduced
and made cheaper.

Liam R. Howlett (2):
  maple_tree: Remove MA_STATE_PREALLOC
  tools: Add SLUB percpu array functions for testing

Vlastimil Babka (5):
  mm, slub: fix bulk alloc and free stats
  mm, slub: add opt-in slub_percpu_array
  maple_tree: use slub percpu array
  maple_tree: avoid bulk alloc/free to use percpu array more
  maple_tree: replace preallocation with slub percpu array prefill

 include/linux/slab.h                    |   4 +
 include/linux/slub_def.h                |  10 ++
 lib/maple_tree.c                        |  60 ++++---
 mm/Kconfig                              |   1 +
 mm/slub.c                               | 221 +++++++++++++++++++++++-
 tools/include/linux/slab.h              |   4 +
 tools/testing/radix-tree/linux.c        |  14 ++
 tools/testing/radix-tree/linux/kernel.h |   1 +
 8 files changed, 286 insertions(+), 29 deletions(-)

-- 
2.41.0

