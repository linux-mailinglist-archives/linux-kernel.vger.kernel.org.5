Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB27F9C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjK0Irp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjK0Irl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:47:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81580125
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c398717726so3114688b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701074843; x=1701679643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9POB4kFuEKuzMcdZHLoubaPw/TJvHsiTa281mWkLZq8=;
        b=GC5F/CXFhYJuJUenZ0PWI85KLbBUvdyJlID0Gj9ZEVieYDdnKXIQN88P/8/PMOrm8D
         uLJMT8J8tEbEjzBU7NCfnWf+SW0jaCyAZI4xacKQFUFu4vpP9S2JzcTUHSbhFYPA1Uz3
         5+VOzKjq47G0RIhab/wVQ0nE2X8mO/i54mQxSXb3Aof3ujrP1ZLmP88dASCYTMOv5ebo
         3O+5ZpPnxeqhBQiMUMAxhigWbKndoLp9fyKp8BUvu16ngY/dq769Q5KPyDLfKxC7k9ah
         4vASxSjqO3F59TOqQfPLWSBN/6HsNgdy6/ZDusLaVzBEwyazQ0EDNY+TpTDBcD5Yy6id
         Lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074843; x=1701679643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9POB4kFuEKuzMcdZHLoubaPw/TJvHsiTa281mWkLZq8=;
        b=F+Q6Glr7B+sPz+6l7wZ5ZxELK0JTF+WxP4VIM8UnqVsJ4VTBCUIOTxLzX8E+bo8QV/
         Zl4p9vov2m0atpf+sPcOytJqk9a4KXtWXpdt40bTJzTANgsGceXgRZYOrHsuPsfFzrO2
         mxc0Nwiw+9jeUFTfo2Bf8rOGdEdi7ID+H5Fr1UT85YM0ip979fAnrOTGmKFX3r0ve0T8
         lsVvMtf6OtmMmVsNAocGbfMyQGve/JpcUxGCUyKzJ1bwj6YJ94uGaqt0TTk5LH2t/yMN
         aMHi/Gm8jDRyeTwAt2ejqyTZ7mEh1J/HSuidLRgr6nr9ZBkVoj69AkXgr6+6HKye+jXU
         O1xA==
X-Gm-Message-State: AOJu0YxWCR8ySgBd6m/VYU/0PL+95G1JY4EGxEJflzs9NMN6wxlKyM5+
        feXM1g6nvc9XHPt7cX6GMf5n2w==
X-Google-Smtp-Source: AGHT+IGPbAAqj7jljm3HkPkr6GUGngrFdQat2yh2VPEfUSz7fn/6W6SAjj42octpaoYEmJpwaYLguA==
X-Received: by 2002:a05:6a00:3926:b0:690:c75e:25c8 with SMTP id fh38-20020a056a00392600b00690c75e25c8mr11586636pfb.7.1701074843002;
        Mon, 27 Nov 2023 00:47:23 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm6686932pfd.121.2023.11.27.00.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Nov 2023 00:47:22 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] mm: pagewalk: assert write mmap lock only for walking the user page tables
Date:   Mon, 27 Nov 2023 16:46:42 +0800
Message-Id: <20231127084645.27017-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231127084645.27017-1-songmuchun@bytedance.com>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
introduces an assertion to walk_page_range_novma() to make all the users
of page table walker is safe. However, the race only exists for walking the
user page tables. And it is ridiculous to hold a particular user mmap write
lock against the changes of the kernel page tables. So only assert at least
mmap read lock when walking the kernel page tables. And some users matching
this case could downgrade to a mmap read lock to relief the contention of
mmap lock of init_mm, it will be nicer in hugetlb (only holding mmap read
lock) in the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/pagewalk.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index b7d7e4fcfad7a..f46c80b18ce4f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -539,6 +539,11 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * not backed by VMAs. Because 'unusual' entries may be walked this function
  * will also not lock the PTEs for the pte_entry() callback. This is useful for
  * walking the kernel pages tables or page tables for firmware.
+ *
+ * Note: Be careful to walk the kernel pages tables, the caller may be need to
+ * take other effective approache (mmap lock may be insufficient) to prevent
+ * the intermediate kernel page tables belonging to the specified address range
+ * from being freed (e.g. memory hot-remove).
  */
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
@@ -556,7 +561,29 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 
-	mmap_assert_write_locked(walk.mm);
+	/*
+	 * 1) For walking the user virtual address space:
+	 *
+	 * The mmap lock protects the page walker from changes to the page
+	 * tables during the walk.  However a read lock is insufficient to
+	 * protect those areas which don't have a VMA as munmap() detaches
+	 * the VMAs before downgrading to a read lock and actually tearing
+	 * down PTEs/page tables. In which case, the mmap write lock should
+	 * be hold.
+	 *
+	 * 2) For walking the kernel virtual address space:
+	 *
+	 * The kernel intermediate page tables usually do not be freed, so
+	 * the mmap map read lock is sufficient. But there are some exceptions.
+	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
+	 * to prevent the intermediate kernel pages tables belonging to the
+	 * specified address range from being freed. The caller should take
+	 * other actions to prevent this race.
+	 */
+	if (mm == &init_mm)
+		mmap_assert_locked(walk.mm);
+	else
+		mmap_assert_write_locked(walk.mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
-- 
2.20.1

