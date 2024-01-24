Return-Path: <linux-kernel+bounces-36814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA783A72D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCD287F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E019475;
	Wed, 24 Jan 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZQhmHf4"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107ED18EAB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093400; cv=none; b=SsB3ubzrWmkLKryhJStUlUV/S4S2gMKXXT3Y2NzxZkqSw4K8ziFk8lRT5pZsfqDhKyUg0+gkXjI9XmBolCZrsEJpSxZtXIGaMSGk3n0O4YhHVTrs1qgVeQ9WVNAV1M+fQRTAIj4+pcGsBuS4Nrmd6ONu6wJSlVFYxzwqYd6uIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093400; c=relaxed/simple;
	bh=UcaFc8EIqTz9qY6jAeo27IC0jBAoygDu3PVfbmwR4yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzQ8KjY+FGidHU9nw2gyUKbsUyRhbWjxLJplPX84ze/YIAMda9CEwe8ErvZgL/g4G5Ct8sv47hEUG0vygeWrA/bsGAX9vz4gLANig86b7GYzZTnA+1BNjuKZrANh6AWJQfNg60lSaIoAVhShTh8Tkv1K9IoonwuYpP3OP2WAarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZQhmHf4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a31092083acso81558366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706093396; x=1706698196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0pd1IELLeD69KnxOq9DWeNqcBUjNxwkuEsIblWWntw=;
        b=SZQhmHf4uA+J3Y5F9NDQj4b7yNw1rbvSoRlIrW80t+ul44+VGJfIr4xgiZKW2Pzi1r
         dzxJiE6yl54WiyTrJCU3Rr7S5ms+AZ7sAqD9dUdv2CQCnmyzr8iLQo1zgTjgq3CPZg3h
         0nlOQ+s+kGAxBjO5QtrBA7WJzl57Jb8fs+m2Nks+txVINx07SssY7rRvjC46JPijfDlM
         dVr9mSHhrFbA7sx0nmWl8lIK7kHN3yQZlIm0QbG7tKciZVgOIE46gLFeFttAM8PPf48l
         wGxvH63F7wibRqow5S+aDSmD+Ui2NkWNULQFvEeSkEzWsCwwV5PnNGtQL4+YfEGpgKqt
         2Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093396; x=1706698196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0pd1IELLeD69KnxOq9DWeNqcBUjNxwkuEsIblWWntw=;
        b=XgU6NA+jIerCGkyd2r/qlbL0A4u/UTI1jfISjU08GPwn+bJaJPyYk50JsQYH3HMbVr
         15D4Tox4gRjuBphvpVGsxtyZvE9QGeWcJmLm9AGVVXMRIDxiTxvLlRbQbS6u7VdjlKjt
         qyWeKocaqKROqlQjfXXKBZxqE2/75YwE3L3arJvtLctKz2IKxoisDkc4gkMk0cJwpdHN
         w91OqO+IH8rFpIwvBIVVg5dbh7q08C1SocNeKuOFCMpy3/BtIfG4bJrdj3x6Mlb7D0GR
         ibRgoqPlM6OOX7CZMUUabU0234UWx10sL/3o2H2qthBNK2ImAemX5YUUG7QDDIM0euLL
         I3nQ==
X-Gm-Message-State: AOJu0YzRgGTnHa8OfOI8/XSWZ1CANunaLFVc2je2A0NN86byjGbZXnek
	kITfCOB55zFy4UnbQsHRTQHdfyihHCz3whtKTaGuM1nUZDs9tUFfiq/Q9x/qpaM=
X-Google-Smtp-Source: AGHT+IFQiFOPq64XWph67XXSVAD6x1gilNsaeT1pVza8zRGwXJnC3KXKQmac19H7BdKFR/vJu/HL3w==
X-Received: by 2002:a17:907:1112:b0:a30:e14e:5666 with SMTP id qu18-20020a170907111200b00a30e14e5666mr613354ejb.67.1706093396328;
        Wed, 24 Jan 2024 02:49:56 -0800 (PST)
Received: from localhost.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090699d300b00a31318c49c7sm294950ejn.115.2024.01.24.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:49:56 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/rtmutex: Use try_cmpxchg_relaxed in mark_rt_mutex_waiters()
Date: Wed, 24 Jan 2024 11:49:53 +0100
Message-Id: <20240124104953.612063-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.

X86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after CMPXCHG (and related move instruction in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when CMPXCHG
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/rtmutex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a10e8c16fd2..88d08eeb8bc0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -237,12 +237,13 @@ static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
  */
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
-	unsigned long owner, *p = (unsigned long *) &lock->owner;
+	unsigned long *p = (unsigned long *) &lock->owner;
+	unsigned long owner, new;
 
+	owner = READ_ONCE(*p);
 	do {
-		owner = *p;
-	} while (cmpxchg_relaxed(p, owner,
-				 owner | RT_MUTEX_HAS_WAITERS) != owner);
+		new = owner | RT_MUTEX_HAS_WAITERS;
+	} while (!try_cmpxchg_relaxed(p, &owner, new));
 
 	/*
 	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE
-- 
2.31.1


