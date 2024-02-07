Return-Path: <linux-kernel+bounces-55983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C685A84C47B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634EF1F232AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59491E4AB;
	Wed,  7 Feb 2024 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8seLXJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D461D557
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284843; cv=none; b=Cl28Pi3kiFG7Obfn4MfhNzMeaEXmNfmwL2wlTi+4f8b+VHVAbzQ1tEq9hId4nPzhWDS21309iC2AfXtzOA+GaAURqJbNiVgdNBx62rzTCbrJIAXDiL2+UxFpamz7GmOrpu7Z/iTkPr/HXbzjAbXET9c37S5SP0sGBtEb9jzTTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284843; c=relaxed/simple;
	bh=cBLjryLsVfu47+tjl5ywQAYVk9Q3xIPJ/WF63oos9zU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltQ7Yhwe0N10/9Yvr58hTBoi5zpfK3g+e2h+h2Wx3PMCF6iT/wZxRsa2jVhFyNXTUV5W9pMrXqL+8O5LLf3wQxU9kNlrxLV3rmYFMsd33DBCFdScLglojLDt/iRgnZRJC5XpU6UPNZ2FwZv2BDK8dn6Y4SOCKXIXA3hHEUcNOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8seLXJQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2Trg27lougTGtlprzjhUTV72eb8EddnblMr0yERIK0=;
	b=i8seLXJQFjjXGxS32e9vPn2GjccPNCgs4y6B6zF1NQWRhS1ZWBhBRtUKNDFiZ60Yaz196b
	PLl3QOxKdm70E9GBGse9LGofDFD/EsvGYe7s9u2t2YV6nhREX6J/wpOzRY8vSeNQzJREEF
	W7grPgZ2tv+Xs38SxVMYAieBkLjPy/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Iw2rWcrUNuqMBJ5bPpkdgA-1; Wed, 07 Feb 2024 00:47:17 -0500
X-MC-Unique: Iw2rWcrUNuqMBJ5bPpkdgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A942E85A58B;
	Wed,  7 Feb 2024 05:47:17 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2AC67C07F51;
	Wed,  7 Feb 2024 05:47:14 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 3/5] vduse: Add function to get/free the pages for reconnection
Date: Wed,  7 Feb 2024 13:43:30 +0800
Message-ID: <20240207054701.616094-4-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-1-lulu@redhat.com>
References: <20240207054701.616094-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add the function vduse_alloc_reconnnect_info_mem
and vduse_alloc_reconnnect_info_mem
These functions allow vduse to allocate and free memory for reconnection
information. The amount of memory allocated is vq_num pages.
Each VQS will map its own page where the reconnection information will be saved

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ef3c9681941e..2da659d5f4a8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -65,6 +65,7 @@ struct vduse_virtqueue {
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
 	struct kobject kobj;
+	unsigned long vdpa_reconnect_vaddr;
 };
 
 struct vduse_dev;
@@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 
 	vq->irq_effective_cpu = curr_cpu;
 }
+static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	unsigned long vaddr = 0;
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		/*page 0~ vq_num save the reconnect info for vq*/
+		vq = dev->vqs[i];
+		vaddr = get_zeroed_page(GFP_KERNEL);
+		if (vaddr == 0)
+			return -ENOMEM;
+
+		vq->vdpa_reconnect_vaddr = vaddr;
+	}
+
+	return 0;
+}
+
+static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		vq = dev->vqs[i];
+
+		if (vq->vdpa_reconnect_vaddr)
+			free_page(vq->vdpa_reconnect_vaddr);
+		vq->vdpa_reconnect_vaddr = 0;
+	}
+
+	return 0;
+}
 
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
@@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	vduse_free_reconnnect_info_mem(dev);
+
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
 	if (ret)
 		goto err_vqs;
+	ret = vduse_alloc_reconnnect_info_mem(dev);
+	if (ret < 0)
+		goto err_mem;
 
 	__module_get(THIS_MODULE);
 
 	return 0;
 err_vqs:
 	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+err_mem:
+	vduse_free_reconnnect_info_mem(dev);
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-- 
2.43.0


