Return-Path: <linux-kernel+bounces-62413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A1852012
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D4B1F23B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A80524D0;
	Mon, 12 Feb 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfAX/e2z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952951C40
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773990; cv=none; b=XOcOki0RR6IKtZhXq6HvLYNIBJrY9KKV++UZ8/eD007KUZhEAyTVLUu7lqLddtrC2OCURJHPOsC0I6WO+br9yZjq6J1o9kYbXQBTZUdVO9Yh/vZapWs4FECHeKmANd8melVQHnPL7GDuxInYp9jODTnoH3Z2BTjf2vk47Pw8H2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773990; c=relaxed/simple;
	bh=YHyqeuHvUrbxaU4ktRueMrpYAdLsayJ8KqWKnRsL9Bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UrRpcj/Y/WB6LuKj6qdk1lLo/RabpMEbEOKwJc4RKEdllHb/+g1iu2xYyRkH64kjuVdq5Dd3VtZySgV/dl8vfN52knGOnb8CaGvG8pctWzAZkxqpoXDNtoDRCKJHC6lHe/keZtl0mlG/qBqVgIDOZttI1q1SXMBcgHQohbqRKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfAX/e2z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a351d3acso65840677b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773988; x=1708378788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=rfAX/e2zkk9fIvt2hoH4yXWF6tTbvbza1R8p4oM8EOcsV3jn4jN4UCdShzqkT5uw+3
         PCjXcf9A8+A8UEb0ve9Wprj0OsKYmMaUA0R8RRLIdaspuJ8Or0G3AoOLUJ/KqtNR1H/v
         oNh0jvzvUia0jxJ/kyINC3uowMwB3AJL7VHmK/5iFmzom9Tr0rLFuZ/gZn70srYiocfl
         Lq7tfzsx4Epu2BCUIq4eEaAZ8YXdwUUaAbE7lfdcGcUEskVYy4/zD+7gWzJYi9nEJoCQ
         3+2aM+zgZgMEpbPsfPcwyMR0NH2iaENAcatbFpUzZSR2xRShrUJ0ZOrBDZ+oVFq+NlZT
         Qg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773988; x=1708378788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=oKJlalVzZg8C0NkOKgmI8a/NT7rJDd9CsJ52snV58G3VysFuGZXgMIrxDV5tYXxmon
         EJiUDgH5WhlOG/zT53OR1m95nmMO3Pk2eLQhF2rLa+0y02tTg/2n4eyz1EEDat3HHvHf
         fz//M/VXWSGpvs0YkbG1WeUXoozRqFubjxgXIXaqaNXM6l1IiBFFxtZrw0CZ/KysS+5i
         3v/r3f5y4nVzrAICFYBCWljWjQeMntyFY20HF/K3YGD4HLFacDZ1S42fNhWC9XNNFlQw
         gvgwTuG6bdNdjH7mWuJQiqJy/rzl6HR2Etj8h9QkM6HloQcoIsbNObwL4xYMoszMFzD0
         qWOw==
X-Forwarded-Encrypted: i=1; AJvYcCUyJArrkXqK6a2f+oCMU75kwdLoQfGuJZLtNAuBS9Io76oguvTWPo4l0iG+LKP4BQZ1CExVLyQVi/AhH6sBQCpSgEqrar43Giyd0HqW
X-Gm-Message-State: AOJu0YxoQDpkDdDiq6Nhk7TdfuXHAcjNK0K4L6dZM2FTM7ZmyItBzmLZ
	MtH1s1SEbRgNITiqazvKtbYaLxZPGXBj8JmR4aSoO9uAUX/jDhTdKeamj+nuHAPJwhnwhzFWigi
	ehQ==
X-Google-Smtp-Source: AGHT+IFIMBcV3x/W8fhRczbwea2w1q1gcT3ETfM1GWq+zDEkeIxrI9ytOpFdbEX8EDgRr+EtsMkcZCh6eRk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:53c3:0:b0:dcb:c4d3:6e07 with SMTP id
 h186-20020a2553c3000000b00dcbc4d36e07mr382686ybb.5.1707773987608; Mon, 12 Feb
 2024 13:39:47 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:53 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-8-surenb@google.com>
Subject: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/slab.h | 7 +++++++
 mm/slub.c            | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..3ac2fc830f0f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -164,6 +164,13 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/* Slab created using create_boot_cache */
+#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_NO_OBJ_EXT         0
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slub.c b/mm/slub.c
index 1eb1050814aa..9fd96238ed39 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5650,7 +5650,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5660,7 +5661,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.43.0.687.g38aa6559b0-goog


