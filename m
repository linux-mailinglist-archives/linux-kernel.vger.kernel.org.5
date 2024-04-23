Return-Path: <linux-kernel+bounces-154454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDB8ADC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7733E1F22FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0621D52D;
	Tue, 23 Apr 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNPRos7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE61CA81
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842667; cv=none; b=W+LVDytD9nLgkIfUghVEZFb9Zy2TRlQqNbJ8H94Iaa+w0kaTjPpD7bWB8ortUKrCXZEoaYPq/F2A5iSA+c5K7jlWf/c5eg4+vCQZbJXVIAUWn1N9eulBchZ86u1pS7k32BMSAfrGHmuFq7RBB+d5c6eZyajdI4oiXQhBh445JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842667; c=relaxed/simple;
	bh=LRQl9lv2M8QSOZPByVQiOvj73HlXJF/ZAmTJj/fGtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGi37c1wUxRWyXxUDfNw7kQUwQl4tL6OLSLurP7fH47e/TSJ6+QGTzrA83epfpzdchqTF4Gn5i8Vn3A3RMGkwTA3Qgg/m1PFeJFqX98NX7ckJnINM6zyw0ixe23j9H8orT6JhEXJn+jsvWVKR18eVHTzG+3jyPkH+9rrkQzWpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNPRos7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BuCY3v8aKDYplSDVVzxpIvd+2taH57MWRDqJV/LGJ4=;
	b=XNPRos7K5V8ohkM4l1Md0+oWydcxM/C0+uZqAUOPZnUyn4sQEUpsxCWj+ry/G5xYSocm4u
	QW3rfBiKVAHies/orIlisLdnF51dIkzOHwRvFR7sai0Fw3PN0mHS8qxvsgIwYpCb8N12/E
	ngzT7J8p3RilDkt0D1g67dqi4i/sdEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-O2h3yeDePoGQV3yoIrddFw-1; Mon, 22 Apr 2024 23:24:21 -0400
X-MC-Unique: O2h3yeDePoGQV3yoIrddFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0F380591B;
	Tue, 23 Apr 2024 03:24:21 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD1E51BDAA;
	Tue, 23 Apr 2024 03:24:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 2/4] vhost: Improve vhost_get_avail_idx() with smp_rmb()
Date: Tue, 23 Apr 2024 13:24:05 +1000
Message-ID: <20240423032407.262329-3-gshan@redhat.com>
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

All the callers of vhost_get_avail_idx() are concerned to the memory
barrier, imposed by smp_rmb() to ensure the order of the available
ring entry read and avail_idx read.

Improve vhost_get_avail_idx() so that smp_rmb() is executed when
the avail_idx is advanced. With it, the callers needn't to worry
about the memory barrier.

No functional change intended.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 91 ++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 57 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ef7942103232..b3adc0bc9e72 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1290,10 +1290,34 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
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
+	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
+		vq_err(vq, "Invalid avail index change from %u to %u",
+		       vq->last_avail_idx, vq->avail_idx);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
@@ -2498,35 +2522,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	__virtio16 avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
-	/* Check it isn't doing very strange things with descriptor numbers. */
 	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
-			vq_err(vq, "Failed to access avail idx at %p\n",
-				&vq->avail->idx);
-			return -EFAULT;
-		}
-		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-
-		if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved avail index from %u to %u",
-				vq->last_avail_idx, vq->avail_idx);
-			return -EFAULT;
-		}
+		ret = vhost_get_avail_idx(vq);
+		if (unlikely(ret))
+			return ret;
 
 		/* If there's nothing new since last we looked, return
 		 * invalid.
 		 */
 		if (vq->avail_idx == vq->last_avail_idx)
 			return vq->num;
-
-		/* Only get avail ring entries after they have been
-		 * exposed by guest.
-		 */
-		smp_rmb();
 	}
 
 	/* Grab the next descriptor number they're advertising, and increment
@@ -2787,35 +2795,19 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
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
@@ -2839,25 +2831,10 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
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


