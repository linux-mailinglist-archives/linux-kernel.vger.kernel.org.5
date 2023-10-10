Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520877BF44B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442659AbjJJH1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442556AbjJJH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:27:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5E326F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:25:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406402933edso49568275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696922719; x=1697527519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TVFpVcIea+y33en3TIZ3rzGeaFl4qxAMi6FTjOi3KY=;
        b=J+d+XKMUV2rU6rcetdzMrWyLEZB+clbr/oLrYzMxkgulYsf1dpfUkM1ocOtZ2YOX/B
         AbWj8bRs3BSzJpan6XmiiU4Z0Nepbq7AdbNfLsvQDJzs0DM9AneA0YCqEpdi7qMkFVTA
         EKvhwOpfKSlpXgbEucZJxx+0U+g4QGpr1oDNF4E7hHwcHXt0YxwpP0MnDxuFEkjKCltp
         AnMU9ef8w2mzZfTcybuFrmbqeOwNg1qu2wIlnjLnUuS3C1KnrddQhqpxHX5B87VmH0Wq
         gDiJQfHeyEqG+9j+okankL3McRLYNKItVMDym4YP/L5mJla9OoUs137RlF5ZxrGPkwZb
         xXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696922719; x=1697527519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TVFpVcIea+y33en3TIZ3rzGeaFl4qxAMi6FTjOi3KY=;
        b=O0WxnrZFmWSaWqZ1kqCOGGt052ncID594cdpJRt7+aTGwHASSkEYe94kZVVZWcZAkq
         k9KP6QZI/kxKuq0RhmL3QkilCWba63RRk9wFrPwm+vc93rJXaavNn+3KUjsnWpMHFxN9
         WXI9oI+ZDwxSnSx6X5wurqCyNh2QYvnAyAKNxuQlrumSkWLOMj/MzNGu0v3YpjFqBPnj
         F3T+9pm0ZB0NB4GgJA/0n6/FuAv3OY3S+MShIkErkF96U4KQGA4caJuk0q/q1KEkj+ds
         QLQ05uP/p2JWDYPpEtofFT66vrwodmrGl4fehmvoH+s459zL0q+gDAL52qPD9l8sX6d7
         v3Dg==
X-Gm-Message-State: AOJu0YxzeGqi+JqYpDQt+8PEyXjx9Gjp4l0f0eywM6Moqfy+fZvzuI+a
        5VphiV1p9rIYfCopeT5/Dfk=
X-Google-Smtp-Source: AGHT+IFxo0w3THdPczoWlufoCzZ9kMB0efXaXT51R2JbrDJy5/905oDyHQ7PAjVRsPG1hyT5ULsJXA==
X-Received: by 2002:a05:600c:2248:b0:405:36d7:4582 with SMTP id a8-20020a05600c224800b0040536d74582mr15298259wmm.15.1696922718342;
        Tue, 10 Oct 2023 00:25:18 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id q5-20020a7bce85000000b0040596352951sm15570524wmj.5.2023.10.10.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:25:17 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RESEND PATCH v2] mm/mprotect: allow unfaulted VMAs to be unaccounted on mprotect()
Date:   Tue, 10 Oct 2023 08:25:02 +0100
Message-ID: <ad5540371a16623a069f03f4db1739f33cde1fab.1696921767.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mprotect() is used to make unwritable VMAs writable, they have the
VM_ACCOUNT flag applied and memory accounted accordingly.

If the VMA has had no pages faulted in and is then made unwritable once
again, it will remain accounted for, despite not being capable of extending
memory usage.

Consider:-

ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
mprotect(ptr + page_size, page_size, PROT_READ);

The first mprotect() splits the range into 3 VMAs and the second fails to
merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
rendering them unmergeable.

This is unnecessary, since no pages have actually been allocated and the
middle VMA is not capable of utilising more memory, thereby introducing
unnecessary VMA fragmentation (and accounting for more memory than is
necessary).

Since we cannot efficiently determine which pages map to an anonymous VMA,
we have to be very conservative - determining whether any pages at all have
been faulted in, by checking whether vma->anon_vma is NULL.

We can see that the lack of anon_vma implies that no anonymous pages are
present as evidenced by vma_needs_copy() utilising this on fork to
determine whether page tables need to be copied.

The only place where anon_vma is set NULL explicitly is on fork with
VM_WIPEONFORK set, however since this flag is intended to cause the child
process to not CoW on a given memory range, it is right to interpret this
as indicating the VMA has no faulted-in anonymous memory mapped.

If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
have ensured that a new anon_vma is assigned (and correctly related to its
parent anon_vma) should any pages be CoW-mapped.

The overall operation is safe against races as we hold a write lock against
mm->mmap_lock.

If we could efficiently look up the VMA's faulted-in pages then we would
unaccount all those pages not yet faulted in. However as the original
comment alludes this simply isn't currently possible, so we are
conservative and account all pages or none at all.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mprotect.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f85d99682ab..6bae0de547b3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -608,8 +608,11 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
-	 * make it unwritable again. hugetlb mapping were accounted for
-	 * even if read-only so there is no need to account for them here
+	 * make it unwritable again except in the anonymous case where no
+	 * anon_vma has yet to be assigned.
+	 *
+	 * hugetlb mapping were accounted for even if read-only so there is
+	 * no need to account for them here.
 	 */
 	if (newflags & VM_WRITE) {
 		/* Check space limits when area turns into data. */
@@ -623,6 +626,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
 		}
+	} else if ((oldflags & VM_ACCOUNT) && vma_is_anonymous(vma) &&
+		   !vma->anon_vma) {
+		newflags &= ~VM_ACCOUNT;
 	}

 	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
@@ -638,6 +644,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		*pprev = vma;
 	}

+	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
+		vm_unacct_memory(nrpages);
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
--
2.42.0
