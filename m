Return-Path: <linux-kernel+bounces-18822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B075B826393
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668BB1F21C66
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AF12B78;
	Sun,  7 Jan 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGQbBQzJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181A12B60
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704619016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BgudMJ+RWICRf+8Eqkdzm+CoYpLiRVe9izyHKQLDpow=;
	b=bGQbBQzJb/n3TEDdPLLJPSjyXpNWIj2Ax29lKvO9hlzv9z1qLmK04hZ/kZeEh2yy0uS9cE
	tvtFsH8DgWH0Ny6Z+wyU+cQlFcSpD4X3yW1ON2zythkDlECKBQhCqskra8hh5808zyN+hh
	wXitGm3yQHE4HE/TgOBhE31qBvF31x8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-mx9G9GVBMsWyf6PcWbO46g-1; Sun, 07 Jan 2024 04:16:47 -0500
X-MC-Unique: mx9G9GVBMsWyf6PcWbO46g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 105BF85A588;
	Sun,  7 Jan 2024 09:16:47 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24E063C31;
	Sun,  7 Jan 2024 09:16:44 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	pmladek@suse.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] panic: suppress gnu_printf warning
Date: Sun,  7 Jan 2024 17:16:41 +0800
Message-ID: <20240107091641.579849-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

with GCC 13.2.1 and W=1, there's compiling warning like this:

kernel/panic.c: In function ‘__warn’:
kernel/panic.c:676:17: warning: function ‘__warn’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  676 |                 vprintk(args->fmt, args->args);
      |                 ^~~~~~~

The normal __printf(x,y) adding can't fix it. So add workaround which
disables -Wsuggest-attribute=format to mute it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/panic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aab51..d49b68184c56 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -666,8 +666,13 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
 			raw_smp_processor_id(), current->pid, caller);
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
 	if (args)
 		vprintk(args->fmt, args->args);
+#pragma GCC diagnostic pop
 
 	print_modules();
 
-- 
2.41.0


