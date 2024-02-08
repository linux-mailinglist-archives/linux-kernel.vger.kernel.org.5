Return-Path: <linux-kernel+bounces-58327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90284E4BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A971C25350
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36E7E774;
	Thu,  8 Feb 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et3upo0o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DA7994A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408633; cv=none; b=UqEolisREf0L9dfJvk9s9Kpa7smRLDisOULyBSX8zNh2uEVEWCy9aOnyfzjLWPdYfHupQCGPkv/ZYNEr6Wf/c7D2NWQxB4sOqMF1G9TKPu0n0IWamHLqF58ptK2lypT1NfaddDGENOJFFwwNHYI1z1THLzqTkgtoZ/IG/CxaAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408633; c=relaxed/simple;
	bh=fp8pgifZfoDofchTOp2aG7ixErXuoj6QPm4g7ry0ED4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ll/rJB7z6w9IAX8nTtCfmy8arF2XaQGXPnle8ki9Tmz8RTfhbeKBBZk+TA9iRl3mOIwqBPeUNPGs8RhlPPL1wzN8147+/xjV3LA8FM4R4rYRWAH2tOiukR1ojvedtltma4XAFWmwjiwc4Yz1J2AdmtpRe0IKxz1eVs/n/zljaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Et3upo0o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PUWu16mgbWaE5xtucdhmWtcovtMptwL5XmanWGj+1j0=;
	b=Et3upo0oJDlpJ+h/Lzj4uLHMNUGByeRw6PK8v18j0x9apdwFy++oPSnBynb3gA5XrvwFX3
	WyqmXV7cq2sG/ZxwiLuSi6RffHeNzaCgIRid0wXcugfLcn0Lmvl+EmqRHAW7j0YzvkJ1px
	kQyBl/Y+7Ln9HWC7J2jFLbTt+/pYHQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-PlygYM99NFuto9qSxggOfg-1; Thu,
 08 Feb 2024 11:10:26 -0500
X-MC-Unique: PlygYM99NFuto9qSxggOfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B9E71C0983C;
	Thu,  8 Feb 2024 16:10:25 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1AA5492BC6;
	Thu,  8 Feb 2024 16:10:24 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v5 0/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Thu,  8 Feb 2024 11:10:10 -0500
Message-Id: <20240208161014.1084943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

 v5:
  - [v4] https://lore.kernel.org/lkml/20240207011911.975608-1-longman@redhat.com/
  - Streamline patch 2 by simplifying unplug_oldest_pwq() and calling it
    only in pwq_release_workfn().

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

 kernel/workqueue.c | 81 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 12 deletions(-)

-- 
2.39.3


