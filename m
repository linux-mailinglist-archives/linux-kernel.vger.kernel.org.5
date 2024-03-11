Return-Path: <linux-kernel+bounces-99269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C768785B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B4C1C21F34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E395731F;
	Mon, 11 Mar 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="KvYA/g7n"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FB56B72
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175618; cv=none; b=HWLd15y2qE3f7IQzxUhsYXR+k5FMTDQaDWCws6mWxZJtitIlUpKBp8ZGjRY+DL80IQtgE11cz6HfdjANjdkWtL0RBcv1YfhDPwg9kwF17yAo/B+nn4hUXPh1MEjMIa25V+RwlNsFRC9+FfaQZjSKeUSjKNBwQNj1NhfFZY4tXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175618; c=relaxed/simple;
	bh=yMyYef3NZl4G4p32yVMbEyHz15V0r/n9UEHNsI8V/OU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTU6rzXEBgQ9NX4SL5bUTBq55J3F9zH2vJN7KexCYJQLGiUwY8I9hTfOJWMuGG19mPYTXzc5gfpGTXSxI59uG88LT4lXpQLK367DWeA0eOXkmhpgn0KXTyl7p9++9rFtb0ueQN5tGjcJHyjpqLVYZ3oz68O6mz+bRuRxD/Qeotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=KvYA/g7n; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so277632585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175615; x=1710780415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3lfkbgOqarNxaTYrCv0KyWjfiF6t60qYNqci1EaSrU=;
        b=KvYA/g7nW8657mqsa3INNq4bY3H2wyoRVWYt64PLx8aNNc1UOdVPJncyG4qm3EG7T4
         kxmmtALcXLvEbGobR6d5CDb6mfMSBIVUPVfMhZm8Rm8T3MnDmKOnXvfTE5krvypWnYn9
         9gWfoFmwRlJ6cCn4ZP7CBm4CS7uj5Ni2Uu1kxz1yUR+cUP3y0YfVpuV2RF8rtrLy7+7L
         tprYNFeJCUwBCJcYRpOahsv8WF+By1fHIzrGQ3FPkme8EIe8NTYlOqNifFhwieS3fQAJ
         HEYORzRRjXTfMmjbfBXN0DMZ9FR7Ai/oCIOIPzlShzmZ0F4aRiUrFVRIioH5n/dgSpVf
         RuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175615; x=1710780415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3lfkbgOqarNxaTYrCv0KyWjfiF6t60qYNqci1EaSrU=;
        b=vj8jsMSdix0sgocRk2cgx+F/immNRyXgHip8rFzDizjKsDk/nWhNyBmtcqWGKPRvjS
         i9zrQeMGHBpSNjui8noIJdIJXY9dTZqGM6aN7b54Zeec5PzMZB0vhHN5jbSoAbqY2hSR
         NwDbquxne3o9A/iWZJkNg2rqgOjCyYrV3xoJ2jzLLyfMcBe6Wf7iSPGQEH6R6HTFZlD+
         e4VB50IbyNWLGOwDF782rdh6PgLWt08HuHVk8ks5Pk4S1BaAwruMeiTaAhWiWO7oyjld
         E7hMMd2DGnLjduNm1CJU6Dme8lXpAoixyG0/Tio36FlLbZD2rQ+3qOIBo5gB7h7MdvkB
         6W6g==
X-Gm-Message-State: AOJu0YwPhowmijEBNMNmGFIuGMiauSyuD0kEFeVOgQIYAHqdm9Ro4PWl
	RvW1P2UTsHFJJ4Bpuqlb+tGpBsSMgP1cglP6OVXUqv7tVDws/2GC4nbgUYxypUN9t36HZSGePqO
	PPgc=
X-Google-Smtp-Source: AGHT+IF4l4AZR/miARXhlieJbwXHGqXTuZHHo2Erbz9LNEfZfrLPyat4CsaJX3i07UmkC9xY9bUxgA==
X-Received: by 2002:a05:620a:4609:b0:788:2740:550a with SMTP id br9-20020a05620a460900b007882740550amr9951495qkb.44.1710175615373;
        Mon, 11 Mar 2024 09:46:55 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:54 -0700 (PDT)
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
Subject: [RFC 12/14] task_stack.h: Clean-up stack_not_used() implementation
Date: Mon, 11 Mar 2024 16:46:36 +0000
Message-ID: <20240311164638.2015063-13-pasha.tatashin@soleen.com>
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

Inside small stack_not_used() function there are several ifdefs for
stack growing-up vs. regular versions. Instead just implement this
function two times, one for growing-up and another regular.

This is needed, because there will be a third implementation of this
function for dynamic stacks.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/sched/task_stack.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 4934bfd65ad1..396d5418ae32 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -135,25 +135,30 @@ static inline int object_is_on_stack(const void *obj)
 extern void thread_stack_cache_init(void);
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+#ifdef CONFIG_STACK_GROWSUP
 static inline unsigned long stack_not_used(struct task_struct *p)
 {
 	unsigned long *n = end_of_stack(p);
 
-	do { 	/* Skip over canary */
-# ifdef CONFIG_STACK_GROWSUP
+	do {	/* Skip over canary */
 		n--;
-# else
-		n++;
-# endif
 	} while (!*n);
 
-# ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long)end_of_stack(p) - (unsigned long)n;
-# else
+}
+#else /* !CONFIG_STACK_GROWSUP */
+static inline unsigned long stack_not_used(struct task_struct *p)
+{
+	unsigned long *n = end_of_stack(p);
+
+	do {	/* Skip over canary */
+		n++;
+	} while (!*n);
+
 	return (unsigned long)n - (unsigned long)end_of_stack(p);
-# endif
 }
-#endif
+#endif /* CONFIG_STACK_GROWSUP */
+#endif /* CONFIG_DEBUG_STACK_USAGE */
 
 static inline int kstack_end(void *addr)
 {
-- 
2.44.0.278.ge034bb2e1d-goog


