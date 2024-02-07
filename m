Return-Path: <linux-kernel+bounces-55791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27884C1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA611C24A14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6D9134A6;
	Wed,  7 Feb 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPKf5oQF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962612E7E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268777; cv=none; b=GBcZvNIP+kk2iBIH2b6YKdshsJeJLxNrb/InxxQyi4fvR/3C+E3tb4Lm9V2sCsdt735F9VRq1ikZTmkqqtKugHlDVSpfXK0GgcPGFBzUH5kpv1zCASrfqTtEZYGc9lFz8Wuuyj4PV34VATOSi1IjWmMyr+e98cDF1Do52yy+fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268777; c=relaxed/simple;
	bh=jtcRfS7FK70oPiJGDW4/0HuF2nzmDdtB4If+8e4T7MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+aH4J7wYVi9SSuHAs4n0qTaY/GrL1cEUTfQ3G2DTEgPI4g19iEtmpuSJhHLMblK3yJDDnd2qXqKzof3KWuoM5Zk9qB2TtyP8l2W3EVqLAqAk0ChfHqM2b0BdyA2CK2nauQXOj8zSWKQ2ZpJqfc/EZIF94VgRXs7GxGL4nA9Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPKf5oQF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707268774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Xu6Dy+LgyMX67Ta0NVKivdXcqKGVmjFkpKpX1QNbOE=;
	b=EPKf5oQFaXlRfqe7kyJfqDpWchYQNpBsKGIagmPmKHukQ2DxYp2hjz7LLUDmS3HQaWEhwf
	hyKvcORWhIRWM+pH2dqljEkkPbdWeUmSwmGkk10ppo3viu5IoLkxh/Bl669RUDv5bp5EEA
	v+x6U9AgCiF+792v8ynnCZsrJTiaNAs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-v9z3RzMnM_qw_2dRQMJXGA-1; Tue,
 06 Feb 2024 20:19:33 -0500
X-MC-Unique: v9z3RzMnM_qw_2dRQMJXGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAC7A3816449;
	Wed,  7 Feb 2024 01:19:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F50240D1B62;
	Wed,  7 Feb 2024 01:19:32 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v4 1/4] workqueue: Link pwq's into wq->pwqs from oldest to newest
Date: Tue,  6 Feb 2024 20:19:08 -0500
Message-Id: <20240207011911.975608-2-longman@redhat.com>
In-Reply-To: <20240207011911.975608-1-longman@redhat.com>
References: <20240207011911.975608-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add a new pwq into the tail of wq->pwqs so that pwq iteration will
start from the oldest pwq to the newest. This ordering will facilitate
the inclusion of ordered workqueues in a wq_unbound_cpumask update.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf514ba0dfc3..fa7bd3b34f52 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4804,7 +4804,7 @@ static void link_pwq(struct pool_workqueue *pwq)
 	pwq->work_color = wq->work_color;
 
 	/* link in @pwq */
-	list_add_rcu(&pwq->pwqs_node, &wq->pwqs);
+	list_add_tail_rcu(&pwq->pwqs_node, &wq->pwqs);
 }
 
 /* obtain a pool matching @attr and create a pwq associating the pool and @wq */
-- 
2.39.3


