Return-Path: <linux-kernel+bounces-110617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E153886154
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9642B2262A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA883134420;
	Thu, 21 Mar 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbC2UZpu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE113442E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050806; cv=none; b=didTQI+GrfZHjv4n9jpce694ESy7hoYmzDgxY7XGGc4Qu+/hNi5I+HZhs/6ZJfKDEguXaimPV0pyWNg4f3nrxPQ3fzq9NpdpDvaYek1alaBsolrykKTgW3b+qeHTbqlpFwpn7EfXUBG33x2cN60w7dcMMloJQ95RtL/49Fr8rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050806; c=relaxed/simple;
	bh=nD8cOpq49+66zTur5Rx14smVkvFzE0T/lc1mTbbANIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYqgtlHucBpjxgYdB5M966X59wKx7CNWo23GxPye+/+Ia4TEEEoR0D9Nce8STumrP51LVhbYB7FHmt+7yXC7Rj2XcwQI8VNSWtccccT4wWqx34++hJrpgwe9AZCHiK/EBcllE7PAbKgQV1sgb4ZZHb+MK39TQG2r/n3ZpYPoAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbC2UZpu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146f2bf8ecso9818195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711050802; x=1711655602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWCv4bEtMtvoPMEGevXwNgVJxevtU1V2OzneMTeW1s0=;
        b=DbC2UZpuMxbYX7kx+3QwVSFzBBiKD655onNOe7GtsuZsdLDVD3lnooxrUFZlwrnKZF
         6gKtIXeVJZyIFW++sxG62nV6ulhsmzDwW0GRbH5zJrIgmUnTCUAJXTa7dbOjDz/5SdDj
         m0f7KmPeI1opxUJHPcXX9HNDmBPlysGuB6iZogCv+jg9a+Hrcbl7vU+BbSq2B2rQsR0Z
         C1z/INajr1y+noCWG4suwq1DSicCnTzopLQyihb6t4Xu01OBAFqLFv6PAgaJz3Tio1/h
         w8SEk5qQFOPHyWYiJ7xt93TyvGeWup/D8RMB0S4i5PNv9NmgVchqoEyeD5ImZNGuLY6Q
         pXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050802; x=1711655602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWCv4bEtMtvoPMEGevXwNgVJxevtU1V2OzneMTeW1s0=;
        b=eUTNlswkR5Fi72ebSjWCr8BgtKOjk2C7s35hS2busuuIkNVAma4dy9Uoz63Q0PSrP+
         TLkW3p0K8AF20uMU7uZfi66vctn33LKp6dMRkriu6LqAFj3k3fnfpW6MY9yb5d5w3WE1
         Llx0k2SJe8u5LcetnDhhfhXX/y9BoQNWRL7L+1Mx5SKCegDMTFmlwP34tM+LXrcGU121
         WQZMFbImyjwQtvfAZk5dH2yELeuCAFSHuuRtv5H3GA6/JyCwaRwTcAv1kfcCpRxPwA6z
         jCObsWfSevH0zwnV1KX7/9dSxElgcqFXjIjNzFqkoXZofA4mhgsePkufhB7fIhIaE6lS
         i04g==
X-Gm-Message-State: AOJu0YxR8Jz/bQadDEyxPwtpp4uJd4xjNljDhxnpLpgABXn2mC7vFoMY
	oWwc+utWRYMMPvIzqiirDf7hvPlx0RfUGi3V/JsE46mhwm8nyO+93W+oRlRo
X-Google-Smtp-Source: AGHT+IEUs5lD9yNsBYQVWu4tJ6B7NxF6YLFedFsTLMUPYCnNirduu3mjEFZEDMun2hXs79+v+oY4VA==
X-Received: by 2002:adf:e391:0:b0:33e:737f:9363 with SMTP id e17-20020adfe391000000b0033e737f9363mr85099wrm.70.1711050801793;
        Thu, 21 Mar 2024 12:53:21 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dj9-20020a0560000b0900b0033ec812ee0esm339613wrb.71.2024.03.21.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:53:21 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/qspinlock: Use atomic_try_cmpxchg_relaxed() in xchg_tail()
Date: Thu, 21 Mar 2024 20:52:47 +0100
Message-ID: <20240321195309.484275-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic_try_cmpxchg_relaxed(*ptr, &old, new) instead of
atomic_cmpxchg_relaxed (*ptr, old, new) == old in xchg_tail().
x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/qspinlock.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..1df5fef8a656 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -220,21 +220,18 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	u32 old, new, val = atomic_read(&lock->val);
+	u32 old, new;
 
-	for (;;) {
-		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
+	old = atomic_read(&lock->val);
+	do {
+		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
 		/*
 		 * We can use relaxed semantics since the caller ensures that
 		 * the MCS node is properly initialized before updating the
 		 * tail.
 		 */
-		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
-		if (old == val)
-			break;
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
 
-		val = old;
-	}
 	return old;
 }
 #endif /* _Q_PENDING_BITS == 8 */
-- 
2.42.0


