Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69777D36D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbjHOThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbjHOTha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:37:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77788E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:37:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so1645e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692128248; x=1692733048;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sM1zcvKgTVf4MMl3o4eOD/9lkdvWOqjCRHYfZxmXFp4=;
        b=dtsj2Yccnw6ntfVKzxT2D57HS3aC6l+R2RtnXXY3+XSkP+4gL0i0rwbavNsx1ywYxL
         m47ZwE4nBSkXSBnyJDpaaVm66Ai2wjtElAVf2fKmaY4jVosflLhgyJch88FWl9+wh3DQ
         A3GgFisdZgKlW/WswSJoxVB1V50VSLO9m6RmzHARaP5KaZx0u1HtAK3qGunDC+aCmFej
         j41Ht8V5B4g/SjQIYaOSeI8tZ2NZvmIicU46hLASpqMMz7BXPVJLeMv2ly+JFzlDpqHZ
         2jbW7zrPP7h52I0xTCABmY23LFnZuiwzLVk6sJtV8TYpXbc+WFlUMBYbjVEFoyglo+RC
         bLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128248; x=1692733048;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM1zcvKgTVf4MMl3o4eOD/9lkdvWOqjCRHYfZxmXFp4=;
        b=Yy5nGGdZ9FmUgbA8clrXpduf+K8/NHDn8c3yzv55nRb5j00ErbDdRS00Wdw0In9f01
         lujkfbBhyHD6FIGBaPhUve1wrLZ5bMDHZ6Oi23vu1XE7y6/Pv/JEBm1xubYIQ6NsD0re
         /2u8E+kbeQ4DLF18ejvjLcaC7zlEbpY28s2xmw42I/hhnZKbvyogfmeY435WAS+Oay8y
         H/0Iw55FtHmw/38hA0jaELWLH4wSSnuzDInVBk3G2q3+CUN4F79efv+hvblin6oS/+uT
         iHZq4CqQEGdAiNkQBqOA0/TbeCSzKaFN9DWu5rLHx/AtHWwIeX0VsWs6T3tQrYsEHKrZ
         +hNQ==
X-Gm-Message-State: AOJu0Yw2etufTOFsy4BfgychgWIu92CTwnjpOvSb6vOEExLfGdnZw4Sn
        tmGgvhvkJQnl8lgRwHdYMPoj1y8TAGiLzYE+B1+6vHjU/Ewte1nW6+mAAe4r
X-Google-Smtp-Source: AGHT+IFI8xJSZXHdMgHHc7A92k4PePM3nJWjf0sI2O6KJfgC7yDF//oZGJYbaVgQf0u5IU9GEB+hVihgyro5GdqD4Zc=
X-Received: by 2002:a05:600c:1c90:b0:3f7:e4d8:2569 with SMTP id
 k16-20020a05600c1c9000b003f7e4d82569mr1047wms.5.1692128247840; Tue, 15 Aug
 2023 12:37:27 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Aug 2023 21:36:51 +0200
Message-ID: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
Subject: maple tree change made it possible for VMA iteration to see same VMA
 twice due to late vma_merge() failure
To:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 18b098af2890 ("vma_merge: set vma iterator to correct
position.") added a vma_prev(vmi) call to vma_merge() at a point where
it's still possible to bail out. My understanding is that this moves
the VMA iterator back by one VMA.

If you patch some extra logging into the kernel and inject a fake
out-of-memory error at the vma_iter_prealloc() call in vma_split() (a
real out-of-memory error there is very unlikely to happen in practice,
I think - my understanding is that the kernel will basically kill
every process on the system except for init before it starts failing
GFP_KERNEL allocations that fit within a single slab, unless the
allocation uses GFP_ACCOUNT or stuff like that, which the maple tree
doesn't):

```
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..a7be4d6a5db6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1454,9 +1454,16 @@ static int userfaultfd_register(struct
userfaultfd_ctx *ctx,
                prev = vma;

        ret = 0;
+       if (strcmp(current->comm, "FAILME") == 0)
+               pr_warn("%s: begin vma iteration\n", __func__);
        for_each_vma_range(vmi, vma, end) {
                cond_resched();

+               if (strcmp(current->comm, "FAILME") == 0) {
+                       pr_warn("%s: prev=%px, vma=%px (%016lx-%016lx)\n",
+                               __func__, prev, vma, vma->vm_start,
vma->vm_end);
+               }
+
                BUG_ON(!vma_can_userfault(vma, vm_flags));
                BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
                       vma->vm_userfaultfd_ctx.ctx != ctx);
@@ -1481,6 +1488,8 @@ static int userfaultfd_register(struct
userfaultfd_ctx *ctx,
                                 vma_policy(vma),
                                 ((struct vm_userfaultfd_ctx){ ctx }),
                                 anon_vma_name(vma));
+               if (strcmp(current->comm, "FAILME") == 0)
+                       pr_warn("%s: vma_merge returned %px\n", __func__, prev);
                if (prev) {
                        /* vma_merge() invalidated the mas */
                        vma = prev;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3937479d0e07..fd435c40c43d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -990,7 +990,7 @@ struct vm_area_struct *vma_merge(struct
vma_iterator *vmi, struct mm_struct *mm,
        if (err)
                return NULL;

-       if (vma_iter_prealloc(vmi))
+       if (strcmp(current->comm, "FAILME")==0 || vma_iter_prealloc(vmi))
                return NULL;

        init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
```

and then you run this reproducer:
```
#define _GNU_SOURCE
#include <err.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/prctl.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <linux/userfaultfd.h>

#ifndef UFFD_USER_MODE_ONLY
#define UFFD_USER_MODE_ONLY 1
#endif

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int uffd = SYSCHK(syscall(__NR_userfaultfd, UFFD_USER_MODE_ONLY));

  struct uffdio_api api = { .api = UFFD_API, .features = 0 };
  SYSCHK(ioctl(uffd, UFFDIO_API, &api));

  /* create vma1 */
  SYSCHK(mmap((void*)0x100000UL, 0x1000, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0));

  /* set uffd on vma1 */
  struct uffdio_register reg1 = {
    .range = { .start = 0x100000, .len = 0x1000 },
    .mode = UFFDIO_REGISTER_MODE_MISSING
  };
  SYSCHK(ioctl(uffd, UFFDIO_REGISTER, &reg1));

  /* create vma2 */
  SYSCHK(mmap((void*)0x101000UL, 0x1000, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0));

  /* tries to merge vma2 into vma1, with injected allocation failure
causing merge failure */
  SYSCHK(prctl(PR_SET_NAME, "FAILME"));
  struct uffdio_register reg2 = {
    .range = { .start = 0x101000, .len = 0x1000 },
    .mode = UFFDIO_REGISTER_MODE_MISSING
  };
  SYSCHK(ioctl(uffd, UFFDIO_REGISTER, &reg2));
  SYSCHK(prctl(PR_SET_NAME, "normal"));
}
```

then you'll get this fun log output, showing that the same VMA
(ffff88810c0b5e00) was visited by two iterations of the VMA iteration
loop, and on the second iteration, prev==vma:

[  326.765586] userfaultfd_register: begin vma iteration
[  326.766985] userfaultfd_register: prev=ffff88810c0b5ef0,
vma=ffff88810c0b5e00 (0000000000101000-0000000000102000)
[  326.768786] userfaultfd_register: vma_merge returned 0000000000000000
[  326.769898] userfaultfd_register: prev=ffff88810c0b5e00,
vma=ffff88810c0b5e00 (0000000000101000-0000000000102000)

I don't know if this can lead to anything bad but it seems pretty
clearly unintended?
