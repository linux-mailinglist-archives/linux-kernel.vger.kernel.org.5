Return-Path: <linux-kernel+bounces-84292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D586A4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E576CB2838D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A761103;
	Wed, 28 Feb 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0PVO0T8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7CA34
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081904; cv=none; b=Qep4ue/zhBJCRL2AfomP4bLjW3CaZ574WPOjicaZ6uB+Gzwf05nfAH3vPQTLrHhR4NXISUYQv3T5HibziJrb5YrQeDaAksx/T9z/zndhszxvuI7MAOZuD4dJXe7xzi/6/ozOliATiZ8kHJyh/7yWHiZ75BGQbwcSvIwuHH89PtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081904; c=relaxed/simple;
	bh=izofhJ8GuVB4VlLoh/I9ckNg1zRYgM+qGaEG4v36yds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=It5io9CJ6kq0w1kWf/LkDomfFDhFupvuyJcUHHUcAVaQqvdnFcyN0Cx5BqxZlIfdc54TG1Gj7lU/VCTf3WZcFgteSATCFOf1hKjEvsVbqXFWSPG3AAYA+WCAa5oSTMQIz4bt1m2qlabXmEBdjUgL48Is8BTuAwWp8czxiRQT6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0PVO0T8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709081901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=St3NN2vP8vgmPHt07QiH+ykevs0W7YQdgC9No+mGpjw=;
	b=C0PVO0T8OqgC0FXt3Ux1uX1j/s4olnKs+Zj4++4FbhPo9qxUGvdZjEti9XnfebtWayltpE
	OhKObQ4Nd0Me2YkZsb035sdFqD6BF54w4Up09AQBruDcUOqihWg+jGm4NtmJVQTloVu9n4
	gF7Ytw6/7/7IjGQgLyHuGxD+aPsl6Vs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-wgJFoDK_Ol6MPTAILi7yVQ-1; Tue, 27 Feb 2024 19:58:20 -0500
X-MC-Unique: wgJFoDK_Ol6MPTAILi7yVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A59C388D183;
	Wed, 28 Feb 2024 00:58:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 88E6A1CBC8;
	Wed, 28 Feb 2024 00:58:18 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mirsad Todorovac <mirsad.todorovac@alu.hr>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Fix a memory leak in update_exclusive_cpumask()
Date: Tue, 27 Feb 2024 19:58:01 -0500
Message-Id: <20240228005801.429847-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Fix a possible memory leak in update_exclusive_cpumask() by moving the
alloc_cpumasks() down after the validate_change() check which can fail
and still before the temporary cpumasks are needed.

Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.hr>
Closes: https://lore.kernel.org/lkml/14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..7260f095802a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2598,9 +2598,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
 		return 0;
 
-	if (alloc_cpumasks(NULL, &tmp))
-		return -ENOMEM;
-
 	if (*buf)
 		compute_effective_exclusive_cpumask(trialcs, NULL);
 
@@ -2615,6 +2612,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval)
 		return retval;
 
+	if (alloc_cpumasks(NULL, &tmp))
+		return -ENOMEM;
+
 	if (old_prs) {
 		if (cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
-- 
2.39.3


