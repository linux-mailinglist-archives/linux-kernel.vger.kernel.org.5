Return-Path: <linux-kernel+bounces-22907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E028582A532
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB180B250DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E6ED2;
	Thu, 11 Jan 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK4PICV4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA394EC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--carlosgalo.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f240ace2efso70059257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704932023; x=1705536823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ds9QCoWJDqvAKdAL5vsJwiq6HddgkjsWTfVqUPaWffA=;
        b=YK4PICV4K9ud4/OO2z7XyuKsR9bUZ2Ixb67mQpfRq6br4IsdL2kgfaUSDYpwQ28q+U
         O82pRIOJLjeMaT2Z2rP9veOQKb3g0tcG59pV03jt0wysrLIYDmBFbS4evoC9jCzP8Byk
         U57G68kf2hO0CzNF0c/n4mHJeiwuKKOPBrVAJ0PnksYgRpvP3a/T/8mminen/uQxTxs8
         ynArP/SlKOzP6gorKhD70Pgr8Wghi9uh9iQMLzGRQK28NDOtCEwifcq5DjXs5KwkhMm5
         lI2Q/aFHqHL0eTIYQkPBu5gEJBVCOlIAfFM/FVbw0dGk6mgpeIT0N0YZfqCwfrouwOUk
         yBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704932023; x=1705536823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds9QCoWJDqvAKdAL5vsJwiq6HddgkjsWTfVqUPaWffA=;
        b=WpV74UAkJNnrL+cb1tJ+P/n/Z2rxikYAl/kPhyQxmLICeSmGPDAGbd5xD2LolQ4Kc9
         2AJ6llZUdq813Yprm7OGFodoQyJhVlHxylPEJ2QZi4YHLaGhRzq6CCHeaMFjyD1IpATs
         ww7vC+LtFLpiRKdSv1iP5R/yvMGm+quYV3IeTlNlUobb3TkvjMeYe1WGSIzD6sRnfzk/
         8M31k3o9EQkheUMOLhYttomnPAmIQQWNzsxEH9InIJDhdO8s4jCZQIe86EiUjZVwUTWT
         AnvrN6KS0N8IZoLA9nlswKTG1hT9YWTMexNxOpX4Ed4nRfGrmYSw6SkBKpPKhLaZtmFT
         hkbw==
X-Gm-Message-State: AOJu0YzUQelCvpO5+hYvlEifEb8q/pLTFhrx2QvRYAVFbQqCxSzUJlpt
	8eo0YLhU+x4KrSmUzvWP8W3lmPf7chbq/U4a6RZ9tF0=
X-Google-Smtp-Source: AGHT+IGOKg1xYoR1bvEZbVA0oOg05MDhta9buJB15J73ALyFEuJd6c88CvkB6II+CbHSVTov/cPiNwv2YMLAGnIB
X-Received: from cgalo-android-cuttlefish.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:24f8])
 (user=carlosgalo job=sendgmr) by 2002:a81:8941:0:b0:5d6:dda0:33b4 with SMTP
 id z62-20020a818941000000b005d6dda033b4mr229013ywf.4.1704932022930; Wed, 10
 Jan 2024 16:13:42 -0800 (PST)
Date: Thu, 11 Jan 2024 00:11:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111001155.746-1-carlosgalo@google.com>
Subject: [PATCH] mm: Update mark_victim tracepoints fields
From: Carlos Galo <carlosgalo@google.com>
To: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com
Cc: android-mm@google.com, kernel-team@android.com, 
	Carlos Galo <carlosgalo@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The current implementation of the mark_victim tracepoint provides only
the process ID (pid) of the victim process. This limitation poses
challenges for userspace tools that need additional information
about the OOM victim. The association between pid and the additional
data may be lost after the kill, making it difficult for userspace to
correlate the OOM event with the specific process.

In order to mitigate this limitation, add the following fields:

- UID
   In Android each installed application has a unique UID. Including
   the `uid` assists in correlating OOM events with specific apps.

- Process Name (comm)
   Enables identification of the affected process.

- OOM Score
   Allows userspace to get additional insights of the relative kill
   priority of the OOM victim.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Galo <carlosgalo@google.com>
---
 include/trace/events/oom.h | 19 +++++++++++++++----
 mm/oom_kill.c              |  6 +++++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..fb8a5d1b8a0a 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -72,19 +72,30 @@ TRACE_EVENT(reclaim_retry_zone,
 );
 
 TRACE_EVENT(mark_victim,
-	TP_PROTO(int pid),
+	TP_PROTO(struct task_struct *task, uid_t uid),
 
-	TP_ARGS(pid),
+	TP_ARGS(task, uid),
 
 	TP_STRUCT__entry(
 		__field(int, pid)
+		__field(uid_t, uid)
+		__string(comm, task->comm)
+		__field(short, oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = pid;
+		__entry->pid = task->pid;
+		__entry->uid = uid;
+		__assign_str(comm, task->comm);
+		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d", __entry->pid)
+	TP_printk("pid=%d uid=%u comm=%s oom_score_adj=%hd",
+		__entry->pid,
+		__entry->uid
+		__get_str(comm),
+		__entry->oom_score_adj,
+	)
 );
 
 TRACE_EVENT(wake_reaper,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde34a..0698c00c5da6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/cred.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -753,6 +754,7 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
  */
 static void mark_oom_victim(struct task_struct *tsk)
 {
+	const struct cred *cred;
 	struct mm_struct *mm = tsk->mm;
 
 	WARN_ON(oom_killer_disabled);
@@ -772,7 +774,9 @@ static void mark_oom_victim(struct task_struct *tsk)
 	 */
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
-	trace_mark_victim(tsk->pid);
+	cred = get_task_cred(tsk);
+	trace_mark_victim(tsk, cred->uid.val);
+	put_cred(cred);
 }
 
 /**

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.43.0.275.g3460e3d667-goog


