Return-Path: <linux-kernel+bounces-16864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9475B82451F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F8E1C22272
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9FC250E5;
	Thu,  4 Jan 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWqyI4kA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863E24B2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704382689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPM6vc4WNmoCS+D/6DliXw39ErXumh08Y6Auv1yi7Xw=;
	b=RWqyI4kAt2rS6gqHGKlUCTtGy3ypuNjz5zNitaN7/4gA/xq5zOeYdRFFVDPjKi71xVblTR
	xiJt0bzBKJuFZBSEnAlncgJmK8RkGOgDauWL8pyXzCYUfrpIxttH72YwUoK+UBwgVDK2j3
	3T4jHJ4e/7z3HjpdvFolMqd0mFNZV9w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-k-i8HbLzOcWdZy7sgA89mg-1; Thu,
 04 Jan 2024 10:38:06 -0500
X-MC-Unique: k-i8HbLzOcWdZy7sgA89mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EA0D3C2AF6D;
	Thu,  4 Jan 2024 15:38:05 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 938ABC15E6A;
	Thu,  4 Jan 2024 15:38:03 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v6 3/3] vduse: enable Virtio-net device type
Date: Thu,  4 Jan 2024 16:37:53 +0100
Message-ID: <20240104153753.2931026-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This patch adds Virtio-net device type to the supported
devices types.

Initialization fails if the device does not support
VIRTIO_F_VERSION_1 feature, in order to guarantee the
configuration space is read-only. It also fails with
-EPERM if the CAP_NET_ADMIN is missing.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 94f54ea2eb06..4057b34ff995 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -151,6 +151,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1694,6 +1695,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & VDUSE_NET_INVALID_FEATURES_MASK))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & (1ULL << VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -1801,6 +1806,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	int ret;
 	struct vduse_dev *dev;
 
+	ret = -EPERM;
+	if ((config->device_id == VIRTIO_ID_NET) && !capable(CAP_NET_ADMIN))
+		goto err;
+
 	ret = -EEXIST;
 	if (vduse_find_dev(config->name))
 		goto err;
@@ -2044,6 +2053,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.43.0


