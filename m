Return-Path: <linux-kernel+bounces-51155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9792584872E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAD1F22110
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763165F547;
	Sat,  3 Feb 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPVxTK5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7EF5F541
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975043; cv=none; b=i9sesHyYV69Zrsl7mgS2Ji7nQYzbU7gWJkGBoiANV9MxQpu7trUIvff+zDA9tsSRgS0lcpmooDcDx5fZPlxH05ywAmlmP6rHBOpdv8svGy81LX8kwlAqQWJYcOypeWrfhJ7Xxkyi/iC8xcxlomqYSeKoeiyujBnX41YLvwuV6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975043; c=relaxed/simple;
	bh=d6cLCt9ayHSlBADDrlW6Zy6tCMiM/CqdbjAmopbqEqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BX8drzwplhaxw2cWNWOX//Etl4UJGnzQLoyFgXkx42FJrLQk+WYsUsRFaxjc5eg+9qtj5MVdVM93HqJ1SFMzs+eMC8Z4MtPEL+IhQZ16de6l+pjka//007v84as8YCesKMFUohczn5ACpbCE5afnpTNKCN3ufXw/dXKHhD6Jxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPVxTK5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706975040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etw5f6ek7q4zMVxUU4qrG6lMZPsjA2+up4LCm7bLvnM=;
	b=IPVxTK5h+QRIH51DWzTZxjorEbq6uKHy1Q2Q+37kGpdZHtYsa4PWZ7eIVDW4gbYKVFHluW
	OdTlYNsut5CRucrMHzElFjixaneH6kTrw79wNI7Qr06IvzMEzmAcpYwQ4vBZm2PTjryl5z
	rf78o9cHeNnlcsZZWK8ga7avFjxId1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-T_OwaJzYO1CLoD68Phcd5A-1; Sat, 03 Feb 2024 10:43:59 -0500
X-MC-Unique: T_OwaJzYO1CLoD68Phcd5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A3985A589;
	Sat,  3 Feb 2024 15:43:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2497D492BC6;
	Sat,  3 Feb 2024 15:43:58 +0000 (UTC)
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
Subject: [PATCH-wq v2 0/5] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Sat,  3 Feb 2024 10:43:29 -0500
Message-Id: <20240203154334.791910-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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

Waiman Long (4):
  workqueue: Skip __WQ_DESTROYING workqueues when updating global
    unbound cpumask
  workqueue: Enable unbound cpumask update on ordered workqueues
  workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
  workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask

 kernel/workqueue.c | 128 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 15 deletions(-)

-- 
2.39.3


