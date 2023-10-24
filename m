Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1816B7D5337
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJXNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjJXNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:50:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964210DB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso61682767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155284; x=1698760084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhDAtTQGKDGtY2/txJr7AfaYGvHf9XTIsotRfIG2XI4=;
        b=uTuQ+BeipJRSS468RV0J4N/errrKktwdtqAbygziGLINd4pYnX/Wwy/y2hB9kX0K9L
         Z1mPWbrzmS4w+Ctdw12m0O1wQajoVEKkDB4XdfbwlWyqODEv5prGsg0+8RX7jxlEoW6D
         zDhluOqX8vDIA0hTaGAy3UC6tSp7I/LMoyf2MIV5evcqrbu5FID7xA5wMlVCt0DoQvTw
         7ruuskGso+/4+CiI8DoPTgiLs+8zytR60Y6thqFcPea6/oliJnso9DwsjjUCMoxUCZzQ
         bznQEhc5P48uoia9Xv2z+lAQGinEXYCjLj3vfiUUkpArYnCUglOSQcsW5lViaV2ni8EI
         OHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155284; x=1698760084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhDAtTQGKDGtY2/txJr7AfaYGvHf9XTIsotRfIG2XI4=;
        b=QNxuAP6QyYgvdCvR2foK8YrSC/QEJUS/I+UHYSt/zdVQXWsDZ80jgQWHknrljopwmS
         Oor6oRJfgDDzdgHrPZ7T1HyTYOuInVm5HcF10rtfYjT+7WF8lS6pV5HQpy5ljlzFL4a+
         lXulzXap6/0R1+rFi5ErVL1/iH2YhcVJrNNiKWPybyb/NGE0mKOtpaCYmElN9szn7u2C
         eMO1WlafTZos/LxeARlKySF31dCGApD1VOGOUzMuIhWaqalSRrORMuSW2axx28r45sHp
         12Yogf1RDA+DVcr51GZspOkLfFYdkTlO72VJ0FLZgYc63dk0ye8aoJMmGaEMIAIyYrbL
         m+TA==
X-Gm-Message-State: AOJu0YyLaKluCQi2VY7RtRn7kzORKjo1o1JFx6LxCZzyaKmV4UsKFWu5
        lZgmgGXi2DNn5WKZFcphk5TALM9WgPc=
X-Google-Smtp-Source: AGHT+IEqWGHLJsK7BvvDJRxELns2H70hhRTn4578toCcoqAqCoHJoeJS8HRj9/dFP0FFd7ukqdr613N1OPo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:8541:0:b0:d89:b072:d06f with SMTP id
 f1-20020a258541000000b00d89b072d06fmr231639ybn.7.1698155283973; Tue, 24 Oct
 2023 06:48:03 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:34 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-38-surenb@google.com>
Subject: [PATCH v2 37/39] codetag: debug: mark codetags for reserved pages as empty
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
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

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.
Maybe we can annotate reserved pages correctly and avoid this?

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 2 ++
 include/linux/mm.h          | 8 ++++++++
 include/linux/pgalloc_tag.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 1f3207097b03..102caf62c2a9 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -95,6 +95,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
@@ -155,6 +156,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..310129414833 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -3077,6 +3078,13 @@ extern void reserve_bootmem_region(phys_addr_t start,
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	union codetag_ref *ref;
+
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 0174aff5e871..ae9b0f359264 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -93,6 +93,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
-- 
2.42.0.758.gaed0368e0e-goog

