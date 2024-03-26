Return-Path: <linux-kernel+bounces-120142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4876A88D2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8F8B22135
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767A13E04C;
	Tue, 26 Mar 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGSfsO/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BC13E036
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496359; cv=none; b=f4XktRU0FL5r90LuKfZyUHqu8gSLosKFNKuFGIVDdRJh+Umn+s4yFN8exlPjwekH6M/vyXDpZfvONbSdDeL9eK1g8ja7wASAc7mAeLwblW4n5lSsMsZqmPTSkZzyhJi/oePgzhXfRRCpepgtPolSX9Lg2W80m82db9lF21/x5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496359; c=relaxed/simple;
	bh=fWYVtaH0/z/cCVWdfxOLtkKAaxll/03zmW3kINIVDTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6jTpMvSvuwVPbkmFztAfK6a7NIJ75HjJRMqhSApjx3BtfQD6ZjNLfXs/AM3YPCqaL0jpReh5sP6l7Y/Icg0IqbXzzkX50nkEvL+tQOCXlIKHaNtSBRRGZ/XO3ivriGTq/2bzq48WBmdgXWHfRVO1tBz6wiupdjYZuiwt5U5wEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGSfsO/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711496357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZ+JJ9n8sK7PpPAJN/QuwYe5pLKlmB/LHTMULmu89sw=;
	b=GGSfsO/5w2NtiYOtmiVkw/ZNBxXB6Fs5VGO9eknLadYxNWjiGumpIxm/Qn8SXTMkZXYTQM
	Hh7ePE2IyQ1Jyv3SAoYMAA7wpedHGcaY23LC8QWMkzTsTRjsko+slnpHWiU5F2YUhjl6BQ
	Bpb0UBm1M60cBvouYB1HT5GcQRrDqFM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-M8JCPtOJP2CGDkT1ZpLatA-1; Tue, 26 Mar 2024 19:39:13 -0400
X-MC-Unique: M8JCPtOJP2CGDkT1ZpLatA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56420811E81;
	Tue, 26 Mar 2024 23:39:13 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 851E21121306;
	Tue, 26 Mar 2024 23:39:09 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	keirf@google.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Date: Wed, 27 Mar 2024 09:38:45 +1000
Message-ID: <20240326233846.1086253-2-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-1-gshan@redhat.com>
References: <20240326233846.1086253-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
available ring entries pushed by guest can be observed by vhost
in time, leading to stale available ring entries fetched by vhost
in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
grace-hopper (ARM64) platform.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
  -accel kvm -machine virt,gic-version=host -cpu host          \
  -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
  -m 4096M,slots=16,maxmem=64G                                 \
  -object memory-backend-ram,id=mem0,size=4096M                \
   :                                                           \
  -netdev tap,id=vnet0,vhost=true                              \
  -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
   :
  guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
  virtio_net virtio0: output.0:id 100 is not a head!

Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
should be safe until vq->avail_idx is changed by commit 275bf960ac697
("vhost: better detection of available buffers").

Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
Cc: <stable@kernel.org> # v4.11+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..00445ab172b3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	r = vhost_get_avail_idx(vq, &avail_idx);
 	if (unlikely(r))
 		return false;
+
 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	if (vq->avail_idx != vq->last_avail_idx) {
+		/* Similar to what's done in vhost_get_vq_desc(), we need
+		 * to ensure the available ring entries have been exposed
+		 * by guest.
+		 */
+		smp_rmb();
+		return false;
+	}
 
-	return vq->avail_idx == vq->last_avail_idx;
+	return true;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
-- 
2.44.0


