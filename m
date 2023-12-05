Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C009804C93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbjLEIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjLEIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702BE191
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OP1NgMKKCzWtLe7quAE0mrqWNiRYPYGvVhdKqorCyI=;
        b=Ii06pIdtsAxZGf3JEaT1+koVOziYStQCAt8y3NeqqCevhAZjGV6cBJLbStb5lfVkO7oOoR
        BBJYOFhIFEqBumHTzBWWDgBdmCMU/h8QZhixUfNv8n4Ol44Cu9Uho+22dQ5BclvtwOS7X/
        kGTknM6cJ0k2edJUKQzrDMUAUEJNEJs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-Ts2cfc3cOLGP9ypVf0uzsA-1; Tue,
 05 Dec 2023 03:35:35 -0500
X-MC-Unique: Ts2cfc3cOLGP9ypVf0uzsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC833C0263D;
        Tue,  5 Dec 2023 08:35:34 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBBB3C27;
        Tue,  5 Dec 2023 08:35:32 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 6/7] vduse: Update the vq_info in ioctl VDUSE_VQ_GET_INFO
Date:   Tue,  5 Dec 2023 16:34:43 +0800
Message-Id: <20231205083444.3029239-7-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-1-lulu@redhat.com>
References: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Once the reconnect memory pages are mapped to userspace, the userspace
application will update the "reconnected" bit in the
"struct vduse_dev_reconnect_data".
The kernel will then check this bit. If it is not set to
"VDUSE_NOT_RECONNECT", it means that the application has been
reconnected, and the kernel will synchronize the vq information.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index f55f415629de..422f1aedebac 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1193,6 +1193,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_vq_info vq_info;
 		struct vduse_virtqueue *vq;
 		u32 index;
+		unsigned long vaddr;
+		struct vduse_vq_state *vq_reconnect;
+		struct vduse_dev_reconnect_data *dev_reconnect;
 
 		ret = -EFAULT;
 		if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
@@ -1209,6 +1212,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		vq_info.device_addr = vq->device_addr;
 		vq_info.num = vq->num;
 
+		vaddr = dev->vdpa_reconnect_vaddr;
+		dev_reconnect = (struct vduse_dev_reconnect_data *)vaddr;
+
+		vaddr = vq->vdpa_reconnect_vaddr;
+		vq_reconnect = (struct vduse_vq_state *)vaddr;
+
 		if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
 			vq_info.packed.last_avail_counter =
 				vq->state.packed.last_avail_counter;
@@ -1218,9 +1227,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				vq->state.packed.last_used_counter;
 			vq_info.packed.last_used_idx =
 				vq->state.packed.last_used_idx;
-		} else
+			/*check if the vq is reconnect, if yes then update the info*/
+			if (dev_reconnect->reconnected != VDUSE_NOT_RECONNECT) {
+				vq_info.packed.last_avail_idx =
+					vq_reconnect->packed.last_avail_idx;
+				vq_info.packed.last_avail_counter =
+					vq_reconnect->packed.last_avail_counter;
+			}
+		} else {
 			vq_info.split.avail_index =
 				vq->state.split.avail_index;
+			/*check if the vq is reconnect, if yes then update the info*/
+			if (dev_reconnect->reconnected != VDUSE_NOT_RECONNECT) {
+				vq_info.split.avail_index =
+					vq_reconnect->split.avail_index;
+			}
+		}
 
 		vq_info.ready = vq->ready;
 
-- 
2.34.3

