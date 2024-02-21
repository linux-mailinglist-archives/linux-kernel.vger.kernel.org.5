Return-Path: <linux-kernel+bounces-75406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195A85E831
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1897E283573
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C64154C0D;
	Wed, 21 Feb 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENcUDboM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3A154437
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544516; cv=none; b=eWFpmOqubYZ16Sd4xQlOqpffsnTsb+UYl/PiL32PJVSxNt+WmKYYj0vXCkngSESQ9/CP3KytkQ2NlBXoyf9BzDbYzeq7TEr7T69WtcWYyRk69V8VexP3/abO24jy9iECWI9iA3ZX7x2E94ZovXZQgNvgWNNEk7nZlCMwwCe6dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544516; c=relaxed/simple;
	bh=eg3VqgfVH0GvUM6k5ElHd0qijCgy50oNlNam1i3xGUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s7S4xVukE0R0V3bXSiWwtwR/pRRdTwvszV+QvJyqnzWBiocNBFWaqfHfI1mVFqO2+PYqffJd62NraYm61AEUtAHVNYs4I8DzxKSjzJ08+rFdGNYfKIzEEpT8okbdeQjyq76upSRx+qxTyjXVfQyiAm1M87JRQCRfxhaIHILKF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENcUDboM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efe82b835fso156756997b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544514; x=1709149314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBIp7l6FYh66kLRcBRL71yRbl3V2EKRiwuHeAcwsTzw=;
        b=ENcUDboMlsWjTwhLiYbQ8ZXVl9W3MtaCw2BfO4PUGcxUjcFLDf5Cm/SPtEoC6a7SyE
         RfUCDyHPb4Ng7zwDo4r75/8L5c93CTCtCkAfMrF1aL2eiHtyPXm50f7RecyxBg0wTr8s
         jc2pSr57nb8DlT3ECQsMOC9fGeX8T7UqClEMWxghCLHicqA0W6g3k1oo0CGfug+kRbmI
         AoKOIJUVt/+C3ZfxO3PSxss9fzeuoq33PgmzyON/JMXbWpMwI4GExXCAx8vF8fN2mxuS
         tm5rC9vbPcFUANSJg6m2LtGzqoQdTvJ50OB7IW1YG6SMI1LFqAvveNVywlonrzI4pvjI
         2cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544514; x=1709149314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBIp7l6FYh66kLRcBRL71yRbl3V2EKRiwuHeAcwsTzw=;
        b=X6n3j2grfPq1JubOEXNGbfW4ExzjvPXdubXdrENlISwaLJRGa+17gVnm2Jhj7lqeo7
         gzjG5RTQVlEvf9U8/tZ+2u1ZQ20Ua9Ydj7tCgzWNq21Chn8bLVNHwNI2F1VT2YtTGxY8
         u/8TErIK8fqGFdyDoGfvMqxDCf161fCuaCv8FSjK1ovKe9GC9vuhSpRcagLymdl4bRTb
         WcElA4AzfkA9uja42MJqO/J8cDcfXw/BpIchbYHGy3YUINBkLMi4tcdnhc58iwH75J9z
         cGJSYwszIKo4A1NCFuhWgH8ZMGVDzMqwQNfODJiK4km7T/HG0YcyNYY/LolUi1a4rGlh
         pZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBKHAGKSXTQxV5ZXlB84s9vHwY50Wz8E34ZtBgjRbvZWLHrc+1adEz+gyULNu8QewIzizGZVKRgZJ0s/4KmEGxnzVrjAgQwkIYlhdZ
X-Gm-Message-State: AOJu0Yws5xLpiNOLhmWNXlDWul4rX7jrHycYF1fqcbIVSbkeqFxSE+lv
	P2ybedzygiwyXLeHyrhT4Vc7ANqJGiANt2Ga/eurjCmMDowzFuRvNFiowyvX4EuENSnR6vDNc8d
	hvg==
X-Google-Smtp-Source: AGHT+IHLKaXp7N9l8d01o/qA3LkmgVnAKUksSqDfIHvWiz4IkTdB0wq71PyEfTle+YY/8d+F4iJoyhChRR4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:690c:3388:b0:608:40e4:d05e with SMTP id
 fl8-20020a05690c338800b0060840e4d05emr2214356ywb.7.1708544513792; Wed, 21 Feb
 2024 11:41:53 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:39 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-27-surenb@google.com>
