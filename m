Return-Path: <linux-kernel+bounces-99265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BC8785B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0D328123D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109885644B;
	Mon, 11 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="2P8Bdxfd"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948305472A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175614; cv=none; b=LhORN8AiGhVs5srBwctx+VN01LvmDFYwbbVOEweTzV0CCCD5DAUU+QmuZ4DMLyiXiszAChuKympQOn0Ql5AQhNgbavvlk6gDbFRhNXxL6lbwajp38J38VtU2rkpn/yoZOx05fGC3zCME/MN8hYAeAOJke9AUFPTWrCotUjJsvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175614; c=relaxed/simple;
	bh=/nr7aaEAvjVHOUDe35kqc9+BWm5yZt4eYB5LCI8io0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdjypVI2aEqRA+VWkvpYkJbmF9D+HmRA6MNwO8yXxlmJe5Q+YArVH0i4W4K1DgzwJwMv5ZRwiYLVhjJc+56+k7rAMhJJcg96dRv0tjc5gDaRq+8UySmI7B5rZVaDMMV7pWLEs86zn/GGlMvrMaYfSnHitd95QeNo+tEBmCC+u2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=2P8Bdxfd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78852e1e923so96445285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175611; x=1710780411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkZD7ALZVm0P5UALUItr672MRcA6vth2fJOAHe6U29Q=;
        b=2P8BdxfdiCm33uclKiECOzNcNUfb4Y8S/DMlHKAotrq30fVsjwhZghrWJjwm+s+RwP
         QQ0iJfAUbbjHzoq9oiyRbUFVbDjW3n3kA8xOiXewnDseUfyGBgKaDY9Vmg5Xq6fa67lJ
         M9Cm+5AcOYIgT/4KKdi6LccefhVIvAAcIxy/66ZdMJO5IUmCDXn/yl93sIRuo7a8B8wW
         zLMizkgG7tlWnVjLa4CYGt6lOlUtzkAzem5OC98X/TnbOh7uXNjkW4Fqh8bVipUY6m00
         Qs/XrfumncsdaZovg3xIaGIo4KOo7/cMZE4UhpvSH/I3O+em5ZAMTbz6I/2Sc6wLWIJd
         TuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175611; x=1710780411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkZD7ALZVm0P5UALUItr672MRcA6vth2fJOAHe6U29Q=;
        b=nOrNF3JYOwtwIlSEGCr9ExBBLgExOjEJurWLJYAh/egYbfpAjMLEBs2/G3VVl6vUE+
         Vq1K68+WrCl830tqsG+TPFzFCrQw50AIk6pqSVPS0GbufUtPstf5SwAbB4EYdkwdyxUG
         NKMMsKHujcSOirlEjFjDMC0K004yA7QTaqV0fwONQS6ByprJN6dEu8LoxXZ8tOpL4/S6
         upCbsjfQ42QVA0OyQr46fL4Qyh2hbdXPYjEgjmVchpuyVe/0Ei/Tjs8Y+ZfwMBGe/td9
         2lWZkEGFxujgbea1PYPATx6YyZjtdogNbMuzs4AHAT/oGl+HffqxNoFpYMCyBrou+Gk3
         2LZQ==
X-Gm-Message-State: AOJu0YwK3TFzbsrkPXDndpxE52ZapaJfikRriT2/A+vPA7FBPVfWQKDq
	cDDQzh8kQRt3fa3rANgLx2t8p578wVwE0EKiq+7BdI/AhOsO1eg6XCBkbcyilunpOprpDTT9Qyq
	SvLA=
X-Google-Smtp-Source: AGHT+IHTkS+2s/WrBF0S6nD4DTbIdKAkKUkplrTiXcc/c/8vBDolvcc8zD3FtIujCYDfupcwREXrKQ==
X-Received: by 2002:a05:620a:15bc:b0:788:50aa:35f7 with SMTP id f28-20020a05620a15bc00b0078850aa35f7mr7780372qkk.30.1710175610969;
        Mon, 11 Mar 2024 09:46:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:50 -0700 (PDT)
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
Subject: [RFC 08/14] fork: separate vmap stack alloction and free calls
Date: Mon, 11 Mar 2024 16:46:32 +0000
Message-ID: <20240311164638.2015063-9-pasha.tatashin@soleen.com>
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

In preparation for the dynamic stacks, separate out the
__vmalloc_node_range and vfree calls from the vmap based stack
allocations. The dynamic stacks will use their own variants of these
functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 53 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3004e6ce6c65..bbae5f705773 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -204,6 +204,29 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+static inline struct vm_struct *alloc_vmap_stack(int node)
+{
+	void *stack;
+
+	/*
+	 * Allocated stacks are cached and later reused by new threads,
+	 * so memcg accounting is performed manually on assigning/releasing
+	 * stacks to tasks. Drop __GFP_ACCOUNT.
+	 */
+	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
+				     VMALLOC_START, VMALLOC_END,
+				     THREADINFO_GFP & ~__GFP_ACCOUNT,
+				     PAGE_KERNEL,
+				     0, node, __builtin_return_address(0));
+
+	return (stack) ? find_vm_area(stack) : NULL;
+}
+
+static inline void free_vmap_stack(struct vm_struct *vm_area)
+{
+	vfree(vm_area->addr);
+}
+
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
 	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
@@ -212,7 +235,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
 		return;
 
-	vfree(vm_area->addr);
+	free_vmap_stack(vm_area);
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
@@ -235,7 +258,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 		if (!vm_area)
 			continue;
 
-		vfree(vm_area->addr);
+		free_vmap_stack(vm_area);
 		cached_vm_stacks[i] = NULL;
 	}
 
@@ -265,7 +288,6 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct vm_struct *vm_area;
 	int i, j, nr_pages;
-	void *stack;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
 		vm_area = this_cpu_xchg(cached_stacks[i], NULL);
@@ -273,14 +295,13 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 			continue;
 
 		if (memcg_charge_kernel_stack(vm_area)) {
-			vfree(vm_area->addr);
+			free_vmap_stack(vm_area);
 			return -ENOMEM;
 		}
 
 		/* Reset stack metadata. */
 		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
-
-		stack = kasan_reset_tag(vm_area->addr);
+		tsk->stack = kasan_reset_tag(vm_area->addr);
 
 		/* Clear stale pointers from reused stack. */
 		nr_pages = vm_area->nr_pages;
@@ -288,26 +309,15 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 			clear_page(page_address(vm_area->pages[j]));
 
 		tsk->stack_vm_area = vm_area;
-		tsk->stack = stack;
 		return 0;
 	}
 
-	/*
-	 * Allocated stacks are cached and later reused by new threads,
-	 * so memcg accounting is performed manually on assigning/releasing
-	 * stacks to tasks. Drop __GFP_ACCOUNT.
-	 */
-	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
-				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP & ~__GFP_ACCOUNT,
-				     PAGE_KERNEL,
-				     0, node, __builtin_return_address(0));
-	if (!stack)
+	vm_area = alloc_vmap_stack(node);
+	if (!vm_area)
 		return -ENOMEM;
 
-	vm_area = find_vm_area(stack);
 	if (memcg_charge_kernel_stack(vm_area)) {
-		vfree(stack);
+		free_vmap_stack(vm_area);
 		return -ENOMEM;
 	}
 	/*
@@ -316,8 +326,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so cache the vm_struct.
 	 */
 	tsk->stack_vm_area = vm_area;
-	stack = kasan_reset_tag(stack);
-	tsk->stack = stack;
+	tsk->stack = kasan_reset_tag(vm_area->addr);
 	return 0;
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


