Return-Path: <linux-kernel+bounces-69125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA298584D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F6D1C219A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC493137C24;
	Fri, 16 Feb 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeznFtxx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DF135A77
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106788; cv=none; b=LfbPtMSyotTR3/dRl3kWPIcsJQ03G0/Lf17FRn6JEMPVt54cayfc/ujKGYvaYb+TVivtsgMCLEAZrHfn9fFsGht+jWV26JLZQrjtMXmy20nN+dpSM/9cMN2cbMQhoVaQtZOA5mwor0w1JIdQW5WozM5OUqMsxmGC0htl5GX5U8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106788; c=relaxed/simple;
	bh=bIcLEIHssCXg2J3Y2ia1/tsZ3YGJRV1EiIfHehEmTOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRRAWOS/Cmbbqggat6+g/OWMkkREM5fNmWapQpdyg1SgXHSG8uKltEoTRfSbNy81QW+pZxHwi8SYxUlM2XQT9dGyougwbBgsT/c9ZFSEC6ivhT5sLbexJFYNwRIFsQcxyxTSeXMz6uvCN8UhA6F/uhvTJCeaWSFIwB//cC44+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeznFtxx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d780a392fdso9993165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106785; x=1708711585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40uXzXSqq0DnD+u5GPsgH4bN6ZTIaIFvK8Qv3W13lls=;
        b=JeznFtxxfTcOzvQuCIb5U9OySI6Q8VfS9TgnrAWArD7PLLiJesM4ELjamePRhFZuZq
         QoSiPweRdQIc9x5NAJMWnWjALNs80k7KciWEpTvGu8c12JXZPZyYrQado9IRnQ/R2b2e
         D0KdLq8FlZsi7sR8eYx78XScO9E9Zo/TYZIWB1qNT+hCvgNRvjTC4bmiYX/goSWEhw1q
         BdpIl1iXfK1ynHQ2ItEfGsc2yUv2QWJEgWQvzATV3YXLrS6v3n0kavR/mHslUe7dwNCl
         6iPm9bHkeiKx1XZ9meNt/EQ3PSF1xbwmwH5+WW1ztGTc+w9otev8Tf3/NT8PcT36Qa6d
         ni1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106785; x=1708711585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40uXzXSqq0DnD+u5GPsgH4bN6ZTIaIFvK8Qv3W13lls=;
        b=OlZmflhJ6gZqlb52EA+eOM2KCZ2FAQhjykp+CljJL5Iy767DCkA53Dw35mAwfy0W+W
         tzpj6Y/u99HMg7iRe/FfkFf+TKrArPZKSF75yX6GSdvCHJSyWfsUqk2XZNKrR3wDHq+Z
         G3RPxvSvNU+zzdZlEYICbdJF0y94lR0RhY4BKlL5VlOh4Ac6SdAIoxh0Cz6MQCAYhsCO
         ovuzz978EcfajRfvnYccdxKVYBXSLzDTNdxspmPaUFE1y32frfEVkC9EKKGqx4wIL9de
         HK8cGa2G1DZgsVGlBKsIL2huAoqM2E24oa41FU9j5IIGWU9dAF5N9++5UZR+9JR4yqSU
         XC+A==
X-Forwarded-Encrypted: i=1; AJvYcCUEcJZlBrGBdzl0ro0YXwYmb9oILgsS237J+DN4B2YZc3khdnnVCFfpudqbhYvOPO1EuRjn1nUoLZFTrj4yNh0UWovfxNN65bhVD9RS
X-Gm-Message-State: AOJu0YwHgg+PmigzSRH0way3DgJ+9gHvwxwM90Z3TuvpmUrzzJavyCJz
	7lMzepi3L746CJH5MmzFRkt79QlNogSJxFsPzEK5jW2k9PckV4FCB6LEmNl4Ygw=
X-Google-Smtp-Source: AGHT+IHWg3J6AMEgG0ZJoSz9sMNHPAIs2I6hP2k+h6VDX3wHF8dj4IJ0PHVXcTWQsyrLhRF2UO9F6g==
X-Received: by 2002:a17:902:d4c3:b0:1d9:cb99:da29 with SMTP id o3-20020a170902d4c300b001d9cb99da29mr7088781plg.14.1708106785546;
        Fri, 16 Feb 2024 10:06:25 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001db6c3a192bsm163016plv.26.2024.02.16.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/17] workqueue: Clean up enum work_bits and related constants
Date: Fri, 16 Feb 2024 08:04:48 -1000
Message-ID: <20240216180559.208276-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bits of work->data are used for a few different purposes. How the bits
are used is determined by enum work_bits. The planned disable/enable support
will add another use, so let's clean it up a bit in preparation.

- Let WORK_STRUCT_*_BIT's values be determined by enum definition order.

- Deliminate different bit sections the same way using SHIFT and BITS
  values.

- Rename __WORK_OFFQ_CANCELING to WORK_OFFQ_CANCELING_BIT for consistency.

- Introduce WORK_STRUCT_PWQ_SHIFT and replace WORK_STRUCT_FLAG_MASK and
  WORK_STRUCT_WQ_DATA_MASK with WQ_STRUCT_PWQ_MASK for clarity.

