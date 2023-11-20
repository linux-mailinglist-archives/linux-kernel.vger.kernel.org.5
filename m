Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1377F0DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKTInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjKTInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:43:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E809129
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:43:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F01A1218E7;
        Mon, 20 Nov 2023 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700469788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9Otojp+w8AMoWXmuyrFVt/HH+ZJc/H2/+W8DuXW/0/s=;
        b=C/iCghJJqGVEZH5sjeM8cB+5cn4P84GAnT6VoLiy/ke/VaAItj+VcZyprlP3OTPcyvMIdL
        9VndrPeIFEYQHZcmiO8IVD+hnpqT+r+Isa/4x87i5nroqpGnZ801KTxsJ4KOXjOjGu34sa
        eNUytNx21nua9y2CYT5k3zTUDcGpwjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700469788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9Otojp+w8AMoWXmuyrFVt/HH+ZJc/H2/+W8DuXW/0/s=;
        b=wyFUqkkO8ikFuMnlKw2a+PhR0JdOAErhnqSFzTklWZGmKpC4bm3DTHdG8wlUxRGzxC2XuT
        NGVdL+tOxDWDWKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 383F813912;
        Mon, 20 Nov 2023 08:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c1MxChwcW2U3VgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Nov 2023 08:43:08 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 0/4] page_owner: print stacks and their counter
Date:   Mon, 20 Nov 2023 09:42:56 +0100
Message-Id: <20231120084300.4368-1-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 5.20
X-Spamd-Result: default: False [5.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,redhat.com,google.com,gmail.com,suse.de];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v5 -> v6:
     - Rebase on top of v6.7-rc1
     - Move stack_record struct to the header
     - Addressed feedback from Vlastimil
       (some code tweaks and changelogs suggestions)

Changes v4 -> v5:
     - Addressed feedback from Alexander Potapenko

Changes v3 -> v4:
     - Rebase (long time has passed)
     - Use boolean instead of enum for action by Alexander Potapenko
     - (I left some feedback untouched because it's been long and
        would like to discuss it here now instead of re-vamping
        and old thread)

Changes v2 -> v3:
     - Replace interface in favor of seq operations (suggested by Vlastimil)
     - Use debugfs interface to store/read valued (suggested by Ammar)

Hi,

page_owner is a great debug functionality tool that lets us know
about all pages that have been allocated/freed and their stacktrace.
This comes very handy when one has to debug memory leaks, since with
some scripting we can see outstanding allocations, which might end up
pointing to a leak.

In my experience, that is one of the most useful cases, but it can get
really tedious to screen through all pages and try to reconstruct the
stack <-> allocated/freed relationship. There is a lot of noise
to cancel off.

This patchset aims to ease that by adding a new functionality into page_owner.
What this does is to create a new read-only file "page_owner_stacks",
which prints out only the stacktraces followed by their outstanding
number of allocations (being that the times the stacktrace has allocated
but not freed yet).

This lets us have a clear overview of stacks <-> allocated/freed relationship
without the need to fiddle with pages and trying to match free stacktraces
with allocated stacktraces.

This is achieved by adding a new refcount_t field in the stack_record struct,
incrementing that refcount_t everytime the same stacktrace allocates,
and decrementing it when it frees a page. Details can be seen in the
respective patches.

We also create another file called "page_owner_threshold", which let us
specify a threshold, so when reading from "page_owner_stacks",
we will only see those stacktraces which counting goes beyond the
threshold we specified.

A PoC can be found below:

 # cat /sys/kernel/debug/page_owner_threshold
  0
 # cat /sys/kernel/debug/page_owner_stacks > stacks_full.txt
 # head -32 stacks_full.txt
  prep_new_page+0x10d/0x180
  get_page_from_freelist+0x1bd6/0x1e10
  __alloc_pages+0x194/0x360
  alloc_page_interleave+0x13/0x90
  new_slab+0x31d/0x530
  ___slab_alloc+0x5d7/0x720
  __slab_alloc.isra.85+0x4a/0x90
  kmem_cache_alloc+0x455/0x4a0
  acpi_ps_alloc_op+0x57/0x8f
  acpi_ps_create_scope_op+0x12/0x23
  acpi_ps_execute_method+0x102/0x2c1
  acpi_ns_evaluate+0x343/0x4da
  acpi_evaluate_object+0x1cb/0x392
  acpi_run_osc+0x135/0x260
  acpi_init+0x165/0x4ed
  do_one_initcall+0x3e/0x200
 stack count: 2
 
  free_pcp_prepare+0x287/0x5c0
  free_unref_page+0x1c/0xd0
  __mmdrop+0x50/0x160
  finish_task_switch+0x249/0x2b0
  __schedule+0x2c3/0x960
  schedule+0x44/0xb0
  futex_wait_queue+0x70/0xd0
  futex_wait+0x160/0x250
  do_futex+0x11c/0x1b0
  __x64_sys_futex+0x5e/0x1d0
  do_syscall_64+0x37/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 stack count: 1
 
  
 
 # echo 10000 > /sys/kernel/debug/page_owner_threshold
 # cat /sys/kernel/debug/page_owner_stacks > stacks_10000.txt
 # cat stacks_10000.txt 
  prep_new_page+0x10d/0x180
  get_page_from_freelist+0x1bd6/0x1e10
  __alloc_pages+0x194/0x360
  folio_alloc+0x17/0x40
  page_cache_ra_unbounded+0x96/0x170
  filemap_get_pages+0x23d/0x5e0
  filemap_read+0xbf/0x3a0
  __kernel_read+0x136/0x2f0
  kernel_read_file+0x197/0x2d0
  kernel_read_file_from_fd+0x54/0x90
  __do_sys_finit_module+0x89/0x120
  do_syscall_64+0x37/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 stack count: 36195
 
  prep_new_page+0x10d/0x180
  get_page_from_freelist+0x1bd6/0x1e10
  __alloc_pages+0x194/0x360
  folio_alloc+0x17/0x40
  page_cache_ra_unbounded+0x96/0x170
  filemap_get_pages+0x23d/0x5e0
  filemap_read+0xbf/0x3a0
  new_sync_read+0x106/0x180
  vfs_read+0x16f/0x190
  ksys_read+0xa5/0xe0
  do_syscall_64+0x37/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 stack count: 44484
 
  prep_new_page+0x10d/0x180
  get_page_from_freelist+0x1bd6/0x1e10
  __alloc_pages+0x194/0x360
  folio_alloc+0x17/0x40
  page_cache_ra_unbounded+0x96/0x170
  filemap_get_pages+0xdd/0x5e0
  filemap_read+0xbf/0x3a0
  new_sync_read+0x106/0x180
  vfs_read+0x16f/0x190
  ksys_read+0xa5/0xe0
  do_syscall_64+0x37/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 stack count: 17874

Oscar Salvador (4):
  lib/stackdepot: Add a refcount field in stack_record
  lib/stackdepot: Move stack_record struct definition into the header
  mm,page_owner: Add page_owner_stacks file to print out only stacks and
    their counter
  mm,page_owner: Filter out stacks by a threshold counter

 include/linux/stackdepot.h |  38 ++++++++++++
 lib/stackdepot.c           | 114 ++++++++++++++++++++++--------------
 mm/page_owner.c            | 115 +++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 43 deletions(-)

-- 
2.42.0

