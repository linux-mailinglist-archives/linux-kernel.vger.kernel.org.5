Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E27D135E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbjJTP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377825AbjJTP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61AB3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJDKpQQy665XvGZPky5UtXAeHywtQ/JigxzuJqzayEo=;
        b=h5ybDBf3gXe7Q0eb0xYrkIs5InhwZO5XftGD+RvPnrTJiVJbM7xbD1NMsdGLMDoaTPznQY
        2Zqp1Ig0xPMmkvnyDpyh4U2lVF9+UOHIigxw0wov/Ejoud9X2jSrr4aQ2e1oErh58GIEW3
        zNhwDrMEee3HD07kVYL0EHrxGm1Km+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636--OQOfImDP0iRRlu1vp9QdA-1; Fri, 20 Oct 2023 11:58:36 -0400
X-MC-Unique: -OQOfImDP0iRRlu1vp9QdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C98808C7EC1;
        Fri, 20 Oct 2023 15:58:35 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAB7D8CF2;
        Fri, 20 Oct 2023 15:58:32 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 2/4] vduse: enable Virtio-net device type
Date:   Fri, 20 Oct 2023 17:58:17 +0200
Message-ID: <20231020155819.24000-3-maxime.coquelin@redhat.com>
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

This patch adds Virtio-net device type to the supported
devices types. Initialization fails if the device does
not support VIRTIO_F_VERSION_1 feature, in order to
guarantee the configuration space is read-only.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5b3879976b3d..73ad3b7efd8e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -142,6 +142,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1672,6 +1673,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & (1ULL << VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -2027,6 +2032,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.41.0

