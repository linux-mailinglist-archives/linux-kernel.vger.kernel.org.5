Return-Path: <linux-kernel+bounces-58330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3CB84E4BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD83B1C24472
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BA7D416;
	Thu,  8 Feb 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTHnVcTX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82E7D413
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408633; cv=none; b=g4gdJt8e7GUffiIXlufjrU24bUbYQ6BTv4iMyK5W02mXOtS0dOlzk/XShDWqesOL55Ns61ubRn3D6XanoN/RvboeXCf6Rqre1yZ3Fg3wI1CQ2hIMAaXIFClttGiTjgozJKEN5knNyA6nA/vMnBh8voqa0h5uxFiJDhbHCQaqcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408633; c=relaxed/simple;
	bh=jtcRfS7FK70oPiJGDW4/0HuF2nzmDdtB4If+8e4T7MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI16iIiXbxNG4YWZ/K2KtaiCFk1v5tcjMfm3WgJFN0xSgpXayuQakgC/NxK0tS5wvgkbZ5waTO2iMx4fTulDErDPe/XKxKo7oKAtpg+2Q6YrPv6ZwCWmjZOPRWffsI1bxIU85NSCwZTUyGZhFLCFJzDr/0ykzqFYR3gdi+TiPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTHnVcTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Xu6Dy+LgyMX67Ta0NVKivdXcqKGVmjFkpKpX1QNbOE=;
	b=MTHnVcTXT//xsWX7usokCHK0FS4aLrXml0ki6SiEikeplu1opSBl1oD6YHy6Fs9AEHVgs+
	F+X5uMSZbUVT57gXJZyeNwRVhoC102dV0Yos18Z1mBjh2XX7ZpSsaMzOoKEU6ZnwDaHTyE
	Qq44S2YnZJQ3k2/+6ppumrbwL/irdEM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-3Fv6xqkQNByRzOKeLgBVHw-1; Thu,
 08 Feb 2024 11:10:26 -0500
X-MC-Unique: 3Fv6xqkQNByRzOKeLgBVHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF068381644E;
	Thu,  8 Feb 2024 16:10:25 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C130492BC8;
	Thu,  8 Feb 2024 16:10:25 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v5 1/4] workqueue: Link pwq's into wq->pwqs from oldest to newest
Date: Thu,  8 Feb 2024 11:10:11 -0500
Message-Id: <20240208161014.1084943-2-longman@redhat.com>
In-Reply-To: <20240208161014.1084943-1-longman@redhat.com>
References: <20240208161014.1084943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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


