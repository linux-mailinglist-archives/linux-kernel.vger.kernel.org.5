Return-Path: <linux-kernel+bounces-24071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256182B65F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC981F2645B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B05786A;
	Thu, 11 Jan 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJkMoIHU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1C58117
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--carlosgalo.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e10c4fcso8378409276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705007229; x=1705612029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KM0MFQzzx6R4T/x1ke0xM5cbA+ktwKoGNKfrBNfIEbw=;
        b=rJkMoIHU1V3WgSD4PFu0QlTOrFsIIZDwJV2idEB8J+WDJ6FXBiZaodwUO54tO6eo2A
         UsvZHwFbVEkPPN1XF64Rb+5Of/FiqnkD3sGeDbm0co6ax0+mNT7Jgfi+0h4R7ePyyQ29
         +AJMkFKODYzRxc+AWOGYz5i2m254rEkkSpqNfzrqjp7COMAZGk2KQjSpT1rnJ8tXGvaQ
         bRXfU49AgN1acJmps4D/7H+cJ74n8RXkx6KlGwC7p77x+n9m31/6/tQWNkSOfRssJ8HZ
         FeGuQwGHCotKVWHcD/6aToor4BA8ttMyDltABkGmf0DfJd9mvaxtzNnyKDsNNC85MPfq
         l/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705007229; x=1705612029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM0MFQzzx6R4T/x1ke0xM5cbA+ktwKoGNKfrBNfIEbw=;
        b=tb2DQRrRY2RnWUlWtiyS9uXnlfyDUlD8uLQB8qmbOU8xH26NH6qFF6A+aRQ8aoyet9
         CLjJcNb5IchL1lUMkvfc9noF8E979LEwOwWgzZPFXRw/GhL/ncrvJHIscOURhUmrorDp
         p+VNdYVv+shvbb5gTmRVMByF7ELxiSc/6VodJTZZRXqYSI8PN5+NLkG52Ty3NXLKa+ps
         Iz/Qdq7yJccf6MOOHiHvQQiSrGyjqxBEGe42ROWvrffipa2Om5pjjXwunby4xnHJeYFy
         oY+3Z6zvaMzwNRDQXBarWAm+JNbbQQavneMlM9yxEDhA9Q5n0S0SDgBYfmxZtwJRcaLH
         qL9w==
X-Gm-Message-State: AOJu0Yx44AJDREexdhKdbA7qKmIfv1te3hXRQ19o3vd/HwdhXCjHvQ9d
	NAKgFEdOwBvK8JEY8Jp2Ex+xs8fJrimNpksBbzxgh7Y=
X-Google-Smtp-Source: AGHT+IEJ8iQ7jU52uMbF/0q9HwIfSP4Ahy2tz5KzGup8oQAgmmJWR0r54OCM5+C/bHTx4p7UxPx+zjBAxjB5XiRg
X-Received: from cgalo-android-cuttlefish.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:24f8])
 (user=carlosgalo job=sendgmr) by 2002:a05:6902:1788:b0:dbd:b6cd:92cf with
 SMTP id ca8-20020a056902178800b00dbdb6cd92cfmr94760ybb.11.1705007229176; Thu,
 11 Jan 2024 13:07:09 -0800 (PST)
Date: Thu, 11 Jan 2024 21:05:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111210539.636607-1-carlosgalo@google.com>
Subject: [PATCH v2] mm: Update mark_victim tracepoints fields
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
v2: Fixed build error. Added missing comma when printing `__entry->uid`.

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
+		__entry->uid,
+		__get_str(comm),
+		__entry->oom_score_adj
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


