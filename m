Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51175BCEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUDsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGUDrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:47:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593253C07
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:46:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so7303a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689911212; x=1690516012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH9eaVq/3xF5+eoF3tJlJvK/nUNTkULMc9bRvazMcXM=;
        b=h8BR3B2IDeSvGlXM1y+Dh8ezr8hVadMms0TzcGbCGfLis7VGJCwpWJB+d+k1frxoNr
         XVJux86B7JYWYqlhIgZZAELTzQKQLnkMCogjVf0LR72ZzaryJntMFO3ZND05DJdp3rpy
         0s6bw3I4DBonlizpUcZLw0GuK1kPNS3FkTh1tcwUdb3AXQcHjGaEVUML/aGj8kP22T87
         l35uS2Sk/VVQI/RaTQe5Lf3byN3UTPJgaBK+blvZA0In4+OSifEkq2xHQB6jfzp5+spD
         0sEAlr5soxvMwxkphgHlcdUMWlNJlOEAnVpWntpSAVGgtCzl5XmRpr565LvUDsCmzMLV
         RPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911212; x=1690516012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH9eaVq/3xF5+eoF3tJlJvK/nUNTkULMc9bRvazMcXM=;
        b=F13gyTm6gEblUSwFDrhWuy/mc/3YVU5cvdyhHVndWx39wuSN9WMl97RujBIN1MZ098
         I4nbLU8InY4PCAx3NNE+NlFO5GN7FAxBUfwj2rBC2SpLLhI6sYoDx9iV4mzM1+lc3WaN
         lAjcaQOtSaUOxDPi5sObWZiTWZmwqxaWLvpj9RE2VeoTxGTotf5X0LQNNwcUFhKw+HB3
         JKvW+8VbGYpVp+oUeEllH9OcxkoWZIC9gvtav5132lBIAgpArTfGUE1UX5MX6kSRtyG2
         sLnwA3IPUgIllZOcfJlK5IdZdTva0XTwWNwelzo+vJd8nOOb0b3vtWx92/9WTwIVYptB
         He/A==
X-Gm-Message-State: ABy/qLa6q+bRF3h+gRUCB6iq50ls5Uzv1J6782Sr+vg/9LiRodyHFmQS
        nPw3ov9UYSecNqhIFGRglgZNBg==
X-Google-Smtp-Source: APBJJlFwy4ubM+xPNPM5dstHjmfNddoFZSHjw0+5/hrgo2ajuwmdAACHgwnCZuMzltQ1GcqzD2X+qA==
X-Received: by 2002:a50:8e07:0:b0:51a:1ffd:10e with SMTP id 7-20020a508e07000000b0051a1ffd010emr43273edw.3.1689911212419;
        Thu, 20 Jul 2023 20:46:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5f41:554c:a4f4:69d])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b003141e629cb6sm2938755wro.101.2023.07.20.20.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:46:51 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Lock VMA in dup_anon_vma() before setting ->anon_vma
Date:   Fri, 21 Jul 2023 05:46:43 +0200
Message-ID: <20230721034643.616851-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VMAs are merged, dup_anon_vma() is called with `dst` pointing to the
VMA that is being expanded to cover the area previously occupied by another
VMA. This currently happens while `dst` is not write-locked.

This means that, in the `src->anon_vma && !dst->anon_vma` case, as soon as
the assignment `dst->anon_vma = src->anon_vma` has happened, concurrent
page faults can happen on `dst` under the per-VMA lock.
This is already icky in itself, since such page faults can now install
pages into `dst` that are attached to an `anon_vma` that is not yet tied
back to the `anon_vma` with an `anon_vma_chain`.
But if `anon_vma_clone()` fails due to an out-of-memory error, things get
much worse: `anon_vma_clone()` then reverts `dst->anon_vma` back to NULL,
and `dst` remains completely unconnected to the `anon_vma`, even though we
can have pages in the area covered by `dst` that point to the `anon_vma`.

This means the `anon_vma` of such pages can be freed while the pages are
still mapped into userspace, which leads to UAF when a helper like
folio_lock_anon_vma_read() tries to look up the anon_vma of such a page.

This theoretically is a security bug, but I believe it is really hard to
actually trigger as an unprivileged user because it requires that you can
make an order-0 GFP_KERNEL allocation fail, and the page allocator tries
pretty hard to prevent that.

I think doing the vma_start_write() call inside dup_anon_vma() is the most
straightforward fix for now.

