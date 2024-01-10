Return-Path: <linux-kernel+bounces-22731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A234B82A245
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E4B1C202E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EA4CB5C;
	Wed, 10 Jan 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ADxJQ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3C4EB3D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704918604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMli2covK2xgHMMXM5SX9EfzjN/4KtLqmGDSMhY+Q5Y=;
	b=R1ADxJQ3XNQfsUMpLiWWNHrRD8OtKadY5Xxaqo9rxs6HzTzqUKRrs2sIKPkmN+rpsc58gT
	7eF66r0Tmb1kHra8Ral+Ry4VEMgvjcP1E6W7Vq+zGDaIFCBhP8X+aa5JE+yQHqeaHuoI+4
	C6Icsq3KYfNu94rupGpp0cNBTftw9ts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Z74T8RBdMNKKI93RDaIrrQ-1; Wed, 10 Jan 2024 15:30:02 -0500
X-MC-Unique: Z74T8RBdMNKKI93RDaIrrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF5788905D;
	Wed, 10 Jan 2024 20:30:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABBA32166B32;
	Wed, 10 Jan 2024 20:30:01 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com,
	ddouwsma@redhat.com,
	loberman@redhat.com,
	raquini@redhat.com
Subject: [PATCH v2] workqueue.c: Increase workqueue name length
Date: Wed, 10 Jan 2024 15:29:59 -0500
Message-ID: <20240110202959.249296-1-audra@redhat.com>
In-Reply-To: <20231215193954.1785069-1-audra@redhat.com>
References: <20231215193954.1785069-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Currently we limit the size of the workqueue name to 24 characters due to
commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
Increase the size to 32 characters and print a warning in the event
the requested name is larger than the limit of 32 characters.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 kernel/workqueue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..cac3b8895c16 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -108,7 +108,7 @@ enum {
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
-	WQ_NAME_LEN		= 24,
+	WQ_NAME_LEN		= 32,
 };
 
 /*
@@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...)
 {
-	va_list args;
+	va_list args, args_copy;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
+	va_copy(args_copy, args);
+	len = vsnprintf(NULL, 0, fmt, args_copy);
+	WARN(len > WQ_NAME_LEN,
+		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
+		len, WQ_NAME_LEN);
+
+	va_end(args_copy);
 	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
-- 
2.43.0


