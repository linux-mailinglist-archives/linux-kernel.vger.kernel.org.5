Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454E7E074E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377762AbjKCRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjKCRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147BA1BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVS2kk0D6Tt1PgwcrwV42T54QxmIjT+wF7r94StjHU4=;
        b=HYpS2zJgWieuA97Fnr0ELmzm+Tb4O+/uvGMRB46qYiZ958QhhXCsaaFxGKuTu3U93yDyDb
        S5HO4YsvvAtnYh0NOzYv89DLrf4uFyV29eALnFpvAWxvZePNyoKtUMesYhnqOyMHbbfktC
        V0XcLO4nZcfeIyZLzIqqGk5ougg1NXk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-lM2HJKEnOZCxb--cVZ2jKw-1; Fri,
 03 Nov 2023 13:17:40 -0400
X-MC-Unique: lM2HJKEnOZCxb--cVZ2jKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EFB8282478F;
        Fri,  3 Nov 2023 17:17:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A404C1290F;
        Fri,  3 Nov 2023 17:17:32 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 7/8] vp_vdpa::Add support for iommufd
Date:   Sat,  4 Nov 2023 01:16:40 +0800
Message-Id: <20231103171641.1703146-8-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new vdpa_config_ops function to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..dd2c372d36a6 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -460,6 +460,10 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_config	= vp_vdpa_set_config,
 	.set_config_cb  = vp_vdpa_set_config_cb,
 	.get_vq_irq	= vp_vdpa_get_vq_irq,
+	.bind_iommufd = vdpa_iommufd_physical_bind,
+	.unbind_iommufd = vdpa_iommufd_physical_unbind,
+	.attach_ioas = vdpa_iommufd_physical_attach_ioas,
+	.detach_ioas = vdpa_iommufd_physical_detach_ioas,
 };
 
 static void vp_vdpa_free_irq_vectors(void *data)
-- 
2.34.3

