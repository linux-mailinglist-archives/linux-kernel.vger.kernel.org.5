Return-Path: <linux-kernel+bounces-99259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077B8785AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5910B20C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456354B5CD;
	Mon, 11 Mar 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="qcP3FLEO"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D67481C0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175608; cv=none; b=ox8gfU5Zo/C1CgVEPagd+hGjpOSzkziiaATkR4/ewia+RV7ET4NHrG4444uBkO7N5ySJsaVbB36OsfeVCUpiv/w4WTgW0RJwuJKBegQn4oBaWq2NF0DfWyFrQuEsP6Q9y9gJqr6i+4ms7oYEBCzX/zq9tFqAUDltWwyNPxPjyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175608; c=relaxed/simple;
	bh=7FN5G5YkH+G4Zy6dvl7Btv8IAMrVxXa8kxhlpjyjjxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0RTSqPrGkkJ4tvz5274M+ZC3gTqlVJBLx2UTppX6sbwKVwxwqjlwz0fUwQMsdukaXhMwF8UatUjX+8WNGY8xv4IKRSAlfwgzjc27ByPxOvskWASkAA3uzjNFFretQHvS95iNJcp+Bl6DgzIB4Vd8JNL2fX5yEXUgDrXRF1+bYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=qcP3FLEO; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c2138463ccso2641871b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175606; x=1710780406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lhjThGfB91n24i50IPCohz8k1KRXdDof+Lt/uTAI2U=;
        b=qcP3FLEOYiFk85fyifZUygn8vQ4KYq7ijS+tCWLqm1H9t0EL6cSOih34kpSpKYopaK
         +po+fpVXorOLnvZKzwpSJbVyaZ4yAA7vZLz35TrDyT3l/4lYLLDn7Boor7gdXNVYJFvQ
         ZJNylAPq9BKwoysoN57iGgmiffcye51RvpsqXbc57daLHHJk4Nq+Nr5WqbgeXuLsjiuQ
         dz/yYhJQdR2sQbdF/8oO7uhLy/BIRBWv2atkQ5tRRCrC6np+NeDSO/XCoLbDysBvP3Fv
         J7OPzMhIGhIaI0dzYei+5lX7mc71i/q3vD8qNcXWleBQDHbPMQyi5Qu1TRsKoqmrOLvH
         EQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175606; x=1710780406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lhjThGfB91n24i50IPCohz8k1KRXdDof+Lt/uTAI2U=;
        b=DfVDGdcerTEHdtTT97gbhvvF9aW3JcQARaMb/xYSaIOzKnXOrAFjmvqwOr0qJc+DKb
         zfsCfZeaxUtR95N0gLC6dHqgZahPrgJGiF9bfOX3mqOALkP5bHMYa5r0ZQ0hyRpZxEaV
         KsWdK9C2kivsh0vh/uiLRoTeQRnlUt2X7cXHT2TduEBYrt4aETjETlNEx3hhBvG7nSx9
         h89NqJ3fYfROg1FaEng+czXs7A/WJ0K6gZjOUV+Wz5QzuekTEgpr6wNPkPUZ++yPSjA2
         f7IH4nytMFnvWuEvxqRu1cwXic8IifU5ytY12yQW4ohiEs5j4+2teCuRhysAzRcsRvkb
         oq9A==
X-Gm-Message-State: AOJu0YzI7I1PDEkJDouULGSbfVxANvXhbSAYeaMcTVDIqNJ3kLBSu5T8
	BLdBoEdeYiNWm/ZdlHUD4SEqMmF4q0WBv+ZsrKIKXVESLiovQaDdmfnCcl9yiYcRKfvRbvjdyoN
	JV7w=
X-Google-Smtp-Source: AGHT+IEjg4Cv5VbQxeFt499tiStDwxoTwSUC+FAOlU+MVjKFmojDB4eSoAwzE63CJMnyaPIAjMQShA==
X-Received: by 2002:a05:6808:ecd:b0:3c2:39d1:f105 with SMTP id q13-20020a0568080ecd00b003c239d1f105mr8453793oiv.11.1710175604451;
        Mon, 11 Mar 2024 09:46:44 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:44 -0700 (PDT)
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
Subject: [RFC 01/14] task_stack.h: remove obsolete __HAVE_ARCH_KSTACK_END check
Date: Mon, 11 Mar 2024 16:46:25 +0000
Message-ID: <20240311164638.2015063-2-pasha.tatashin@soleen.com>
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

Remove __HAVE_ARCH_KSTACK_END as it has been osolete since removal of
metag architecture in v4.17.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/sched/task_stack.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..860faea06883 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -116,7 +116,6 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 #endif
 extern void set_task_stack_end_magic(struct task_struct *tsk);
 
-#ifndef __HAVE_ARCH_KSTACK_END
 static inline int kstack_end(void *addr)
 {
 	/* Reliable end of stack detection:
@@ -124,6 +123,5 @@ static inline int kstack_end(void *addr)
 	 */
 	return !(((unsigned long)addr+sizeof(void*)-1) & (THREAD_SIZE-sizeof(void*)));
 }
-#endif
 
 #endif /* _LINUX_SCHED_TASK_STACK_H */
-- 
2.44.0.278.ge034bb2e1d-goog


