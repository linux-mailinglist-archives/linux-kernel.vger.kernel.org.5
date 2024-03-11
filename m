Return-Path: <linux-kernel+bounces-99271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAB8785B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436601C219F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03858203;
	Mon, 11 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="m3FrBRkb"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76857303
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175619; cv=none; b=I/pDj0eJ2e0ST8APlTjt92w1yFXndxI56NAh8EH3sMW+TlM5U/ozPt8aaMYnpcslwVuIdlORWfI0tqvHyLRiA79mPq5x45bQ1jTt3jaQ233MlRAwoV6PU7wpwTD0jAsAeSz/hgZ7JPP24NkE8EnUYO0qrdawH3jMvx1UP2NeakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175619; c=relaxed/simple;
	bh=/QZnssDAeZpjT2sFmC0j/E2H3o0tSEKpT/2jMGwPGOw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG49q/4bW7jBtSh2JZPpGRGK/thdpD8eMzQablWP7O3os9ip0sPEUOF64o9OpnHphyZxOSwr1QielHgTpnJl6KUp3UWsNvcmMjpRHjzlytHj2bQFUtQHxKw7UkBKD099465BTaQkAAMlX5i4KHv6dXcvO8l/yXqHLJYMDGw1wKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=m3FrBRkb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7884a9a47a5so122048385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175617; x=1710780417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6FpZ49BpunKdsFtEl370XBCgostMe6YS8Mf7VMqlwM=;
        b=m3FrBRkbW1wH9x988Zv/mO0VhHRfDaVv+k5okI9z8d8zGJ0OTxhr+P98Ds7N0ymveY
         DW8iDwq6YwWOZtRRKh3JmyFVZduGITXhTF8Igupvz6FtCAOGVP6Djk93KeLl8etbmNuS
         6TKDtIPia0vhrI976Qa7KEkf32e0W9Y9apsjFC1Akesy9WnHaJWih5+42tboxL+L/sNY
         tsSEOugU6XXiVDb/pe8Ve78pLnwk+0VVwxyAkZ703tfdMCublXompMRWGfb578k9cESX
         zOECp1/QDHeAounTyL2o0L6qo1noAYnS7tkQqDD3L9oT2IHa5eWXX/axE/L/ar1BVRvf
         RodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175617; x=1710780417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6FpZ49BpunKdsFtEl370XBCgostMe6YS8Mf7VMqlwM=;
        b=iWsVdIwff+bgNtDnEPrMcq5dG0wgO1WdLUUxNQkP/gTxFawBk/sJYjmQuFLd3ItPi5
         kN7RJU/h4d/HkeHqUYVhoTki8gcv+QiBIlAuuCagynkAzuH+r6QFvCt1sww6+PR6Wfik
         VE4GeY3E3tfP2pcXQj0G1l/fS2LE6Z1+bK+9Bu0PBhEKpwrtBrKrtk+sfESLNMOrr602
         YPHxVIcO/KO4mj6Pz8QFsgD7kxiCciX4o180fMglN8FD+5eaoBLNicETJa7QKpAduQjf
         pLjFjDqTnibZeYPbZDAMjHlHqMnuE1tKHJXRaSfPU0t6RZUriA40V2NKsOWbcw7bC6bX
         ZSEA==
X-Gm-Message-State: AOJu0YxEZzkcw29uLOdsrFwCIv95bCU3cguHkaIWalymJFZu2X0yLyFM
	h/dnjpd8pCjAv72OGiUtrxMjl3c+i2JI740Z9yb9pQ3iwOn0u+p31Nj0ABKXzNYbE+Y06I2Dkh7
	cqXo=
X-Google-Smtp-Source: AGHT+IGBBQHGTyj0HK6a6nT9QQX2CzgLifOnSoon3yUl5MxZhI+SOhyqTpiNJHmFfzsFPzFEmk6ojA==
X-Received: by 2002:ae9:e701:0:b0:788:2e8a:1731 with SMTP id m1-20020ae9e701000000b007882e8a1731mr6728530qka.17.1710175617252;
        Mon, 11 Mar 2024 09:46:57 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:56 -0700 (PDT)
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
Subject: [RFC 14/14] fork: Dynamic Kernel Stack accounting
Date: Mon, 11 Mar 2024 16:46:38 +0000
Message-ID: <20240311164638.2015063-15-pasha.tatashin@soleen.com>
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

Add an accounting of amount of stack pages that has been faulted is
currently in use.

Example use case:
  $ cat /proc/vmstat | grep stack
  nr_kernel_stack 18684
  nr_dynamic_stacks_faults 156

The above shows that the kernel stacks use total 18684KiB, out of which
156KiB were faulted in.

Given that the pre-allocated stacks are 4KiB, we can determine the total
number of tasks:

tasks = (nr_kernel_stack - nr_dynamic_stacks_faults) / 4 = 4632.

The amount of kernel stack memory without dynamic stack on this machine
woud be:

4632 * 16 KiB = 74,112 KiB

Therefore, in this example dynamic stacks save: 55,428 KiB

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mmzone.h |  3 +++
 kernel/fork.c          | 13 ++++++++++++-
 mm/vmstat.c            |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f189d988..ba4f1d148c3f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -198,6 +198,9 @@ enum node_stat_item {
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
+#ifdef CONFIG_DYNAMIC_STACK
+	NR_DYNAMIC_STACKS_FAULTS_KB, /* KiB of faulted kernel stack memory */
+#endif
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 63e1fd661e17..2520583d160a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -343,6 +343,9 @@ void dynamic_stack_refill_pages(void)
 
 		mod_lruvec_page_state(page, NR_KERNEL_STACK_KB,
 				      PAGE_SIZE / 1024);
+		mod_lruvec_page_state(page,
+				      NR_DYNAMIC_STACKS_FAULTS_KB,
+				      PAGE_SIZE / 1024);
 
 		page = alloc_pages(THREADINFO_GFP & ~__GFP_ACCOUNT, 0);
 		if (unlikely(!page))
@@ -771,9 +774,17 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		int i, nr_pages;
 
 		nr_pages = vm->nr_pages;
-		for (i = 0; i < nr_pages; i++)
+		for (i = 0; i < nr_pages; i++) {
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
+#ifdef CONFIG_DYNAMIC_STACK
+			if (i >= THREAD_PREALLOC_PAGES) {
+				mod_lruvec_page_state(vm->pages[i],
+						      NR_DYNAMIC_STACKS_FAULTS_KB,
+						      account * (PAGE_SIZE / 1024));
+			}
+#endif
+		}
 	} else {
 		void *stack = task_stack_page(tsk);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..1ad6eede3d85 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1237,6 +1237,9 @@ const char * const vmstat_text[] = {
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
 	"nr_kernel_stack",
+#ifdef CONFIG_DYNAMIC_STACK
+	"nr_dynamic_stacks_faults",
+#endif
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
-- 
2.44.0.278.ge034bb2e1d-goog


