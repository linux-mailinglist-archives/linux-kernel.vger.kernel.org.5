Return-Path: <linux-kernel+bounces-142729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2258A2F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67FD1F21B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D782C60;
	Fri, 12 Apr 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlZS93Vw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919F824BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928656; cv=none; b=HkClbN8CytGleNGXGgEYUeTo559FIsBHK/tyHcpElkFIRQAnC4tM7PS4l0WDHAGuuM0IrNaXdZvQT1fjTDMWc7sxlQcq+BoKP/j2JPG4jbqnoCwe/vOaIZoHh8+QAHXOnDLhWIbqyZpfURP9raTtiN3c2g4r1hUoIQou7hzeJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928656; c=relaxed/simple;
	bh=/j71C6LLegHXOz3snuWsv0xGmVODLdDmNr+bmnXNKGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6kydjyQfDgO6fhAccV4N8nIXuN0vqb9jsbPDLRHcZIQoq7cTuHdpabHXA2/uMqsd3xFGaF4XwtyZwRi/2CVECFvwwbNNnkl9ZWNmRd90VwTvxNfWw5J13uEsc7CC+X06FzevP3lhy7PiqYUP4GFudzpWK+dpwimsQpFT28qkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlZS93Vw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11vsPZmrTyORN2f8NF7cBdxobijSaF6IqQZ7CKve6yA=;
	b=IlZS93Vw1DFN+H58fNugXQ5/1FxeILVxPS1EtemQw3+C9uXE4kGvZRv2DD8dcGvWBMtfsQ
	7byuNk68TpfSAz7coyYy7DwobFtssH5aCXQl9nJydZExyna1/UYuQQYQLGzfBhT1kbI9oK
	hu2xu5o3WWVZ2Mz72KT75xIwQEwo7Us=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-uELeKrU3Mm-3mm9odQpx1g-1; Fri, 12 Apr 2024 09:30:51 -0400
X-MC-Unique: uELeKrU3Mm-3mm9odQpx1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 984328032FA;
	Fri, 12 Apr 2024 13:30:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4364840C6CBF;
	Fri, 12 Apr 2024 13:30:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 1/5] vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
Date: Fri, 12 Apr 2024 21:28:21 +0800
Message-ID: <20240412133017.483407-2-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-1-lulu@redhat.com>
References: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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


