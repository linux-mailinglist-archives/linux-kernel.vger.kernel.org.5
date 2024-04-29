Return-Path: <linux-kernel+bounces-162027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B338B54D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA51C218F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5B3EA71;
	Mon, 29 Apr 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC6N8eHw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959413BBFA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385669; cv=none; b=q3fa/4RORAq2UUyhwUZ4hsM/OqyNfNAKiT1o6KIckYE7XqbfFueswAUUvTT0NZdwveGyEWBgBbel5XJQebvrSJJDv7Qb4QcgK5h5iEnnN/kb7cNU4od7/GWxoCLJzTD1NkBOYA4nF5JkXct2QY6nsVM2pawgS4KjpbCZt/ENWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385669; c=relaxed/simple;
	bh=wPCxHih6c1vg4MIhCKlt1UClyyDOfohtXqvQUkMZ+Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKggz63TADapmTzuE5O0yDbW5B5CCXfkKEvtrVmHq6J1TXTxHqkiUjZAPoVuYOmR1Qh88Hss26VoieVp6L5GEvniFxuk52gAxv13gbki5etX0uYZ1jsD0RRP3e7e0m2AAy0yQJNqWZY4DuQbfCWCaf4wFApIxY9JTj9KqM2HsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC6N8eHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVxg8KMA7vvgaacJi4UzbU3rBDHOjF9aejTpYpkSnrY=;
	b=PC6N8eHwBdmfvUKIZ35oM+mWK5CNsHqfFHdH9Esincmu6zttsp1Hlabxycot+POCBR+jt0
	VpBJMfNiQLl8ogO+SMZijOlMlJQS/c8HKFJU50pHsBnUeLcD7ADccrxv7EkJOV1r8GKQRi
	aH+kTrmTNZ8qVJYQvZLnJQIaZH1AVos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-1Oyf9mrDPxefgbDRlG6VsQ-1; Mon, 29 Apr 2024 06:14:24 -0400
X-MC-Unique: 1Oyf9mrDPxefgbDRlG6VsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75E8F8032FA;
	Mon, 29 Apr 2024 10:14:24 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A6111C060D0;
	Mon, 29 Apr 2024 10:14:22 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 4/4] vhost: Reformat vhost_{get, put}_user()
Date: Mon, 29 Apr 2024 20:14:00 +1000
Message-ID: <20240429101400.617007-5-gshan@redhat.com>
In-Reply-To: <20240429101400.617007-1-gshan@redhat.com>
References: <20240429101400.617007-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Reformat the macros to use tab as the terminator for each line so
that it looks clean.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4ddb9ec2fe46..c1ed5e750521 100644
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


