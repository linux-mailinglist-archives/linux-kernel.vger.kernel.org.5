Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469827AD341
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjIYIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIYIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:22:38 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E7A2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:22:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8168d08bebso6621688276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630151; x=1696234951; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sZK+xCuT0P0uH5eP+c4/6boHa42doWBfySEpYJVCK8=;
        b=3vMb1WfNB52Ctd8ZUSYd3LaVttK5c7Bfurq43e9L29hBs7NUW8q0+grL80cz4YRTfZ
         u/mqAWWMBom+VTxVTJp0DOeT0Rz/1VbBBv3e86WhH/Bsy4PiEw7RHGuX4iHAkLyRnmjH
         XXaYcHZM8HPKX8D8CskW81EF6/FJROCkpEQeXxjPUjqvK6ViOJcMxLkl/Hdcga2XkNbv
         zmNO8fKxha8IrVBud/Hb4Hie5by8IMGjhhhM662qhj6eMgtdbGzFYf2wV9jvSgv3SPzp
         3kngQmiV8uUFuLc0eEoQJ1wXXj2fQD7XRml8KvSwBpO8jHx0XS5Y4Fy6lBeXq2IU4u3u
         ofdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630151; x=1696234951;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sZK+xCuT0P0uH5eP+c4/6boHa42doWBfySEpYJVCK8=;
        b=YR67oEBQZ2V0+qPcQS6nV9TZieuYaBMyYVJdRXjYlefEVFE9GzKnsUG9+TL+1Lotx8
         pwHGyrxs8q1E1JtBEiwedQqXeU76LjwVW5AozCz3TuL+vMwOgHkmUmpE68he5RzPDY+D
         kzc0mSSrabz2hv1XwuHNhfFJoJ4Ro2Q0ijZFM7sqtrlG0fHgbXeaBojHO5hWojP/SfQ1
         qsQG1DaiWq9+51I/onOgtedhCt9ZIYJgFHlMXYy5XBd5AIKT5HZ67yEuEXD6T0Zlldx9
         hgb//CB1q0swZy2NBswmDbkVt/ABcqfpmxoQQe/kTyogWpKqemcnrp8LD4gRLtbhPOSc
         Ynow==
X-Gm-Message-State: AOJu0YyI+mn89qXpJ0SFELtJcVix+Cgoka3u69Eih8EWXBuHO1+gsRGz
        x0Tru6azyjsiguwSaz4l3HjG9A==
X-Google-Smtp-Source: AGHT+IEwv44FcIamrq7TyieXIPq5bY4OaPs0D1yBi6vYNp4KwxZNNaUgHfeQiKSegaaLKY4KIVfLOQ==
X-Received: by 2002:a25:6942:0:b0:d7b:9580:240c with SMTP id e63-20020a256942000000b00d7b9580240cmr6055638ybc.47.1695630151093;
        Mon, 25 Sep 2023 01:22:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n80-20020a25da53000000b00d217e46d25csm2127705ybf.4.2023.09.25.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:22:30 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:22:27 -0700 (PDT)
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
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/12] kernfs: drop shared NUMA mempolicy hooks
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <dffc667-5dc9-a980-dab8-8554eafbda7@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

It seems strange that kernfs should be an outlier with a set_policy and
get_policy in its kernfs_vm_ops.  Ah, it dates back to v2.6.30's commit
095160aee954 ("sysfs: fix some bin_vm_ops errors"), when I had crashed
on powerpc's pci_mmap_legacy_page_range() fallback to shmem_zero_setup().

Well, that was commendably thorough, to give sysfs-bin a set_policy and
get_policy, just to avoid the way it was coded resulting in EINVAL from
mmap when CONFIG_NUMA; but somehow feels a bit over-the-top to me now.

It's easier to say that nobody should expect to manage a shmem object's
shared NUMA mempolicy via some kernfs backdoor to that object: delete
that code (and there's no longer an EINVAL from mmap in the NUMA case).

This then leaves set_policy/get_policy as implemented only by shmem -
though importantly also by SysV SHM, which has to interface with shmem
which implements them, and with SHM_HUGETLB which does not.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/kernfs/file.c | 49 ------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f51..aaa76410e550 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -429,60 +429,11 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
-#ifdef CONFIG_NUMA
-static int kernfs_vma_set_policy(struct vm_area_struct *vma,
-				 struct mempolicy *new)
-{
-	struct file *file = vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	int ret;
-
-	if (!of->vm_ops)
-		return 0;
-
-	if (!kernfs_get_active(of->kn))
-		return -EINVAL;
-
-	ret = 0;
-	if (of->vm_ops->set_policy)
-		ret = of->vm_ops->set_policy(vma, new);
-
-	kernfs_put_active(of->kn);
-	return ret;
-}
-
-static struct mempolicy *kernfs_vma_get_policy(struct vm_area_struct *vma,
-					       unsigned long addr)
-{
-	struct file *file = vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	struct mempolicy *pol;
-
-	if (!of->vm_ops)
-		return vma->vm_policy;
-
-	if (!kernfs_get_active(of->kn))
-		return vma->vm_policy;
-
-	pol = vma->vm_policy;
-	if (of->vm_ops->get_policy)
-		pol = of->vm_ops->get_policy(vma, addr);
-
-	kernfs_put_active(of->kn);
-	return pol;
-}
-
-#endif
-
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
 	.fault		= kernfs_vma_fault,
 	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
-#ifdef CONFIG_NUMA
-	.set_policy	= kernfs_vma_set_policy,
-	.get_policy	= kernfs_vma_get_policy,
-#endif
 };
 
 static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.35.3