- Improve documentation.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h | 58 +++++++++++++++++++++------------------
 kernel/workqueue.c        |  8 +++---
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1565bab9edc8..0ad534fe6673 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -24,41 +24,49 @@
 
 enum work_bits {
 	WORK_STRUCT_PENDING_BIT	= 0,	/* work item is pending execution */
-	WORK_STRUCT_INACTIVE_BIT= 1,	/* work item is inactive */
-	WORK_STRUCT_PWQ_BIT	= 2,	/* data points to pwq */
-	WORK_STRUCT_LINKED_BIT	= 3,	/* next work is linked to this one */
+	WORK_STRUCT_INACTIVE_BIT,	/* work item is inactive */
+	WORK_STRUCT_PWQ_BIT,		/* data points to pwq */
+	WORK_STRUCT_LINKED_BIT,		/* next work is linked to this one */
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
-	WORK_STRUCT_STATIC_BIT	= 4,	/* static initializer (debugobjects) */
-	WORK_STRUCT_COLOR_SHIFT	= 5,	/* color for workqueue flushing */
-#else
-	WORK_STRUCT_COLOR_SHIFT	= 4,	/* color for workqueue flushing */
+	WORK_STRUCT_STATIC_BIT,		/* static initializer (debugobjects) */
 #endif
+	WORK_STRUCT_FLAG_BITS,
 
+	/* color for workqueue flushing */
+	WORK_STRUCT_COLOR_SHIFT	= WORK_STRUCT_FLAG_BITS,
 	WORK_STRUCT_COLOR_BITS	= 4,
 
 	/*
-	 * Reserve 8 bits off of pwq pointer w/ debugobjects turned off.
-	 * This makes pwqs aligned to 256 bytes and allows 16 workqueue
-	 * flush colors.
+	 * When WORK_STRUCT_PWQ is set, reserve 8 bits off of pwq pointer w/
+	 * debugobjects turned off. This makes pwqs aligned to 256 bytes (512
+	 * bytes w/ DEBUG_OBJECTS_WORK) and allows 16 workqueue flush colors.
+	 *
+	 * MSB
+	 * [ pwq pointer ] [ flush color ] [ STRUCT flags ]
+	 *                     4 bits        4 or 5 bits
 	 */
-	WORK_STRUCT_FLAG_BITS	= WORK_STRUCT_COLOR_SHIFT +
-				  WORK_STRUCT_COLOR_BITS,
+	WORK_STRUCT_PWQ_SHIFT	= WORK_STRUCT_COLOR_SHIFT + WORK_STRUCT_COLOR_BITS,
 
-	/* data contains off-queue information when !WORK_STRUCT_PWQ */
-	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
-
-	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
+	/*
+	 * data contains off-queue information when !WORK_STRUCT_PWQ.
+	 *
+	 * MSB
+	 * [ pool ID ] [ OFFQ flags ] [ STRUCT flags ]
+	 *                 1 bit        4 or 5 bits
+	 */
+	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
+	WORK_OFFQ_CANCELING_BIT = WORK_OFFQ_FLAG_SHIFT,
+	WORK_OFFQ_FLAG_END,
+	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
 	/*
-	 * When a work item is off queue, its high bits point to the last
-	 * pool it was on.  Cap at 31 bits and use the highest number to
-	 * indicate that no pool is associated.
+	 * When a work item is off queue, the high bits encode off-queue flags
+	 * and the last pool it was on. Cap pool ID to 31 bits and use the
+	 * highest number to indicate that no pool is associated.
 	 */
-	WORK_OFFQ_FLAG_BITS	= 1,
-	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
+	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-
 };
 
 enum work_flags {
@@ -88,12 +96,10 @@ enum wq_misc_consts {
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
-#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_CANCELING	(1ul << WORK_OFFQ_CANCELING_BIT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
 #define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
-
-#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
-#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+#define WORK_STRUCT_PWQ_MASK	(~((1ul << WORK_STRUCT_PWQ_SHIFT) - 1))
 
 #define WORK_DATA_INIT()	ATOMIC_LONG_INIT((unsigned long)WORK_STRUCT_NO_POOL)
 #define WORK_DATA_STATIC_INIT()	\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 317c85f051b0..7c6915e23c5c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -247,7 +247,7 @@ enum pool_workqueue_stats {
 };
 
 /*
- * The per-pool workqueue.  While queued, the lower WORK_STRUCT_FLAG_BITS
+ * The per-pool workqueue.  While queued, bits below WORK_PWQ_SHIFT
  * of work_struct->data are used for flags and the remaining high bits
  * point to the pwq; thus, pwqs need to be aligned at two's power of the
  * number of flag bits.
@@ -294,7 +294,7 @@ struct pool_workqueue {
 	 */
 	struct kthread_work	release_work;
 	struct rcu_head		rcu;
-} __aligned(1 << WORK_STRUCT_FLAG_BITS);
+} __aligned(1 << WORK_STRUCT_PWQ_SHIFT);
 
 /*
  * Structure used to wait for workqueue flush.
@@ -843,7 +843,7 @@ static void clear_work_data(struct work_struct *work)
 
 static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
 {
-	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+	return (struct pool_workqueue *)(data & WORK_STRUCT_PWQ_MASK);
 }
 
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
@@ -4851,7 +4851,7 @@ static void pwq_release_workfn(struct kthread_work *work)
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
 {
-	BUG_ON((unsigned long)pwq & WORK_STRUCT_FLAG_MASK);
+	BUG_ON((unsigned long)pwq & ~WORK_STRUCT_PWQ_MASK);
 
 	memset(pwq, 0, sizeof(*pwq));
 
-- 
2.43.2


