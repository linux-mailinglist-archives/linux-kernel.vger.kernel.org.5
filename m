Return-Path: <linux-kernel+bounces-39481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9782783D1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289EDB26CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21222816;
	Fri, 26 Jan 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z18Yng7v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596E387
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231027; cv=none; b=OeU5R2ftb2qqau0jFJ47E2YswlHoQ6oZ/BOQW5rgv+X0KUHR4qtnbyQwkgIBa6r7J/+7M4g12XE2kPPd1CR6hC20bh9RV86NNseSfIMBUTuXkUvww3rbMfG6hECIjPdGOe78+6+8JJdXzh8770cNjrJDRxiPL94gDePELDxSjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231027; c=relaxed/simple;
	bh=x/Fy+vSOe5K6cda9CrIqHXqxQHyuV4PgLwTLhmMnB/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwtyQxQmiqhCmPXNSOadfjow+5nuAN5aiz/NF76bJc3avTSPfP0XusCBfVI2xvt7jD54Qnenko2Ojx7sLqko3Aax6Hnt/5f60Ka2JTV7yh89QRnfgQsMXLFJETVSs2LFltU29CZG/lKvIpZys0BYvNhWYvLWbsIh7AXbqL/8/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z18Yng7v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706231024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZcInKXV7VZ3Z31/jYrVlsMNVE9JbQ5TlQGqxeiZxuGM=;
	b=Z18Yng7v6n0IE70D8bMLBy826YUL7r7Z5gacF7H8fPNkwCH31f8Xu2dnSGY5Voyy4zpIYv
	Du4hXP8ro3/560LNnDQlJwukzdhTmHQBMtEWpU1pdLEXrARL7sz7F7YWJbu1W/QJ1weOWX
	izKKo+c/nmPz8GAB6QkZYubtzSio66U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-RQA6yt7JPiyRJ1S7ZPKHzg-1; Thu, 25 Jan 2024 20:03:42 -0500
X-MC-Unique: RQA6yt7JPiyRJ1S7ZPKHzg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6805a03aeaeso1681936d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706231022; x=1706835822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcInKXV7VZ3Z31/jYrVlsMNVE9JbQ5TlQGqxeiZxuGM=;
        b=WfkAFSg01p1AtKdfBPUqF6mBtIU/fFMJkzShfHbi+aOxY+Ty89Ik9JcTMXwRllDOEc
         0WBE+zFQzwiCAsceMXpiJILu/BBVK5fA14z0Q/GSrULHWKUlfU2hBic2Uu84S9hra1XF
         ZY3pnTzMHW64qUmvK4sCniU+MIG3yj9vqysmXJRoPLQ2z+L7HJoW3kGCzGGHIn+qbzql
         f8Jl4Cni73t9z0utAglICQfGR23wHKDEGADzYrsCKmZ36egcAOcZiC6CtFosrzeJHSAH
         mXlkeWa8VVcDY/+lU5E9ZWbvv4CjeiSF9tneOwXROpL1fHTJCYbCcgwQDV/K/LvpNThi
         JnoQ==
X-Gm-Message-State: AOJu0YzTcio4E/MGDvFkMCtn+gu4fz6Uz9/Tug5eRQ/JcXeASxJXcAY3
	MEQPg1QWFES6tSrp1ZJHY0xhHiaDs6Y5Wo87HzWd+OlfkTJFIcKFtQ/jNUAXQ0pxNE9Zt3GmRGz
	W96vEzNbUzy9hBH7vp+Z239vZBHIbM5HNsj7nR2j1ix55UwKCh/cjySk8Lz/opw==
X-Received: by 2002:a05:6214:1bca:b0:681:7d2f:cdb5 with SMTP id m10-20020a0562141bca00b006817d2fcdb5mr653699qvc.127.1706231022300;
        Thu, 25 Jan 2024 17:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcvKD57NT81CBh6p/oYysWYTDBnODoEmvSM3GI2USlRKkh0Whptov9w01cen3pCzg/zCoQzA==
X-Received: by 2002:a05:6214:1bca:b0:681:7d2f:cdb5 with SMTP id m10-20020a0562141bca00b006817d2fcdb5mr653687qvc.127.1706231022058;
        Thu, 25 Jan 2024 17:03:42 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id kv2-20020a056214534200b00684d2729709sm59553qvb.85.2024.01.25.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:03:41 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Thu, 25 Jan 2024 22:03:20 -0300
Message-ID: <20240126010321.2550286-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __queue_delayed_work() is called with WORK_CPU_UNBOUND, it means any
cpu is able to run the work, as well as any cpu timer is able to be used.

This is not good if a system does use CPU isolation, because it can take
away some valuable cpu time to:
1 - deal with the timer interrupt,
2 - schedule-out the desired task,
3 - queue work on a random workqueue, and
4 - schedule the desired task back to the cpu.

So to fix this, during __queue_delayed_work(), if both:
- Work is not cpu-bounded,
- CPU isolation is in place,
then pick a random non-isolated cpu to use both the timer and the
system per-cpu workqueue.

AS an optimization, if the current cpu is not isolated, use it's timer
instead of looking for another candidate.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
Changes since RFC:
- Do not use the same cpu from the timer for queueing the work.
- If the current cpu is not isolated, use it's timer instead of
  looking for another candidate.

 kernel/workqueue.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed8923..0a85b00bbe52d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1958,10 +1958,24 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	dwork->cpu = cpu;
 	timer->expires = jiffies + delay;
 
-	if (unlikely(cpu != WORK_CPU_UNBOUND))
-		add_timer_on(timer, cpu);
-	else
-		add_timer(timer);
+	if (likely(cpu == WORK_CPU_UNBOUND)) {
+		if (!housekeeping_enabled(HK_TYPE_TIMER)) {
+			/* Reuse the same timer */
+			add_timer(timer);
+			return;
+		}
+
+		/*
+		 * If the work is cpu-unbound, and cpu isolation is in place,
+		 * only use timers from housekeeping cpus.
+		 * If the current cpu is a housekeeping cpu, use it instead.
+		 */
+		cpu = smp_processor_id();
+		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
+			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+	}
+
+	add_timer_on(timer, cpu);
 }
 
 /**
-- 
2.43.0


