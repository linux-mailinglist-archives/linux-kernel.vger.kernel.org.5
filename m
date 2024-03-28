Return-Path: <linux-kernel+bounces-122213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E288F383
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519051C2354C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F44101D4;
	Thu, 28 Mar 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR59b+Wo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD31BC49
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585347; cv=none; b=EeXVbjuNBcFA4ASBiFIf7mxD4d6h19bVHSNMc+UzTQGgfs0NrFkU2zIFOML1UTzBqnh7pPc7OduVXNEPbYPOHvHI7u/yYJwQH2JLeeU7sco8hUrpRrEh9IVeF0tOojSq8+mVkkJgVJ5ku8jnOuKxFo53YsX+hi5mXAgpXY+X3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585347; c=relaxed/simple;
	bh=NEWB7Jyx6ZTqoQYpQmN8i2qbWCNLe6BWjFi5j4OmaIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J99R0m7qrWLxHXcD/dap0XqaBh+K6fDmX4LzV6YqCNy4uH5OXhJvK2xFlqO4W6F2Ix4ViZzCANTRrlbuheCJs9Wpra1Pt1wMMvss4L8m8glWu7nnAQB5Svys3UAONKcQn2lYMFAGU3ebdPhdtIl70UVXEkteK60naYKc4gfaQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IR59b+Wo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711585344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ak0Cq/D1N2M9Qn2X1+lt/FpcfjVoz3V3sPZ0fz5NBc=;
	b=IR59b+WozRgzp90VLsFGZzIBvACvL8X4ihIead5eUtVLH7vFHp9W0brA3RoWa93JunNUjL
	O8zYgfS+yf/lUyHt7Fw/HXN4julc9/bNCcDxpTj4GpW7b333dfAW1ILqtIEwV1givsQHEW
	dLT7Z+ZeSHJyk/UZJyqXE6it0RepPIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-Wz9J29WXMTaRPc9LhpVekA-1; Wed, 27 Mar 2024 20:22:21 -0400
X-MC-Unique: Wz9J29WXMTaRPc9LhpVekA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B388B800265;
	Thu, 28 Mar 2024 00:22:19 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BBCDE2166B31;
	Thu, 28 Mar 2024 00:22:15 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	will@kernel.org,
	davem@davemloft.net,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	keirf@google.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with smp_rmb()
Date: Thu, 28 Mar 2024 10:21:49 +1000
Message-ID: <20240328002149.1141302-4-gshan@redhat.com>
In-Reply-To: <20240328002149.1141302-1-gshan@redhat.com>
References: <20240328002149.1141302-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

All the callers of vhost_get_avail_idx() are concerned to the memory
barrier, imposed by smp_rmb() to ensure the order of the available
ring entry read and avail_idx read.

Improve vhost_get_avail_idx() so that smp_rmb() is executed when
the avail_idx is advanced. With it, the callers needn't to worry
about the memory barrier.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 75 +++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 49 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 32686c79c41d..e6882f4f6ce2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1290,10 +1290,28 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 		mutex_unlock(&d->vqs[i]->mutex);
 }
 
-static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
-				      __virtio16 *idx)
+static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
-	return vhost_get_avail(vq, *idx, &vq->avail->idx);
+	__virtio16 avail_idx;
+	int r;
+
+	r = vhost_get_avail(vq, avail_idx, &vq->avail->idx);
+	if (unlikely(r)) {
+		vq_err(vq, "Failed to access avail idx at %p\n",
+		       &vq->avail->idx);
+		return r;
+	}
+
+	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	if (vq->avail_idx != vq->last_avail_idx) {
+		/* Ensure the available ring entry read happens
+		 * before the avail_idx read when the avail_idx
+		 * is advanced.
+		 */
+		smp_rmb();
+	}
+
+	return 0;
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
@@ -2499,7 +2517,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
 	u16 last_avail_idx;
-	__virtio16 avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
@@ -2507,12 +2524,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	last_avail_idx = vq->last_avail_idx;
 
 	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
-			vq_err(vq, "Failed to access avail idx at %p\n",
-				&vq->avail->idx);
+		if (unlikely(vhost_get_avail_idx(vq)))
 			return -EFAULT;
-		}
-		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
 		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
 			vq_err(vq, "Guest moved used index from %u to %u",
@@ -2525,11 +2538,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		 */
 		if (vq->avail_idx == last_avail_idx)
 			return vq->num;
-
-		/* Only get avail ring entries after they have been
-		 * exposed by guest.
-		 */
-		smp_rmb();
 	}
 
 	/* Grab the next descriptor number they're advertising, and increment
@@ -2790,35 +2798,19 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 /* return true if we're sure that avaiable ring is empty */
 bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
-	int r;
-
 	if (vq->avail_idx != vq->last_avail_idx)
 		return false;
 
-	r = vhost_get_avail_idx(vq, &avail_idx);
-	if (unlikely(r))
-		return false;
-
-	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-	if (vq->avail_idx != vq->last_avail_idx) {
-		/* Since we have updated avail_idx, the following
-		 * call to vhost_get_vq_desc() will read available
-		 * ring entries. Make sure that read happens after
-		 * the avail_idx read.
-		 */
-		smp_rmb();
+	if (unlikely(vhost_get_avail_idx(vq)))
 		return false;
-	}
 
-	return true;
+	return vq->avail_idx == vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
 /* OK, now we need to know about added descriptors. */
 bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
 	int r;
 
 	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
@@ -2842,25 +2834,10 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
 	smp_mb();
-	r = vhost_get_avail_idx(vq, &avail_idx);
-	if (r) {
-		vq_err(vq, "Failed to check avail idx at %p: %d\n",
-		       &vq->avail->idx, r);
+	if (unlikely(vhost_get_avail_idx(vq)))
 		return false;
-	}
-
-	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-	if (vq->avail_idx != vq->last_avail_idx) {
-		/* Since we have updated avail_idx, the following
-		 * call to vhost_get_vq_desc() will read available
-		 * ring entries. Make sure that read happens after
-		 * the avail_idx read.
-		 */
-		smp_rmb();
-		return true;
-	}
 
-	return false;
+	return vq->avail_idx != vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.44.0


