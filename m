Return-Path: <linux-kernel+bounces-45751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF08434ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C671F2547E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8163D0B9;
	Wed, 31 Jan 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2eALLQD"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347693D0AF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677296; cv=none; b=cvEbSgZuDRNSWjePeT+4JwhhFsG8owWbVP3gvfK+JD0T3L2YK0Lew0JW9sChlfn0mzJ28hRmlP8WugUDZ4Qlwm0H2JMqW2umlbOfQ/umVpas6JUBzltvjhA/AEYneO91RFHp4ufAqQfswZnQkQNh5O6T6oXo8wN4iX2vnadqrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677296; c=relaxed/simple;
	bh=zbNco60F0Bo8Nkqj220inUtOObLoKlsToXEJ+dIRm6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqio1GcL7XpHAZsPpEAqpzlsEpa9gzZ9rTMk1/BOWmHpyss5Z2kkVIWqpdbKVL0W6qUU7f+Ygr40GIHh5qlyAqB8AbX1UpMuePR65CDrOM/VsAePX8a/khXE65Rqg7lXbIl1ZnvTyboNaRt+jmY7iUmoMFG6ejID7krItUijAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2eALLQD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2709667a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706677294; x=1707282094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzWUkc0mXsWLFULbShXAP97/0EjZAkE5oTGKWjkDQGY=;
        b=O2eALLQDPZ0OOSFcY0LI+WxC+PNtXdB/Yb+sJ9sXk9UBR0D2UCOe7kuDiCU1SgjhpU
         n1q8Spvi9VQblOG0PoEgOTJzSZkBW5twhulzYlQMkSkYNRl40KG4bTIWQ4vFaWuStA19
         q/iMvcfnxfSFWuXvrBhyIeyKk6mN9kNJCtnN13Rt2ORrWQZn9P/hgdM5u0sFhcqAvzLY
         RqeraIts1aA/YqUMCu+bND/LxrKmpNFm8Ug3vjnguKPU1M03O2RPX3FQjwAT36BU7cMj
         iZtHQONarod4ULyfwSGR88EN/AdMk5+qPFsvSvyPV0+KI//WIWJnqDjymIyqhdzUr3Ad
         JIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706677294; x=1707282094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzWUkc0mXsWLFULbShXAP97/0EjZAkE5oTGKWjkDQGY=;
        b=bchbZUbRv3kc2ij4E21V0BWIzlXUeXIsh9Cjh05P3HoUVEwOdaok6o5zwYcpEJPddj
         pHHnEUH5dE+duVGqQohIy45pbEfO+d6y+O1nZmqw/45VocC/TqjM7mewSw5tZ3hSIRAs
         r+rJ43T19Bjc2Z2eilHuHI2gviXC+SNQh53Y5Ua5YLdN9NllkSirz1SYGeOQTQF7m0bL
         QeLR53x+bPeGXp0uWiyv45mDiiQBpW4MMjr89YHGGehT0QkUg+QfjvXfFl65gzrkb3db
         PdgZ0e/XFzmse6l0ybxpgJuG8DpNMTSWEcaz1tPn3L/w+B+xMWN9zhu2RtRwQL0K0sil
         i+KQ==
X-Gm-Message-State: AOJu0YyXIO+k43LFLH0lqCd+EAjL4PgUjuHIaBDv7VGt2TO3Kyss1ntj
	GrMakqNlOIwQ+wjhHED1Tai0tG3CQAxPWHq1TDEtRyzyXg1m1OHp2h5fWRiFZ6A=
X-Google-Smtp-Source: AGHT+IGEoZ7vkPoSCvbIxARPaDP+L1VKPa7BTJn568ecMi5Pg8akd6oHnFhIJqzKvwAiBN35YGpp4w==
X-Received: by 2002:a17:902:cec6:b0:1d7:8cae:a5e2 with SMTP id d6-20020a170902cec600b001d78caea5e2mr659284plg.69.1706677294188;
        Tue, 30 Jan 2024 21:01:34 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id lh3-20020a170903290300b001d92a2b258esm466122plb.118.2024.01.30.21.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:01:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 19:01:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbnULGnVOtA5Zdl9@slm.duckdns.org>
References: <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
 <ZbnIzqmClhAvPxKC@slm.duckdns.org>
 <20240131042031.GA3946229@dev-arch.thelio-3990X>
 <ZbnLk7pZbcODRNER@slm.duckdns.org>
 <20240131044254.GA802495@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131044254.GA802495@dev-arch.thelio-3990X>

From 15930da42f8981dc42c19038042947b475b19f47 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 30 Jan 2024 18:55:55 -1000
Subject: [PATCH] workqueue: Don't call cpumask_test_cpu() with -1 CPU in
 wq_update_node_max_active()

For wq_update_node_max_active(), @off_cpu of -1 indicates that no CPU is
going down. The function was incorrectly calling cpumask_test_cpu() with -1
CPU leading to oopses like the following on some archs:

  Unable to handle kernel paging request at virtual address ffff0002100296e0
  ..
  pc : wq_update_node_max_active+0x50/0x1fc
  lr : wq_update_node_max_active+0x1f0/0x1fc
  ...
  Call trace:
    wq_update_node_max_active+0x50/0x1fc
    apply_wqattrs_commit+0xf0/0x114
    apply_workqueue_attrs_locked+0x58/0xa0
    alloc_workqueue+0x5ac/0x774
    workqueue_init_early+0x460/0x540
    start_kernel+0x258/0x684
    __primary_switched+0xb8/0xc0
  Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill the idle task!
  ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: http://lkml.kernel.org/r/91eacde0-df99-4d5c-a980-91046f66e612@samsung.com
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
---
Applied to wq/for-6.9.

Thanks.

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9221a4c57ae1..31c1373505d8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1510,7 +1510,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
-	if (!cpumask_test_cpu(off_cpu, effective))
+	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
 		off_cpu = -1;
 
 	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
-- 
2.43.0


