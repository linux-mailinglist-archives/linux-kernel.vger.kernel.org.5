Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B47B6561
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjJCJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbjJCJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:23:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FFB7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:23:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d865c441a54so734843276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324982; x=1696929782; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzr/4uL62aOMXHcIAqfjDQcxRGe9jlWGjvKm9366txw=;
        b=u2VvcG01nUNwn5OWn7Il/uGa0HHiBypHthBaYP9WNSd552T6Q47T/pFLnvGuvLBWyz
         ShrNGkvODTNH7RDHrhX+xMp7/F0qvGwVnEgQ3r8fFkVlMjOBjN7qeNK0/jAOr8yJ6ufj
         FApIJ6NlDMs3KTb0QHPon+puNNkHyhEV/ARKT8VaMF+kwxNFjkIXP0v1Q57VO/xaLodP
         gsHrHw4XYE3KBWCLaemYNGH0fKa2TcVXpDtebWqvy6FWYYqUZPKByaE9Ptd/fDAQx3XJ
         aTs2W6N09uSBPnwP8hr1WabY9WYbM/zhNoqrfaMdm6gU7ALr00SMjalyQ8Y4FkiSg2RM
         zI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324982; x=1696929782;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzr/4uL62aOMXHcIAqfjDQcxRGe9jlWGjvKm9366txw=;
        b=esKIiP/hlP7YeSXPrhPBoIx6wwvoYBnzL/RxNFak9qc537YejnJM1LmJHjarFOIoA2
         zp81I5urbhlE1KJIdKM8ECMuxjRAqgAfdKUhGoOq5T1D/Q1l080Zs1HBwmoASFuWo/BU
         p5Ht/3dEJZPYhNKOAGZvu6VvL1oxev7U+SCcaqXIe04vMvg2lfFKY0DrtLtCO9B0Z4hC
         g3+EK6+WzELlLE3p63XAWOHEzyIlvxWVwmc/xX8VQ9IZ1r5N2zO17DaCqhOqEJhzPWNu
         RiqQEelHYWls3iVvdH5+D588r3yVUxHp7bUx0D0O/Kcor7S+cIuVbvcArjYETOGQU1/I
         IkZA==
X-Gm-Message-State: AOJu0YwGL5qBRhrqwCAxiEf3oU1YEvRomK4k6iqH5psv10UNQ4S2YyYT
        D7CqHJOlfzEwXalv7wkGMCWKDw==
X-Google-Smtp-Source: AGHT+IFxboDdNa1UhQmoXRYSqnKITzmYFNT7NTostAtgCQUNJAxTZwIq6gRE4Eb16MSOzmlZgLi7Uw==
X-Received: by 2002:a5b:c89:0:b0:d81:599f:a538 with SMTP id i9-20020a5b0c89000000b00d81599fa538mr10809754ybq.51.1696324982333;
        Tue, 03 Oct 2023 02:23:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c6-20020a259c06000000b00d816fa23bd4sm280649ybo.26.2023.10.03.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:23:01 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:22:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 07/12] mempolicy: mpol_shared_policy_init() without
 pseudo-vma
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <3bef62d8-ae78-4c2-533-56a44ae425c@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpol_shared_policy_init() does not need to use a pseudo-vma: it can use
sp_alloc() and sp_insert() directly, since the object's shared policy
tree is empty and inaccessible (needing no lock) at get_inode() time.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1d3f9e1ecbb8..5d99fd5cd60b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2756,30 +2756,30 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 	rwlock_init(&sp->lock);
 
 	if (mpol) {
-		struct vm_area_struct pvma;
-		struct mempolicy *new;
+		struct sp_node *sn;
+		struct mempolicy *npol;
 		NODEMASK_SCRATCH(scratch);
 
 		if (!scratch)
 			goto put_mpol;
-		/* contextualize the tmpfs mount point mempolicy */
-		new = mpol_new(mpol->mode, mpol->flags, &mpol->w.user_nodemask);
-		if (IS_ERR(new))
+
+		/* contextualize the tmpfs mount point mempolicy to this file */
+		npol = mpol_new(mpol->mode, mpol->flags, &mpol->w.user_nodemask);
+		if (IS_ERR(npol))
 			goto free_scratch; /* no valid nodemask intersection */
 
 		task_lock(current);
-		ret = mpol_set_nodemask(new, &mpol->w.user_nodemask, scratch);
+		ret = mpol_set_nodemask(npol, &mpol->w.user_nodemask, scratch);
 		task_unlock(current);
 		if (ret)
-			goto put_new;
+			goto put_npol;
 
-		/* Create pseudo-vma that contains just the policy */
-		vma_init(&pvma, NULL);
-		pvma.vm_end = TASK_SIZE;	/* policy covers entire file */
-		mpol_set_shared_policy(sp, &pvma, new); /* adds ref */
-
-put_new:
-		mpol_put(new);			/* drop initial ref */
+		/* alloc node covering entire file; adds ref to file's npol */
+		sn = sp_alloc(0, MAX_LFS_FILESIZE >> PAGE_SHIFT, npol);
+		if (sn)
+			sp_insert(sp, sn);
+put_npol:
+		mpol_put(npol);	/* drop initial ref on file's npol */
 free_scratch:
 		NODEMASK_SCRATCH_FREE(scratch);
 put_mpol:
-- 
2.35.3

