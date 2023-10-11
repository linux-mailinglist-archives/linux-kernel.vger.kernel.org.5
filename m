Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4407C4ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbjJKGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345840AbjJKGnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E99E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csqBKeBkUZLQ+DInT3ODQljj1j3iH3HbX8W5xJ28ftc=;
        b=CRGl/ABCFt8cIeSlSDHagbI02GU1LHIzPAS32KojAgsVj15r2tma8vFigAarq2I4LPNxud
        dOTazPnoV74iJroDbtavF14Hi0EFyXnPR7jNnM9D7F3UiwMO7n3gH8+UW3HHz+qw/1lA55
        n3L7f7NfWrGjvYe4uBbXzojFAh3eV5Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-ejz1fDbsMlCzYq1-sYFuig-1; Wed, 11 Oct 2023 02:42:31 -0400
X-MC-Unique: ejz1fDbsMlCzYq1-sYFuig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D321F3C1E9D3;
        Wed, 11 Oct 2023 06:42:30 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC8A51E3;
        Wed, 11 Oct 2023 06:42:27 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v1 3/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
Date:   Wed, 11 Oct 2023 14:42:07 +0800
Message-Id: <20231011064208.2143245-4-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-1-lulu@redhat.com>
References: <20231011064208.2143245-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
and The number of mapping memory pages from the kernel. The userspace
App can use this information to map the pages.

Add struct vhost_reconnect_data/vhost_reconnect_vring for sync the
information in reconnection

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++
 include/uapi/linux/vduse.h         | 43 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 05e72d752fb6..0f15e7ac716b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1347,6 +1347,21 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 	}
+	case VDUSE_GET_RECONNECT_INFO: {
+		struct vduse_reconnect_mmap_info info;
+
+		ret = -EFAULT;
+		if (copy_from_user(&info, argp, sizeof(info)))
+			break;
+
+		info.size = PAGE_SIZE;
+		info.max_index = dev->vq_num + 1;
+
+		if (copy_to_user(argp, &info, sizeof(info)))
+			break;
+		ret = 0;
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 11bd48c72c6c..5ccac535fba6 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -350,4 +350,47 @@ struct vduse_dev_response {
 	};
 };
 
+/**
+ * struct vhost_reconnect_data - saved the reconnect info for device
+ * @reconnect_time: reconnect time for this device. userspace APP needs to do ++
+ *                  while reconnecting
+ * @version; version for userspace APP
+ * @features; Device features negotiated in the last reconnect.
+ * @status; Device status in last reconnect
+ * @nr_vrings; number of vqs
+ */
+
+struct vhost_reconnect_data {
+	__u32 reconnect_time;
+	__u32 version;
+	__u64 features;
+	__u8 status;
+	__u32 nr_vrings;
+};
+
+/**
+ * struct vhost_reconnect_vring -saved the reconnect info for vqs
+ * @last_avail_idx: device available index
+ * @avail_wrap_counter: Driver ring wrap counter
+ */
+struct vhost_reconnect_vring {
+	__u16 last_avail_idx;
+	__u16 avail_wrap_counter;
+};
+
+/**
+ * struct vduse_reconnect_mmap_info
+ * @size: mapping memory size, here we use page_size
+ * @max_index: the number of pages allocated in kernel,just
+ * use for check
+ */
+
+struct vduse_reconnect_mmap_info {
+	__u32 size;
+	__u32 max_index;
+};
+
+#define VDUSE_GET_RECONNECT_INFO \
+	_IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.34.3

