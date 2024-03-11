Return-Path: <linux-kernel+bounces-99258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1D8785AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEFF1F215E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98454AEC5;
	Mon, 11 Mar 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="NdFUqRgw"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D547F6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175608; cv=none; b=fQmB/FI16LpToZ7muUDS6eEt3uVYpEh6XNhedV3YaP48NkGBXdENXYgy149NQrD0n9Fk7DUx1Wmpur3R4sQWE3Io+aIppEot9kQDgD6KEHu3I357qiFHliQ61gvfSdBceTf/mVOJwX1ib3XSUy7bK0zCNwGppT1etlRtyfUNmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175608; c=relaxed/simple;
	bh=rNSw66o+XpxAmDCLp/4Y0L0j3NJA6sLvc+VkxIH0y8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egiqYDUeVTxKgLghmoEQRABkGhepRAbEZsJJcw0hhJVQHjWbdb7mQMkWpwGnve7UJd9OOPMT+u1++Ik569X1cg2cWUF8CGRDHqF6r4+Me+scsTD+zKBxBTTQuMulUVkzVFafOT4zGhHdtIMBiRKkPtRbdlcP0rLxmOekxea6z60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=NdFUqRgw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22181888b88so3895624fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175605; x=1710780405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRKHBCRgEDsAkh8Uu5g0LvaNrGLtTcS4Fv1I3hMOqvE=;
        b=NdFUqRgwZzPkrAPEBG6Vly8/GajM6oy9t9Cc7v6qZZiUENLwc8xDKDA40eIsvDxLke
         KHWZ51VzZZWxK24XkQCe5NhpFSD+7fTad2xoa/+kGX6FyYn+HE1tuSL19AuX0tZ+DB1x
         wyjb9eaia04Eed/6QvxNFJvZ6K4JueagJ2LXxj0PQ/gspKhR9W+Cs6WvU8bnZXyoCu93
         Dwq5RtFypq0rg02fJ60zJACeYkDT2Xi9XjQ/xkE91vQ/dzxCmC+gIR+1ZTY3/8fWbijw
         OtEASAdUhLVKvMGzcYX6uBadWCGgmHmADgiRQOMQvVFfDiT0Z4LEnfKE7EkKvWE8xvoQ
         YqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175605; x=1710780405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRKHBCRgEDsAkh8Uu5g0LvaNrGLtTcS4Fv1I3hMOqvE=;
        b=pC9yqcGs/Rz6XEzSg8iARr1P9IrFZnZP2WzsPaBXZo2vp9FreyZuk7QhzaNj/aS243
         cJ+GR67uAvZFe4x9s2T9qqRL378fw4qz4Nq8qITLx0TQd+ImWU3FSHOz9mwWG6aKWXi9
         +q6hy5D2nSZoAu5/Ep6Jq1brqbXg6reO4Q6cDevPN9Pm5AqNyCUDn/hGbWklzNVBsh9f
         OvfMheXhVR/Ac4HTh904YAoULRMR31BdBavrvY2tfAITDcLMTli1eczMbGylyKhr4co5
         XXj+xz5C329OLthP+gOjs+RRREChJ6J+waOUiywn3UOnOZFss4RH48BjVaAqF0jmWRS1
         iGrg==
X-Gm-Message-State: AOJu0Yzc9D20zGJrM/9rM6+lBSClgOxB//2frFdRsu9SnbMBp4catV9u
	xVdXtRp3u/7mHbUgU6ihs4GWQOeFAwVPrEUWSIalCqHuKqkhNg+XQ5Ge9ScLzvo9AhDfR4prn86
	luRA=
X-Google-Smtp-Source: AGHT+IGB8z9Eh2EiOSMQqnmRI9zZB59VQQwcHf8aThINC/aQYO0+ESVp0WJ0ORdeFBqZ+2a6LmE9PQ==
X-Received: by 2002:a05:6870:4721:b0:21f:4fe:9ee8 with SMTP id b33-20020a056870472100b0021f04fe9ee8mr7898763oaq.4.1710175605333;
        Mon, 11 Mar 2024 09:46:45 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:45 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 02/14] fork: Clean-up ifdef logic around stack allocation
Date: Mon, 11 Mar 2024 16:46:26 +0000
Message-ID: <20240311164638.2015063-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is unneeded OR in the ifdef functions that are used to allocate
and free kernel stacks based on direct map or vmap. Adding dynamic stack
support would complicate this logic even further.

Therefore, clean up by Changing the order so OR is no longer needed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43f..32600bf2422a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -179,13 +179,7 @@ static inline void free_task_struct(struct task_struct *tsk)
 	kmem_cache_free(task_struct_cachep, tsk);
 }
 
-/*
- * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
- * kmemcache based allocator.
- */
-# if THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)
-
-#  ifdef CONFIG_VMAP_STACK
+#ifdef CONFIG_VMAP_STACK
 /*
  * vmalloc() is a bit slow, and calling vfree() enough times will force a TLB
  * flush.  Try to minimize the number of calls by caching stacks.
@@ -337,7 +331,13 @@ static void free_thread_stack(struct task_struct *tsk)
 	tsk->stack_vm_area = NULL;
 }
 
-#  else /* !CONFIG_VMAP_STACK */
+#else /* !CONFIG_VMAP_STACK */
+
+/*
+ * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
+ * kmemcache based allocator.
+ */
+#if THREAD_SIZE >= PAGE_SIZE
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
@@ -369,8 +369,7 @@ static void free_thread_stack(struct task_struct *tsk)
 	tsk->stack = NULL;
 }
 
-#  endif /* CONFIG_VMAP_STACK */
-# else /* !(THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)) */
+#else /* !(THREAD_SIZE >= PAGE_SIZE) */
 
 static struct kmem_cache *thread_stack_cache;
 
@@ -409,7 +408,8 @@ void thread_stack_cache_init(void)
 	BUG_ON(thread_stack_cache == NULL);
 }
 
-# endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#endif /* THREAD_SIZE >= PAGE_SIZE */
+#endif /* CONFIG_VMAP_STACK */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
-- 
2.44.0.278.ge034bb2e1d-goog


