Return-Path: <linux-kernel+bounces-53860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047684A75F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F6B1C26F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125107E79C;
	Mon,  5 Feb 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjhfQK0N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825E7E585
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162402; cv=none; b=KnHPXdsHxwQOVzUqo4DRC8zsGDEv45utvV10ePP5LEQ1sBswFKEfO2Bo1Xq4BupfhieZOMTq/GPKgbKlg8Z95+Kpu7mIyQf7ub8YaWpJ0TAa+sguVk7wjvspk0tZIYmt7xedsWdeBZj4yr+HXiKsjOcHNP3CON1p7udl8tF15l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162402; c=relaxed/simple;
	bh=a/l7dIHL4lD27xI3QHJBmm7xg9IPaYq194T/QUkU0vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RsDyGTd2wjOOcGKki5YZAT+fpAuo+fXXb10G6+B/zEAb1lUM1AKCnzfuv1IJKbAVrZCJa7DNKUUdyU+JTQok6SupiGwPvSK98NYkOwCZIJ/Q+GW/KkRz96kWRR+DyAoIr9Fgc66hBgo9D4AmSiCrKw0KVfIlwflgEAiz0YcJuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjhfQK0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2wAq9zuBQRCHAAv9+2rXsge637bX5qI7IyvgEpLY8sU=;
	b=RjhfQK0NrmjjFaeBH1FqtiqoDqW4LUi0IlUeFBvMcIi34fR7KV8d9FVpZN7UafR2zmj1tH
	QyQGxbjPNG+izPzoT0l2pVgsRAnODK2HUBhUbxDP8InrSgwD44pD2ZoN6RX0l7i0tIKCgV
	cHL6laUhlE4TisGNqjL2x7BjgXH4rAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-iAC3FgjmOWyn7ePocsI6QA-1; Mon, 05 Feb 2024 14:46:35 -0500
X-MC-Unique: iAC3FgjmOWyn7ePocsI6QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61863800074;
	Mon,  5 Feb 2024 19:46:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0DA11C060AF;
	Mon,  5 Feb 2024 19:46:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-wq v3 0/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Mon,  5 Feb 2024 14:45:58 -0500
Message-Id: <20240205194602.871505-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

 v3:
  - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
  - Drop patch 1 as it has been merged into the for-6.9 branch.
  - Use rcu_access_pointer() to access wq->dfl_pwq.
  - Use RCU protection instead of acquiring wq->mutex in
    apply_wqattrs_cleanup().

 v2:
  - [v1] https://lore.kernel.org/all/20240130183336.511948-1-longman@redhat.com/
  - Rebased on top of wq's for-v6.9 branch.
  - Use the new pwq_tryinc_nr_active() mechanism to freeze the new
    pwq of an ordered workqueue until the old pwq has been properly
    drained to maintain ordering.
  - Make rescuer follow changes in workqueue unbound cpumask as well
    as its sysfs cpumask, if available.

Ordered workqueues does not currently follow changes made to the
global unbound cpumask because per-pool workqueue changes may break
the ordering guarantee. IOW, a work function in an ordered workqueue
may run on a cpuset isolated CPU.

This series enables ordered workqueues to follow changes made to
the global unbound cpumask by temporaily freeze the newly allocated
pool_workqueue by using the new frozen flag to freeze execution of
newly queued work items until the old pwq has been properly flushed.

The cpumask of the rescuer task of each workqueue is also made to follow
changes in workqueue unbound cpumask as well as its sysfs cpumask,
if available.

Juri Lelli (1):
  kernel/workqueue: Let rescuers follow unbound wq cpumask changes

Waiman Long (3):
  workqueue: Enable unbound cpumask update on ordered workqueues
  workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
  workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask

 kernel/workqueue.c | 127 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 14 deletions(-)

-- 
2.39.3


