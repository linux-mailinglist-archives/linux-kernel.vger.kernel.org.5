Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7627837A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHVBz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHVBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C3186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790970a8706so147646939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669321; x=1693274121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsH3vkDr9agJVI3SouFCcK5RkzBRN3iHA9ib5+au0Rw=;
        b=CzldOLSR/1CFch60cKxnxJV7KC0TbczE/AS7NU3vcELLGEqTO96428h5zAJIQx9q47
         qJfdzOYkvoVEnJLl8uynvnnrnlYgm5gqjmtv+3cgEgtH/Nt4FRLdULpgo/k3RjIb+SnU
         WTKw5yuYuGQnOEhCHelds3JU0dgsb9m7n0OS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669321; x=1693274121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsH3vkDr9agJVI3SouFCcK5RkzBRN3iHA9ib5+au0Rw=;
        b=E95CKLmRMkli9UxsmIlsf38BBDJx5jm6Mmi3dY5oUe1srRthxEnjFDfRP0jIxspGRv
         5vPBz+pMyJ5o6cXPPVW4tplOZJqwVP+ON/LgSBzC6mtii51Ulak3/fe89w3s3cRNiWWV
         gjrj8lbggNEJqxys0NJz8b8wEkyIPN64yuyGGInM/yF1grDr9mOud3Blk/VDDvhazQiW
         yFBa0zw9cmWK7wZAZlH/OA3AsFm7boPbNXR1yXAXRz2g7L+ZvMVcDxoWyKo+3szZ+bOy
         1/xC12TSjeegu+7K5kfnvIHKydma5MD9cuNAAXy2LDkZQaWr9Sezk+q/ByxEDNer65Gd
         xBMQ==
X-Gm-Message-State: AOJu0YwWpfoYm6F9O+VGIJVRIyRtG8WXqZ8a+inE6Ur2kesWPzj2h/3+
        gZeZUtqsLrvkRcEC4wxJ73y46njTp03w9PvHhzM=
X-Google-Smtp-Source: AGHT+IFjdGA7XRGfiXyy54FM+yhexl4gbxKokE/+1QN35KTpxnmuosD5M/koT6P5pAtsasmz/S2vng==
X-Received: by 2002:a05:6e02:dce:b0:349:9938:a9b3 with SMTP id l14-20020a056e020dce00b003499938a9b3mr9158834ilj.3.1692669321018;
        Mon, 21 Aug 2023 18:55:21 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v5 1/7] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Tue, 22 Aug 2023 01:54:54 +0000
Message-ID: <20230822015501.791637-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822015501.791637-1-joel@joelfernandes.org>
References: <20230822015501.791637-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we see reports [1] of a warning that triggers due to
move_page_tables() doing a downward and overlapping move on a
mutually-aligned offset within a PMD. By mutual alignment, I
mean the source and destination addresses of the mremap are at
the same offset within a PMD.

This mutual alignment along with the fact that the move is downward is
sufficient to cause a warning related to having an allocated PMD that
does not have PTEs in it.

This warning will only trigger when there is mutual alignment in the
move operation. A solution, as suggested by Linus Torvalds [2], is to
initiate the copy process at the PMD level whenever such alignment is
present. Implementing this approach will not only prevent the warning
from being triggered, but it will also optimize the operation as this
method should enhance the speed of the copy process whenever there's a
possibility to start copying at the PMD level.

Some more points:
a. The optimization can be done only when both the source and
destination of the mremap do not have anything mapped below it up to a
PMD boundary. I add support to detect that.

b. #1 is not a problem for the call to move_page_tables() from exec.c as
nothing is expected to be mapped below the source. However, for
non-overlapping mutually aligned moves as triggered by mremap(2), I
added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

d. We need to be careful about mremap of ranges within the VMA itself.
For this purpose, I added checks to determine if the address after
alignment falls within its VMA itself.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 11e06e4ab33b..035fbf542a8f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -489,6 +489,53 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	return moved;
 }
 
+/*
+ * A helper to check if a previous mapping exists. Required for
+ * move_page_tables() and realign_addr() to determine if a previous mapping
+ * exists before we can do realignment optimizations.
+ */
+static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
+			       unsigned long mask)
+{
+	unsigned long addr_masked = addr_to_align & mask;
+
+	/*
+	 * If @addr_to_align of either source or destination is not the beginning
+	 * of the corresponding VMA, we can't align down or we will destroy part
+	 * of the current mapping.
+	 */
+	if (vma->vm_start != addr_to_align)
+		return false;
+
+	/*
+	 * Make sure the realignment doesn't cause the address to fall on an
+	 * existing mapping.
+	 */
+	return find_vma_intersection(vma->vm_mm, addr_masked, addr_to_align) == NULL;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			     unsigned long *new_addr, struct vm_area_struct *new_vma,
+			     unsigned long mask)
+{
+	/* Skip if the addresses are already aligned. */
+	if ((*old_addr & ~mask) == 0)
+		return;
+
+	/* Only realign if the new and old addresses are mutually aligned. */
+	if ((*old_addr & ~mask) != (*new_addr & ~mask))
+		return;
+
+	/* Ensure realignment doesn't cause overlap with existing mappings. */
+	if (!can_align_down(old_vma, *old_addr, mask) ||
+	    !can_align_down(new_vma, *new_addr, mask))
+		return;
+
+	*old_addr = *old_addr & mask;
+	*new_addr = *new_addr & mask;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -508,6 +555,14 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
 
+	/*
+	 * If possible, realign addresses to PMD boundary for faster copy.
+	 * Only realign if the mremap copying hits a PMD boundary.
+	 */
+	if ((vma != new_vma)
+		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
+		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
 				old_addr, old_end);
@@ -577,6 +632,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned
+	 * but we broke out of the above loop for the first PMD itself.
+	 */
+	if (len + old_addr < old_end)
+		return 0;
+
 	return len + old_addr - old_end;	/* how much done */
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

