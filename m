Return-Path: <linux-kernel+bounces-162024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600B8B54CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78967B20B05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D943A1BE;
	Mon, 29 Apr 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIQukdBR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAB36B08
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385662; cv=none; b=O1k2GyotGmRBExj/JMyhjJ2/0MluBI7U9BFN1koH/8vBR1qqgBjrRlV+USHEpFTtkvCr40ckLNUKPkyhiyx5u/8IigX254muP/9xr+GZNy6Kf/I8UpsMmWAVbXlRguk44F4s1I282w0taIf0vUbRqwg7NfTdfjkTTNo8HP1NlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385662; c=relaxed/simple;
	bh=6SjZPcbUbLKZ4v3s8EBPZH85hWGE+Q59iUn92olayg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiYYARmtkntIW78zzR2i+5LkZ42+XZwb6fFhJ6n+6EOqhSgdusc0HT5dTPHJfypA+4k1G3CjQgLwDDt1HpGp3CDG2LfDaRgl/lXoEptNs3zjg++62vPJS+iNYbeQUd1hbA8r/jatjQGKLeYTpwtrHPGFDsCGUgOXwIPEMY9+Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIQukdBR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4Kh6SgnD3DEa96jCeHBWIW1JPmHvCoT4CqiUmflZJE=;
	b=PIQukdBRoUd1MZgEHKPVaOOKlh92zvNf5bv6BJ0DBn4cZL2PtHu9Uji4M3J75f3ACeS1Kr
	BspZwoAk+SixHWvbNBnLw5EQvrScDGqXZ/sLtbP5w2eVI1Nvo8/yvIaWmICpc65eAJ0+u7
	V0PFdNmAOEau80ZRghCadcLwVUuBPzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-K6vRAmYKNN66VAVs_T2FBQ-1; Mon, 29 Apr 2024 06:14:16 -0400
X-MC-Unique: K6vRAmYKNN66VAVs_T2FBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52372100E77E;
	Mon, 29 Apr 2024 10:14:16 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE37C1C060D0;
	Mon, 29 Apr 2024 10:14:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 1/4] vhost: Improve vhost_get_avail_idx() with smp_rmb()
Date: Mon, 29 Apr 2024 20:13:57 +1000
Message-ID: <20240429101400.617007-2-gshan@redhat.com>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

All the callers of vhost_get_avail_idx() are concerned to the memory
barrier, imposed by smp_rmb() to ensure the order of the available
ring entry read and avail_idx read.

Improve vhost_get_avail_idx() so that smp_rmb() is executed when
the avail_idx is advanced. With it, the callers needn't to worry
about the memory barrier.

No functional change intended.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[gshan: repainted vhost_get_avail_idx()]
Reviewed-by: Gavin Shan <gshan@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vhost.c | 106 +++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8995730ce0bf..7aa623117aab 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1290,10 +1290,36 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 		mutex_unlock(&d->vqs[i]->mutex);
 }
 
-static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
-				      __virtio16 *idx)
+static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
-	return vhost_get_avail(vq, *idx, &vq->avail->idx);
+	__virtio16 idx;
+	int r;
+
+	r = vhost_get_avail(vq, idx, &vq->avail->idx);
+	if (unlikely(r < 0)) {
+		vq_err(vq, "Failed to access available index at %p (%d)\n",
+		       &vq->avail->idx, r);
+		return r;
+	}
+
+	/* Check it isn't doing very strange thing with available indexes */
+	vq->avail_idx = vhost16_to_cpu(vq, idx);
+	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
+		vq_err(vq, "Invalid available index change from %u to %u",
+		       vq->last_avail_idx, vq->avail_idx);
+		return -EINVAL;
+	}
+
+	/* We're done if there is nothing new */
+	if (vq->avail_idx == vq->last_avail_idx)
+		return 0;
+
+	/*
+	 * We updated vq->avail_idx so we need a memory barrier between
+	 * the index read above and the caller reading avail ring entries.
+	 */
+	smp_rmb();
+	return 1;
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
@@ -2498,38 +2524,17 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	u16 last_avail_idx;
-	__virtio16 avail_idx;
+	u16 last_avail_idx = vq->last_avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
-	/* Check it isn't doing very strange things with descriptor numbers. */
-	last_avail_idx = vq->last_avail_idx;
-
 	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
-			vq_err(vq, "Failed to access avail idx at %p\n",
-				&vq->avail->idx);
-			return -EFAULT;
-		}
-		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-
-		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved avail index from %u to %u",
-				last_avail_idx, vq->avail_idx);
-			return -EFAULT;
-		}
+		ret = vhost_get_avail_idx(vq);
+		if (unlikely(ret < 0))
+			return ret;
 
-		/* If there's nothing new since last we looked, return
-		 * invalid.
-		 */
-		if (vq->avail_idx == last_avail_idx)
+		if (!ret)
 			return vq->num;
-
-		/* Only get avail ring entries after they have been
-		 * exposed by guest.
-		 */
-		smp_rmb();
 	}
 
 	/* Grab the next descriptor number they're advertising, and increment
@@ -2790,35 +2795,20 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 /* return true if we're sure that avaiable ring is empty */
 bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
 	int r;
 
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
-		return false;
-	}
-
-	return true;
+	/* Treat error as non-empty here */
+	r = vhost_get_avail_idx(vq);
+	return r == 0;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
 /* OK, now we need to know about added descriptors. */
 bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
 	int r;
 
 	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
@@ -2842,25 +2832,13 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
 	smp_mb();
-	r = vhost_get_avail_idx(vq, &avail_idx);
-	if (r) {
-		vq_err(vq, "Failed to check avail idx at %p: %d\n",
-		       &vq->avail->idx, r);
-		return false;
-	}
 
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
+	/* Treat error as empty here */
+	r = vhost_get_avail_idx(vq);
+	if (unlikely(r < 0))
+		return false;
 
-	return false;
+	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.44.0


