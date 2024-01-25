Return-Path: <linux-kernel+bounces-39170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CCD83CBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7660C1C22C56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0ED13399E;
	Thu, 25 Jan 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfzeEnkS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BC6A005
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209540; cv=none; b=kGU4ks6fgOWu+5Mpwmhr38Hl8M4h0DxzuUcvkebWE1gycghiB+TBalLIJrDuN537W+bxauXaI6uXmwaSHZmUDQUkxsM+SfWSNCGvQBp387OygkkKvgBtFIGwq6TINXsGIKImMxewoUbmh85Hl0Im0LtYWM75DVFkEzJDaCfdhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209540; c=relaxed/simple;
	bh=RMPY+xcwkGO88JRISYjEN0ZUrS2mNpltVpDpreXVXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv4FziqhB2V4XZbH7QU/F/gfvmLZcGNBETZbXrp1+RLZo9djY93DPz8QySW6FgZazrb+eN5hRIRQBK02rKSzB1YURl9wOEPZfKJYaZSnkJi9TLRBCv2v9MPC63rAM0abyOjRnB7wdfRVPDzCTDxEje9gIuU0QL6DGbwSLWNq34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfzeEnkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706209537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ut7Yj1rkRRp5GGEb0U1jCLRxZ7Bn+gqUqTucHc10AAY=;
	b=HfzeEnkSv+OOv6TPavILYs2FRofVsVy2FvxEO6Xh3ROx1vZRoEIFY6b2P+ppxjRj4c6OE4
	7By8BnaMcUiGFRaJxf4Qx34Y7cAV0tZdEogvI8a9RwGf/DbZlX+b2tK0LuJlFFV+RMh3I7
	STMxouJ4xeZbypQqWy1mdtDVBHvCo6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686--npH1BJ1MOqB5dc5JtCKag-1; Thu, 25 Jan 2024 14:05:34 -0500
X-MC-Unique: -npH1BJ1MOqB5dc5JtCKag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 926EB185A781;
	Thu, 25 Jan 2024 19:05:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75875492BC6;
	Thu, 25 Jan 2024 19:05:33 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org,
	raquini@redhat.com
Subject: [PATCH] workqueue.c: Shorten events_freezable_power_efficient name
Date: Thu, 25 Jan 2024 14:05:32 -0500
Message-ID: <20240125190532.335558-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Since we have set the WQ_NAME_LEN to 32, decrease the name of
events_freezable_power_efficient so that it does not trip the name length
warning when the workqueue is created.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..9b5890c51853 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6691,7 +6691,7 @@ void __init workqueue_init_early(void)
 					      WQ_FREEZABLE, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
 					      WQ_POWER_EFFICIENT, 0);
-	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
+	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
 					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
-- 
2.43.0