For a kernel-assisted reproducer, see the notes section of the patch mail.

Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Cc: stable@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
To reproduce, patch mm/rmap.c by adding "#include <linux/delay.h>" and
changing anon_vma_chain_alloc() like this:
 
 static inline struct anon_vma_chain *anon_vma_chain_alloc(gfp_t gfp)
 {
+       if (strcmp(current->comm, "FAILME") == 0) {
+               // inject delay and error
+               mdelay(2000);
+               return NULL;
+       }
        return kmem_cache_alloc(anon_vma_chain_cachep, gfp);
 }

Then build with KASAN and run this reproducer:


#define _GNU_SOURCE
#include <pthread.h>
#include <err.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/prctl.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1L) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

static char *area;
static volatile int fault_thread_done;
static volatile int spin_launch;

static void *fault_thread(void *dummy) {
  while (!spin_launch) /*spin*/;
  sleep(1);
  area[0] = 1;
  fault_thread_done = 1;
  return NULL;
}

int main(void) {
  fault_thread_done = 0;
  pthread_t thread;
  if (pthread_create(&thread, NULL, fault_thread, NULL))
    errx(1, "pthread_create");

  // allocator spam
  int fd = SYSCHK(open("/etc/hostname", O_RDONLY));
  char *vmas[10000];
  for (int i=0; i<5000; i++) {
    vmas[i] = SYSCHK(mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0));
    *vmas[i] = 1;
  }

  // create a 3-page area, no anon_vma at this point, with guard vma behind it to prevent merging with neighboring anon_vmas
  area = SYSCHK(mmap((void*)0x10000, 0x4000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
  SYSCHK(mmap(area+0x3000, 0x1000, PROT_READ, MAP_SHARED|MAP_FIXED, fd, 0));
  // turn it into 3 VMAs
  SYSCHK(mprotect(area+0x1000, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC));

  // create an anon_vma for the tail VMA
  area[0x2000] = 1;

  // more allocator spam
  for (int i=5000; i<10000; i++) {
    vmas[i] = SYSCHK(mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0));
    *vmas[i] = 1;
  }

  printf("with anon_vma on tail VMA:\n\n");
  system("cat /proc/$PPID/smaps | head -n55");
  printf("\n\n");

  spin_launch=1;
  // mprotect() will try to merge the VMAs but bail out due to the injected
  // allocator failure
  SYSCHK(prctl(PR_SET_NAME, "FAILME"));
  SYSCHK(mprotect(area+0x1000, 0x1000, PROT_READ|PROT_WRITE));
  SYSCHK(prctl(PR_SET_NAME, "normal"));

  printf("after merge from mprotect:\n\n");
  if (!fault_thread_done)
    errx(1, "fault thread not done yet???");
  system("cat /proc/$PPID/smaps | head -n55");
  printf("\n\n");

  // release the anon_vma
  SYSCHK(munmap(area+0x1000, 0x2000));

  // release spam
  for (int i=0; i<10000; i++)
    SYSCHK(munmap(vmas[i], 0x1000));

  // wait for RCU
  sleep(2);

  // trigger UAF?
  printf("trying to trigger uaf...\n");
  SYSCHK(madvise(area, 0x1000, 21/*MADV_PAGEOUT*/));
}


You should get an ASAN splat like:

BUG: KASAN: use-after-free in folio_lock_anon_vma_read+0x9d/0x2f0
Read of size 8 at addr ffff8880053a2660 by task normal/549

CPU: 1 PID: 549 Comm: normal Not tainted 6.5.0-rc2-00073-ge599e16c16a1-dirty #292
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x36/0x50
 print_report+0xcf/0x660
[...]
 kasan_report+0xc7/0x100
[...]
 folio_lock_anon_vma_read+0x9d/0x2f0
 rmap_walk_anon+0x282/0x350
[...]
 folio_referenced+0x277/0x2a0
[...]
 shrink_folio_list+0xc9f/0x15c0
[...]
 reclaim_folio_list+0xdc/0x1f0
[...]
 reclaim_pages+0x211/0x280
[...]
 madvise_cold_or_pageout_pte_range+0x2ea/0x6a0
[...]
 walk_pgd_range+0x6c5/0xb90
[...]
 __walk_page_range+0x27f/0x290
[...]
 walk_page_range+0x1fd/0x230
[...]
 madvise_pageout+0x1cd/0x2d0
[...]
 do_madvise+0xb58/0x1280
[...]
 __x64_sys_madvise+0x62/0x70
 do_syscall_64+0x3b/0x90
[...]


 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3eda23c9ebe7..3937479d0e07 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -615,6 +615,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		vma_start_write(dst);
 		dst->anon_vma = src->anon_vma;
 		return anon_vma_clone(dst, src);
 	}

base-commit: e599e16c16a16be9907fb00608212df56d08d57b
-- 
2.41.0.487.g6d72f3e995-goog

