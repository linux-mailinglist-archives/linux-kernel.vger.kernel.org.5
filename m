Return-Path: <linux-kernel+bounces-141529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BA8A1F70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F3B1F2B18D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190F3398A;
	Thu, 11 Apr 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIzXNkt9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572F134A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863412; cv=none; b=XzMzwhYEssQ9eOOFW7sKOgkNZVVXo+XywSflb/5KCgAHAZQo8haBTPz8+wbN0T5Kdp4pZHOPGBgqoaTDKVAFB7UrweC0bqyP6jrh0slIF0F8u3vvxAPqTqRPGnB0zYGySzf5EJ3wcgzyq+yIc892IOEjLYVMf0c487AfQxJss3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863412; c=relaxed/simple;
	bh=mmKLAGO1ChT4QaOPJ4C2nKflXfyPkDU7/58x9YVgZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZwBJJ1WFRqLdqBjC/0mk7w5vKhbHtSv01maHqkBiwp0mFvG5hWzi1HEKJwfsn2bT11dDXNnVvmfRqCJAS6U8YAniIkH/yigchvkW/zw8pzWUiyQvrFsMbLvU4/utQgZak1l2NfPq33wCNtn7SaSxBz6sEYBHcwBmMLAhJ9TF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIzXNkt9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d6898bebso210126e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712863409; x=1713468209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdtmvV5oF4PyQpeOVZMdyH3WAHAWgd3AepjEjFobbOk=;
        b=cIzXNkt9DzhPyJUx6TgzKIpVBJ8EsOqyh1ahXRbD+Tiyq/hP12jLMGo0vRHrOM/oRa
         sfqbdYSt5yX2E42/J+xI6L2z3FvamAf8/JdzP/uLrRQ0Kla4EgoE1fJSofYfcCAteIXb
         svMiD9EoYei75zcrwV5DBNX0+Pvg++LegRl7ni85zqfAXd/UEabqA7uc5e6AEu/GLdUz
         iIN/jVpSoog9InvHDMAC6S7wMC0g+ciWIUnLm9OAPMjj+GMbPVHHk5XCOKeBbouGUNAP
         x598vvqQAvav6u2HXHO0GzYdqeVWpwsr7Y/hWidpXF8ewnlJXsakO4dU0nmZh2ZjJ9a5
         pnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863409; x=1713468209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdtmvV5oF4PyQpeOVZMdyH3WAHAWgd3AepjEjFobbOk=;
        b=jpk9BTUpzvTRpslmIkHtbsBqQAl4k8Jk961TJ/4+2FzQYJIJ8gWpvQMhu/xAU7rl+Y
         yk5M5ZW+m9/xqadlov/8uJ1ltVI9PJphEfC3fc48O6mte4mCtbQ3wwclFVFhoFI3fXFM
         U6NNt5/2kSf7jT6PSsXCZj74XdIEzTYj4ZeRqB3mu+6yxFCVu/J4zwcOAn2ayNv7+sjd
         QjvApaLLv74uZb3QvuiyNWb9PSumOzEFcQC8dx2CAlAKh8/DTCWthRpAz9EjBUDo0iYm
         JfTlFqPbxaeaffAb5E+JE0HxB2stuq59aK9X9W1P4YT3iOkZ5g0RjuHDYmHEo9BOKFF1
         eJIw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+rlvTNqLyfs5E6Ym1mMameEf2AmE1uJHp9VMLaiv9Wv0kwiEP2EU5hEFU/balPgm6QHy5NScvjBXcLM0Y1/BAw53seBesc0dnSKy
X-Gm-Message-State: AOJu0Yz513Z85paoh5roQdAcZCUTsV4F4xEQLUBoGuYZhe9fBDxU/XUN
	2LfXRx8gdE98qJAFRfG6utV0DkZP4z6zGxBdTat2y1Bhij6vUDPG
X-Google-Smtp-Source: AGHT+IEIVFoFFd2SmN3NWxo7as05KjEYPHvLXNcnbtzrEvLM+J/Q011I21DldaRGt5SAkVTrTN6EdA==
X-Received: by 2002:ac2:518c:0:b0:515:c0ca:d9e6 with SMTP id u12-20020ac2518c000000b00515c0cad9e6mr410397lfi.38.1712863408791;
        Thu, 11 Apr 2024 12:23:28 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170907940500b00a518b14d6cesm1026406ejc.172.2024.04.11.12.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:28 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()
Date: Thu, 11 Apr 2024 21:22:54 +0200
Message-ID: <20240411192317.25432-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg_acquire(*ptr, &old, new) instead of
cmpxchg_acquire(*ptr, old, new) == old in trylock_clear_pending().
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg.

Also change the return type of the function to bool.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
v2: Correct cut-n-pasto in the ChangeLog.
---
 kernel/locking/qspinlock_paravirt.h | 31 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 169950fe1aad..77ba80bd95f9 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -116,11 +116,12 @@ static __always_inline void set_pending(struct qspinlock *lock)
  * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
  * lock just to be sure that it will get it.
  */
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
+	u16 old = _Q_PENDING_VAL;
+
 	return !READ_ONCE(lock->locked) &&
-	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
-				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
+	       try_cmpxchg_acquire(&lock->locked_pending, &old, _Q_LOCKED_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
 static __always_inline void set_pending(struct qspinlock *lock)
@@ -128,27 +129,21 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
-	int val = atomic_read(&lock->val);
-
-	for (;;) {
-		int old, new;
-
-		if (val  & _Q_LOCKED_MASK)
-			break;
+	int old, new;
 
+	old = atomic_read(&lock->val);
+	do {
+		if (old & _Q_LOCKED_MASK)
+			return false;
 		/*
 		 * Try to clear pending bit & set locked bit
 		 */
-		old = val;
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
-		val = atomic_cmpxchg_acquire(&lock->val, old, new);
+		new = (old & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+	} while (!atomic_try_cmpxchg_acquire (&lock->val, &old, new));
 
-		if (val == old)
-			return 1;
-	}
-	return 0;
+	return true;
 }
 #endif /* _Q_PENDING_BITS == 8 */
 
-- 
2.42.0


