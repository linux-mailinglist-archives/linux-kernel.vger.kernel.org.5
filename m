Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADA804C83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbjLEIe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586ACFA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvXGrTDaK1+8fbsQp8oZ7MPiXUC1xBJXWn44I4Pe5Yo=;
        b=hgJWgnAGmd8CwrnaiZfIdqpwngHHql0N0JA9LfFwNMF00wfyBxzcCm9cYoI/sy9NMR/dqk
        A34gq3/fIQBOmLrfmfQMWKH1Qxo8h8T9tYgS2hzfOiSyHavD7JurwTa1WIWznZtbDMehjc
        diNT7OtYR4VOWt2PLJjTXPWVBfR8We4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-nLPidf_8NBSXCDQYWq1QDQ-1; Tue,
 05 Dec 2023 03:34:57 -0500
X-MC-Unique: nLPidf_8NBSXCDQYWq1QDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A499C1C068DD;
        Tue,  5 Dec 2023 08:34:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 248002166B31;
        Tue,  5 Dec 2023 08:34:54 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 1/7] vdpa: Move struct vdpa_vq_state to uAPI
Date:   Tue,  5 Dec 2023 16:34:38 +0800
Message-Id: <20231205083444.3029239-2-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-1-lulu@redhat.com>
References: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct vdpa_vq_state to uAPI for vduse reconnect.
Userspace and kernel will use this structure to synchronize the vq status

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/linux/vdpa.h      | 29 +----------------------------
 include/uapi/linux/vdpa.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 43f59ef10cc9..62ce97bce934 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -8,6 +8,7 @@
 #include <linux/vhost_iotlb.h>
 #include <linux/virtio_net.h>
 #include <linux/if_ether.h>
+#include <uapi/linux/vdpa.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -29,34 +30,6 @@ struct vdpa_notification_area {
 	resource_size_t size;
 };
 
-/**
- * struct vdpa_vq_state_split - vDPA split virtqueue state
- * @avail_index: available index
- */
-struct vdpa_vq_state_split {
-	u16	avail_index;
-};
-
-/**
- * struct vdpa_vq_state_packed - vDPA packed virtqueue state
- * @last_avail_counter: last driver ring wrap counter observed by device
- * @last_avail_idx: device available index
- * @last_used_counter: device ring wrap counter
- * @last_used_idx: used index
- */
-struct vdpa_vq_state_packed {
-	u16	last_avail_counter:1;
-	u16	last_avail_idx:15;
-	u16	last_used_counter:1;
-	u16	last_used_idx:15;
-};
-
-struct vdpa_vq_state {
-	union {
-		struct vdpa_vq_state_split split;
-		struct vdpa_vq_state_packed packed;
-	};
-};
 
 struct vdpa_mgmt_dev;
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 54b649ab0f22..f4bc3589685e 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -7,6 +7,8 @@
 #ifndef _UAPI_LINUX_VDPA_H_
 #define _UAPI_LINUX_VDPA_H_
 
+#include <linux/types.h>
+
 #define VDPA_GENL_NAME "vdpa"
 #define VDPA_GENL_VERSION 0x1
 
@@ -60,4 +62,33 @@ enum vdpa_attr {
 	VDPA_ATTR_MAX,
 };
 
+/**
+ * struct vdpa_vq_state_split - vDPA split virtqueue state
+ * @avail_index: available index
+ */
+struct vdpa_vq_state_split {
+	__u16 avail_index;
+};
+
+/**
+ * struct vdpa_vq_state_packed - vDPA packed virtqueue state
+ * @last_avail_counter: last driver ring wrap counter observed by device
+ * @last_avail_idx: device available index
+ * @last_used_counter: device ring wrap counter
+ * @last_used_idx: used index
+ */
+struct vdpa_vq_state_packed {
+	__u16 last_avail_counter : 1;
+	__u16 last_avail_idx : 15;
+	__u16 last_used_counter : 1;
+	__u16 last_used_idx : 15;
+};
+
+struct vdpa_vq_state {
+	union {
+		struct vdpa_vq_state_split split;
+		struct vdpa_vq_state_packed packed;
+	};
+};
+
 #endif
-- 
2.34.3

