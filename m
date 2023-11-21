Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83C7F265A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjKUHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjKUHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA085C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iZa9dT80BCE+foVlf/TZ2RRVWFHn8gNFqGFDP3tw+0=;
        b=gt3drWoRcXu8WPxeKfUFdVs+nD4H3ojB0l0mA5vva9/fDeL6RoN72+9nFVuCY6J3v39zkg
        M6k0Wc1EtjtIWZeEfh0mC9NzChWz3WCLwC8a7Pzi3GxoDtJlHWLod0I+nkH2SDBQ5/iER9
        uHbEYAkZYUXmzXfQ8O6CqGsOw3oMYDM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-kPUB6VRzNNmmbs2KrBeXsg-1; Tue,
 21 Nov 2023 02:31:06 -0500
X-MC-Unique: kPUB6VRzNNmmbs2KrBeXsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A74B11C0896D;
        Tue, 21 Nov 2023 07:31:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB04E20268CF;
        Tue, 21 Nov 2023 07:31:03 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 3/5] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
Date:   Tue, 21 Nov 2023 15:30:48 +0800
Message-Id: <20231121073050.287080-4-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
References: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++
 include/uapi/linux/vduse.h         | 50 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ccb30e98bab5..d0fe9a7e86ab 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1343,6 +1343,21 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
index 11bd48c72c6c..c0b7133aebfd 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -3,6 +3,7 @@
 #define _UAPI_VDUSE_H_
 
 #include <linux/types.h>
+#include <linux/virtio_net.h>
 
 #define VDUSE_BASE	0x81
 
@@ -350,4 +351,53 @@ struct vduse_dev_response {
 	};
 };
 
+/**
+ * struct vhost_reconnect_data - saved the reconnect info for device
+ * @version; version for userspace APP
+ * @reconnected: indetify if this is reconnected. userspace APP needs set this bit to 1
+ *               while reconnecting.kernel will use this bit to indetify if this is
+ *               reconnect
+ * @features; Device features negotiated in the last connect.
+ * @status; Device status in last reconnect
+ * @nr_vrings; number of active vqs in last connect
+ * @struct virtio_net_config config; the config in last connect
+ */
+
+struct vhost_reconnect_data {
+	__u32 version;
+	__u32 reconnected;
+	__u64 features;
+	__u8 status;
+	__u32 nr_vrings;
+	struct virtio_net_config config;
+};
+
+/**
+ * struct vhost_reconnect_vring -saved the reconnect info for vqs
+ * when use split mode will only use last_avail_idx
+ * when use packed mode will use both last_avail_idx and avail_wrap_counter
+ * userspace App
+ * @last_avail_idx: device last available index
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
+ * use for sanity check
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

