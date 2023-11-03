Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B17E074B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377423AbjKCRS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377249AbjKCRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05517D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZcijrBkenJpJgKIh5nn77fb44ksEJ9Uwp/HPtluVaY=;
        b=FLhpaRJ43evcLk4oVC0416wghzrtz+4oiTFODPMtRG8iQfwyB7zPuQfxnyy6KYi+SSeWyI
        zbSz3P9jRVj1Iv5pMknBHfBdWwkudzpl1DDdNJW3zanzRTbPmCCLsgdrXVFORxp1v1Rl1P
        4fuvJo33hpdky5V1MDBmAnLphGI+uhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-WVF19FtuOU6EB2xsKppuQQ-1; Fri, 03 Nov 2023 13:17:34 -0400
X-MC-Unique: WVF19FtuOU6EB2xsKppuQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31B6101389C;
        Fri,  3 Nov 2023 17:17:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0CFC15983;
        Fri,  3 Nov 2023 17:17:25 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 5/8] vdpa_sim :Add support for iommufd
Date:   Sat,  4 Nov 2023 01:16:38 +0800
Message-Id: <20231103171641.1703146-6-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d41058add9..9400ec32ec41 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -762,6 +762,10 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
+	.bind_iommufd           = vdpa_iommufd_emulated_bind,
+	.unbind_iommufd         = vdpa_iommufd_emulated_unbind,
+	.attach_ioas            = vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas            = vdpa_iommufd_emulated_detach_ioas,
 };
 
 static const struct vdpa_config_ops vdpasim_batch_config_ops = {
@@ -799,6 +803,10 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
+	.bind_iommufd        = vdpa_iommufd_emulated_bind,
+	.unbind_iommufd        = vdpa_iommufd_emulated_unbind,
+	.attach_ioas           = vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas           = vdpa_iommufd_emulated_detach_ioas,
 };
 
 MODULE_VERSION(DRV_VERSION);
-- 
2.34.3

