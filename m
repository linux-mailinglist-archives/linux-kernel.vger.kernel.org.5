Return-Path: <linux-kernel+bounces-55982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F684C47A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B404289B61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA831D545;
	Wed,  7 Feb 2024 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwnglLS9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901161CF92
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284839; cv=none; b=YfCrnWoTkehzVx2y9ofxreLEDWQR0RYM0Mw20LzQt3FZ+bQNzfQ9LyGcfOFrAeMi+e/pvCzV+9EvptM9/kX0xVpuFIOPEB0baBnZC+2WfUNODijuCEiudQPFRluYFt1+phQzyrCor19uBIz9+NNZeG4Nt4ceJoZHomNdvOx6QUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284839; c=relaxed/simple;
	bh=j1lCtWf8kQGK0h6m9q3I3l1BoBQdXKPTjFjyW0xeUpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwT54F+B9ff/4roH/Dlu8JJZhQefMCnhz8WmYAO06Se9ZjoWC8L73e3YcBY6OjzC83meGU0u6JHdBFwvUL4V0Saz/ZvIO4lVe+YtKS+FCpoAqpuW+2LohCquh+Vfp4LAlfha5aH2YaX/OENDy8q7/PLSPc8n/SpU/FuhxiRm86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwnglLS9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwsrIyNME3xvIfwfaV6NG7sB+rLE21QzcYEDoBZyr4Q=;
	b=JwnglLS9NH/V7kX7W39P1A4wZ2sisDAKL0Bw4qQR32eMDaRQOeBxsYwcvxQgirV7kUzmr2
	6EzR0zeV5eI0lsv63/JWiyOvkAcQV8Kmsxi1qPZSHTzRia08eOVvRTXZpciJZ7s+MQxz+r
	QkfiINwneTYC0O1O07RT4zu7vnu1xKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-DczEB4sWPJKuz0ywDfuvYg-1; Wed, 07 Feb 2024 00:47:14 -0500
X-MC-Unique: DczEB4sWPJKuz0ywDfuvYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8902483722F;
	Wed,  7 Feb 2024 05:47:14 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08522C1D36C;
	Wed,  7 Feb 2024 05:47:11 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 2/5] vduse: Add new ioctl VDUSE_DEV_GET_STATUS
Date: Wed,  7 Feb 2024 13:43:29 +0800
Message-ID: <20240207054701.616094-3-lulu@redhat.com>
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

The ioctl VDUSE_DEV_GET_STATUS is used by the Userspace App
to get the device status

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
 include/uapi/linux/vduse.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ab246da27616..ef3c9681941e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1389,6 +1389,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 	}
+
+	case VDUSE_DEV_GET_STATUS:
+		/*
+		 * Returns the status read from device
+		 */
+		ret = put_user(dev->status, (u8 __user *)argp);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 125d7529d91b..f501173a9d69 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -353,4 +353,6 @@ struct vduse_dev_response {
 /* get device configuration space */
 #define VDUSE_DEV_GET_CONFIG _IOR(VDUSE_BASE, 0x1b, struct vduse_config_data)
 
+#define VDUSE_DEV_GET_STATUS _IOR(VDUSE_BASE, 0x1c, __u8)
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.43.0


