Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17077D5244
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJXNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjJXNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:46:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48277D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7e4745acdso84785947b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155210; x=1698760010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=griUcA7GUXZ/C94ijw+khTWkXdhOo9/SkZ3zjzjerBg=;
        b=Jqnwgpl+iQgBXPyzwBt0Y9Y8w3zvUht2600ZNQUwsUvGgtC5+FTtNIYPEd0CTsQKi1
         k5rzT4QjzP+sGrlMTVBJdcf2MlS7wm0dRhvz7KMmLgKKLED3QqZTQhJaRxOnRIzdhuJ0
         Pz6IqSMaKj66GjRXDUUzPuO0/S3KH7tCKtLAFYVTnSrD7Dj/O0JGspre3I9wUFlICaH/
         D9Llcg1gxL/kpuP5Cf9pEv0t00foYmiEvsdUi456IyngEl+AI6pOmIo5BU4yGsCJVryI
         WhpiVIWQkegWWs2eCR9huOjYJC5Cjrz1nGoo7LW1qCRFneuvE7GwF4ffuk5p0W+n/xTw
         3ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155210; x=1698760010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=griUcA7GUXZ/C94ijw+khTWkXdhOo9/SkZ3zjzjerBg=;
        b=eUeXNz0LyiMoJ4BUEHDGY7vIKXFzPrZesnE8luqi2xXe0zPq5sMY8uMbB887B5gKt0
         0RZ2XM7T5ZgKXHtDkGCw+LpfAhqU0OIj8U3yIw7U//pFObRgx5KBWxqSz3OvuHiSi2e6
         iDTsIDwRa4ft9PTm8F3A8f6zNTjBEE6wfpAin28SncuXOjViDaXTl8mrrQwTMPeT8d7U
         tgnwIn24XFtH9J9pwRiyotXzXRIpnTEcLKE0+O4IljkJVIIwS3wGl+tVdlNlsHEgl4tq
         1RceVXcizRUBM14DAE4gK+Fak7caask7zHpw08qrZLeZX5BTRxWZOpfl/fXMa8UyiPCO
         iA1g==
X-Gm-Message-State: AOJu0Yx8Khd0FOeOqOiTS3DMWLcEeqqiIrcftYjH40sLNaDmuCN/Oe+l
        MgqN5nnLPFRZWw6hSiPtdScJek5AcBU=
X-Google-Smtp-Source: AGHT+IEpwWcHxe3pWwBFpCZZha+IjIrDrruma7abx61pSV1ETO4xUZC89g08mISvSSxLbel6DAK32ekX/R8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:7485:0:b0:d9a:cbf9:1c8d with SMTP id
 p127-20020a257485000000b00d9acbf91c8dmr216225ybc.12.1698155210387; Tue, 24
 Oct 2023 06:46:50 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:01 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-5-surenb@google.com>
Subject: [PATCH v2 04/39] nodemask: Split out include/linux/nodemask_types.h
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

From: Kent Overstreet <kent.overstreet@linux.dev>

sched.h, which defines task_struct, needs nodemask_t - but sched.h is a
frequently used header and ideally shouldn't be pulling in any more code
that it needs to.

This splits out nodemask_types.h which has the definition sched.h needs,
which will avoid a circular header dependency in the alloc tagging patch
series, and as a bonus should speed up kernel build times.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/nodemask.h       | 2 +-
 include/linux/nodemask_types.h | 9 +++++++++
 include/linux/sched.h          | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/nodemask_types.h

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 8d07116caaf1..b61438313a73 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -93,10 +93,10 @@
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/minmax.h>
+#include <linux/nodemask_types.h>
 #include <linux/numa.h>
 #include <linux/random.h>
 
-typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
 
 /**
diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
new file mode 100644
index 000000000000..84c2f47c4237
--- /dev/null
+++ b/include/linux/nodemask_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_NODEMASK_TYPES_H
+#define __LINUX_NODEMASK_TYPES_H
+
+#include <linux/numa.h>
+
+typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+
+#endif /* __LINUX_NODEMASK_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..12a2554a3164 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -20,7 +20,7 @@
 #include <linux/hrtimer.h>
 #include <linux/irqflags.h>
 #include <linux/seccomp.h>
-#include <linux/nodemask.h>
+#include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/resource.h>
-- 
2.42.0.758.gaed0368e0e-goog

