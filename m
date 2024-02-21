Return-Path: <linux-kernel+bounces-75401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD185E817
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070841F250D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931D1509B4;
	Wed, 21 Feb 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1TQT1uR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9C14E2DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544507; cv=none; b=fPCCuKe0+lOCXQnuQ/wOZ0sKZLbgYxjuYm1BCyEdlXV0F6Y02OdIsPzvGsKOF2NYSKq4y6xaVopZGrd2G3U1UJcHpGB9c4IBOVBPbx1Qcq/6XwFJTw4GFUPMI9a3TencUbqOECJ2+Z2uCmktgsL5o976z2B/Wp6Ld4DyMDi/8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544507; c=relaxed/simple;
	bh=xJM3d3cNTLVIQIxe0J7q2btrWl4VSNh4tAtwnD/MBRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPoOePGt03q8mlOaaAawfmfuP0v40PS/ibFZLYtbEhjLfX75bJbTvhGUJrkzLM5I60vEJYuo7hgTDh3cHDsuYLLECQzkSdCEJFAHL1UtdMU/eyWsQzP+PKSTiwDjXOUw1Ol+8yW+/fzIEC2KCta2/E523EdabGhq0EBI8vltYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1TQT1uR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607c9677a91so17929837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544505; x=1709149305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFqjsc0WslhSBLDjO+3ojiIHoGv8W+Erk8fAgLgypEk=;
        b=O1TQT1uRLoRpA/mZagg9jukZkX1wPpfxXHLxJD3GrNCGxQq71BgFAxn4s6nX40hDtv
         I2SBLtdX21tweRlMKTto+knKrreFwop46rBW9xTcqswIgTt8w45gfwWRwU/G6Sxwu9cK
         xWANYGw5Yvj0rzTDkar9ehThRUyfyiXJ1Cg0bnUE0ZZSzlIrDWyYi7xTAXzkGzn5wkpH
         QWJ7urV9XGYZ9L+E0h78KxD+d+GPbrnJRJ5UN963/h61ojrNeuEGsl9nfmWnainnAD+g
         AmeDQuMTwMhq1vwy60bKJN6MDG8XT6caOkl6d65Zvkvx83trSEQtFSfStEPcCn6t74LN
         puuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544505; x=1709149305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFqjsc0WslhSBLDjO+3ojiIHoGv8W+Erk8fAgLgypEk=;
        b=vMXXcBdOwJKmyznYxyGX3IhRL5esShIKMfzvuR7dgAtM2tvUwmwIbVZ+Fo3383Ghjv
         8VUGp1WgVWfZHVZT3rJ2WDfuEm1trQdnqND+ocV5ndTl3al2icOUyO9gnGR7Jy1J7UZh
         9kfD+eZoGRrmUFnUGsZvqKqS044ROcVUSw4bWEV+aYZvRjEUwYVyyEPxM9A4yNifw8Fc
         c3t/4ZcfpRluoSQ7NrKrHUOD7o7LxG8Biy5J4EEWffMYrbmuEEEwck1hVwNuLPvAOItD
         7T+92SbFhVThEk5S1072HnC+8H2KlfUUGsR7NJngdl8cEKHLWglu6t5hQg+TQpsshGmK
         HhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWwiIOuO0Uap4WzzQu+/8QnoJERDseQ36tccZYulIJqCiHDFZqOWlET3bODQSpuJH2412hBrHgq6MhqR6/mAG4INi4kv0/EqbLBfNzM
X-Gm-Message-State: AOJu0Yw++wSe5u4KO5QM9bpk/rPGu2x20u+OICbKe8AlgqY2DDJfyVsb
	R+s9/Un6bJJ/ykhJVPDQ8ostXa8uY/gs0IQmmSOl2SQae93Mq8ImaMym5oGckg25dH9WwNQJ5rm
	LOw==
X-Google-Smtp-Source: AGHT+IFEtEW0GI6YMD3iPDE2fE3Szl49cxeT7/Q/vgrbPAzl796e5Nz4XS4xSM5+xHy4B42fIJc5lCjZ/j8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a0d:e692:0:b0:608:6894:120 with SMTP id
 p140-20020a0de692000000b0060868940120mr1109228ywe.4.1708544504629; Wed, 21
 Feb 2024 11:41:44 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:35 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-23-surenb@google.com>
Subject: [PATCH v4 22/36] mm/slab: add allocation accounting into slab
 allocation and free paths
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

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/slab.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slub.c |  9 ++++++++
 2 files changed, 75 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 13b6ba2abd74..c4bd0d5348cb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -567,6 +567,46 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, bool new_slab);
 
+static inline bool need_slab_obj_ext(void)
+{
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	if (mem_alloc_profiling_enabled())
+		return true;
+#endif
+	/*
+	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
+	 * inside memcg_slab_post_alloc_hook. No other users for now.
+	 */
+	return false;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	struct slab *slab;
+
+	if (!p)
+		return NULL;
+
+	if (!need_slab_obj_ext())
+		return NULL;
+
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
+	slab = virt_to_slab(p);
+	if (!slab_obj_exts(slab) &&
+	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
+		 "%s, %s: Failed to create slab extension vector!\n",
+		 __func__, s->name))
+		return NULL;
+
+	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+}
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
@@ -589,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		unsigned int off = obj_to_index(s, slab, p[i]);
+
+		alloc_tag_sub(&obj_exts[off].ref, s->size);
+	}
+}
+
+#else
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #ifdef CONFIG_MEMCG_KMEM
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
diff --git a/mm/slub.c b/mm/slub.c
index 5dc7beda6c0d..a69b6b4c8df6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3826,6 +3826,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 			  unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	struct slabobj_ext *obj_exts;
 	bool kasan_init = init;
 	size_t i;
 	gfp_t init_flags = flags & gfp_allowed_mask;
@@ -3868,6 +3869,12 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
+		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
@@ -4346,6 +4353,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, &object, 1);
+	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
 	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
 		do_slab_free(s, slab, object, object, 1, addr);
@@ -4356,6 +4364,7 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		    void *tail, void **p, int cnt, unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
+	alloc_tagging_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
-- 
2.44.0.rc0.258.g7320e95886-goog


