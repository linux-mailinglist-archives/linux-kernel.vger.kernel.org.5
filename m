Return-Path: <linux-kernel+bounces-85137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5A86B0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD33A1F26961
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA69151CC5;
	Wed, 28 Feb 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc9goBtW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89814F987
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128455; cv=none; b=SusS/aJ65nR9RH5aSdqiZ5fJX7doZjxXFa9Slf/+W9DmSMGsVVRzFMK2JLyOsFdo3P68i/O4VejdeRcA63gKcDwmq5GjfygaGOnLMsLpMIKt7uSl4qVeUiQI2Wfq/ap2diMm4HhOW4qw+hvoPVEiMvOVLZzG6zzI1JymiYf770g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128455; c=relaxed/simple;
	bh=aV+01cbnvwYneym9pG1JuXfXvYgIVTFiDpBI353TUkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8LzQZOM7893gFT9JM4YSqYcGQ0ZLrpGtFMZYmV9uR08lFQ+LrlnHNIWv8pn+wiSXCuvkX9O9Qm3Jv2xw7CvXddVRH2TN0HZVRN0RRuXYpMfYi/mIJZtmPxQmz5mHqNJ87HIkfYCUN7xHDTyBedfENjsOVmeUKOyU8jGrC/y1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rc9goBtW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709128453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7eik1TFl3fkD2jZ/xnSrKIHXhnveA7D9yMR9JohoGKk=;
	b=Rc9goBtWHFYKdDvdEuo2i3ETk27e2AHZZAGLjKp/n/ZQ5nk0jxDmaKJO28yuin6v0wBYge
	AE4QRsoxzNJwNY1TZvOj8MHtCn9oElJ+vr8P7QVkxyuFXb+00h1Fzkali4BTOeaOCHobRN
	qbWaf1nMLlKLziFD7yt8muE+JjNbDX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-2abDcOcHNvuNVjn4T_N9AA-1; Wed, 28 Feb 2024 08:54:06 -0500
X-MC-Unique: 2abDcOcHNvuNVjn4T_N9AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6AFE10AFB08;
	Wed, 28 Feb 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 854CD1121312;
	Wed, 28 Feb 2024 13:54:03 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: add guard definitions for xa_lock
Date: Wed, 28 Feb 2024 14:53:52 +0100
Message-ID: <20240228135352.14444-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add DEFINE_GUARD definitions so that xa_lock can be used with guard() or
scoped_guard().

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 include/linux/xarray.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..73a8fc0e830a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -11,6 +11,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/gfp.h>
 #include <linux/kconfig.h>
@@ -1883,4 +1884,19 @@ static inline void *xas_next(struct xa_state *xas)
 	return xa_entry(xas->xa, node, xas->xa_offset);
 }
 
+DEFINE_GUARD(xa_lock, struct xarray *,
+	     xa_lock(_T),
+	     xa_unlock(_T))
+DEFINE_GUARD(xa_lock_bh, struct xarray *,
+	     xa_lock_bh(_T),
+	     xa_unlock_bh(_T))
+DEFINE_GUARD(xa_lock_irq, struct xarray *,
+	     xa_lock_irq(_T),
+	     xa_unlock_irq(_T))
+DEFINE_GUARD_COND(xa_lock, _try, xa_trylock(_T))
+DEFINE_LOCK_GUARD_1(xa_lock_irqsave, struct xarray,
+		    xa_lock_irqsave(_T->lock, _T->flags),
+		    xa_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif /* _LINUX_XARRAY_H */
-- 
2.43.2


