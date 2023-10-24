Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D447D5234
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjJXNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbjJXNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:46:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992F10CB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso59606987b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155208; x=1698760008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWOhaEKA8zMI+Iz0e6SkNPW5Kz551oWdhyAlPdtU984=;
        b=1XFbROdLiVVoN5uydLx7JI2SMR4wMa5dO4rGWCS3ucWQUgp7xD3Uzyga3UuvTJbPjm
         Fb+47YRq/bMpaN3E/eB5AwNie/G70xGjaCjNyWrqPmTvDb2rkdtqc3uQf9aQ1gnWUCjE
         QKxrw0Y/wn10DXzumW7IxBG4cDEADZzN9KbaQ2FIv5UWBdI2dOrlwWecw0OGsFRf5QxF
         jeq5BqGdkGUNO4rLanTanR8I/vNGHzjj8gUjKziIlqqh5dw4TEW7wdaqzxfbAp8TzWnI
         UHPJiV1xnBqRqC5VWZUmCosAbA2hlohjCCpOUUSjvso+AnyYb/QCZBMR7VbscOR7liFR
         qgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155208; x=1698760008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWOhaEKA8zMI+Iz0e6SkNPW5Kz551oWdhyAlPdtU984=;
        b=shk3zGr0Ci0725Afg99ZZL93aXvmmPX3+OKSgpBYJyIKSnI+y1I0zmA4HXB0B9BPDL
         Eauy+9IJKvb9HMSUUZC26xzvdPl1cW2CCXPPOhJkxSDQCZYIXiacRE+H4/Kp+gKxEtOu
         /M0iur3TbZ3/7aKbkVAWW3qVtUi1f91fry3+95d5elNYsJ2gRROEFIa8onccE5Y/Q5YE
         exQSM9heCHq+1/I29DlUahnshKl5K/LrR7ECTjzSC9Lsnfs35+vxaQJ1eZrXhuQ8/FZh
         59BQmG7H0HX+Gs0ti7YT0LwGK5by7cg1DtAykVbxmEHHHuqrZsWonBzfKbR3Ws2ZDoh6
         /Muw==
X-Gm-Message-State: AOJu0YyJ7w7eDxbsVZf0rhRkQiMeUwsSo+MPIh/HfWo8U90xGkk9eavd
        gF3eLdnMwpYyFzdtdVxHSMgwKW9veK4=
X-Google-Smtp-Source: AGHT+IGS8NlUfJRUa0CiIFG8N+DG1BCVzQogfv9Ui1pQm5p1SwS7Eeeej+mjL+3fA2TwJ+bOdBMbqGXulW0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:b951:0:b0:da0:1ba4:6fa2 with SMTP id
 s17-20020a25b951000000b00da01ba46fa2mr82321ybm.4.1698155208197; Tue, 24 Oct
 2023 06:46:48 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:00 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-4-surenb@google.com>
Subject: [PATCH v2 03/39] fs: Convert alloc_inode_sb() to a macro
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, surenb@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a40823c3c67..c545b1839e96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2862,11 +2862,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.42.0.758.gaed0368e0e-goog