Subject: [PATCH v4 26/36] mm: percpu: Introduce pcpuobj_ext
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

From: Kent Overstreet <kent.overstreet@linux.dev>

Upcoming alloc tagging patches require a place to stash per-allocation
metadata.

We already do this when memcg is enabled, so this patch generalizes the
obj_cgroup * vector in struct pcpu_chunk by creating a pcpu_obj_ext
type, which we will be adding to in an upcoming patch - similarly to the
previous slabobj_ext patch.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
---
 mm/percpu-internal.h | 19 +++++++++++++++++--
 mm/percpu.c          | 30 +++++++++++++++---------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index cdd0aa597a81..e62d582f4bf3 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -32,6 +32,16 @@ struct pcpu_block_md {
 	int			nr_bits;	/* total bits responsible for */
 };
 
+struct pcpuobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup	*cgroup;
+#endif
+};
+
+#ifdef CONFIG_MEMCG_KMEM
+#define NEED_PCPUOBJ_EXT
+#endif
+
 struct pcpu_chunk {
 #ifdef CONFIG_PERCPU_STATS
 	int			nr_alloc;	/* # of allocations */
@@ -64,8 +74,8 @@ struct pcpu_chunk {
 	int			end_offset;	/* additional area required to
 						   have the region end page
 						   aligned */
-#ifdef CONFIG_MEMCG_KMEM
-	struct obj_cgroup	**obj_cgroups;	/* vector of object cgroups */
+#ifdef NEED_PCPUOBJ_EXT
+	struct pcpuobj_ext	*obj_exts;	/* vector of object cgroups */
 #endif
 
 	int			nr_pages;	/* # of pages served by this chunk */
@@ -74,6 +84,11 @@ struct pcpu_chunk {
 	unsigned long		populated[];	/* populated bitmap */
 };
 
+static inline bool need_pcpuobj_ext(void)
+{
+	return !mem_cgroup_kmem_disabled();
+}
+
 extern spinlock_t pcpu_lock;
 
 extern struct list_head *pcpu_chunk_lists;
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..2e5edaad9cc3 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1392,9 +1392,9 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
 		      alloc_size);
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef NEED_PCPUOBJ_EXT
 	/* first chunk is free to use */
-	chunk->obj_cgroups = NULL;
+	chunk->obj_exts = NULL;
 #endif
 	pcpu_init_md_blocks(chunk);
 
@@ -1463,12 +1463,12 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 	if (!chunk->md_blocks)
 		goto md_blocks_fail;
 
-#ifdef CONFIG_MEMCG_KMEM
-	if (!mem_cgroup_kmem_disabled()) {
-		chunk->obj_cgroups =
+#ifdef NEED_PCPUOBJ_EXT
+	if (need_pcpuobj_ext()) {
+		chunk->obj_exts =
 			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
-					sizeof(struct obj_cgroup *), gfp);
-		if (!chunk->obj_cgroups)
+					sizeof(struct pcpuobj_ext), gfp);
+		if (!chunk->obj_exts)
 			goto objcg_fail;
 	}
 #endif
@@ -1480,7 +1480,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 
 	return chunk;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef NEED_PCPUOBJ_EXT
 objcg_fail:
 	pcpu_mem_free(chunk->md_blocks);
 #endif
@@ -1498,8 +1498,8 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
-#ifdef CONFIG_MEMCG_KMEM
-	pcpu_mem_free(chunk->obj_cgroups);
+#ifdef NEED_PCPUOBJ_EXT
+	pcpu_mem_free(chunk->obj_exts);
 #endif
 	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
@@ -1646,9 +1646,9 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 	if (!objcg)
 		return;
 
-	if (likely(chunk && chunk->obj_cgroups)) {
+	if (likely(chunk && chunk->obj_exts)) {
 		obj_cgroup_get(objcg);
-		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
+		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
@@ -1663,13 +1663,13 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
 	struct obj_cgroup *objcg;
 
-	if (unlikely(!chunk->obj_cgroups))
+	if (unlikely(!chunk->obj_exts))
 		return;
 
-	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
+	objcg = chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup;
 	if (!objcg)
 		return;
-	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
+	chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = NULL;
 
 	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 
-- 
2.44.0.rc0.258.g7320e95886-goog


