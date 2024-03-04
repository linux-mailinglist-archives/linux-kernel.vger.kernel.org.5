Return-Path: <linux-kernel+bounces-89995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590986F8BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C27DB2133B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D896611A;
	Mon,  4 Mar 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HwXbhoP/"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244F46A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521260; cv=none; b=heKGM9MnzXtdrIZuE2o/d4+4LRJvwWZqoNo7MCjW9quh9ChCXvO0VTbiCfI41qu3OL+VQh8BzTy/Ob/ZJLRUFlDKgmeJ8Quqq2UpQFAXq7XWnyycuQqw2yL0J3wcGmlKPYqO7cGprusB84BYqbjJv4u6IZOtycjJvsCLOEcfGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521260; c=relaxed/simple;
	bh=NJJDtRbQFVy9snM13IFsjlCr4VllPQo815+e3AACI9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvPEB872rAG7oI+eXA5NrdHGpFXwwMaDKrkpzEgshxzCfLlNddpOwBpTkUquTo6Tl5ht2gtPDjd3IgM2VvfemYojtOlE0A7X4Nym+mFNqbgjem6l1pK7na/TDJuzWLGheXj2xfeyKm3qPAuLcfGhAbdhV6O8Qr9Su/okgRoHvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HwXbhoP/; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709521249; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aS+J7p3RRwOja5dl+bHJ8Sx7YM7f9k8lwlebgVQqc1c=;
	b=HwXbhoP/Nt1vkIL1yFn6vQ8JdleTKD/+aaVtYz1rygubzTtVCBJm2/oAvIOZvDkRmC64xcAOLAN0G7UfSlbYpS4Jcyv2wjKWEo6DocQZIkJbY0DZosF9q09ifixkBhCFnEHYFmqQxwVvBNlZR+XXgOSarfKOQoQVoIkpsm5f2/0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1i0XUi_1709521242;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1i0XUi_1709521242)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 11:00:49 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 0/2] sched/eevdf: Minor fixes for reweight_entity()
Date: Mon,  4 Mar 2024 11:00:40 +0800
Message-Id: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the discussion in [1], fix a calculation bug in
reweight_entity().

[1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/

Tianchen Ding (2):
  sched/eevdf: Always update V if se->on_rq when reweighting
  sched/eevdf: Fix miscalculation in reweight_entity() when se is not
    curr

 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.39.3


