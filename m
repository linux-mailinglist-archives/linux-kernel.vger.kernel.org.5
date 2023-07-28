Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4A766C68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjG1MCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjG1MBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:01:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC82449A;
        Fri, 28 Jul 2023 05:01:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1949078f8f.0;
        Fri, 28 Jul 2023 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690545660; x=1691150460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWHxp6BYdj1hUJAaAzWGPFjl679471PQKsgA5+VvHzI=;
        b=WcjR4GrSPK9AcULOwlcp9u5LCac4D8DTrx8onXlvQ+V3Xrrf9fMg93DLHFgJBCzrOI
         uA/wFSCt5zIuCe1WNavuKIga+bIlAQS5N7XckyoYHdxI08iFU6faB0Qz7inZzrC8NP3z
         xLdpI0ZtQxxfwp9L5wsdhktuj1tsEyGmLWy6X2mwWnjY5NOi8UXfATZJAuuPtP8/tmTN
         4p9+zR7YinSSbsrmAZOjLCfMrSHJmEaDH7OH2Z7a7Ddq+ZPaC+Db80JI48/xgAhuoFEQ
         2fiw4KBZWDiFyX8DtVsR9tObg/FAa7PFFPHKa/GdQ0bq8A9RBefHKUHdIUx6AHJLGyyU
         1PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545660; x=1691150460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWHxp6BYdj1hUJAaAzWGPFjl679471PQKsgA5+VvHzI=;
        b=OjHhVR1+fDckH4mkg2tRLaDHpdf9GPoSb+BQwvq9gRvYA/osiUNbDKVY3wXS8zUkWG
         Ql32KRgrqrSRVyPvchPfwBqruLiUfIs26j0y8lQ45smalp35D5UUNU1Kdi78yiEQ1Vn8
         1Zb6pRVucDZYqu6PiBbk7BdnZRySOgt51IzWakuG8N3FTZjZ8nAZgZ678TlgbvLM1HaJ
         WqKDPU/eUBGNNd7k8SWNuBssrLD8eZZsQBDnU1sH3vTtibEo2fejgpbiyud1FogQWDR0
         k/fVQEU88sBPzwAn+df9EmfaJOVwHUvR6vFlteJccTc00iHY5/4BJykCcZ5FUmV2vNx4
         h0IA==
X-Gm-Message-State: ABy/qLaOaVqCQyDPpBaWOgAvNnyXylA9ZgPcXip++VOZLKcLCx1QJxyR
        oN/8sM7NZZmweHGBuvKrJk0=
X-Google-Smtp-Source: APBJJlEUUYRrKzptH8xy7CAmo7/9D1YkWZXuZn+2o4ZW8I6hH44ezT5uhOjJmRR/1W6WyQd0ln8xgA==
X-Received: by 2002:a5d:474c:0:b0:30f:b7b4:3e55 with SMTP id o12-20020a5d474c000000b0030fb7b43e55mr1528699wrs.19.1690545659659;
        Fri, 28 Jul 2023 05:00:59 -0700 (PDT)
Received: from localhost.localdomain (host-95-244-91-78.retail.telecomitalia.it. [95.244.91.78])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d68d0000000b003140f47224csm4645454wrw.15.2023.07.28.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:00:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Fri, 28 Jul 2023 13:53:01 +0200
Message-ID: <20230728120054.12306-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend page_tables.rst by adding a section about the role of MMU and TLB
in translating between virtual addresses and physical page frames.
Furthermore explain the concept behind Page Faults and how the Linux
kernel handles TLB misses. Finally briefly explain how and why to disable
the page faults handler.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This has been an RFC PATCH in its 2nd version for a week or so. I received
comments and suggestions on it from Jonathan Cameron (thanks!), and so it has
now been modified to a real patch. I hope that other people want to add their
comments on this document in order to further improve and extend it.

The link to the thread with the RFC PATCH v2 and the messages between Jonathan
and me start at https://lore.kernel.org/all/20230723120721.7139-1-fmdefrancesco@gmail.com/#r

 Documentation/mm/page_tables.rst | 105 +++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index 7840c1891751..6ecfd6d2f1f3 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -152,3 +152,108 @@ Page table handling code that wishes to be architecture-neutral, such as the
 virtual memory manager, will need to be written so that it traverses all of the
 currently five levels. This style should also be preferred for
 architecture-specific code, so as to be robust to future changes.
