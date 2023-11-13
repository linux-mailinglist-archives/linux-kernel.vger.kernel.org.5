Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E707EA36D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjKMTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043A10D0;
        Mon, 13 Nov 2023 11:14:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52E101F854;
        Mon, 13 Nov 2023 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W7QXmIFPtyA621azrDtsOPQFV81EzYubbdba9PHLL0k=;
        b=iXl/C1dLeuvhEZYdxXFS8vwa/6hEZvHeAoLkv2y/Pro4x9I1NfIFHF2xNy7zR7td3VisoW
        Jnoiv+QP+KnaD4LKz8bKRn+0+X5xXp6/UocGU+oqFckvf21ODPPjfWDwXmMXhvvHR3ezLP
        1DNFp4UMCfYxY5dZmgfqtz6ZRI1eavE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W7QXmIFPtyA621azrDtsOPQFV81EzYubbdba9PHLL0k=;
        b=Ikh9Erxsl7uTaSvib65hNgBM28up4uw5lXTZ9xrfbHBQKHYYrw70te4lLGFSuD6hgqGEqZ
        0ISNDKspXXt91rAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2EE313398;
        Mon, 13 Nov 2023 19:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Us6jOoB1UmVFOgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:08 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 00/20] remove the SLAB allocator
Date:   Mon, 13 Nov 2023 20:13:41 +0100
Message-ID: <20231113191340.17482-22-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SLAB allocator has been deprecated since 6.5 and nobody has objected
so far. As we agreed at LSF/MM, we should wait with the removal until
the next LTS kernel is released. AFAIK that version hasn't been
announced yet, but assuming it would be 6.7, we can aim for 6.8 and
start exposing the removal to linux-next during the 6.7 cycle.

To keep the series reasonably sized and not pull in people from other
subsystems than mm and closely related ones, I didn't attempt to remove
every trace of unnecessary reference to dead config options in external
areas, nor in the defconfigs. Such cleanups can be sent to and handled
by respective maintainers after this is merged.

Instead I have added some patches aimed to reap some immediate benefits
of the removal, mainly by not having to split some fastpath code between
slab_common.c and slub.c anymore. But that is also not an exhaustive
effort and I expect more cleanups and optimizations will follow later.

Patch 08 updates CREDITS for the removed mm/slab.c. Please point out if
I missed someone not yet credited.

Git version: https://git.kernel.org/vbabka/l/slab-remove-slab-v1r4

Vlastimil Babka (20):
  mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
  KASAN: remove code paths guarded by CONFIG_SLAB
  KFENCE: cleanup kfence_guarded_alloc() after CONFIG_SLAB removal
  mm/memcontrol: remove CONFIG_SLAB #ifdef guards
  cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
  mm/slab: remove CONFIG_SLAB code from slab common code
  mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB ifdefs
  mm/slab: remove mm/slab.c and slab_def.h
  mm/slab: move struct kmem_cache_cpu declaration to slub.c
  mm/slab: move the rest of slub_def.h to mm/slab.h
  mm/slab: consolidate includes in the internal mm/slab.h
  mm/slab: move pre/post-alloc hooks from slab.h to slub.c
  mm/slab: move memcg related functions from slab.h to slub.c
  mm/slab: move struct kmem_cache_node from slab.h to slub.c
  mm/slab: move kfree() from slab_common.c to slub.c
  mm/slab: move kmalloc_slab() to mm/slab.h
  mm/slab: move kmalloc() functions from slab_common.c to slub.c
  mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
  mm/slub: optimize alloc fastpath code layout
  mm/slub: optimize free fast path code layout

 CREDITS                  |   12 +-
 arch/arm64/Kconfig       |    2 +-
 arch/s390/Kconfig        |    2 +-
 arch/x86/Kconfig         |    2 +-
 include/linux/slab.h     |   21 +-
 include/linux/slab_def.h |  124 --
 include/linux/slub_def.h |  204 --
 kernel/cpu.c             |    5 -
 lib/Kconfig.debug        |    1 -
 lib/Kconfig.kasan        |   11 +-
 lib/Kconfig.kfence       |    2 +-
 lib/Kconfig.kmsan        |    2 +-
 mm/Kconfig               |   50 +-
 mm/Kconfig.debug         |   16 +-
 mm/Makefile              |    6 +-
 mm/dmapool.c             |    2 +-
 mm/kasan/common.c        |   13 +-
 mm/kasan/kasan.h         |    3 +-
 mm/kasan/quarantine.c    |    7 -
 mm/kasan/report.c        |    1 +
 mm/kfence/core.c         |    4 -
 mm/memcontrol.c          |    6 +-
 mm/mempool.c             |    6 +-
 mm/slab.c                | 4026 --------------------------------------
 mm/slab.h                |  550 ++----
 mm/slab_common.c         |  231 +--
 mm/slub.c                |  597 +++++-
 27 files changed, 784 insertions(+), 5122 deletions(-)
 delete mode 100644 include/linux/slab_def.h
 delete mode 100644 include/linux/slub_def.h
 delete mode 100644 mm/slab.c

-- 
2.42.1

