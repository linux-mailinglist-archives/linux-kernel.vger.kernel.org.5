Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B722F7BC91D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbjJGQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjJGQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:47:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F614BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 09:47:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32615eaa312so2876051f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696697273; x=1697302073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPzbdkXzux7hGqpntQrbYwU9cFGZ3zqwfLnYy+s7r78=;
        b=k0oR9sDoVV0zicSAbzDfSXSBo9ifxdlfUHfyuKeUw6HqoVfVXYrIMXuTJRlaDHcXsG
         ZBzUykoTkOuEHx4loJsCEWIk/5X8biKDrTd8/iT3YPTKJtE8uAVniiiq7ZcEuCsJb0hd
         wnxQCwGeni2wd8KCECoZge+wxjCrUEqgUZ38fziwKBJVt0YyS/SOMXC5RHggehX4ymj+
         qrgEgil+GWGUl0ITT5Z2IA1hvyXupNubpEhJQAdByM+O5xyK6KySN2dXOh0VdCW+yWQl
         0FN1GGrFcuxs2V0Wb6h6Sa54Zy01Hbx9NtGnf39HZw1ofaCNmF5ib42rDCB4T3AWo7Ts
         +UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696697273; x=1697302073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPzbdkXzux7hGqpntQrbYwU9cFGZ3zqwfLnYy+s7r78=;
        b=mtfeYhqau0QSjet2Db1jDxKLBSzuZyqfdIaKaUt4KqxuQw+5pCZa0b3EcvlwcZH6x7
         wMZk2V9vWjXN/BVkGtGnJ6ld3GSo/ASn1YMX9jWxN7peXQ2mGdw1wr3UrD+efYUgGbMW
         64x2Bf0mQefzt9E6JvCFw89e3YBpZvWW3hatoYOpQWfVY4y9dCItAYUrwxZfTZraS7Ab
         RPHgVjihGktKHcbao5J4LwNB24pW8cbeuxUMLB4DgN/EgziwR0n9H6/4OZq4E+jf3iP6
         4FSITWlLYZrsECPvxNldvOvXcwOaA8CNVjC4vhdZIHFYp0t5spAko7iACfF+QMSAjBV+
         Or2Q==
X-Gm-Message-State: AOJu0Yx8RiXIuNcb77YJFk39ssblMweTjJggBWuYYIPrDRWcTt/xQnJs
        Txy1aV6zNhOd74PCa7a7iVNhusnN5fQ=
X-Google-Smtp-Source: AGHT+IE0iF7TNrIoG00cme4DOEVEjXbhmV7pVKEgVWJYcUTViq8s5rmvK0WqRhGIqmNsNVq19Mvtfw==
X-Received: by 2002:a05:6000:186:b0:31f:c033:686c with SMTP id p6-20020a056000018600b0031fc033686cmr8884147wrx.49.1696697272334;
        Sat, 07 Oct 2023 09:47:52 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id x14-20020a5d54ce000000b0031773a8e5c4sm4694181wrv.37.2023.10.07.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 09:47:51 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2] mm/mprotect: allow unfaulted VMAs to be unaccounted on mprotect()
Date:   Sat,  7 Oct 2023 17:47:48 +0100
Message-ID: <bfef277462dd0dc75ce86e051bebc8b063f8d885.1696694712.git.lstoakes@gmail.com>
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

v2:
- Minor spelling correction.

v1:
https://lore.kernel.org/all/20230626204612.106165-1-lstoakes@gmail.com/


 mm/mprotect.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..10685ec35c5e 100644
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
 
 	/*
@@ -653,6 +659,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	}
 
 success:
+	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
+		vm_unacct_memory(nrpages);
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
-- 
2.42.0

