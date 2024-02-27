Return-Path: <linux-kernel+bounces-83728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3E869E55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86690B3257F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9061151CDC;
	Tue, 27 Feb 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfx0uEDe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAA149E04
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054944; cv=none; b=iS/IkYUmC6QXmrEvjIf9bdIzQJwAWXHpou390+VQPIiHniqK92ItF7cEu+cqWxWV2Qmx9BTVgQSZ76v9B3OZfHuyctVwuEFfkWGVfU5I8841rYi5mpnIewgeMO3SU5t7ttWkdWFEwgDNs7KhMYtW/TR5Hc7yzQ47lPUyH1fExtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054944; c=relaxed/simple;
	bh=zxKHR21Jstusr40mSQjWfKjcsE9IIwgkyaIjQBWdGj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHykDAEXIZcKrBt9V+XXrW0+39zM4om1YzGh3sYMzqMUwBJRtcFlfsaKrJA34AUZfxGqy6xDXlUQQoGj+iwbjRo5JO9TlxMERri53C4wfMBdWvwah7sMbzT4a27ufxaeD07+QNNUACWu/qY3stYIyERtKB8jeiQGGpbnNw6OgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfx0uEDe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so3071923b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054942; x=1709659742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3gLZ75DcNCW2nMZ7SozZqVZgwIf3nxHu28BLf6sihc=;
        b=Gfx0uEDeZA38GJIzxfPdkgCvfFxfO9wSVzeeWUts0XjGGWu/m0rzdwmS3RUdMbvif6
         5/q1ZLltU7oAsILUOo9YYjgEDUPx9fWwaY0ihaXTGZgwLSEuhrMnKUH9OUz9EcfsKhdh
         AekFi+08gHTBX8/Q19Gq+CSf+pH+33Nd/ZKfFREcI8LVPBrKknPOlhrlMZeJ5VHTtqVB
         w9c/z+1ZY4ZJAuJbvY0n/laGQ4su+JmToQexjVsi0r1iDJ2HIq5k7ps6WChkF3bEjwRy
         jj4JgD1x51z9OIeBCwy3bZtyrB8R8QAkuPiLgyNO32sLYuPNxkM4EOU0/FXMs/4l5Bh4
         BPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054942; x=1709659742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3gLZ75DcNCW2nMZ7SozZqVZgwIf3nxHu28BLf6sihc=;
        b=gXAYaLrlZavsYlYdpfsrxw+vSW9xpQzOI9gX2XcOQsgxkPQ6aRM/u+XQYK8dG+Ai3J
         fY2HQXU1pO/a/gZP5RYlqBQXn2KybSF4eS07LCugS3Q8FFWp4vIZ60rKYl1k5O4lP0cH
         4scLd5vuZpBzQBvUB63Zbc/C3Mtfz87lJxAt3S1NKFajTDVxod1mq2LmB+dN2bFgr3h5
         di7afF0f0TxfTo+cbD20Xr6hPIXhvp+YjG3XmrPLyN+a6yWeUd1ubDV6MgZ9eZrQPTGA
         lTVDs6XN4uY5ptdDObjNH4oQ++Ti7pRfEbkmUqoJqAasE+xFsD0NBTGp6oI0Wbmj6G5U
         ET2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCt55GMLGub/5me1Qs8nZmeriEWqj+TvQOfImhWex819cSZT0NV7FkdCZ/Mmhgkke/bGI/8vgMYiewl6DsXN6YYTVHNISiNV5MCoGk
X-Gm-Message-State: AOJu0Yw0hz5lY3N815t7Kbc27Ii3AIvb46mqKUWOzSMMeYlK+RDe1Twr
	mYA98HE8+OcQWPYYOxRgnwSGYkUVHK8DYTRS8IYSwKPgjmg5y+TV
X-Google-Smtp-Source: AGHT+IE544My9LSJ1iL/VYimX2ZoUlnzAM3YdyOi1ZP1Ns8jMCYE4V5i4PvrX0zUmHDUNjGqnjeWdg==
X-Received: by 2002:a05:6a20:499e:b0:19e:98a1:1160 with SMTP id fs30-20020a056a20499e00b0019e98a11160mr2342232pzb.28.1709054942600;
        Tue, 27 Feb 2024 09:29:02 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902704300b001dcc158df20sm911695plt.97.2024.02.27.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:29:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] workqueue: Remember whether a work item was on a BH workqueue
Date: Tue, 27 Feb 2024 07:28:15 -1000
Message-ID: <20240227172852.2386358-5-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
References: <20240227172852.2386358-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an off-queue flag, WORK_OFFQ_BH, that indicates whether the last
workqueue the work item was on was a BH one. This will be used to test
whether a work item is BH in cancel_sync path to implement atomic
cancel_sync'ing for BH work items.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  4 +++-
 kernel/workqueue.c        | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 86483743ad28..7710cd52f7f0 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -52,9 +52,10 @@ enum work_bits {
 	 *
 	 * MSB
 	 * [ pool ID ] [ disable depth ] [ OFFQ flags ] [ STRUCT flags ]
-	 *                  16 bits          0 bits       4 or 5 bits
+	 *                  16 bits          1 bit        4 or 5 bits
 	 */
 	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
+	WORK_OFFQ_BH_BIT	= WORK_OFFQ_FLAG_SHIFT,
 	WORK_OFFQ_FLAG_END,
 	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
@@ -98,6 +99,7 @@ enum wq_misc_consts {
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_BH		(1ul << WORK_OFFQ_BH_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
 #define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07e77130227c..5c71fbd9d854 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -763,6 +763,11 @@ static int work_next_color(int color)
 	return (color + 1) % WORK_NR_COLORS;
 }
 
+static unsigned long pool_offq_flags(struct worker_pool *pool)
+{
+	return (pool->flags & POOL_BH) ? WORK_OFFQ_BH : 0;
+}
+
 /*
  * While queued, %WORK_STRUCT_PWQ is set and non flag bits of a work's data
  * contain the pointer to the queued pwq.  Once execution starts, the flag
@@ -2119,7 +2124,8 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		 * this destroys work->data needed by the next step, stash it.
 		 */
 		work_data = *work_data_bits(work);
-		set_work_pool_and_keep_pending(work, pool->id, 0);
+		set_work_pool_and_keep_pending(work, pool->id,
+					       pool_offq_flags(pool));
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);
@@ -3171,7 +3177,7 @@ __acquires(&pool->lock)
 	 * PENDING and queued state changes happen together while IRQ is
 	 * disabled.
 	 */
-	set_work_pool_and_clear_pending(work, pool->id, 0);
+	set_work_pool_and_clear_pending(work, pool->id, pool_offq_flags(pool));
 
 	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
-- 
2.43.2


