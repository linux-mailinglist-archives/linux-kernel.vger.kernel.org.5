Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD47D136A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377866AbjJTQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377839AbjJTQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C0D65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YaH8GqSCmsbSQK65aeluJxBiMUQ9PtkPz8wZaXPjys=;
        b=c/Gnpb2qABMhWmGPOGNosn8CVEAMwcDUV5f0c4OPYCuVZBcRWz5Pn4LfcXyngQC/E42twk
        PtOnKBpKaTTxlVvizWsgOOx0aNM5T6YGKWA68PGaAyFuH8mn+bYkJicKroisXFfg/R3niC
        zAhHcM9+Dd3+cubLQVIGk2p4b1mgSj0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-GcMYqtHEOs6LTSLRuNoADw-1; Fri, 20 Oct 2023 11:58:39 -0400
X-MC-Unique: GcMYqtHEOs6LTSLRuNoADw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7E33C28647;
        Fri, 20 Oct 2023 15:58:39 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 219DB10828;
        Fri, 20 Oct 2023 15:58:35 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 3/4] vduse: Temporarily disable control queue features
Date:   Fri, 20 Oct 2023 17:58:18 +0200
Message-ID: <20231020155819.24000-4-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-1-maxime.coquelin@redhat.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's disable control virtqueue and features that depend on
it.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73ad3b7efd8e..0243dee9cf0e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
 
 #include "iova_domain.h"
@@ -46,6 +47,30 @@
 
 #define IRQ_UNBOUND -1
 
+#define VDUSE_NET_VALID_FEATURES_MASK           \
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |           \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
+	 BIT_ULL(VIRTIO_NET_F_MTU) |            \
+	 BIT_ULL(VIRTIO_NET_F_MAC) |            \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |         \
+	 BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
+	 BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
+	 BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
+	 BIT_ULL(VIRTIO_F_VERSION_1) |          \
+	 BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |        \
+	 BIT_ULL(VIRTIO_F_IN_ORDER))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1778,6 +1803,16 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_filter(struct vduse_dev_config *config)
+{
+	/*
+	 * Temporarily filter out virtio-net's control virtqueue and features
+	 * that depend on it while CVQ is being made more robust for VDUSE.
+	 */
+	if (config->device_id == VIRTIO_ID_NET)
+		config->features &= VDUSE_NET_VALID_FEATURES_MASK;
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1793,6 +1828,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_filter(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.41.0

