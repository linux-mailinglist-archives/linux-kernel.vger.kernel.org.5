Return-Path: <linux-kernel+bounces-94424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E30873F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047A2B214AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A6151763;
	Wed,  6 Mar 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhQNyVsu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32901504FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749557; cv=none; b=kS+UpweaRKG+EJ6iAlcuJfGSe/NoZ7W0ZrbFtoJkasVrugZ1NeJqVcxhWv/Fo4SD7l+JOGvMUzpjfOjWnZP393pj0RtCU9ML+q+y56q3PRoBgrgblNFF9w31jzMzFowlixjn+aB3cSW6t69xwwNMl6pKf48HsyZYSQKSeR1L0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749557; c=relaxed/simple;
	bh=ohrxd0Xt/4LNJR5ZQ5Y/3Iy36LDyfF+B5GacqpQr+Fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3chCMCGum+94AyZv5ZL2JsW0zw9eooj4aqzlHjiOjHHmHAi/IF0xRsXaYObYW2zJmUmEJJFgRfn/lsMYyEs1Ct+odljTT6qElHmQXsPl/F95ZjH/RuZXYlmDi2KJIsCeX9WVylPt9Uqv/fXT4prD38B1NJJhBQqBOJXvtgBCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhQNyVsu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a1063919so706477b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749554; x=1710354354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wmfS4WzHQ3O9sWr06d7OoGjn7qYNg0oNg7s1VmP4AA=;
        b=dhQNyVsuUXJYv+Vc9DiOLzlpVZNRiEgrn8hRZzUVXF7rI82C9Cm8gpI/Y0SwGn7NJ3
         iqxyIkbshbvIH8vxDMmb84K3YSelh3hQ4EewK1LJzfTOvoBVzpHAWke/etGuFKZ89SJb
         VGVNN05ltLpwR11120pm4a6yvbzlRgnZU4etX52/AUM55LEIO8cOozxfi1dabPh55X6n
         hjY/C2MOvzX3cIvAyqyz2c1uCCNL3QAsZzUYR7vP+scZAy5kpFTZK4QUvn5m3DKzPCMG
         6P2IuOx4pvhCU6v7upP5HNbwH6ErSKOuFSV07UprIPgVqoGfc2M7azp6/ZC4j3EG7Fd9
         NvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749554; x=1710354354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wmfS4WzHQ3O9sWr06d7OoGjn7qYNg0oNg7s1VmP4AA=;
        b=DctGsz5oLTMNg1SHwMrTpvA9tFfYHdoaxJXt49IbKY+aidtbx2W+mxz5SXmzDpRd9O
         U+Pp0DYyiLru/p1FclfqgCZUt6Kxx1vLIDPvjwBoczV2VgcnybecR8p8O2SASY+xrIl1
         lg2BYNKsDhvFe/GI5WwuY2gyZxAaYp2RtjMqtGUd0jmPeQATdzC04haaFhypnfn83vA4
         VSb/ViHLk8Tpczbkw8wFzxoMhhQrG2gIQNDm7sfClZVdMfESNc/5vpTMJNrdDm3D0hyU
         3qLI8IJrCPWXLRt068LM8LKF8e0aTS7TqLwCW8VIkwme0IjC13JsJ4jAfq10DD80WVja
         r9Og==
X-Forwarded-Encrypted: i=1; AJvYcCUKqVjqCRkqxL7K6aZ0HZHOjs6jls86TxFD6Vr/d/ckMDWMrYJhKDLx2qyf1t3pqAhFFk23r263X3tZ0vQA4i/kNbHGjxQaJOhf/JpB
X-Gm-Message-State: AOJu0YxiT92+a4SUcUksrwb8ELSThlSv5noTUJxp1tPsIqphrBz1JVIF
	qtQRjBaoUqrvKd3iZIMeB27fFkH+8uxGZ2UCB+MwAhYaSd6UhPLaDX1OGXx6l9eSNsuPXvW5jaJ
	TYQ==
X-Google-Smtp-Source: AGHT+IF6YEyRmq18pPuKKpt59wbNGO1QMY+fEEbCCtJ5tUZChXHjWclQVIOgZ7rujqj4/I2Mqr5y06vHSeM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:150d:b0:dc6:fa35:b42 with SMTP id
 q13-20020a056902150d00b00dc6fa350b42mr4231906ybu.2.1709749553765; Wed, 06 Mar
 2024 10:25:53 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:30 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-33-surenb@google.com>
Subject: [PATCH v5 32/37] lib: add memory allocations report in show_mem()
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

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/alloc_tag.h |  7 +++++++
 include/linux/codetag.h   |  1 +
 lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
 lib/codetag.c             |  5 +++++
 mm/show_mem.c             | 26 ++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index cf69e037f645..aefe3c81a1e3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,13 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+struct codetag_bytes {
+	struct codetag *ct;
+	s64 bytes;
+};
+
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep);
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
 	return container_of(ct, struct alloc_tag, ct);
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index bfd0ba5c4185..c2a579ccd455 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -61,6 +61,7 @@ struct codetag_iterator {
 }
 
 void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
+bool codetag_trylock_module_list(struct codetag_type *cttype);
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 617c2fbb6673..e24830c44783 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -86,6 +86,44 @@ static const struct seq_operations allocinfo_seq_op = {
 	.show	= allocinfo_show,
 };
 
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct codetag_bytes n;
+	unsigned int i, nr = 0;
+
+	if (can_sleep)
+		codetag_lock_module_list(alloc_tag_cttype, true);
+	else if (!codetag_trylock_module_list(alloc_tag_cttype))
+		return 0;
+
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&iter))) {
+		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
+
+		n.ct	= ct;
+		n.bytes = counter.bytes;
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < count) {
+			nr -= nr == count;
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+
+	return nr;
+}
+
 static void __init procfs_init(void)
 {
 	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
diff --git a/lib/codetag.c b/lib/codetag.c
index 408062f722ce..5ace625f2328 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -36,6 +36,11 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
 		up_read(&cttype->mod_lock);
 }
 
+bool codetag_trylock_module_list(struct codetag_type *cttype)
+{
+	return down_read_trylock(&cttype->mod_lock) != 0;
+}
+
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
 {
 	struct codetag_iterator iter = {
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..bdb439551eef 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -423,4 +423,30 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct codetag_bytes tags[10];
+		size_t i, nr;
+
+		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
+		if (nr) {
+			pr_notice("Memory allocations:\n");
+			for (i = 0; i < nr; i++) {
+				struct codetag *ct = tags[i].ct;
+				struct alloc_tag *tag = ct_to_alloc_tag(ct);
+				struct alloc_tag_counters counter = alloc_tag_read(tag);
+
+				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
+				if (ct->modname)
+					pr_notice("%12lli %8llu %s:%u [%s] func:%s\n",
+						  counter.bytes, counter.calls, ct->filename,
+						  ct->lineno, ct->modname, ct->function);
+				else
+					pr_notice("%12lli %8llu %s:%u func:%s\n",
+						  counter.bytes, counter.calls, ct->filename,
+						  ct->lineno, ct->function);
+			}
+		}
+	}
+#endif
 }
-- 
2.44.0.278.ge034bb2e1d-goog


