Return-Path: <linux-kernel+bounces-120143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94188D2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CFF2E445C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9513E6A3;
	Tue, 26 Mar 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmW55Etd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034113E41E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496364; cv=none; b=YXJfP6EiGpBFTch86P+O8n0p53NcyMEguFP++LZVQNyyA0Zdg2x3Sd6Igj1783ZjwlAQReXOTn2zLqPGw5/1HMmz4PnipmF/oI6zZVSnMA2VtkQNq9l5PoHXADwG6nxpz5FpCKRK9oas8+9k+vY/d++lTxwRbKkDqT3JOk0Cr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496364; c=relaxed/simple;
	bh=C66pxqnaYgvSMHHvu/Rl5/6ccP5Y4wM4IySE5hpm7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LubzUeswFlXCyyyAZ/aRbGU5cEXtDhLgTRyczi3cL9XH0taUkK69DoT96ghuB9eQ/4Y4qRnjkmAEDXQNvw6tyUOVhCwoUiOLUQq50VMRZuhab042UhRnqarZHGb3ddZ4vtmlZPQaKTFuGRgRFR/4OyUr/5GvILIHKTH4NEykHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmW55Etd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711496361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGW7zYz0pRH3cTXT89dCGhJ9Ht7hdJj/uu/aueTV3H4=;
	b=KmW55EtdJzmg/lDAd4QGhnMVqe6g8QGrP44uWcm5KD8RhfV6E+vOz3C2DSNh7JyXsiUzLq
	QllAJur4ZzSQ0XabkITv+iE/LYLOA2HVq5tLGRmwXtLHnfY60Y5j4UAS4/Za6cvtdp1ueB
	by8M/oMNZLrs4+Sq+v4Hy3QMssc3tZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-DIN0kOIZPSKlaT7y_Yhb7g-1; Tue, 26 Mar 2024 19:39:18 -0400
X-MC-Unique: DIN0kOIZPSKlaT7y_Yhb7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EA30800264;
	Tue, 26 Mar 2024 23:39:17 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC031121306;
	Tue, 26 Mar 2024 23:39:13 +0000 (UTC)
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
Subject: [PATCH v2 2/2] vhost: Add smp_rmb() in vhost_enable_notify()
Date: Wed, 27 Mar 2024 09:38:46 +1000
Message-ID: <20240326233846.1086253-3-gshan@redhat.com>
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

A smp_rmb() has been missed in vhost_enable_notify(), inspired by
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

Add the missed smp_rmb() in vhost_enable_notify(). Note that it
should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
("vhost: cache avail index in vhost_enable_notify()").

Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
Cc: <stable@kernel.org> # v5.18+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/vhost/vhost.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 00445ab172b3..58f9d6a435f0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2847,9 +2847,18 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+
 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	if (vq->avail_idx != vq->last_avail_idx) {
+		/* Similar to what's done in vhost_get_vq_desc(), we need
+		 * to ensure the available ring entries have been exposed
+		 * by guest.
+		 */
+		smp_rmb();
+		return true;
+	}
 
-	return vq->avail_idx != vq->last_avail_idx;
+	return false;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.44.0


