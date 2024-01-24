Return-Path: <linux-kernel+bounces-36636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471883A424
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105E6B24B21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E12171C9;
	Wed, 24 Jan 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDpalqq6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202A2F3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085026; cv=none; b=lva4GTMkK8Fz/p4zrQ1BV5vkp9Ycn+2l3U6tjEzitrIWzKcw6v+cL3APEcJfZ8Dd1t76uYCC8vYHnsZkw7LrHo7o3EqeKoRiLSR0yT++uZ6slR3Y+3eKs4OXA6fUo9hGfXFif0pCvZKP/5CPg3Wgv0SbDH3W10v9O8+qEYu2NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085026; c=relaxed/simple;
	bh=ZKsH2VREsO19/Ss18aLaVOH/PWpISvXjzjfUPgj1H/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIV4fZGtgMI3loWwIYPe0vCotNAz3mFA/ZSOfNTKiTi0emPYksRlqgB9Z39PnOCogbHut9Gsoy0Bjusmv4ZBy1TAhIYpsjPAyHWUL/3GiKZgjcJyISjcBvB2EKWi2YhtYqE1soHdBPWFsPxIIWi8+vlbx1RgRLRgmZv5SiKPIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDpalqq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706085023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TNoxPybDnpkJWKABzryLmZgP0Fmh6igqY9ezgktqVMM=;
	b=FDpalqq6hO9fN/rLU2gH1siZEFCN8qQ5dhaRDLw1v3xSzzw1NFEFqlTKTYovF8ZLbb1AzY
	jGYUPPR/HRXs8Dr9X6RcMgC/8kVBxH9yeoZe5y2JPsvN9nkigdf53V9On8AvXcPwaleebE
	lvww6RvfRoCg7BVIRR/H0ffrrDUb6vY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-eRO5HtwWNzKq86K5nKV80Q-1; Wed, 24 Jan 2024 03:30:21 -0500
X-MC-Unique: eRO5HtwWNzKq86K5nKV80Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7831bc14ae3so794993085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085021; x=1706689821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNoxPybDnpkJWKABzryLmZgP0Fmh6igqY9ezgktqVMM=;
        b=TESjf9XIzicO8+7js855585CidE6ZtHj0EccAs0JCyMg6V2+MjgRTcEbP98GqWNMbE
         8S0rtO4kczl0pDz0P/FzYAyfI/SaiJIYQzX6Rc+KNNOROGziykTb0KvasdLv5iyJPyj8
         4a4HCElpv2haB6G1Brh8TSSz02u0Morw+0ZEbx/yZ5XprJqweBNRspDtK+a8NTOzRsUZ
         vu1eiQiSWlFiL6XY47Uzh1qWNGeW1HyfoUQ+zjKG1bEb4BanuLa0LMaUCu/lEutid+85
         ju5o7x3wl/pZGi0QnrzOH2JbeXsgjECtCAIm4VQ/GpdALxMpQMBV/hKdVK88jx+TveOh
         9GmQ==
X-Gm-Message-State: AOJu0YzXTun/BHh3wcU3a2N6bd6q3fASNpL7w8ljWsJLrWYYDIs6KyZh
	4qzz93uVmsupSaW+Dnb29mAgKEcB5M17jq6h1VEAiOxNBJbn3QxAFEa6q0v7qa4XhJmR6NUmY8L
	f3Z1tT2X1vr/D/ykv9xLZSkyyoDFebnsX1mbFLu4XOTlbuytHP7mqzLywiMsGsg==
X-Received: by 2002:a05:620a:208d:b0:783:930f:e57b with SMTP id e13-20020a05620a208d00b00783930fe57bmr8350553qka.2.1706085021295;
        Wed, 24 Jan 2024 00:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsDa+MqKTkS/2hX7pQN9KwB/1dwy7C2SPrF6fJ6q8TvmFhcLIzZnhzFvmgrddDClhyR41mqA==
X-Received: by 2002:a05:620a:208d:b0:783:930f:e57b with SMTP id e13-20020a05620a208d00b00783930fe57bmr8350544qka.2.1706085021021;
        Wed, 24 Jan 2024 00:30:21 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id q17-20020a05620a039100b007839e82e148sm2556386qkm.129.2024.01.24.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:30:20 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Wed, 24 Jan 2024 05:29:37 -0300
Message-ID: <20240124082938.2527697-2-leobras@redhat.com>
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

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 kernel/workqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed8923..0c50f41d9f95e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1954,6 +1954,14 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 		return;
 	}
 
+	/*
+	 * If the work is cpu-unbound, and cpu isolation is in place, only
+	 * schedule use timers from housekeeping cpus. In favor of avoiding
+	 * cacheline bouncing, run the WQ in the same cpu as the timer.
+	 */
+	if (cpu == WORK_CPU_UNBOUND && housekeeping_enabled(HK_TYPE_TIMER))
+		cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+
 	dwork->wq = wq;
 	dwork->cpu = cpu;
 	timer->expires = jiffies + delay;
-- 
2.43.0


