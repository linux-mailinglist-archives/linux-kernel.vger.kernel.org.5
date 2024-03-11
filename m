Return-Path: <linux-kernel+bounces-99260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029A8785AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CFF2839F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C004E1CB;
	Mon, 11 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="mQTT3A9v"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77229482C8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175609; cv=none; b=jxSn2S4elh1VQO+uCOB8vgPGvj4lP8R/j7qF0fcNwZGneOjSGOjvWyFMC6XlzM1IdG+ynqRBdJSMrtnajBdrkQTk/1RFH2Cb1nzodapsHFrbMMJzTSTmi6G9q8yi0cSPSl/5hzhOKUIcAUTW01Q0GU2pwS3F91gwVhWH5EyHKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175609; c=relaxed/simple;
	bh=tEvVrQdda52ZeoTZCZGpLyifsvZ4B54Au/IQTs3CyBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns6TQ6VKLgGQMZXreh3KxYS6XESyfsN7IQ2Jkz6cEZGNqdmKkwsCoo3bPNIsNA3cce4cWjuXeyGWjPp9kI7+FIgomeTIF9bCAtzEvcb0C+d8DPrT+EC2AZpIgx9PvKEEsADmVF8UmTo6xQ9XtCpk1dv2dRLNybeSPIHeZNIa9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=mQTT3A9v; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7882e94d408so382722985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175606; x=1710780406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoufURnUHz+cr/acEvSc8ejQyNfvHWk1Ds3/A5XAtBc=;
        b=mQTT3A9vqwHQNYTdHWJygzw8tcaJfBI7IIbzYESS5ds1wk3CkSvRc3G8gYZ9Yx4xd1
         WuLOFK3uodx7DUGJHqwoWZUn1yu5VNDonE6bIJWoqLcmoLHzFXYZp/86Z7kgxPetBGcV
         XieCbZKVad8qPUsUym6gVTPlcaebw15P/vhb63W66HG6KTxZPcKiCGsSAZ6hDQSByy/D
         Dlb/GG1dLT3OZZEM6p5ox/BMfIPyRU51Nd/FEa0uDZIEEv9Af1xPQzjuPtmlwhfbJRqV
         iOF9/0/J/8AmFNXlXSnmVl58R1RUOwRpta/wAkxbP/VbLlVlFn2KBmNuu1VWFNauAWD3
         gfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175606; x=1710780406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoufURnUHz+cr/acEvSc8ejQyNfvHWk1Ds3/A5XAtBc=;
        b=TisOJKYWBzP47zQWt6T5wEXj2uTE3sO+yudfuv4yR88anHIySym1jqr8aNu4EuU74H
         LouTTF3dMta3/oN0Tt2eFovZZ0BjdByjy/yR73AQAEiXbf68EBZGPYJD0LJQq8lR+cKg
         HzINZ8HRkCwLTs/pH2f/bdY9RsVL4Xl8sXM29K2N5HIQtLQoZLNcGWYAvt8LOtM/Rmtu
         zi4lPd7WMuNEXjUD9n5m7rw2qi1+/yrxyAdCQ2itNCsovqWj4yA5sBEncIyq/Ej5oh7b
         i7XUWEtzhqtR8h4udeQKc9046cbAT6JovM7xAtlX6bR0pO8Tvx4KRHUQMpAsMmEZJVUI
         gElA==
X-Gm-Message-State: AOJu0Ywn9U/kqzVZV0qVOOh/cmbS9oNUG8uc34G4F6XOUQSUBnpuD4PF
	Z6UQkupAlM7aboc+Gl4WtBLp+atvczlZbNMMOwyfRE40bXFkBSbkLUCoJIr0C0tXHh35+N1CzFL
	2gag=
X-Google-Smtp-Source: AGHT+IGrhJ6GByyle2ZXj6YELCySZAA2hRd+lCiymK5OoO5mkfddy6eeNIr6RoEdx/yXV9YfoWqMCg==
X-Received: by 2002:a05:620a:13cd:b0:788:3c2b:42e2 with SMTP id g13-20020a05620a13cd00b007883c2b42e2mr8567991qkl.10.1710175606139;
        Mon, 11 Mar 2024 09:46:46 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.45
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
Subject: [RFC 03/14] fork: Clean-up naming of vm_strack/vm_struct variables in vmap stacks code
Date: Mon, 11 Mar 2024 16:46:27 +0000
Message-ID: <20240311164638.2015063-4-pasha.tatashin@soleen.com>
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

There are two data types: "struct vm_struct" and "struct vm_stack" that
have the same local variable names: vm_stack, or vm, or s, which makes
code confusing to read.

Change the code so the naming is consisent:

struct vm_struct is always called vm_area
struct vm_stack is always called vm_stack

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 32600bf2422a..60e812825a7a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -192,12 +192,12 @@ struct vm_stack {
 	struct vm_struct *stack_vm_area;
 };
 
-static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
+static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 {
 	unsigned int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm_area) != NULL)
 			continue;
 		return true;
 	}
@@ -207,11 +207,12 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
 	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
+	struct vm_struct *vm_area = vm_stack->stack_vm_area;
 
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
 		return;
 
-	vfree(vm_stack);
+	vfree(vm_area->addr);
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
@@ -228,12 +229,12 @@ static int free_vm_stack_cache(unsigned int cpu)
 	int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		struct vm_struct *vm_stack = cached_vm_stacks[i];
+		struct vm_struct *vm_area = cached_vm_stacks[i];
 
-		if (!vm_stack)
+		if (!vm_area)
 			continue;
 
-		vfree(vm_stack->addr);
+		vfree(vm_area->addr);
 		cached_vm_stacks[i] = NULL;
 	}
 
@@ -263,32 +264,29 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
-	struct vm_struct *vm;
+	struct vm_struct *vm_area;
 	void *stack;
 	int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		struct vm_struct *s;
-
-		s = this_cpu_xchg(cached_stacks[i], NULL);
-
-		if (!s)
+		vm_area = this_cpu_xchg(cached_stacks[i], NULL);
+		if (!vm_area)
 			continue;
 
 		/* Reset stack metadata. */
-		kasan_unpoison_range(s->addr, THREAD_SIZE);
+		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
-		stack = kasan_reset_tag(s->addr);
+		stack = kasan_reset_tag(vm_area->addr);
 
 		/* Clear stale pointers from reused stack. */
 		memset(stack, 0, THREAD_SIZE);
 
-		if (memcg_charge_kernel_stack(s)) {
-			vfree(s->addr);
+		if (memcg_charge_kernel_stack(vm_area)) {
+			vfree(vm_area->addr);
 			return -ENOMEM;
 		}
 
-		tsk->stack_vm_area = s;
+		tsk->stack_vm_area = vm_area;
 		tsk->stack = stack;
 		return 0;
 	}
@@ -306,8 +304,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	if (!stack)
 		return -ENOMEM;
 
-	vm = find_vm_area(stack);
-	if (memcg_charge_kernel_stack(vm)) {
+	vm_area = find_vm_area(stack);
+	if (memcg_charge_kernel_stack(vm_area)) {
 		vfree(stack);
 		return -ENOMEM;
 	}
@@ -316,7 +314,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	tsk->stack_vm_area = vm;
+	tsk->stack_vm_area = vm_area;
 	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
 	return 0;
-- 
2.44.0.278.ge034bb2e1d-goog


