Return-Path: <linux-kernel+bounces-45113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D6842BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5441F21E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806D762EB;
	Tue, 30 Jan 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btSLtLni"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE97762C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639642; cv=none; b=fkyBKsGt918SjjkpBMlBk4JD1v9I13oLYmQbRjUZZpsR8o5EL5ePMx6LuNwr3KRF7rV0N/4bR4FE5tFE3KNfoUexFUlxgN4XA7Ng+EaD8jpr3oS6FTtq91Yeil7b46BUwCz2CDdRXXt7Dp/g7YRbLgJ0SPBLRfhQtGtDMF3Q+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639642; c=relaxed/simple;
	bh=eC7+OI6/+9wto86uJj8ssIpbqkS2aO7JFeCrcZQgCgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8MVIr/xMyHg/MIXmmmSqQC/XeFHdlHstFfV4161UULKz3Gu9oeOTS+NAraQuwD9oKsqKXNCZxf1cYIU3RoA3K1PPTXuwti9UBCBAeZHnbMoaUnn0vvr1NTKuKfR9Zu9X+UAUXaMl+gkkQYUdMWgskiP1+d0SLuzdSF3UEiEvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btSLtLni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706639640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Ij0fUh99sNPGQIuhuaIyYnTfjT0QFXCH+1kvsJ6p4E=;
	b=btSLtLninwegMg6AIWGJtY+TAqaHX9qI1ZgNuSNyFvEu1peg1u2cZ+cx4pfw1ixCUBpauR
	qtwZOkxeH0bjUWFR1Ouj31HUcOQCBN8C/JJtA1dn3JIRg3/3w3DAoQS/0XLrkn06h4Gtql
	rFBGa7zm9/BNRy0/JWBVnRGEbEn8/OE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-e8NJ87b1OLq84HdCPEafQw-1; Tue, 30 Jan 2024 13:33:56 -0500
X-MC-Unique: e8NJ87b1OLq84HdCPEafQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B768881EA5;
	Tue, 30 Jan 2024 18:33:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E83E40C122E;
	Tue, 30 Jan 2024 18:33:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Tue, 30 Jan 2024 13:33:33 -0500
Message-Id: <20240130183336.511948-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Ordered workqueues does not currently follow changes made to the
global unbound cpumask because per-pool workqueue changes may break
the ordering guarantee. IOW, a work function in an ordered workqueue
may run on a cpuset isolated CPU.

This series enables ordered workqueues to follow changes made to the
global unbound cpumask by temporaily saving the work items in an
internal queue until the old pwq has been properly flushed and to be
freed. At that point, those work items, if present, are queued back to
the new pwq to be executed.

Waiman Long (3):
  workqueue: Skip __WQ_DESTROYING workqueues when updating global
    unbound cpumask
  workqueue: Break out __queue_work_rcu_locked() from __queue_work()
  workqueue: Enable unbound cpumask update on ordered workqueues

 kernel/workqueue.c | 217 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 183 insertions(+), 34 deletions(-)

-- 
2.39.3


