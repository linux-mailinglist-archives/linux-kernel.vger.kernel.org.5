Return-Path: <linux-kernel+bounces-162026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7938B54D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8357B1F223E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18043BBFE;
	Mon, 29 Apr 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnrlGBdL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B13B798
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385667; cv=none; b=UYl9+Ks/NA/M8mnxHX57WSBsvDSq+Kr0onU5FfjhOdHlQoBJOZszuy/A4VrSyTxtJpE3cn+Qb4mJmKYkX384/fTOZHsmIyk8pjeQ/2cP7v86hn69xiEiYIEUSaBFbTXeoAN6oFW8KbrODur7QXRlmt5IytiHvPI82M97ZBKR0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385667; c=relaxed/simple;
	bh=91YU68g5/Rx6XCivSIXx5FuQeNsrW8rUkwDzyohzLvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZKROJaugud0EWrRRkbAVUWGxYS7l3c01TtmP14pQ391pdTU6VVEVPsRv5XkpQikjUwGE2VTTfHLwy5mT9V/WSJiXJJMCCIXggT7Nl1I2jpIKEy1QozdDMYrUJaLB0/UK3TiJcc4ZE/M8A4BR+wSiwdWQg3vafjqEoUGWwg70wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnrlGBdL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9NTPnuJF9Q3tKbWrrHkgNuzaaSPtWXInMPFcIIlGPM=;
	b=VnrlGBdLelgELGjj/2Z0STzk1v9dAmkhHImQEca4czD3vnYfc1/qxED17SxBscIpF5+kaM
	bCFC07TU+sTF2ACX4cXCFBAPZZwnXK27Z1+nKMBj3khqHNjzVTKl5OwF2jPyqPTDSm8gTR
	z7RJMIWJEEG9pjrrvLUl0kvKJk0fS50=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-0qXNvE84N4Gy1o1ZFEXugg-1; Mon,
 29 Apr 2024 06:14:22 -0400
X-MC-Unique: 0qXNvE84N4Gy1o1ZFEXugg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02D301E441CE;
	Mon, 29 Apr 2024 10:14:22 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA671C060D0;
	Mon, 29 Apr 2024 10:14:19 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 3/4] vhost: Improve vhost_get_avail_head()
Date: Mon, 29 Apr 2024 20:13:59 +1000
Message-ID: <20240429101400.617007-4-gshan@redhat.com>
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

Improve vhost_get_avail_head() so that the head or errno is returned.
With it, the relevant sanity checks are squeezed to vhost_get_avail_head()
and vhost_get_vq_desc() is further simplified.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b278c0333a66..4ddb9ec2fe46 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1322,11 +1322,27 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 	return 1;
 }
 
-static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
-				       __virtio16 *head, int idx)
+static inline int vhost_get_avail_head(struct vhost_virtqueue *vq)
 {
-	return vhost_get_avail(vq, *head,
-			       &vq->avail->ring[idx & (vq->num - 1)]);
+	__virtio16 head;
+	int r;
+
+	r = vhost_get_avail(vq, head,
+			    &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
+	if (unlikely(r)) {
+		vq_err(vq, "Failed to read head: index %u address %p\n",
+		       vq->last_avail_idx,
+		       &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
+		return r;
+	}
+
+	r = vhost16_to_cpu(vq, head);
+	if (unlikely(r >= vq->num)) {
+		vq_err(vq, "Invalid head %d (%u)\n", r, vq->num);
+		return -EINVAL;
+	}
+
+	return r;
 }
 
 static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
@@ -2523,9 +2539,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		      struct vhost_log *log, unsigned int *log_num)
 {
 	struct vring_desc desc;
-	unsigned int i, head, found = 0;
-	__virtio16 ring_head;
-	int ret, access;
+	unsigned int i, found = 0;
+	int head, ret, access;
 
 	if (vq->avail_idx == vq->last_avail_idx) {
 		ret = vhost_get_avail_idx(vq);
@@ -2536,23 +2551,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			return vq->num;
 	}
 
-	/* Grab the next descriptor number they're advertising, and increment
-	 * the index we've seen. */
-	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
-		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       vq->last_avail_idx,
-		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
-		return -EFAULT;
-	}
-
-	head = vhost16_to_cpu(vq, ring_head);
-
-	/* If their number is silly, that's an error. */
-	if (unlikely(head >= vq->num)) {
-		vq_err(vq, "Guest says index %u > %u is available",
-		       head, vq->num);
-		return -EINVAL;
-	}
+	/* Grab the next descriptor number they're advertising */
+	head = vhost_get_avail_head(vq);
+	if (unlikely(head < 0))
+		return head;
 
 	/* When we start there are none of either input nor output. */
 	*out_num = *in_num = 0;
-- 
2.44.0


