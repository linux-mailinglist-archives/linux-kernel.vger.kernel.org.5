Return-Path: <linux-kernel+bounces-117598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDE88AD06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8BC1C3D925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1712FB32;
	Mon, 25 Mar 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Z3EsaD2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E912F582
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387662; cv=none; b=u5TKh58VtUArhnVe2xJioegG8K/Q2GLVc5H9BCJK/urpMLmmugh57oTycFLk8D7qIWCsadUlwgRqTCh3vbnVffF1ff98Gc86C7hZOrDLCKSF3yxJPpCbvRq8DO8Ui9TvNWzxhlf3bRpZhBFJ7mH2sa/szWSLFfNHJvriAZRHePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387662; c=relaxed/simple;
	bh=AyBVpI9vaGXwp404hB8NwI0hWf2z6RpoeeU9eY+5rJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZc1fSh+ve0rtJUz/dz8PdtqxV+RQyyTr9X6Pd+a1532ZC4/FR5VsZbScENo4BkVwTROkxiy4xx6fCAzoVqcgd0sQo6yY4STm2X9BMG3Q7pieK9PfDDXOIfPBgyS/LY3KG6icXbUIBrN50chOljg0F3bQ2QbDkFDRueoS4v50Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Z3EsaD2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so73033677b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387660; x=1711992460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNpwPuaEt/XFweY06CO9RkqXPvdKzwhVG5w7ZvFx+D4=;
        b=4Z3EsaD2fSgqcMSqzxKlCbEjXGJ3rx7ZvfFGIk9sa7+mj+d79VhHMTbhRXOOd36SM9
         ZLZNDn/eBkF5Z4OVZQUv/w4VxwGT6H60j8AXoAaz4k8Az07FeaUdD/sQ7dc+we1G2GPY
         hzWGGsx73nNt93k2Gc/707Eg4IeS52aoNWxMhV/eqE1n5aEO2LLP9n7uDR9iWCg7Wlo2
         e8/Bnuv3x+KBqIU5s1FSE4vPORjdh5NXo0UB2QrkzZyCnNvPFPJcrcwqkUJcLjOzXHQV
         kF7R7hjnyQNhMHPqFYItQLSpeiTipInGxS9zL7BHseteSLQ/dFURhd/pYGfCUAG3pptV
         n9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387660; x=1711992460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNpwPuaEt/XFweY06CO9RkqXPvdKzwhVG5w7ZvFx+D4=;
        b=tWVc7OwyS6fJBQn3dzGZrBH2YwAU2gogUp0yG+rUIjnu0nHOoY9rTZJ4khNU25xa2e
         oih7s67VQUEwyvVnj82hnIn03GlVq6MjaUXc0M0Xc0/KWLxCcgBKG+J2zNBj40qJxY63
         W47dPFbtUsIrYnZw8N6N6vJ+aik+Hff1s5LEcNUpbZDIPfH6Vi5hxd6F5slzldW1T4tu
         ZKD2DXPjZj6zq/rBnou6/5GmfxMfKx4FppcSS5DleqTHREHsFl7yVDMqyaJtlqTFi9gR
         fCrPZPDkAlI7ALqQHE4b7BB8bCO4L1YoGdFTg8YY6UBAf8droFolrrsO25SW5YWQrlvd
         G2IA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvQ6rhYq3HGui4CaEJ+2HhawfNY5cOCAGNV7l1NYlSmbLfyYQbOlXdkbkF4NDJlIwbD5xZ2Dypgk3OMA32IcwZ9H1STB2Esaa9G8O
X-Gm-Message-State: AOJu0YxNcm+6vlhpzWWeJN8BBdDiXOt/EFXExe0d05BoPs1HcLnKPQlg
	wqurgHOu3xWy1xWSr4OKLUBf1J3Fwkk8DZoiWdXXPIteIlbGmqVv7nneWawRdlemm16xUwfkP72
	5zKOlfigYY/ifu3DxBzbWYA==
X-Google-Smtp-Source: AGHT+IHlfxCzaC5QZvJS8UKj5AkDxbOZp4SBMBs3PGEZ0LkbHF7gM5w89iof3Cqnk0L6PzpzXy18Cb0tqtiscYFF9Q==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a81:de51:0:b0:609:f0f0:20c4 with SMTP
 id o17-20020a81de51000000b00609f0f020c4mr1784308ywl.4.1711387660115; Mon, 25
 Mar 2024 10:27:40 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:03 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-3-peternewman@google.com>
Subject: [PATCH v1 2/6] x86/resctrl: Add hook for releasing task_struct references
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

In order for the task_struct to hold references to rdtgroups, it must be
possible to release these references before a concurrent deletion causes
them to be freed.

It is not possible for resctrl code to do this with
for_each_process_thread() because the task can still switch in after it
has been removed from the tasklist, at which point the task_struct could
be referring to freed memory.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  6 ++++++
 kernel/exit.c                          |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5d599d99f94b..9b1969e4235a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2931,6 +2931,16 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	read_unlock(&tasklist_lock);
 }
 
+/**
+ * exit_resctrl() - called at thread destruction to release resources
+ *
+ * This hook is called just before the task is removed from the global tasklist
+ * and still reachable via for_each_process_thread().
+ */
+void exit_resctrl(struct task_struct *tsk)
+{
+}
+
 static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 {
 	struct rdtgroup *sentry, *stmp;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 62d607939a73..b2af1fbc7aa1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -325,4 +325,10 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 #endif
 }
 
+#ifdef CONFIG_X86_CPU_RESCTRL
+void exit_resctrl(struct task_struct *tsk);
+#else
+static inline void exit_resctrl(struct task_struct *tsk) {}
+#endif
+
 #endif /* _RESCTRL_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 41a12630cbbc..ccdc90ff6d71 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/resctrl.h>
 
 #include <uapi/linux/wait.h>
 
@@ -862,6 +863,8 @@ void __noreturn do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	exit_resctrl(tsk);
+
 	exit_mm();
 
 	if (group_dead)
-- 
2.44.0.396.g6e790dbe36-goog


