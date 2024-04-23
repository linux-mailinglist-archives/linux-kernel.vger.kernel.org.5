Return-Path: <linux-kernel+bounces-154456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4C28ADC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDFCB23F69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9B1CA81;
	Tue, 23 Apr 2024 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByNErQpW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA0219FC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842672; cv=none; b=ED8I76AdBadF6DcaifjI2u3GKTfIqJHQPNOpQvo+DxUOUqigCfF3BQdhzlVCJcXsDhL+H2H1cLtpOP7xsdSIEfrtGu3PlLNe/78rCDPFX3tWrI0e5B8UmjTLMXzQ9afG79mUiOkUatZ9KOraGgwoPA9oe6I45UNqljcnDL9Rzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842672; c=relaxed/simple;
	bh=5MVVIcDipqgJAk3mCYyyzSHu50ImzAuTrQ9oKbZbq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2xU5FtZRgY8zieeLaZJlbBXdSKeapFTyfrDdMIGtmbvMmkNtX1hxaLWbVjXpOzjuB8WLqeoyZb+2o0Q1UtJSmbR8qQn/JJ8Lg5DZkhtpSgaoMSb2YVteaU4m/IibIhNlIq4kSex+qTkRV/Vovp0djLHzMCHmz2OkZTth2nP9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByNErQpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtMGrJ3CLLK0RMLaaz/XukLZE22bi0+EJWg0qr8z6dw=;
	b=ByNErQpWLEuR+y/0VexF/g2/zIX6ZqJlWMFPDXAyxYBA1jIUOpp5JvZ26qgTtSLmbm0yeZ
	XFL0AX5xg3+krFwJN9Be3N0Gxl9LghLvULgiwAZxyh+AFuV1WN+wSYepjNTS4kbG0XZHhT
	qWgtlGBflcQdiavq3cM6kwrinyVbMak=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-NjVT6l0HMT-_YCt94dPB7Q-1; Mon,
 22 Apr 2024 23:24:26 -0400
X-MC-Unique: NjVT6l0HMT-_YCt94dPB7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615C11C068C0;
	Tue, 23 Apr 2024 03:24:26 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA181BDAA;
	Tue, 23 Apr 2024 03:24:23 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 4/4] vhost: Reformat vhost_{get, put}_user()
Date: Tue, 23 Apr 2024 13:24:07 +1000
Message-ID: <20240423032407.262329-5-gshan@redhat.com>
In-Reply-To: <20240423032407.262329-1-gshan@redhat.com>
References: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Reformat the macros to use tab as the terminator for each line so
that it looks clean.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a3de9325175f..3be19877f9df 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1207,21 +1207,22 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
-({ \
-	int ret; \
-	if (!vq->iotlb) { \
-		ret = __put_user(x, ptr); \
-	} else { \
-		__typeof__(ptr) to = \
+#define vhost_put_user(vq, x, ptr)					\
+({									\
+	int ret;							\
+	if (!vq->iotlb) {						\
+		ret = __put_user(x, ptr);				\
+	} else {							\
+		__typeof__(ptr) to =					\
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
-		if (to != NULL) \
-			ret = __put_user(x, to); \
-		else \
-			ret = -EFAULT;	\
-	} \
-	ret; \
+						sizeof(*ptr),		\
+						VHOST_ADDR_USED);	\
+		if (to != NULL)						\
+			ret = __put_user(x, to);			\
+		else							\
+			ret = -EFAULT;					\
+	}								\
+	ret;								\
 })
 
 static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
@@ -1252,22 +1253,21 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
 			      &vq->used->idx);
 }
 
-#define vhost_get_user(vq, x, ptr, type)		\
-({ \
-	int ret; \
-	if (!vq->iotlb) { \
-		ret = __get_user(x, ptr); \
-	} else { \
-		__typeof__(ptr) from = \
-			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
-							   sizeof(*ptr), \
-							   type); \
-		if (from != NULL) \
-			ret = __get_user(x, from); \
-		else \
-			ret = -EFAULT; \
-	} \
-	ret; \
+#define vhost_get_user(vq, x, ptr, type)				\
+({									\
+	int ret;							\
+	if (!vq->iotlb) {						\
+		ret = __get_user(x, ptr);				\
+	} else {							\
+		__typeof__(ptr) from =					\
+			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
+						sizeof(*ptr), type);	\
+		if (from != NULL)					\
+			ret = __get_user(x, from);			\
+		else							\
+			ret = -EFAULT;					\
+	}								\
+	ret;								\
 })
 
 #define vhost_get_avail(vq, x, ptr) \
-- 
2.44.0


