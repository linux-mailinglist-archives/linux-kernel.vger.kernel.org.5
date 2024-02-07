Return-Path: <linux-kernel+bounces-55792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF984C1D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4931C24220
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739115E96;
	Wed,  7 Feb 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etul6Y8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E712E63
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268778; cv=none; b=L5QQUQgTF0wSig/JFu75wPrNCvoyxKWJ5ITsRLGkTur6F98vGLgAf/RhSP6M4ILmfwDEUIgV9RmD1/zwsre06cxYSMGqof9B/3eaYqtH1G0Und/dr32U0oRV+10a0K4GGHh3ecCehRQC73CBYkJ1NERzo2BeXrD3tA9le69MAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268778; c=relaxed/simple;
	bh=V376dAOHiR5NDvb/JoHxzkqr2Lx52cRJPyLcJzBT4tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XBvyYCPmb8/hW4Zh3jtIe1QfMORoXRB87GpGISZT9a6nkmVS/AQ8Btwid75eMAtFpC1klPd7wJLKBbv5NunDUC90YLNPhjqi5JnCVQa8BJ/LG2P7dEtLc97K7EwoNbX4Ekm/gJJrNRGFv7y1kHNeHNwvTppV4qi4XYqid4T/A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etul6Y8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707268776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=plEIwUaygIL7gqVklYFDo8bIs1ikW11gzA9fRUjic6s=;
	b=etul6Y8dGwhn5ouYP30ED7Xbxi3/6Vc/yvF85j/YLlq+JSjK/MJI7c/c/BoxXgRzRVpeQl
	1zOQh7N2qLaFkvk7gZjjBWsDI5SEHhz7eoUw6Q0+93blHj0rLaFkCYT0CZiKX88afbwWRo
	0oF+A0F8feVoUyB8ym4R1hCLFX19LsI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-KBcKGl_rNbGKEBFM2mM0WA-1; Tue,
 06 Feb 2024 20:19:32 -0500
X-MC-Unique: KBcKGl_rNbGKEBFM2mM0WA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 201F7280A9A1;
	Wed,  7 Feb 2024 01:19:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9300040C9444;
	Wed,  7 Feb 2024 01:19:31 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v4 0/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Tue,  6 Feb 2024 20:19:07 -0500
Message-Id: <20240207011911.975608-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

 v4:
  - [v3] https://lore.kernel.org/lkml/20240205194602.871505-1-longman@redhat.com/
  - Rebase on the latest for-6.9 branch again & discard the use of
    __WQ_ORDERED_EXPLICIT and resetting of __WQ_ORDERED.
  - Add a new patch 1 to change the ordering of pwq's in wq->pwqs from
    oldest to newest.
  - Change the terminalogy from freeze/thaw to plug/unplug.
  - Allow more than 2 pwq's in wq->pwqs of ordered workqueue but only the
    oldest one is unplugged. This eliminates the need to wait for
    the draining of extra pwq in workqueue_apply_unbound_cpumask().

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

This series enables ordered workqueues to follow changes made to the
global unbound cpumask by temporaily suspending (plugging) the execution
of work items in the newly allocated pool_workqueue until the old pwq
has been properly drained.

The cpumask of the rescuer task of each workqueue is also made to follow
changes in workqueue unbound cpumask as well as its sysfs cpumask,
if available.

Juri Lelli (1):
  kernel/workqueue: Let rescuers follow unbound wq cpumask changes

Waiman Long (3):
  workqueue: Link pwq's into wq->pwqs from oldest to newest
  workqueue: Enable unbound cpumask update on ordered workqueues
  workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask

 kernel/workqueue.c | 111 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 12 deletions(-)

-- 
2.39.3


