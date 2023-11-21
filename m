Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224E7F265C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjKUHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKUHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D9919A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAkVxc3aGCIVy+mum1Tmv8tqRWzijzVSekSFIcVpdTI=;
        b=A0kMw3TIhs2EbU962e+26T7JKuBRfCzifPBOFlsOEzmydSStpHeyuICM3WnPwWI5mjeGC+
        /NSCpogwkqVX10M3U52GfNVpOqshuiQ4vokJJsXDen60k3Q8H+2AiP88jmH1NhDQbpAGvj
        nc48Mtw/Go18XrupVKr4QXfqCbiFXxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-CVgMNopqMVOpQb5uC-0KgA-1; Tue, 21 Nov 2023 02:31:32 -0500
X-MC-Unique: CVgMNopqMVOpQb5uC-0KgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5126857F7A;
        Tue, 21 Nov 2023 07:31:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0087D1C060B0;
        Tue, 21 Nov 2023 07:31:28 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 4/5] vduse: update the vq_info in ioctl
Date:   Tue, 21 Nov 2023 15:30:49 +0800
Message-Id: <20231121073050.287080-5-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
References: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
with reconnect info, After mapping the reconnect pages to userspace
The userspace App will update the reconnect_time in
struct vhost_reconnect_vring, If this is not 0 then it means this
vq is reconnected and will update the last_avail_idx

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d0fe9a7e86ab..6bc5fc2b88cc 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1209,6 +1209,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_vq_info vq_info;
 		struct vduse_virtqueue *vq;
 		u32 index;
+		struct vdpa_reconnect_info *area;
+		struct vhost_reconnect_vring *vq_reconnect;
+		struct vhost_reconnect_data *dev_reconnect;
 
 		ret = -EFAULT;
 		if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
@@ -1225,6 +1228,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		vq_info.device_addr = vq->device_addr;
 		vq_info.num = vq->num;
 
+		area = &dev->reconnect_info;
+		dev_reconnect = (struct vhost_reconnect_data *)area->vaddr;
+
+		area = &vq->reconnect_info;
+		vq_reconnect = (struct vhost_reconnect_vring *)area->vaddr;
+
 		if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
 			vq_info.packed.last_avail_counter =
 				vq->state.packed.last_avail_counter;
@@ -1234,9 +1243,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				vq->state.packed.last_used_counter;
 			vq_info.packed.last_used_idx =
 				vq->state.packed.last_used_idx;
-		} else
+			/*check if the vq is reconnect, if yes then update the last_avail_idx*/
+			if (dev_reconnect->reconnected != 0) {
+				vq_info.packed.last_avail_idx =
+					vq_reconnect->last_avail_idx;
+				vq_info.packed.last_avail_counter =
+					vq_reconnect->avail_wrap_counter;
+			}
+		} else {
 			vq_info.split.avail_index =
 				vq->state.split.avail_index;
+			/*check if the vq is reconnect, if yes then update the last_avail_idx*/
+			if (dev_reconnect->reconnected != 0) {
+				vq_info.split.avail_index =
+					vq_reconnect->last_avail_idx;
+			}
+		}
 
 		vq_info.ready = vq->ready;
 
-- 
2.34.3

