Return-Path: <linux-kernel+bounces-31724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFF833305
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E1B1F21EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFC20E0;
	Sat, 20 Jan 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUBKTSWE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154721858
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733760; cv=none; b=vFFdPthAZX7CWVtIWaqENPCkirhz/PhnZUSwEI0nRkCLSbNcOpA2IUmEQMHLi0PSGpQ2Yg+vcaBwxn2qx4Rv6O6RMrNdTqTeoOnrkxUrPxYYyqAnJ8WVWH8wbK8X+XQ6uM9A+hT5lGhMVGdTJLvt7LZgrgWKEnCBmHcS0VV1j4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733760; c=relaxed/simple;
	bh=UKO1d22DE5qaYTzjwXgC1y9WVGi1HgsHirzj/ddBBlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMAtSo6MQIsbYPwsQMOGyjuBK3ayuLpI5OQgdJhgedLFyZDCmAVwZ8wvyO6xT4aE7wSbnO+rN6Gg7xQ5QshH4AJ+FyAJG0HdpRKuFKvnOdU1cBni59ZKNwU3Q4fVzl6SkOBGVcar1g0i3aCA4iRnUizDEaxv5CN7HUfG8CDpBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUBKTSWE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705733757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=drqLI5iv8tK+6H2RZsx4Mqly9yp+Pt1Pkvi8hiH2284=;
	b=UUBKTSWEsKRKbLvKhICVXk1stxFNrRR52Gx8oI0GenV5eI7amGm1ZAv9Rpcre4yrHYXDZB
	CsZIJkzArY+9INOblYPaJsRUSIF26N++B1sd8na88RruT8mB2jyUhPumi2lBWNMNAbMJHv
	Bn5y/rVO4VwgX2lAH8V6trtZ14X7TKY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-ge-UWV4kMeG87RNIsk1Xjw-1; Sat,
 20 Jan 2024 01:55:56 -0500
X-MC-Unique: ge-UWV4kMeG87RNIsk1Xjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2B7A3C0ED41;
	Sat, 20 Jan 2024 06:55:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DEA451D5;
	Sat, 20 Jan 2024 06:55:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] lib/group_cpus.c: simplify grp_spread_init_one()
Date: Sat, 20 Jan 2024 14:55:43 +0800
Message-ID: <20240120065543.739203-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

What the inner loop needs to do is to assign each cpu in `siblmsk & nmsk`.

Clean it by using cpumask_next_and(), meantime add helper of grp_assign_cpu().

So grp_spread_init_one() becomes more readable now.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---

Hello Andrew,

Please consider to use this one to replace the 1st, 2nd & 4th patches
in Yury's V5:

- avoid to add new kernel API
- avoid to update iterator variable inside loop, which is tricky
- fix bug in the 4th patch
- add grp_assign_cpu() to make code more readable & clean

 lib/group_cpus.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..6cbc7379d954 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -11,32 +11,36 @@
 
 #ifdef CONFIG_SMP
 
+static bool grp_assign_cpu(int cpu, struct cpumask *irqmsk,
+		struct cpumask *nmsk)
+{
+	if (cpu >= nr_cpu_ids)
+		return false;
+
+	cpumask_clear_cpu(cpu, nmsk);
+	cpumask_set_cpu(cpu, irqmsk);
+	return true;
+}
+
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
 	const struct cpumask *siblmsk;
-	int cpu, sibl;
-
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
+	int cpu = -1, sibl;
 
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
+	while (cpus_per_grp > 0) {
+		cpu = cpumask_next(cpu, nmsk);
+		if (!grp_assign_cpu(cpu, irqmsk, nmsk))
 			return;
-
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
 		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
+		sibl = cpu;
+		while (cpus_per_grp > 0) {
+			sibl = cpumask_next_and(sibl, siblmsk, nmsk);
+			if (!grp_assign_cpu(sibl, irqmsk, nmsk))
 				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
-			cpumask_set_cpu(sibl, irqmsk);
 			cpus_per_grp--;
 		}
 	}
-- 
2.41.0


