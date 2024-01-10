Return-Path: <linux-kernel+bounces-22133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171948299CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E401F22ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BC481C6;
	Wed, 10 Jan 2024 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7jZh31g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BB4A9AC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704887202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZJYdODU3wiLWDtYGGvI8tT8GVp8sktVt/9zuVN5SknQ=;
	b=c7jZh31gepuKYIsXrc9IbKXghnn1PAy9jCdmAZntbFeNG8eSRtWZHpQdpXLk4BCbNha149
	SNxoAEPeUCWB1bF+KSvR6UflFwT5Gu3NR5HfEfzmeJQJ9b0ZZFAsjVUCb53wLXQt44FwGM
	bLN24VfeNNB8bZtD0+LK02WMeKGDA4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-b6ny7NZ1M_ChO9SnTGNcbg-1; Wed, 10 Jan 2024 06:46:39 -0500
X-MC-Unique: b6ny7NZ1M_ChO9SnTGNcbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBD1C830F97;
	Wed, 10 Jan 2024 11:46:38 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E7071C060AF;
	Wed, 10 Jan 2024 11:46:36 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] sched/isolation: Warn about missing isolcpus mask
Date: Wed, 10 Jan 2024 12:46:10 +0100
Message-ID: <20240110114610.1941474-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Since an empty string is a valid cpulist, this cmdline option does not
trigger any warnings:

  isolcpus=domain,

housekeeping_setup() just carries on and we end up with the housekeeping
mask being all CPUs in the system.

Check that there *is* a cpulist and that it isn't empty.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/isolation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc5..aa20cd1702199 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -120,7 +120,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	}
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
-	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
+	if (cpulist_parse(str, non_housekeeping_mask) < 0 ||
+	    cpumask_empty(non_housekeeping_mask)) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		goto free_non_housekeeping_mask;
 	}
-- 
2.43.0