+
+
+MMU, TLB, and Page Faults
+=========================
+
+The `Memory Management Unit (MMU)` is a hardware component that handles virtual
+to physical address translations. It may use relatively small caches in hardware
+called `Translation Lookaside Buffers (TLBs)` and `Page Walk Caches` to speed up
+these translations.
+
+When a process wants to access a memory location, the CPU provides a virtual
+address to the MMU, which then uses the MMU to check access permissions and
+dirty bits, and if possible it resolves the physical address and consents the
+requested type of access to the corresponding physical address.
+
+If the TLBs have not yet any recorded translations, the MMU may use the Page
+Walk Caches and complete or restart the page tables walks until a physical
+address can finally be resolved. Permissions and dirty bits are checked.
+
+In the context of a virtual memory system, like the one used by the Linux
+kernel, each page of memory has associated permission and dirty bits.
+
+The dirty bit for a page is set (i.e., turned on) when the page is written
+to. This indicates that the page has been modified since it was loaded into
+memory. It probably needs to be written on disk or other cores may need to
+be informed about previous changes before allowing further operations.
+
+If nothing prevents it, eventually the physical memory can be accessed and
+the requested operation on the physical frame is performed.
+
+There are several reasons why the MMU can't find certain translations. It
+could happen because the process is trying to access a range of memory that is
+not allowed to, or because the data is not present into RAM.
+
+When these conditions happen, the MMU triggers page faults, which are types
+of exceptions that signal the CPU to pause the current process and run a special
+function to handle the mentioned page faults.
+
+One cause of page faults is due to bugs (or maliciously crafted addresses) and
+happens when a process tries to access a range of memory that it doesn't have
+permission to. This could be because the memory is reserved for the kernel or
+for another process, or because the process is trying to write to a read-only
+section of memory. When this happens, the kernel sends a Segmentation Fault
+(SIGSEGV) signal to the process, which usually causes the process to terminate.
+
+An expected and more common cause of page faults is an optimization called "lazy
+allocation". This is a technique used by the Kernel to improve memory efficiency
+and reduce footprint. Instead of allocating physical memory to a process as soon
+as it's requested, the Kernel waits until the process actually tries to use the
+memory. This can save a significant amount of memory in cases where a process
+requests a large block but only uses a small portion of it.
+
+A related technique is called "Copy-on-Write" (CoW), where the Kernel allows
+multiple processes to share the same physical memory as long as they're only
+reading from it. If a process tries to write to the shared memory, the kernel
+triggers a page fault and allocates a separate copy of the memory for the
+process. This allows the Kernel to save memory and avoid unnecessary data
+copying and, by doing so, it reduces latency and space occupation.
+
+Now, let's see how the Linux kernel handles these page faults:
+
+1. For most architectures, `do_page_fault()` is the primary interrupt handler
+   for page faults. It delegates the actual handling of the page fault to
+   `handle_mm_fault()`. This function checks the cause of the page fault and
+   takes the appropriate action, such as loading the required page into
+   memory, granting the process the necessary permissions, or sending a
+   SIGSEGV signal to the process.
+
+2. In the specific case of the x86 architecture, the interrupt handler is
+   defined by the `DEFINE_IDTENTRY_RAW_ERRORCODE()` macro, which calls
+   `handle_page_fault()`. This function then calls either
+   `do_user_addr_fault()` or `do_kern_addr_fault()`, depending on whether
+   the fault occurred in user space or kernel space. Both of these functions
+   eventually lead to `handle_mm_fault()`, similar to the workflow in other
+   architectures.
+
+`handle_mm_fault()` (likely) ends up calling `__handle_mm_fault()` to carry
+out the actual work of allocation of the page tables. It works by using
+several functions to find the entry's offsets of the 4 - 5 layers of tables
+and allocate the tables it needs to. The functions that look for the offset
+have names like `*_offset()`, where the "*" is for pgd, p4d, pud, pmd, pte;
+instead the functions to allocate the corresponding tables, layer by layer,
+are named `*_alloc`, with the above mentioned convention to name them after
+the corresponding types of tables in the hierarchy.
+
+At the very end of the walk with allocations, if it didn't return errors,
+`__handle_mm_fault()` finally calls `handle_pte_fault()`, which via
+`do_fault()` performs one of `do_read_fault()`, `do_cow_fault()`,
+`do_shared_fault()`. "read", "cow", "shared" give hints about the reasons
+and the kind of fault it's handling.
+
+The actual implementation of the workflow is very complex. Its design allows
+Linux to handle page faults in a way that is tailored to the specific
+characteristics of each architecture, while still sharing a common overall
+structure.
+
+To conclude this brief overview from very high altitude of how Linux handles
+page faults, let's add that page faults handler can be disabled and enabled
+respectively with `pagefault_disable()` and `pagefault_enable()`.
+
+Several code path make use of the latter two functions because they need to
+disable traps into the page faults handler, mostly to prevent deadlocks.[1]
+
+[1] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
+https://lore.kernel.org/all/20221025220136.2366143-1-ira.weiny@intel.com/
-- 
2.41.0

