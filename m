Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F47804C85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbjLEIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344835AbjLEIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:35:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB36138
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oONAYYTEgNjcC4Phz29fvyjfObj+V7u6RFkS9+bCyRY=;
        b=euMKehM04CKTsO86meJoF6ZcSpOiO5SlsKAUDSTv94pydl1ZNTU4+OfTb4Qb/7n/ockTRP
        fEACS9Ms7KJTUzoZigsSkXGQTBqAU7tS9qDl7sG3hPUr3VeJ6MKQkqPK0X2Aqdy+gl/iVi
        VT8YTLnzPn7wDZQpWth/Qlc4R3uonkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-w8Dp9Zc-MxWUoIp4NgUW3w-1; Tue, 05 Dec 2023 03:35:04 -0500
X-MC-Unique: w8Dp9Zc-MxWUoIp4NgUW3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E81AB101A52A;
        Tue,  5 Dec 2023 08:35:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 669D92166B31;
        Tue,  5 Dec 2023 08:35:01 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 3/7] vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
Date:   Tue,  5 Dec 2023 16:34:40 +0800
Message-Id: <20231205083444.3029239-4-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-1-lulu@redhat.com>
References: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl VDUSE_GET_RECONNECT_INFO is used by the Userspace App
to get the device configuration space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
 include/uapi/linux/vduse.h         |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 26b7e29cb900..dd074a7b4bc7 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1273,6 +1273,27 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
index c22838247814..5280042ced23 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -372,4 +372,7 @@ struct vduse_dev_reconnect_data {
 /* the reconnection mmap size for each VQ and dev status */
 #define VDUSE_RECONNCT_MMAP_SIZE PAGE_SIZE
 
+/* get device configuration space */
+#define VDUSE_DEV_GET_CONFIG _IOR(VDUSE_BASE, 0x1b, struct vduse_config_data)
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.34.3

