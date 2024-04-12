Return-Path: <linux-kernel+bounces-142730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51A8A2F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FBC1F21876
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830383CBA;
	Fri, 12 Apr 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPe7vVNI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874908289C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928659; cv=none; b=kvqq5sQQyKEc3m14UQSN3EXjDoAOgk+ZUiSyYy7O9YuKNpcWec8wH9UMF2Jszdg7IOelsJpu/P4EUijzvm9YlvnRxilwA+jy66j1VWtnOJlY7QdIFPW8pZPgPF4UIGTRZD5BjEp7Px0Kx8TqeQ8m568t1iAom7LXCM2CrceWfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928659; c=relaxed/simple;
	bh=j1lCtWf8kQGK0h6m9q3I3l1BoBQdXKPTjFjyW0xeUpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMzd4outjcmK3OzY18mLBnCraNYhSP+D1Gymn5KtCmf0Aw2j/QEMP7qAmTJrb6lZUddZLia/CojfZO2NvGVU66wkDpIXMnaOOA6rc3qf1YbrnegdEUWkKD3qq/8hpJtxeD1nyjV6CfFL5p5TR/4X57lGpSzxG9d8Uc6p31DoQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPe7vVNI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwsrIyNME3xvIfwfaV6NG7sB+rLE21QzcYEDoBZyr4Q=;
	b=gPe7vVNIJo9AYLS7OFEUldniAlaoNy7vH1kcc0lMDyDQ4pvyLe0FATz688zpcJPK/kqiU8
	wYyIqOkvQ0mtUaWEpVBpb7hOFUO35Wq3uXcnYQF6E4UPQJsH+7rBziDYegk/lXp+YJYV7u
	n2NmNob++EAtor34npidsLS9RxdVrq4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-5sRcogbPOS20FuEZEaFDgQ-1; Fri,
 12 Apr 2024 09:30:55 -0400
X-MC-Unique: 5sRcogbPOS20FuEZEaFDgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D4AE28B7403;
	Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37C1940C6CBF;
	Fri, 12 Apr 2024 13:30:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 2/5] vduse: Add new ioctl VDUSE_DEV_GET_STATUS
Date: Fri, 12 Apr 2024 21:28:22 +0800
Message-ID: <20240412133017.483407-3-lulu@redhat.com>
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


