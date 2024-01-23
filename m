Return-Path: <linux-kernel+bounces-35563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D746839352
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444A62866F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C28657D6;
	Tue, 23 Jan 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGJ0vJKf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42E657B2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024117; cv=none; b=Qqz4j96+YMQpwx2XJvNV2n8h7yUdjXBHOYpCbNRnXOUrxMFZutw5t6YmmDYXn94hJhs/wf7H9U7YNZCFd1nojV3DqafZ9UAcKUlcyNVFdXdFdzzutlNpXlqaIdsmWfqfU3HCwgS0ecu49eEvuHdTy1CaelIWa6seUKjI0UbIj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024117; c=relaxed/simple;
	bh=D9S/w+5o+A62Nxx/ISEz51lECzS059pBiYjXyW/CbrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hLck8Gz4iKCBs4KDaSI6HY1fAttyERu39oSnxG7OFqI0Pfz8eVIWRSQMfLK+cOthvL/34ZkF3S+J7zH31fvk7rXxxybf/15YmM5rhR//a/Q/A7V0alH8mCJX3RjcNetclEEDoQRinPMEvyw9caH1XAUbDXxCbETqSzI4o8lEy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGJ0vJKf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706024114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=bIcROdxOGKA/fk6m4Nxqn1gTa+sWPdKk6gCIL7a7N7s=;
	b=MGJ0vJKfGNKt5plbWSJ+UfxBy5khqHkF6eqhFkijFpJ6UynryjPBAKjKVZbeGVZ870r14o
	x7zMu4cehtcPs4EVIezg/JL09t8OJhXvwBngiKS3xEc3wK/AHIC64A7rDw35zwQ7w+vJQg
	9GHDuN5ttHYGapZ5JpjYXMEjoxS2xps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Eh1mlGpsPxWje1pyXNOMIA-1; Tue, 23 Jan 2024 10:35:10 -0500
X-MC-Unique: Eh1mlGpsPxWje1pyXNOMIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 089FD185A785;
	Tue, 23 Jan 2024 15:35:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id D83BD40C1430;
	Tue, 23 Jan 2024 15:35:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 16:33:56 +0100 (CET)
Date: Tue, 23 Jan 2024 16:33:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fs/proc: do_task_stat: move
 thread_group_cputime_adjusted() outside of lock_task_sighand()
Message-ID: <20240123153355.GA21854@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153313.GA21832@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

thread_group_cputime() does its own locking, we can safely shift
thread_group_cputime_adjusted() which does another for_each_thread loop
outside of ->siglock protected section.

Not only this removes for_each_thread() from the critical section with
irqs disabled, this removes another case when stats_lock is taken with
siglock held. We want to remove this dependency, then we can change the
users of stats_lock to not disable irqs.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/array.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ff08a8957552..45ba91863808 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -511,7 +511,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = utime = stime = 0;
+	cutime = cstime = 0;
 	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
@@ -546,7 +546,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
-			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
 
 			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
@@ -562,10 +561,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
-	if (!whole) {
+
+	if (whole) {
+		thread_group_cputime_adjusted(task, &utime, &stime);
+	} else {
+		task_cputime_adjusted(task, &utime, &stime);
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
-		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
 	}
 
-- 
2.25.1.362.g51ebf55


