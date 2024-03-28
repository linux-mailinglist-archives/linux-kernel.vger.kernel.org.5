Return-Path: <linux-kernel+bounces-94414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC37873F37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BF5B20D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF7914CAAC;
	Wed,  6 Mar 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlQvMxy9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5B14BF2E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749536; cv=none; b=rwSCokwmpunbCq2ZcFDHimAetkh+1V8bcd83Xk3PlHVfDlH2cNfeHDtm19FGoHdhpbOg+fjyvj+JFP3Kvzy4hZrL5YCamQVqGXQYjrj7IpdqQjLnPtgGqMF3bZHfH8KWLq4seWWPmmtD7bZisf0g4EsKSK/5eX7C7M+hDcCbaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749536; c=relaxed/simple;
	bh=5X/AexHQW90KeQjyGkMbYKB5WQHanB7BlzRsAd7/9vI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHAkdJUXsPl4dUic1x1c0GwoUNGfSWgu1b2MLvjYUlc74jErr6MeM7YEm8wQhOg0Tb9gx8BeKTJFegW/Qm4q5lhbxA6IRtZ/hvqQRMnjT7IVZtUOLg6OBGcgR9GhiCTNfpysxGApHiAGUvCbZn729v+wkkVaTcp2EOe3kKBwR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlQvMxy9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60971264c48so593047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749532; x=1710354332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6IJ0Q4L7KBxRODnLb4yefimTum4BvWKaOTt5/YB2o=;
        b=GlQvMxy9n468uijGtR8dhEvRg6rsCcInobtJm6bJxkSiHI/8WCtMbk49uxAij2WHxR
         oupI4bcvwcInZkySe4lWTAbxZ68CiYfqHu1qCaQyk1sBIQmCSjw/7NI89BLMmlBB0o0A
         q5zaWOXdLzsmfdcUj0MLTeyIUMhpki2CRrf3RFzIUqvCE6GJPl5hDX8603Uj72fzZXyb
         UtDOJJaqv/BCSIIG6GbFgGKXdSfwNhPJsu8LhAb2fwZA+W9/wZ4RzgHn9jw9VF4D1pgG
         +bsI0hg29w9br86sRLuo0IoPysiooHa5aFkNI8gMDiyJ3l3O+XAWAofULnnlPu6tKBZX
         Q3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749532; x=1710354332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6IJ0Q4L7KBxRODnLb4yefimTum4BvWKaOTt5/YB2o=;
        b=KP9vfHps0bSVxvLJXWsrpT/eZRjCgCx5wO662Ie3wM1xMeDu8p8vqAYu11q52xncZ/
         4hISeScPAnxqyHy2GFwh/V0ebACnhq0UqdcQXwc3ka+2JWGevvOnUPAwwlrkrpyp89tc
         mqn9Fb4bD5gCpSIC7LIKkc9rrO7koBOc0CT0yXD3SbOWj80s2e8WTjahDyfUccIPhzjf
         ht1URPGzzdUa7v2eqAB9mVf8p2VBsznqRFKclRv7F9473ORjfaxAEraUCST2Nd6YrRcl
         iYzUxJkrre5i69mSQwHLRM0AR/8BguNBO9QwUkyrofN6dkq6iTmy0zShpoArj83nPYBc
         oBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvjPwk6TEjrtKGsk7wHEZ8jS8XVNbTKc58rDABdmrUJ/cbmuJtcEDrYcnJwns8d+p70qygnJFeOXlFvZ3HjFzNiI6YPR2W+3BZ+JtL
X-Gm-Message-State: AOJu0Yxo13gFyqH5uHREkVRhrTB9aMd+tBpcjH+6+GTsn0UqbqRnINRG
	hAOMxbfdFEZtlxEa+7DItoRNplRNKM1tjtzFqZGAY7pFTXamzg5I1Qb3teRxPg/Aqb8t2+UFvjo
	Gng==
X-Google-Smtp-Source: AGHT+IF+RFcX0NYxjT6uNvnW+K0lH94IF3O72VJ6PT7ea1CL+TwW9QtFKtQNO2MOoPPDxhg0sWNTYKHdXg0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a81:9945:0:b0:609:781f:a7ab with SMTP id
 q66-20020a819945000000b00609781fa7abmr3355582ywg.1.1709749532080; Wed, 06 Mar
 2024 10:25:32 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:20 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-23-surenb@google.com>
Subject: [PATCH v5 22/37] lib: add codetag reference into slabobj_ext
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7709fc3f8f5f..33cdb995751e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1652,7 +1652,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
+#endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref ref;
+#endif
 } __aligned(8);
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3e06320474d4..dfb5a03aa47b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
-- 
2.44.0.278.ge034bb2e1d-goog


