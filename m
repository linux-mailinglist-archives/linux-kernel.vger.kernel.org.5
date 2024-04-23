Return-Path: <linux-kernel+bounces-154453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBB8ADC39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BAE1F22FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C01C695;
	Tue, 23 Apr 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLlgDQeL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894017C66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842664; cv=none; b=qPFq05vUy1HIwHuzeAv8wI+KoG+B7sQ/zHqL3jL/rkgbVaWVDOIf901iFNMQfl2ms5C24BC2JdZq7oC4zHj5gx5zYzJBWsZxQTBtXIDKdvbzRJN8K+ihxBdL222Vni3rR/eSriOwGvH23DLFGVJL+pA6nPb25HoCy52Vf8JDed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842664; c=relaxed/simple;
	bh=LfYpnyQAsBnDVm5T77C4UR9syKWZT60Wqobuc9Uot60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKcrGl7+qvqk47VWWk5ZBEwtmsRfLv+JSBndGu+2f2/tXzssPIU/4WjvR2QNcc95baI+iRBzIvjl/0RAiTBona2ly86t9xzYHuZJw7ywEscv9G+R9WPWHg3pCxrguvEds3C2d/Z0kE/ckRLC1NoUSuQhG0bPTWxq4ebGorE3dOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLlgDQeL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdbGfF2EWeWPE3Aari8NoS/LX4R/2UfIijpnrdTbWd0=;
	b=gLlgDQeLWkTHxa09oG0fESn8IjtktJfAbtH3ii1bnGiuDK9X0k+GmG4TCp1Y1FKTUFHD29
	aOr1Yuij78dtw7DOGMDTROgLg1ZW7f4pdQlhs0Zpzeku4rsmU+cEpb1aUVabRQb6S2JScb
	q21lb7wTYxidbARj3Vp7ASkHCw1ryaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-cfbfH8CoNKiFSi8BANP4Gg-1; Mon, 22 Apr 2024 23:24:18 -0400
X-MC-Unique: cfbfH8CoNKiFSi8BANP4Gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B54D80B935;
	Tue, 23 Apr 2024 03:24:18 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2395A1BDAA;
	Tue, 23 Apr 2024 03:24:15 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 1/4] vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
Date: Tue, 23 Apr 2024 13:24:04 +1000
Message-ID: <20240423032407.262329-2-gshan@redhat.com>
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

The local variable @last_avail_idx is equivalent to vq->last_avail_idx.
So the code can be simplified a bit by dropping the local variable
@last_avail_idx.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8995730ce0bf..ef7942103232 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2498,14 +2498,11 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	u16 last_avail_idx;
 	__virtio16 avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
 	/* Check it isn't doing very strange things with descriptor numbers. */
-	last_avail_idx = vq->last_avail_idx;
-
 	if (vq->avail_idx == vq->last_avail_idx) {
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
@@ -2514,16 +2511,16 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		}
 		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
-		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
+		if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
 			vq_err(vq, "Guest moved avail index from %u to %u",
-				last_avail_idx, vq->avail_idx);
+				vq->last_avail_idx, vq->avail_idx);
 			return -EFAULT;
 		}
 
 		/* If there's nothing new since last we looked, return
 		 * invalid.
 		 */
-		if (vq->avail_idx == last_avail_idx)
+		if (vq->avail_idx == vq->last_avail_idx)
 			return vq->num;
 
 		/* Only get avail ring entries after they have been
@@ -2534,10 +2531,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
+	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
 		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       last_avail_idx,
-		       &vq->avail->ring[last_avail_idx % vq->num]);
+		       vq->last_avail_idx,
+		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
 		return -EFAULT;
 	}
 
-- 
2.44.0


