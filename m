Return-Path: <linux-kernel+bounces-99261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48B8785AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEC41C217D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0C53392;
	Mon, 11 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="q9Di0cQF"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B374AED1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175610; cv=none; b=LEnwbILsB8zX69Fg933aDWUHEvtORoiRvO5lZgh0LBexKC8D5es0YTb77c6wy/yM6ZjibyBrjSY4RnDT9TxlWyBQBD1aEZCY0zfOJSIlrNNxjWCOonqTlPc9yfaGtQZxBC7rD3QS/CPBqMOm8sGDamoC4KJi5jf+RAFF2qQyDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175610; c=relaxed/simple;
	bh=1rbaxunOVQPm7FPgRClladfLQq23xPc2MbtK28dseXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyzAAD1lS6sCJJnmxTk9sGNi2LEPCwGRxg3X/OXJ14DszkpFsYLW2FiU0kObGVksNAZF5ItxvbI0AqUo9DQbJUvrrHZRmZzATflur6M5MsLpTBHnRqgdiHwVqk/NXZTyro8gx0NwueXxaAplHuu8VrcUEG9M9ZCN4qpeSGe+EOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=q9Di0cQF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7884114feb8so119905385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175607; x=1710780407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZjnTg3rcm4xEs2wuMm2S2zMsfw/GRvQpvq6ZsCVNYQ=;
        b=q9Di0cQFIiTo63gXIxSVQaGOI70w8l37/sKZzk4Af7Uh7nSl+Rx6ztOW/R2b0heH7K
         CxS9f6ldFRJRtXWZLXifv4jqSUEHtkY+yrVDognppkBJ6Zk17TWRDmdnvx+qUskpwo6O
         j6qBj1PLHtd2aWkvVwth14JPdOst4Q+LJAs/vtF1jkjueuuAL0xqkQD+hlXdUO5uH/PJ
         4o6HmBjqeZ6bixvnWvKujRJszPjgzkyVaHscTs1WSFaWK5h1DbwIU7bpelCnOAHnIAB7
         9iV0SSQRHNvVDFXIEWhK4HU1IXkVLDCw8IqjI6QxDuLokK7Y0OfY8vvHNM7xh52M18I0
         2kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175607; x=1710780407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZjnTg3rcm4xEs2wuMm2S2zMsfw/GRvQpvq6ZsCVNYQ=;
        b=WdMnAFXOaR8Ac5pX6ByVpg3/AgcFWHfBi9JSUD4aWFOn5egrHvc2GeGVdwov/u1//+
         4yK864H1q5SVDOIG17L8hQXD60sc8KLyhrJrgvF6PxIeXGNApRkEAULF4e/OKkterVmd
         knDGO7ZhdjmFE6U5pPLGGjCx1lbwzDCiamxC7qjLhQZFdOvRHvzc4ZpV8PasK0PZtZWu
         H/HmtKRY824ruu57tWvCJJ+mnvkAucN0nXpSiHCrdZk72Jlp8THB+k6uBrB3pIyEV89w
         vHVcHl3/ybg2NMgHWpI9HQl97RcSf3tR7pcRp+qHgWhSHqjQs3PHKRrHOhZncfVTu9uq
         S+BA==
X-Gm-Message-State: AOJu0YzzWcnUu8VVO3zzeziBLmfhG0J6uLE7djB5Ayn03K96FwaiF3jy
	JoP7EWMPhwijfOGuwuw+nLe30RTVku35IfIf3H4tNTJDxtWuzHbmYqW3kmaJzhA4TtHTHwv6WJ2
	WkbY=
X-Google-Smtp-Source: AGHT+IGK3ZkaISv7/cXUwYINZRSYzKZD81aDWnU5gX/aNi31ERoz+HAdpfJ4DupGmG/DqWHaLyf2Ag==
X-Received: by 2002:a05:620a:3908:b0:788:7507:6e24 with SMTP id qr8-20020a05620a390800b0078875076e24mr1874945qkn.3.1710175607288;
        Mon, 11 Mar 2024 09:46:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:47 -0700 (PDT)
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
Subject: [RFC 04/14] fork: Remove assumption that vm_area->nr_pages equals to THREAD_SIZE
Date: Mon, 11 Mar 2024 16:46:28 +0000
Message-ID: <20240311164638.2015063-5-pasha.tatashin@soleen.com>
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

In many places number of pages in the stack is detremined via
(THREAD_SIZE / PAGE_SIZE). There is also a BUG_ON() that ensures that
(THREAD_SIZE / PAGE_SIZE) is indeed equals to vm_area->nr_pages.

However, with dynamic stacks, the number of pages in vm_area will grow
with stack, therefore, use vm_area->nr_pages to determine the actual
number of pages allocated in stack.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 60e812825a7a..a35f4008afa0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -243,13 +243,11 @@ static int free_vm_stack_cache(unsigned int cpu)
 
 static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
-	int i;
-	int ret;
+	int i, ret, nr_pages;
 	int nr_charged = 0;
 
-	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
-
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+	nr_pages = vm->nr_pages;
+	for (i = 0; i < nr_pages; i++) {
 		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
 		if (ret)
 			goto err;
@@ -531,9 +529,10 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 		struct vm_struct *vm = task_stack_vm_area(tsk);
-		int i;
+		int i, nr_pages;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		nr_pages = vm->nr_pages;
+		for (i = 0; i < nr_pages; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
@@ -551,10 +550,11 @@ void exit_task_stack_account(struct task_struct *tsk)
 
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 		struct vm_struct *vm;
-		int i;
+		int i, nr_pages;
 
 		vm = task_stack_vm_area(tsk);
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		nr_pages = vm->nr_pages;
+		for (i = 0; i < nr_pages; i++)
 			memcg_kmem_uncharge_page(vm->pages[i], 0);
 	}
 }
-- 
2.44.0.278.ge034bb2e1d-goog


