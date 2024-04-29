Return-Path: <linux-kernel+bounces-162025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4058B54D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0819B282CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DC3B1AA;
	Mon, 29 Apr 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXqo3idc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0C3B29A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385667; cv=none; b=VVo536m0RlRRjbyc67js9E3GbzMhOSEVWjpY2wJmUED0G2LUp316RHdwPoipTubPPVTxAtk8ogtZ3+hdK4tW1il3hMr+ziDn+pEgthSoIaW76IwGQSfFHnWbKJIxdkLV4gBmwR4WTY8zjJe2ekynqO5qyhLqi3pDoRPCxMpFdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385667; c=relaxed/simple;
	bh=wFFVcm/k79HiZBQXjR6hHvK8Eq3yzCmKghIT42hEDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gabo9m2p2wTOYAWHEU6lPKqwQCbhEY7mywNJTvbNVsM0F8vTzNaZn4jPBCClTF/Pu5pyIGpjakYKBezdKNxqXAZUFtdKuvbKb2piDcPZi6p27YubEiiHD8sVJeIg3tfSHZfgfJ+ERd3dBnHZq1RnPYbUhrV5htPjKbUp7iywuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXqo3idc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ+t0av/EOP1urgumrrp1t7Px6sEa+YzHYZfwcovyAc=;
	b=VXqo3idcXUV5Q4coeNFgm/6h0cjL7DqJF6ECVI382pZAPIeh5gYX5St3gNHLQU1KzxhC7O
	91zpblyH9UVgW6DVfNZACG33tZWCorZfu3giMTlbdv00fv4mHCnzz5Al2tN88g2dvdtyIP
	L0nt3kDRH6hrD4vFDkGDjsYzr4etiuU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-IldMwNX_M8WvfhBrYQeNAw-1; Mon,
 29 Apr 2024 06:14:19 -0400
X-MC-Unique: IldMwNX_M8WvfhBrYQeNAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 210513C025D0;
	Mon, 29 Apr 2024 10:14:19 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E42A11C060D1;
	Mon, 29 Apr 2024 10:14:16 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 2/4] vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
Date: Mon, 29 Apr 2024 20:13:58 +1000
Message-ID: <20240429101400.617007-3-gshan@redhat.com>
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

The local variable @last_avail_idx is equivalent to vq->last_avail_idx.
So the code can be simplified a bit by dropping the local variable
@last_avail_idx.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7aa623117aab..b278c0333a66 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2524,7 +2524,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	u16 last_avail_idx = vq->last_avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
@@ -2539,10 +2538,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
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


