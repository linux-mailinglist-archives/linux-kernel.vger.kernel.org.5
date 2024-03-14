Return-Path: <linux-kernel+bounces-102949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F287B8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2E0289C23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1216026C;
	Thu, 14 Mar 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXIZpCpt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AA6024E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402588; cv=none; b=mA2HUMu8W2Uti8PzDF0r9Nk8vMXX9126iScDDmN5s9gVfmsZcPf5cW23UCzS/w4pEvdA07FbqKLPEpcXdXrQ9I1vTNHlJ78M/gsbxhWIW6itKmlhuFBIrrZx37qnz+bUplyZf2/c2NVrgPuxtr5KQGAj5zFWv+oPRaRN78HcNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402588; c=relaxed/simple;
	bh=au2T8EyQNZT1Y2JxCjARB4gUru0OlT7JfM1KnJZLoUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6aqLO2EpzanbOLxnTPYHzMiZ1/VqvCU4jBEaoMTZYAEtQUoXrLOO5uIZxXuK2ma8RfabxvoPM+LTcSsyj0gzN9EcSyzxFnsDCzzC9R2sGcyBlT6PeFFePAWAGfxf5S8eYAjPiYxWdTjPqbMrsk01iUJ2t25cXkhZtFD/uZ2Gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXIZpCpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710402585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4k25JO+YyOBDjJ6GZlIvWxzo6WAx4koWTCdtMZJqhv8=;
	b=KXIZpCptlT1i3HI/UvLzNA2fwgtMs1SVDeSv27gMPsK/IEx5ktDaDeGI9CNUM3UcSxJR6s
	R1sgftjfjEY6CSnPK1yvn7D+uLvd5+VV7VaFWZ79aRJNX18ovlT6eWFAph0txGDBQHqnfu
	0N67j6Po/AmfFTPRagjXu4OSstYhX2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-9gCeRlxeO9iXPE7lJWv7UA-1; Thu, 14 Mar 2024 03:49:42 -0400
X-MC-Unique: 9gCeRlxeO9iXPE7lJWv7UA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85AEF81A260;
	Thu, 14 Mar 2024 07:49:42 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA96B1121306;
	Thu, 14 Mar 2024 07:49:39 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH] virtio_ring: Fix the stale index in available ring
Date: Thu, 14 Mar 2024 17:49:23 +1000
Message-ID: <20240314074923.426688-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The issue is reported by Yihuang Yu who have 'netperf' test on
NVidia's grace-grace and grace-hopper machines. The 'netperf'
client is started in the VM hosted by grace-hopper machine,
while the 'netperf' server is running on grace-grace machine.

The VM is started with virtio-net and vhost has been enabled.
We observe a error message spew from VM and then soft-lockup
report. The error message indicates the data associated with
the descriptor (index: 135) has been released, and the queue
is marked as broken. It eventually leads to the endless effort
to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
and soft-lockup. The stale index 135 is fetched from the available
ring and published to the used ring by vhost, meaning we have
disordred write to the available ring element and available index.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
  -accel kvm -machine virt,gic-version=host                            \
     :                                                                 \
  -netdev tap,id=vnet0,vhost=on                                        \
  -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \

  [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!

Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
ARM64. It should work for other architectures, but performance loss is
expected.

Cc: stable@vger.kernel.org
Reported-by: Yihuang Yu <yihyu@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec7..7d852811c912 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
 	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
+	/*
+	 * Descriptors and available array need to be set before we expose
+	 * the new available array entries. virtio_wmb() should be enough
+	 * to ensuere the order theoretically. However, a stronger barrier
+	 * is needed by ARM64. Otherwise, the stale data can be observed
+	 * by the host (vhost). A stronger barrier should work for other
+	 * architectures, but performance loss is expected.
+	 */
+	virtio_mb(false);
 	vq->split.avail_idx_shadow++;
 	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 						vq->split.avail_idx_shadow);
-- 
2.44.0


