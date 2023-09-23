Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8577AC3DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjIWRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjIWRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3E194
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JLc/gcAH7DqQQF3pLiWnqXoje3Kz4Ompug0RZFEuno=;
        b=gqNQ7XU52rlFNyl3JZVL8fqeRWFGaCgSrvBn9le9iIT5mt+aAkIGIkHHys3D6BozjYfOci
        RZE9HXDx+HyoxUh3l6/OZRQDsuAq2gnOypZ0S1NpPsbIivBiZ2uW+ELUMx7QI33nAXPtUb
        EhlUq0QCCEtAp54+jFMAB7dR0xgWZv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-r5i6n1P3PIacCZt-mrDfdQ-1; Sat, 23 Sep 2023 13:06:31 -0400
X-MC-Unique: r5i6n1P3PIacCZt-mrDfdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EFE13C025B6;
        Sat, 23 Sep 2023 17:06:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD11E2156701;
        Sat, 23 Sep 2023 17:06:27 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 6/7] vdpa_sim :Add support for iommufd
Date:   Sun, 24 Sep 2023 01:05:39 +0800
Message-Id: <20230923170540.1447301-7-lulu@redhat.com>
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

Add new vdpa_config_ops to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index cb88891b44a8..55e6f45bb274 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -727,6 +727,10 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
+	.bind_iommufd			= vdpa_iommufd_emulated_bind,
+	.unbind_iommufd			= vdpa_iommufd_emulated_unbind,
+	.attach_ioas			= vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas			= vdpa_iommufd_emulated_detach_ioas,
 };
 
 static const struct vdpa_config_ops vdpasim_batch_config_ops = {
@@ -759,6 +763,10 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_group_asid         = vdpasim_set_group_asid,
 	.set_map                = vdpasim_set_map,
 	.free                   = vdpasim_free,
+	.bind_iommufd		= vdpa_iommufd_emulated_bind,
+	.unbind_iommufd		= vdpa_iommufd_emulated_unbind,
+	.attach_ioas		= vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas		= vdpa_iommufd_emulated_detach_ioas,
 };
 
 MODULE_VERSION(DRV_VERSION);
-- 
2.34.3

