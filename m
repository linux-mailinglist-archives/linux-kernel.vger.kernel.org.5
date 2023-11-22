Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C639A7F3CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjKVEgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61958199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700627760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z5Llx2phfB7hptylQeopcoFDKXqvVDVH9ZvTWbzDxa0=;
        b=bLpe7G9Fgn/CSFtnhRwyIYzPrRtI7Lmfg90HQY7OOBeaV8SLYDyU5P18tlUGmvhgVjMEC3
        CibNB8/qtEaZK5raFoFKm5sNr7OjZrvx3SKpF+1eiE8P3lKZBCigE1DhEpl0U51VlQgfuU
        1bpMGvTUUvSwbUp11ZueLwTLkF5+zHs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-Rlt5mkkbPW6BumRYVMuWjA-1; Tue,
 21 Nov 2023 23:35:57 -0500
X-MC-Unique: Rlt5mkkbPW6BumRYVMuWjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3C38280640E;
        Wed, 22 Nov 2023 04:35:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3871C060AE;
        Wed, 22 Nov 2023 04:35:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] mm/page.c: move mem_init_print_info() to later place
Date:   Wed, 22 Nov 2023 12:35:50 +0800
Message-ID: <20231122043550.489889-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, only part of
pages are initialized and added into buddy allocator at early stage. Then
the system memory information printed by mem_init_print_info() is
incorrect. The snippets of boot log are pasted here:
-----------------------------------------------------------------------
[    0.059606] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.059622] software IO TLB: area num 64.
[    0.143887] Memory: 1767888K/133954872K available (20480K kernel code, 3284K rwdata, 8972K rodata, 4572K init, 4916K bss, 2529756K reserved, 0K cma-reserved)
[    0.145111] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=2
---------------------------------------------------------------------------

Here, move mem_init_print_info() to later place until page init is
finished. After the fix, the printed memory information is like this:
-------------------------------------------------------------------------
[  +0.001002] smpboot: Total of 64 processors activated (293724.92 BogoMIPS)
[  +0.050086] node 0 deferred pages initialised in 45ms
[  +0.007309] node 1 deferred pages initialised in 53ms
[    4.035449] Memory: 131272772K/133954872K available (20480K kernel code, 3284K rwdata, 8972K rodata, 4572K init, 4916K bss, 2529700K reserved, 0K cma-reserved)
[  +0.015995] devtmpfs: initialized
[  +0.003943] x86/mm: Memory block size: 2048MB
-------------------------------------------------------------------------

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/gfp.h | 1 +
 init/main.c         | 1 +
 mm/mm_init.c        | 3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..2d69fa59b489 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -335,6 +335,7 @@ void drain_local_pages(struct zone *zone);
 
 void page_alloc_init_late(void);
 void setup_pcp_cacheinfo(void);
+void mem_init_print_info(void);
 
 /*
  * gfp_allowed_mask is set to GFP_BOOT_MASK during early boot to restrict what
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..88f238a478a1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1547,6 +1547,7 @@ static noinline void __init kernel_init_freeable(void)
 	workqueue_init_topology();
 	padata_init();
 	page_alloc_init_late();
+	mem_init_print_info();
 
 	do_basic_setup();
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..d08f7c7f75f1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2703,7 +2703,7 @@ static void __init report_meminit(void)
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
 
-static void __init mem_init_print_info(void)
+void __init mem_init_print_info(void)
 {
 	unsigned long physpages, codesize, datasize, rosize, bss_size;
 	unsigned long init_code_size, init_data_size;
@@ -2774,7 +2774,6 @@ void __init mm_core_init(void)
 	kmsan_init_shadow();
 	stack_depot_early_init();
 	mem_init();
-	mem_init_print_info();
 	kmem_cache_init();
 	/*
 	 * page_owner must be initialized after buddy is ready, and also after
-- 
2.41.0

