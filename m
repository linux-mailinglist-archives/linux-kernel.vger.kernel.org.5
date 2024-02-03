Return-Path: <linux-kernel+bounces-51156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602384872F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993491C2256C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8E5F843;
	Sat,  3 Feb 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN3lK1be"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F75F557
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975046; cv=none; b=VRgUPQIJG5Mzfn7V1l8PpdfzTdPMrXtRgtcdu5H06zRSPnb+7N3PTVg7mk6TroMQUPlLo29ZBqiychHb3En/EbVi2EoDwGM6vaoctPnpD0xJOqbbovZjoqy40rao/Qw+ITdwUnO7NVmCiJicW6LpzovOi/230Lwo+knqu/6Sbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975046; c=relaxed/simple;
	bh=N0NFN9G6d8VckDtQzeRTKSXMqsIlgHOkxLBCqDdAB+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=il4Sa6mfIUTG/EW+ZGY8hJ+QA+5a5gYJJpwLOSE6kqdVYK5lu80p2GQXt43zQKXu6AEKbRXLsXEudfssY/9ClEYGPwEbWwxGxxFAOMtCDDIMzWjJHCmJ9fPdzuhri14wPVHkFALMiOCl1lpxmCQ61jg7sZK7OPNvDVutskLSq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UN3lK1be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706975043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd3lbhuW8fX+DsS5188RrMwd7iN3OLF290p+wTUe/dc=;
	b=UN3lK1beGPMzr4dsr0b9cKs1uKH4G8ZD4wM/6pq5boXAdvfSSB9ecrL9+gYDoiyWojaTF3
	iibRtWmVBWp1TxO/Dy+8o6zt8nXsVt86g4EY9QNtODUIcx8W//QiaB+R2bU0OflAioNEkH
	EnxD8VlM8ve11EB+dtVP3xgDatRq5oI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-XtEwpxLtMrWxLbKcxe-wAw-1; Sat,
 03 Feb 2024 10:43:59 -0500
X-MC-Unique: XtEwpxLtMrWxLbKcxe-wAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39BB73C0C136;
	Sat,  3 Feb 2024 15:43:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8BA5492BC6;
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
Subject: [PATCH-wq v2 1/5] workqueue: Skip __WQ_DESTROYING workqueues when updating global unbound cpumask
Date: Sat,  3 Feb 2024 10:43:30 -0500
Message-Id: <20240203154334.791910-2-longman@redhat.com>
In-Reply-To: <20240203154334.791910-1-longman@redhat.com>
References: <20240203154334.791910-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Skip updating workqueues with __WQ_DESTROYING bit set when updating
global unbound cpumask to avoid unnecessary work and other complications.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ffb625db9771..7ef393f4012e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6313,7 +6313,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	lockdep_assert_held(&wq_pool_mutex);
 
 	list_for_each_entry(wq, &workqueues, list) {
-		if (!(wq->flags & WQ_UNBOUND))
+		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
 
 		/* creating multiple pwqs breaks ordering guarantee */
-- 
2.39.3


