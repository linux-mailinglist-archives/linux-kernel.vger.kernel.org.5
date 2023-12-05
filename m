Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D5804C86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbjLEIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB3FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Go5CbagaE3XYKeSXAgFuW3lKr5JwgDqKZNKpmj7+xFw=;
        b=frjKNqq/4j1UeHsJBjvatzMSKl3Ef2Dd2rK2mWhccdu/iVRgEPcLFhqHVG0C1u3UQNARe0
        BFQDGDAiUwe0GsTkyHj3GazIINuT72sokoiXomOqvrMbbRq1/Zl3uhEvauEsI1IPQwTAtt
        92d+x+0h3qQKblxs/O599gryTK16Et8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-0e4_gnNANvCgaBGDcw9MEw-1; Tue,
 05 Dec 2023 03:35:01 -0500
X-MC-Unique: 0e4_gnNANvCgaBGDcw9MEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C61FA3C0263D;
        Tue,  5 Dec 2023 08:35:00 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44A6D2166B31;
        Tue,  5 Dec 2023 08:34:57 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 2/7] vduse: Add new uAPI for vduse reconnection
Date:   Tue,  5 Dec 2023 16:34:39 +0800
Message-Id: <20231205083444.3029239-3-lulu@redhat.com>
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

To synchronize the information for reconnection, add a new structure
struct vduse_dev_reconnect_data to save the device-related information,
Add the VDUSE_RECONNCT_MMAP_SIZE for the size of mapped memory for each vq
and device status.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/uapi/linux/vduse.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 11bd48c72c6c..c22838247814 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -350,4 +350,26 @@ struct vduse_dev_response {
 	};
 };
 
+/**
+ * struct vduse_dev_reconnect_data - saved the reconnect info for device
+ * @version; version for userspace APP
+ * @reconnected: indetify if this is reconnected.userspace APP needs set this
+ *                to VDUSE_RECONNECT, while reconnecting.kernel will use this
+ *                to indetify if this is reconnect
+ * @features; Device features negotiated in the last connect.
+ * @status; Device status in last reconnect
+ */
+
+struct vduse_dev_reconnect_data {
+	__u32 version;
+#define VDUSE_RECONNECT 1
+#define VDUSE_NOT_RECONNECT 0
+	__u32 reconnected;
+	__u64 features;
+	__u8 status;
+};
+
+/* the reconnection mmap size for each VQ and dev status */
+#define VDUSE_RECONNCT_MMAP_SIZE PAGE_SIZE
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.34.3

