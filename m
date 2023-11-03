Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD317E074D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377284AbjKCRSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjKCRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E821D59
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpK/Y1O55XislOg5N5jgXt0h6vbPef/n6csAVM8Xygs=;
        b=WW9A36V0M78YifZLp9JBpTkKsQDrxnlkCKOLmT0jEwNLcXhltvXPwOBi1ImKk/5xN1R36A
        ZY66fjG57TFhb5YyXerufluLtBPUfNDt1uVdzri9auPhUL+r4Q09avfn4O/c483R3zROGe
        Ymgk68YZjrhVH0WhNyTactvLsm6cqFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-44JTi4YMOiuZp0J0ge-3XA-1; Fri,
 03 Nov 2023 13:17:37 -0400
X-MC-Unique: 44JTi4YMOiuZp0J0ge-3XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 775B33826D52;
        Fri,  3 Nov 2023 17:17:32 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54708C15983;
        Fri,  3 Nov 2023 17:17:29 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 6/8] vdpa: change the map/unmap process to support iommufd
Date:   Sat,  4 Nov 2023 01:16:39 +0800
Message-Id: <20231103171641.1703146-7-lulu@redhat.com>
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

Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
then will use the Legacy iommu domain pathway

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index dfaddd833364..0e2dba59e1ce 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1067,9 +1067,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		/* Legacy iommu domain pathway without IOMMUFD */
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm), GFP_KERNEL);
-	} else {
-		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
@@ -1095,8 +1092,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	if (ops->set_map) {
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
+	} else if (!vdpa->iommufd_ictx) {
+		/* Legacy iommu domain pathway without IOMMUFD */
+		iommu_unmap(v->domain, iova, size);
 	}
-
 }
 
 static int vhost_vdpa_va_map(struct vhost_vdpa *v,
@@ -1149,7 +1148,36 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
 
 	return ret;
 }
+#if 0
+int vhost_pin_pages(struct vdpa_device *device, dma_addr_t iova, int npage,
+		    int prot, struct page **pages)
+{
+	if (!pages || !npage)
+		return -EINVAL;
+	//if (!device->config->dma_unmap)
+	//return -EINVAL;
+
+	if (0) { //device->iommufd_access) {
+		int ret;
+
+		if (iova > ULONG_MAX)
+			return -EINVAL;
 
+		ret = iommufd_access_pin_pages(
+			device->iommufd_access, iova, npage * PAGE_SIZE, pages,
+			(prot & IOMMU_WRITE) ? IOMMUFD_ACCESS_RW_WRITE : 0);
+		if (ret) {
+
+			return ret;
+		}
+
+		return npage;
+	} else {
+		return pin_user_pages(iova, npage, prot, pages);
+	}
+	return -EINVAL;
+}
+#endif
 static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     struct vhost_iotlb *iotlb,
 			     u64 iova, u64 size, u64 uaddr, u32 perm)
@@ -1418,9 +1446,13 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
 
 	if (v->domain) {
-		iommu_detach_device(v->domain, dma_dev);
+		if (!vdpa->iommufd_ictx) {
+			iommu_detach_device(v->domain, dma_dev);
+		}
 		iommu_domain_free(v->domain);
 	}
+	if (vdpa->iommufd_ictx)
+		vdpa_iommufd_unbind(vdpa);
 
 	v->domain = NULL;
 }
@@ -1645,6 +1677,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	}
 
 	atomic_set(&v->opened, 0);
+	atomic_set(&vdpa->iommufd_users, 0);
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-- 
2.34.3

