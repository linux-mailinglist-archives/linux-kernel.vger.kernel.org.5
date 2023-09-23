Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD907AC3D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIWRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjIWRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667FD11B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UcKrjqyQxxSyECaK74/D93KIs/IAtnu5JgrP6RvkC4=;
        b=dRbj4lw8gkxcZtNFc+S0kqdjQJfdXx0rp7Ioxo/lsO49tiWi7PoH4/gEAYYe6UlA5Zis3o
        JbFxNqlUPxLYpgJ+veImZPuSotrFwV1ck60RW5kRdSlgcXnu8dxcFbw+VbTkPXw0yh7GHX
        FZkFZ4SbaX2jMZZUSy1vDMLvKHA7Huw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-toftKyUmOkqGbn7mW2VNZw-1; Sat, 23 Sep 2023 13:05:55 -0400
X-MC-Unique: toftKyUmOkqGbn7mW2VNZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62F22185A790;
        Sat, 23 Sep 2023 17:05:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C91F2026D4B;
        Sat, 23 Sep 2023 17:05:50 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 2/7] Kconfig: Add the new file vhost/iommufd
Date:   Sun, 24 Sep 2023 01:05:35 +0800
Message-Id: <20230923170540.1447301-3-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the makefile and Kconfig, to add the
new file vhost/iommufd.c

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig  | 1 +
 drivers/vhost/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..c54cea6c03f0 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -67,6 +67,7 @@ config VHOST_VDPA
 	select VHOST
 	select IRQ_BYPASS_MANAGER
 	depends on VDPA
+	depends on IOMMUFD || !IOMMUFD
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
index f3e1897cce85..cda7f6b7f8da 100644
--- a/drivers/vhost/Makefile
+++ b/drivers/vhost/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) += vringh.o
 
 obj-$(CONFIG_VHOST_VDPA) += vhost_vdpa.o
 vhost_vdpa-y := vdpa.o
+vhost_vdpa-$(CONFIG_IOMMUFD) += iommufd.o
 
 obj-$(CONFIG_VHOST)	+= vhost.o
 
-- 
2.34.3

