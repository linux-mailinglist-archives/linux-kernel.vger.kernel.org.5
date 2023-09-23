Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5B7AC3D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjIWRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIWRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0F192
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSxKvZZwCgHkxa7Gx3Q9oCdQPfbiPlUKMx5CV8bK/Xw=;
        b=Ugx3uPtnNO4vnms/ObL0wZ6rQiEXoCH9FMGXM0QIFqX7oNoSKcsWimRAi9resL9fdtO/dc
        0XLsR6XDrnGfDa4rHKE85pLuKqEbNoAlcJeIM6XM8PGS9KTaOks3rxAgRAVf1i+ACXRf9v
        Qe2WYgpmTho4wiGWcIeingADkFLsweg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-T93U6ufYNTeOS2d86puqOg-1; Sat, 23 Sep 2023 13:06:23 -0400
X-MC-Unique: T93U6ufYNTeOS2d86puqOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8022229AA385;
        Sat, 23 Sep 2023 17:06:23 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 539CC2156701;
        Sat, 23 Sep 2023 17:06:20 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 4/7] vdpa: change the map/unmap process to support iommufd
Date:   Sun, 24 Sep 2023 01:05:37 +0800
Message-Id: <20230923170540.1447301-5-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
then will use the Legacy iommu domain pathway

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 91da012084e9..8d1ad89d4671 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -981,6 +981,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, asid, iotlb);
+	} else if (!vdpa->iommufd_ictx) {
+		/* Legacy iommu domain pathway without IOMMUFD */
+		r = iommu_map(v->domain, iova, pa, size,
+			      perm_to_iommu_flags(perm));
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
@@ -1009,6 +1013,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	if (ops->set_map) {
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
+	} else if (!vdpa->iommufd_ictx) {
+		/* Legacy iommu domain pathway without IOMMUFD */
+		iommu_unmap(v->domain, iova, size);
 	}
 	/* If we are in the middle of batch processing, delay the free
 	 * of AS until BATCH_END.
@@ -1337,6 +1344,8 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 		iommu_detach_device(v->domain, dma_dev);
 		iommu_domain_free(v->domain);
 	}
+	if (vdpa->iommufd_ictx)
+		vdpa_iommufd_unbind(vdpa);
 
 	v->domain = NULL;
 }
@@ -1560,6 +1569,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	}
 
 	atomic_set(&v->opened, 0);
+	atomic_set(&vdpa->iommufd_users, 0);
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-- 
2.34.3

