Return-Path: <linux-kernel+bounces-20748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB209828492
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD4F1C23F36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043E381A2;
	Tue,  9 Jan 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY/zZuDD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625D36AFF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704798646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DDFZxrU+9MYVeduyTCL7aynBvhEel3T3b/VCxzLnYk=;
	b=RY/zZuDDpEeUjL9xDREeFpOLnPDR90Lk+ASXDMFSSFYqly1RPqyUHcfA+mYCWgXwYAR5Ec
	Mj8TRiyDn/x0CXOET5mgm4zaNqwgocHMi1SmBmfni816NM8L3u12zkIbyJkRskPE0Lap6X
	pzO69Y9ORQiWLR0/BLmZCILbWLriN34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0VDSwIlePUOcLGfVcmQ_2A-1; Tue, 09 Jan 2024 06:10:37 -0500
X-MC-Unique: 0VDSwIlePUOcLGfVcmQ_2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4FD85A58B;
	Tue,  9 Jan 2024 11:10:37 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B765492BE6;
	Tue,  9 Jan 2024 11:10:35 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v7 3/3] vduse: enable Virtio-net device type
Date: Tue,  9 Jan 2024 12:10:25 +0100
Message-ID: <20240109111025.1320976-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This patch adds Virtio-net device type to the supported
devices types.

Initialization fails if the device does not support
VIRTIO_F_VERSION_1 feature, in order to guarantee the
configuration space is read-only. It also fails with
-EPERM if the CAP_NET_ADMIN is missing.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 00f3f562ab5d..8924bbc55635 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -143,6 +143,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1686,6 +1687,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & BIT_ULL(VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -1793,6 +1798,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	int ret;
 	struct vduse_dev *dev;
 
+	ret = -EPERM;
+	if ((config->device_id == VIRTIO_ID_NET) && !capable(CAP_NET_ADMIN))
+		goto err;
+
 	ret = -EEXIST;
 	if (vduse_find_dev(config->name))
 		goto err;
@@ -2036,6 +2045,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.43.0


