Return-Path: <linux-kernel+bounces-45114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDDE842BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3F1C23B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1B762C5;
	Tue, 30 Jan 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQdKKw8w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE13762D0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639643; cv=none; b=nOc1xR6V6jJV9J11pGAA/s9YHwU555T/LJ/jSNVIZ4iDVrfKSR4K6a2RaL9QMv7zuFx5M7XjyEmL+14KCd3ek6pZw8blO8vsY2kO8N/eLSc5ihCWqG3eIJUzVHihUwqBf2xdXIZXHDRbqshD3BgMS4XuxW5drWefRy5eruv70Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639643; c=relaxed/simple;
	bh=Aa3cym5mjG1BHlHIUMCHX33rDI7Y6taSaQCcsrAKHSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/P4sNRqsBTamz2Q4sMRw8Wew9pKIKsVuhEd3ejY+EZuxOj1Fsw5dba0lpCW08lGXF7+7S8OShSn7ULESCsGJFYs3uPThlLaPTvZ7C41E6K9jz0djspaw4XyPbfn8+RfRz5qYtuWhkiSqF+rx7Nl4fjeAEA0xCwkPKD1KUCKxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQdKKw8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706639640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zEEimyOdTkcF6f/u66KBqEEbATKOuXf1jTOu6zU+Ug=;
	b=ZQdKKw8ww81lmCy+fgFkxYo6IvIr2rPt4FOFP3e/6GjOOnFgALiYF58RQy6a51dJITqjs1
	9V7U2rlqCjmgom7BZ1QkbBuWynBnAc4q35V6+zOoCVHhUPPuyxK2Mtz660HF0TaFQwr9p0
	33M00qE5JTIIuB1QqySQH1617XtGGWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-3y4lfYFJNYGkuFMrPlx6XQ-1; Tue, 30 Jan 2024 13:33:56 -0500
X-MC-Unique: 3y4lfYFJNYGkuFMrPlx6XQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DA5710665A0;
	Tue, 30 Jan 2024 18:33:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B47040CD14D;
	Tue, 30 Jan 2024 18:33:56 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 1/3] workqueue: Skip __WQ_DESTROYING workqueues when updating global unbound cpumask
Date: Tue, 30 Jan 2024 13:33:34 -0500
Message-Id: <20240130183336.511948-2-longman@redhat.com>
In-Reply-To: <20240130183336.511948-1-longman@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Skip updating workqueues with __WQ_DESTROYING bit set when updating
global unbound cpumask to avoid unnecessary work and other complications.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..350179382667 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5784,7 +5784,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	lockdep_assert_held(&wq_pool_mutex);
 
 	list_for_each_entry(wq, &workqueues, list) {
-		if (!(wq->flags & WQ_UNBOUND))
+		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
 
 		/* creating multiple pwqs breaks ordering guarantee */
-- 
2.39.3


