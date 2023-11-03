Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4627E0748
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjKCRRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjKCRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4BD44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vRd7f5G8x90QkHchEr3Lu9idWoM8f/Qc/4n6P4JgvYc=;
        b=PgStz4e3nzBQ84CFyCeZfcpqsBsMB8phpd92nw6Sm2pR0dzoRTsoK5f7/tIA5y8j4fsfue
        cXbr1wAqDp+efWaMC5O9blJ0qV4RLQX91Io9r2f2nRKIfJop4a9H1o1uQjGoiFPMOyBUy/
        jouEAGad2Yt0mvkebne5LoxZXt1Uhnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Ae_BpGh3OHuKUFySfTAznw-1; Fri, 03 Nov 2023 13:16:49 -0400
X-MC-Unique: Ae_BpGh3OHuKUFySfTAznw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CD90848A77;
        Fri,  3 Nov 2023 17:16:48 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAA440C6EBC;
        Fri,  3 Nov 2023 17:16:44 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Date:   Sat,  4 Nov 2023 01:16:33 +0800
Message-Id: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


Hi All
This code provides the iommufd support for vdpa device
This code fixes the bugs from the last version and also add the asid support. rebase on kernel
v6,6-rc3
Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
I will continue working on it

The kernel code is
https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1

Signed-off-by: Cindy Lu <lulu@redhat.com>


Cindy Lu (8):
  vhost/iommufd: Add the functions support iommufd
  Kconfig: Add the new file vhost/iommufd
  vhost: Add 3 new uapi to support iommufd
  vdpa: Add new vdpa_config_ops to support iommufd
  vdpa_sim :Add support for iommufd
  vdpa: change the map/unmap process to support iommufd
  vp_vdpa::Add support for iommufd
  iommu: expose the function iommu_device_use_default_domain

 drivers/iommu/iommu.c             |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
 drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
 drivers/vhost/Kconfig             |   1 +
 drivers/vhost/Makefile            |   1 +
 drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
 drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h             |  21 +++
 include/linux/vdpa.h              |  38 +++++-
 include/uapi/linux/vhost.h        |  66 ++++++++++
 10 files changed, 525 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vhost/iommufd.c

-- 
2.34.3

