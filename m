Return-Path: <linux-kernel+bounces-43703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803F84180C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF46B21D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920A2E40C;
	Tue, 30 Jan 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx6ru7LU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E12E403
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576482; cv=none; b=pAgNX12W/kDiSsaRfdTSZSCVssWFjRA+sS1DpK5Aju4u2xh62FtCGRRXOC+YiEk7fA0YsfMFPbnv2Gow8pZ95XvGPqpE9sY5oByCsSbTbdNjNEJFZqfnv00a10yNf/vha8qhgn+u+1c+c47RiHBpFdN+42FFhrh4pDwBOuv5fBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576482; c=relaxed/simple;
	bh=1LGEO7I1BqruecxFtj7rpE8e2oy/VyosnmAQNqB7h+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFjA1qGUZrvt1vrV2IbQvvka+NHQ5R3mRYVA8qqlLxlkAVC/5UTBQDQMNnyUtjnBI41/Dd1vlxVy53j1yBQExzXrL4yNG9cOx7yNRGZAOjnsmn8rOKUaM8LmWmLtYxkE+cGRdTJPP8LERMPO0EE0/ordmj50gpmzAGIchzjhvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx6ru7LU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706576475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bDV0d2K1/adHDmTgUutNz6jKT+pZG4kv9THTh/fStTM=;
	b=Kx6ru7LUk2PFUHm53qbaG/hjM9uzv8TkPyiGsGTSw8xORw694ingSQwf4nawaXvpsM9FOn
	5ItngeBINrMq97AJe78uY0Wa4fkSgqv0kWaNkroIu5+sf9iGqd8pxLsfrlaqUtJNgc+lwk
	NElUA220mGRrKetx8reLsfeUHKOLqnQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-RmblI2dLMKyOF7ec2BlkCA-1; Mon, 29 Jan 2024 20:01:13 -0500
X-MC-Unique: RmblI2dLMKyOF7ec2BlkCA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-783fb71911bso289925885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576473; x=1707181273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDV0d2K1/adHDmTgUutNz6jKT+pZG4kv9THTh/fStTM=;
        b=Sny2613CTSA3LRWiAANu+mqnGI5QHt6QtSohgWVhRk5USLU5ylIm2R6KVzcNyRvIv9
         1JiBbxV/XFGqWVB3y4yIdjX1TEiglLwR6qUblYD5iCTXoXoVleKe7ifLK6WwVs6wZHCX
         aIZA08J9wjLqYKMgRKVp44F5VNFMnjN7YbGQ3OugWbzxYt1cvYSeOxUmTSDRfNeHV83/
         3BishQQoWtpqpsCCo8sAObY+AHqDXnxM18om5kPP36LqYM3bpxFucL4zgvUdxGdOp4lX
         PXk6NUJksdEeIoeVF0DCkaZg4R9AIle2YQ7q8MGEC3GsdbDXH24VZIqiFI8fw5miUlFT
         290g==
X-Gm-Message-State: AOJu0YxNiJcqHmpiVBWj+6PnSCNC8gfrAIAEvDipQTGEIyLjGYNOdfx+
	8sOVJibcJ4I961+H2GIGcpGy2rdWUTdQiaD0+xq9M6vPZzvS/Wbnf7ololWLBAsmnx7leXEcEzY
	TuZLwMYRWMxTnekuBnbBEyzDgmY5y7A+6X1E49/7K2ZyGOE5ozYx+SwyrRZpjGg==
X-Received: by 2002:ad4:5b87:0:b0:68c:5573:2280 with SMTP id 7-20020ad45b87000000b0068c55732280mr1931014qvp.127.1706576473121;
        Mon, 29 Jan 2024 17:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUwW+HeXFE0HKQPfewWEjNN3w77Hr42tO0N+qqvIuQpbJaAx6b83YjN5V91qQKemNeXKWAbw==
X-Received: by 2002:ad4:5b87:0:b0:68c:5573:2280 with SMTP id 7-20020ad45b87000000b0068c55732280mr1931003qvp.127.1706576472903;
        Mon, 29 Jan 2024 17:01:12 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:e70d:8905:313f:9514:fada])
        by smtp.gmail.com with ESMTPSA id mb6-20020a056214550600b0068c5e3d86bdsm205718qvb.48.2024.01.29.17.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:01:12 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	Junyao Zhao <junzhao@redhat.com>
Subject: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
Date: Mon, 29 Jan 2024 22:00:46 -0300
Message-ID: <20240130010046.2730139-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __queue_delayed_work() is called, it chooses a cpu for handling the
timer interrupt. As of today, it will pick either the cpu passed as
parameter or the last cpu used for this.

This is not good if a system does use CPU isolation, because it can take
away some valuable cpu time to:
1 - deal with the timer interrupt,
2 - schedule-out the desired task,
3 - queue work on a random workqueue, and
4 - schedule the desired task back to the cpu.

So to fix this, during __queue_delayed_work(), if cpu isolation is in
place, pick a random non-isolated cpu to handle the timer interrupt.

As an optimization, if the current cpu is not isolated, use it instead
of looking for another candidate.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
Changes since v1:
- Make sure the CPU is isolated for any value of "cpu"

Changes since RFC:
- Do not use the same cpu from the timer for queueing the work.
- If the current cpu is not isolated, use it's timer instead of
  looking for another candidate.

 kernel/workqueue.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed8923..8dd7c01b326a4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1958,10 +1958,18 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	dwork->cpu = cpu;
 	timer->expires = jiffies + delay;
 
-	if (unlikely(cpu != WORK_CPU_UNBOUND))
+	if (housekeeping_enabled(HK_TYPE_TIMER)) {
+		/* If the current cpu is a housekeeping cpu, use it. */
+		cpu = smp_processor_id();
+		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
+			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
 		add_timer_on(timer, cpu);
-	else
-		add_timer(timer);
+	} else {
+		if (likely(cpu == WORK_CPU_UNBOUND))
+			add_timer(timer);
+		else
+			add_timer_on(timer, cpu);
+	}
 }
 
 /**
-- 
2.43.0


