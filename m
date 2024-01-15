Return-Path: <linux-kernel+bounces-26294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A882DE30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898521C21E53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0018C05;
	Mon, 15 Jan 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IENH+kDH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACB18AE8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705338521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oEHJxs+4pEZsHsz+fGMFU6jnZAwW1mhS11P5P0qOaA=;
	b=IENH+kDH3J1xWDxJtO5+52MFTqUbMex9w73tnAqSJmC6w2nfIlFZx2k5lGh1TxBJlfcjlc
	fXueHfJMzQthqkYqSw6dl4IYz0qoS9T2kf5BBgCdEctlHRRdF2hrs2t+Ler6UQ/d5lQk/E
	A45Ks+8edIM5NunSUlzX0xHRN1VQ1qM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-Hc3NWg6-ONit_PzGXk21fw-1; Mon,
 15 Jan 2024 12:08:37 -0500
X-MC-Unique: Hc3NWg6-ONit_PzGXk21fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 649203830082;
	Mon, 15 Jan 2024 17:08:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.191])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB3502026D6F;
	Mon, 15 Jan 2024 17:08:36 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com,
	ddouwsma@redhat.com,
	loberman@redhat.com,
	raquini@redhat.com,
	rasmus.villemoes@prevas.dk
Subject: [PATCH v3] workqueue.c: Increase workqueue name length
Date: Mon, 15 Jan 2024 12:08:22 -0500
Message-ID: <20240115170822.451231-1-audra@redhat.com>
In-Reply-To: <20231215193954.1785069-1-audra@redhat.com>
References: <20231215193954.1785069-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Currently we limit the size of the workqueue name to 24 characters due to
commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
Increase the size to 32 characters and print a warning in the event
the requested name is larger than the limit of 32 characters.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..8d9dec14b9bb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -108,7 +108,7 @@ enum {
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
-	WQ_NAME_LEN		= 24,
+	WQ_NAME_LEN		= 32,
 };
 
 /*
@@ -4666,6 +4666,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	va_list args;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4692,9 +4693,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
+	if (len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
+
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
 
-- 
2.43.0


