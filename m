Return-Path: <linux-kernel+bounces-55981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11B84C479
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8581C251AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4161CF90;
	Wed,  7 Feb 2024 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMGVVyqY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F71CD1B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284836; cv=none; b=uOeovQ6sz57n0IXL9HI8f+wBFXSAdX7D5tNH9935yfepDeu+LHXCfQWMQ5va68EOlP5T7tQb1rjcebwIay04orFoBT0KAdVyRog9QXFOoYhw4erNnMcUbN4fYU79RuyPCiSUcfgbtQA0ky4BkcwhYUWqCV3PZXYOX3KmLPHEAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284836; c=relaxed/simple;
	bh=/j71C6LLegHXOz3snuWsv0xGmVODLdDmNr+bmnXNKGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2011Jv9QAgv18ygmHQVClOndpAJSlwcptQSu2YR2BopMQfV8HiB7YQqpCbd4kBBsAI9KtETV4NUf1lIklGxvPshkIGCeVRSaavk7ppuO3lwAZU9CEXOOnzwa4XEXTXXSdtcR3HHr+rqHUA++C2oT5FWm+rg02zMkfaeHyX8Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMGVVyqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11vsPZmrTyORN2f8NF7cBdxobijSaF6IqQZ7CKve6yA=;
	b=LMGVVyqY+2gP/OVXtD4viCVzO4+YD4TUWKUVEDhHJHs3gc28WojwuTaZVBNbzH7k0jD/mO
	vbL5l9/dUMyU9BRVnS/hcsRvhZpCGcyynoM7nB49LT5UkHLc/ArJWisx+iT6VEBDRbooRa
	ygJ4yuZ2MslQbGNXEOt28VLrpOM9P8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-pTo_-G6PNOeBD3YIKSAkdw-1; Wed,
 07 Feb 2024 00:47:11 -0500
X-MC-Unique: pTo_-G6PNOeBD3YIKSAkdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E371C04B54;
	Wed,  7 Feb 2024 05:47:11 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA41CC1690E;
	Wed,  7 Feb 2024 05:47:08 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 1/5] vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
Date: Wed,  7 Feb 2024 13:43:28 +0800
Message-ID: <20240207054701.616094-2-lulu@redhat.com>
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

The ioctl VDUSE_DEV_GET_CONFIG is used by the Userspace App
to get the device configuration space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
 include/uapi/linux/vduse.h         |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1c1d71d69026..ab246da27616 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1368,6 +1368,27 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 	}
+	case VDUSE_DEV_GET_CONFIG: {
+		struct vduse_config_data config;
+		unsigned long size = offsetof(struct vduse_config_data, buffer);
+
+		ret = -EFAULT;
+		if (copy_from_user(&config, argp, size))
+			break;
+
+		ret = -EINVAL;
+		if (config.offset > dev->config_size || config.length == 0 ||
+		    config.length > dev->config_size - config.offset)
+			break;
+
+		if (copy_to_user(argp + size, dev->config + config.offset,
+				 config.length)) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = 0;
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 11bd48c72c6c..125d7529d91b 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -350,4 +350,7 @@ struct vduse_dev_response {
 	};
 };
 
+/* get device configuration space */
+#define VDUSE_DEV_GET_CONFIG _IOR(VDUSE_BASE, 0x1b, struct vduse_config_data)
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.43.0


