Return-Path: <linux-kernel+bounces-117209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD588A8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8081C61244
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B2148FE6;
	Mon, 25 Mar 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqdA3M0u"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8A148853
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375795; cv=none; b=s6VCbRM6ehYbFmE0TqNDM32VE7VO2OllfCzucs+nxM3RZP/rdp/B7uGJ7GxROO1NS7RbbSC3peXewc7PySFdDQx141sB5gSJEw/R4KlwXvadIy2GkQbNh0rAe8MlUn1xsbNLIzooS/+Y5MmCSo2RzEeYIXqY6pIQ2OfaQKlfhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375795; c=relaxed/simple;
	bh=geZeuSNyd+lU3zUt7F6vw9I8yrmXaaVcIxj0Gi/MEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=conPszVI3mpF5ZDPsQrXRspCD9IL8VgXWSXBfbu5CkQM7ox5leWd+wfXK+QsNVBYMImggGChInRkv+LcKHWwNXaZoxI3EIKINJ4LmtQlxQdceSM3EEcArVwC+wWcFLugisGgBZfw0/lnCjylAz4BzlCmVaaaWR1o+j3F2AQLOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqdA3M0u; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so2995966a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711375791; x=1711980591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjG3csePsDpHGxpWJaP4Umm+TAgWPS8s6WfHuls4lSg=;
        b=KqdA3M0uvGFD6U3jB2JoxNiaUoSsswK7RXNsLDn2jWGjeAnXfYDoxQVqaeF4ePTeJn
         1oplLo6d6Xrib/bk5DP5H+tHWtiKm6QC5pLJys6fK5G8/wQR7tKYSaBZjAJnGxeJsiwQ
         yj+yv3o138lwRUigLhb4MJBJFejhSuDKxh/MdXzUucR2iHTVupczm3sD8fZCegEErCA1
         Tkh6xWbB1UtPzc4HTE53grB22RKcyNmimiqnLFaFB45yA5sE+NlyhHyHBnhLUC0Dj/1t
         F2RD07E9ue5uilW166z7b48qW2SfctEhJ21xEoIgTmmFJkbd3drZYp86X17CtozAtdi+
         e9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375791; x=1711980591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjG3csePsDpHGxpWJaP4Umm+TAgWPS8s6WfHuls4lSg=;
        b=g4R5cXVZ8GKRQCFaKSMO5K/hPAIAKnu/R/PabHz+52MKCqYmVafh2EpeZoyiTsEhR/
         yy8lygje7LBtxJDuJgu6PafHPw9m+u40MCr/+grLHwlEXXQ3aZdFadWwbvxG+Zx3slqw
         TDbui1SWUXetCEXlZs6XrhdGvCS5aRMQ1C1iLtG0Bf/oxM3fBDk3lp+ZzCWjWXqdhvv4
         m/KiFUo9/46f5iElb1wJGvCqAYb0i3EpCV+jCrmYv8EF5riAAqCz1DdjbAZfy+ONdcVu
         uix2JDIjYSp3GskbtrewDjag9lDpcW4mgoBhtDc4JTJHasTtCrjlx5ge3oVfoMkr6cRZ
         rhTw==
X-Gm-Message-State: AOJu0Yx70LuBG376V6KhS8DaCg771QuYzTWgT9UxW5u6Mqkbe6RcQLHx
	c+OvYbt8HcjcD0SJ0beiDYHJP0E3JU9G5P6kp0jtwWcCOH6uQJqkBe0/cIo3qwu3tA==
X-Google-Smtp-Source: AGHT+IHuH8PiEaoLH/TbCkItTHJMmkVfUQtvECA0vYHrKZX0pijDl9Bg/il6vfVZvYYn7MwdHBqy7g==
X-Received: by 2002:a50:ab5d:0:b0:56b:deff:4402 with SMTP id t29-20020a50ab5d000000b0056bdeff4402mr4067365edc.42.1711375791289;
        Mon, 25 Mar 2024 07:09:51 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7d493000000b0056a2b87787dsm3024770edr.37.2024.03.25.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:09:50 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 2/2] locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h
Date: Mon, 25 Mar 2024 15:09:33 +0100
Message-ID: <20240325140943.815051-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325140943.815051-1-ubizjak@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg(*ptr, &old, new) instead of
cmpxchg(*ptr, old, new) == old in qspinlock_paravirt.h
x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/qspinlock_paravirt.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 77ba80bd95f9..3db5f811260f 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -86,9 +86,10 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 	 */
 	for (;;) {
 		int val = atomic_read(&lock->val);
+		u8 old = 0;
 
 		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+		    try_cmpxchg_acquire(&lock->locked, &old, _Q_LOCKED_VAL)) {
 			lockevent_inc(pv_lock_stealing);
 			return true;
 		}
@@ -211,8 +212,9 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
 	int hopcnt = 0;
 
 	for_each_hash_entry(he, offset, hash) {
+		struct qspinlock *old = NULL;
 		hopcnt++;
-		if (!cmpxchg(&he->lock, NULL, lock)) {
+		if (try_cmpxchg(&he->lock, &old, lock)) {
 			WRITE_ONCE(he->node, node);
 			lockevent_pv_hop(hopcnt);
 			return &he->lock;
@@ -355,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-
+	enum vcpu_state old = vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -372,8 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
-	    != vcpu_halted)
+	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
 		return;
 
 	/*
@@ -541,15 +542,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	u8 locked;
+	u8 locked = _Q_LOCKED_VAL;
 
 	/*
 	 * We must not unlock if SLOW, because in that case we must first
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
+	if (try_cmpxchg_release(&lock->locked, &locked, 0);
 		return;
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
-- 
2.44.0


