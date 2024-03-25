Return-Path: <linux-kernel+bounces-117208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E07A88A8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB721C61077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C57148849;
	Mon, 25 Mar 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K37zVjCr"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F64148843
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375791; cv=none; b=ULmKOVOBP93QHAz8CiZ9boGaYxCibf+3altm9HsSEvt9ypkJFvhO9MN677jg1NdDfmEowDupVfhQpK1Mq8Jxi45rG0pQCtyLU4H33MA3IZLxVKVP7FyrK7CAxNQ+6PeMpigOvD3Q+a5NVVsWd5MXEKOopftJSIHveMtm1mEZvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375791; c=relaxed/simple;
	bh=ymG1qqXhgn7PW2wlFsfcg/8Hr9mUZn9evnux5+viqF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQAIaRpBVrtkTInFEUlST2SLUiC2QS3pqPrc9hw3RqOEpEz+Cf+aKGE1fpuYyUeRm+f+BWr4yIdbpKsDHKuhn2rVq4TdoElFu5dL4RHlwjYvNxxLGkDC3N4ZS1NgtyNXeBwGoZaIQlhEAsW2GyiwGmL4kLi2I3YtOy6Tm81twQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K37zVjCr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d4559fb4so5889572e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711375787; x=1711980587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7EeTI/Qnw+b7WxNi/qECrvz/kx6GyUB+cBmx/R3mAc=;
        b=K37zVjCr7JomHmcAWn6yC9y2ZJbUG2+2LAPNlqUYNthG5JaxhgUzp6vg6swQVlH9yw
         ltJXuv3wePttlWWUI8EQMeiIquK3b6REexGbQPzmbaCfxvcXS1b5ySXhnjKvXr3G4KxV
         Fnh3VxFfHB5PsIX5okgypKNyz7HiCXrZAKZvWQesDJalu19GigH+q4tqy5y3ghrGzEiV
         PVGbB14q+vM00h0BxWeGYmA8QotK1StCfaefHpV36n0PC8SU4MmSxBF//Zhe9zSZYi7w
         V4ICa3TM2Cb4OYLSN1a6oAf/inVvzNBo4BS3L8y/qu3BJI+qJnP3auy4/64gG7t9vQmN
         /yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375787; x=1711980587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7EeTI/Qnw+b7WxNi/qECrvz/kx6GyUB+cBmx/R3mAc=;
        b=wwpmTQprw2ZpCBljN+U0CIQpnuX2cMJB3Ixux5p3bsFg6KQpJQk6cTiJgy4eb+n9Ou
         5/NT0CaOANNNunSMpfBZH0mkNt9ETtxqPTU0DhWkC/eo4kYo1u5nZ982Zj1Rt2pWFe4T
         GIPZbgheHTYs0H+wBpK+PvXXIoQx8W67ZyESUmm0+kAi2uXaG6rUXNN8FBtz+60spvzL
         /5KHEX7ISK+vkciFJgnBEmc71SUdF/wvPgAQXCgy9j++0p9lr4Wp0zm0UsawcmYqxjWo
         hYag1C/XK1dsFZB8+hV7qxPHi5UkzdLmn6iSto3r8PQ8Gybn88sgfsqN/VVAGkgTnj8G
         Ybmg==
X-Gm-Message-State: AOJu0YyambGmylyj3+lu2yHVq/sn7+UoQPz0HyxCKZzoJkItvZzBbq2s
	4vUnS3glg4BM6Qfpisw/cjD6yBwWgR+P9hh7lx88GJ8GGpkulXq/v1QZRmNypmG3jA==
X-Google-Smtp-Source: AGHT+IGKvduEKjvO/xhe3qvqUL8yUjmsVSJFfxutxbvEq7FaaCIjowWGirrhFI31JYbdnEWLVATC6A==
X-Received: by 2002:a05:6512:3257:b0:512:fab6:6df6 with SMTP id c23-20020a056512325700b00512fab66df6mr4825242lfr.4.1711375786693;
        Mon, 25 Mar 2024 07:09:46 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7d493000000b0056a2b87787dsm3024770edr.37.2024.03.25.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:09:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 1/2] locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()
Date: Mon, 25 Mar 2024 15:09:32 +0100
Message-ID: <20240325140943.815051-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg_acquire(*ptr, &old, new) instead of
cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg.

Also change the return type of the function to bool.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
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
2.44.0


