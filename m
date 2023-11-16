Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD37EE82D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjKPUQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbjKPUP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E6131
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700165753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5Hs9QdfwrjJDDWeQ9cxEQGj2Q5OwzhPOjdAfeINdzY=;
        b=Ht139EY9bgY4hLQn0dJcnFqesDIAwPtigeCY7vvmzJnvaN9pBIjOFTLRfaq/d9GmtRqOfa
        7hVeS6+ZJpMj4j3Acr7dK/emKLQTADVCujwDQZanCe0/jj/AVxOz2wOUtBbqeLvX/xa+p6
        536DAgj00N8xlQNiYTLGE7jAyBcxoCY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-eEapdL2RNEexFak4aCs0gw-1; Thu, 16 Nov 2023 15:15:52 -0500
X-MC-Unique: eEapdL2RNEexFak4aCs0gw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66ffa15d354so3241316d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165752; x=1700770552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Hs9QdfwrjJDDWeQ9cxEQGj2Q5OwzhPOjdAfeINdzY=;
        b=Gz6pvDvpkJ6vIg5+/j5OA4jdggLdYS0NfMQGmToZxxPvg9MJIz20uksomsyGoRxsRq
         gSfKac7y8hqwh6CMWydTouD2Zri/N8IIaYJK67+sHsaW1l2cNK/aM66rL6TVVWNYom1F
         3dqFU9U5snRBHk7TYDvEPaEgg/B0TBd5XK6sM4iymoSr2C1NOsppWtgm7q7tdnUU4Bh9
         LC4A0VBacqOAWWhRh86G4JNSbbpRmrNL19ui63nVs6V07I3wBGwURWNcYlJOD8leiiWF
         tbPzqb2BcHRiQzHjJSHX0rJLR0r80S8DuwoCvtYI4FnfigLHD/vhATm6pVs/SppMk7Em
         Bgzw==
X-Gm-Message-State: AOJu0YzMTsAzEHZhdzEmfJ+v3HIITmWZouenjGv5NcgX3hdHnX74BEmZ
        jH5jWOUd/nSKTyfMy7cQ9ifgh7DgiYpeSiooKuV0Y9bwNqQHwvr5O+NxzTMcZqyUWe0pd57mq3L
        gyHT3+zj5WB637Ku6YVuwa4zR
X-Received: by 2002:a05:620a:4687:b0:76d:9234:1db4 with SMTP id bq7-20020a05620a468700b0076d92341db4mr10712155qkb.7.1700165751876;
        Thu, 16 Nov 2023 12:15:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmDFvQLKh+9k0oT4EBKFDQfAkcZ4rcK4Q8PBCrNJ52LzF+uNq5CMglTWczZ0GdgxJefrjWuw==
X-Received: by 2002:a05:620a:4687:b0:76d:9234:1db4 with SMTP id bq7-20020a05620a468700b0076d92341db4mr10712123qkb.7.1700165751543;
        Thu, 16 Nov 2023 12:15:51 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b007659935ce64sm65524qkp.71.2023.11.16.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:15:50 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
Subject: [PATCH 1/3] mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check
Date:   Thu, 16 Nov 2023 15:15:45 -0500
Message-ID: <20231116201547.536857-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116201547.536857-1-peterx@redhat.com>
References: <20231116201547.536857-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new ioctl(PAGEMAP_SCAN) relies on vma wr-protect capability provided by
userfault, however in the vma test it didn't explicitly require the vma to
have wr-protect function enabled, even if PM_SCAN_WP_MATCHING flag is set.

It means the pagemap code can now apply uffd-wp bit to a page in the vma
even if not registered to userfaultfd at all.

Then in whatever way as long as the pte got written and page fault
resolved, we'll apply the write bit even if uffd-wp bit is set.  We'll see
a pte that has both UFFD_WP and WRITE bit set.  Anything later that looks
up the pte for uffd-wp bit will trigger the warning:

WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]

Fix it by doing proper check over the vma attributes when
PM_SCAN_WP_MATCHING is specified.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51e0ec658457..e91085d79926 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1994,15 +1994,31 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	unsigned long vma_category = 0;
+	bool wp_allowed = userfaultfd_wp_async(vma) &&
+	    userfaultfd_wp_use_markers(vma);
 
-	if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
-		vma_category |= PAGE_IS_WPALLOWED;
-	else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
-		return -EPERM;
+	if (!wp_allowed) {
+		/* User requested explicit failure over wp-async capability */
+		if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
+			return -EPERM;
+		/*
+		 * User requires wr-protect, and allows silently skipping
+		 * unsupported vmas.
+		 */
+		if (p->arg.flags & PM_SCAN_WP_MATCHING)
+			return 1;
+		/*
+		 * Then the request doesn't involve wr-protects at all,
+		 * fall through to the rest checks, and allow vma walk.
+		 */
+	}
 
 	if (vma->vm_flags & VM_PFNMAP)
 		return 1;
 
+	if (wp_allowed)
+		vma_category |= PAGE_IS_WPALLOWED;
+
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		vma_category |= PAGE_IS_SOFT_DIRTY;
 
-- 
2.41.0

