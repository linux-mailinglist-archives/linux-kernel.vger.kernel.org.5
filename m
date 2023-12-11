Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5680CA72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjLKNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbjLKNEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E32C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702299877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=giFVLOTqkebo2x+oA3YA6G6HzBfr3m1iYomgrY5Darc=;
        b=WW+xx/EFCET7haeCoIXNIYTQmBszVT/HZ3owFg/9KMaVldbyeRxSjwM3wSuvNua0IA4fX0
        MVnJbq/1JLMCcyiZglOIsnteuQKPnCQTSTgnVFZBbBtgITZca/n/ueqIFOwbf3WMVuGJD9
        s6EFR1vihPoZJXw3pZTGWyUVtVyzt3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-X5XFshiTM9O69vzQtEUuRQ-1; Mon, 11 Dec 2023 08:04:35 -0500
X-MC-Unique: X5XFshiTM9O69vzQtEUuRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D514D830F32;
        Mon, 11 Dec 2023 13:04:34 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804F51C060B1;
        Mon, 11 Dec 2023 13:04:33 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vacek <neelx@redhat.com>
Subject: [PATCH 2/2] IB/ipoib: Clean up redundant netif_addr_lock
Date:   Mon, 11 Dec 2023 14:04:25 +0100
Message-ID: <20231211130426.1500427-3-neelx@redhat.com>
In-Reply-To: <20231211130426.1500427-1-neelx@redhat.com>
References: <20231211130426.1500427-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single memory load does not need to be protected by any lock.
The same priv->flags are fetched 15 lines ago without locking anyways.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 8e4f2c8839be..f54e0d212630 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -572,13 +572,9 @@ void ipoib_mcast_join_task(struct work_struct *work)
 		return;
 	}
 	priv->local_lid = port_attr.lid;
-	netif_addr_lock_bh(dev);
 
-	if (!test_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags)) {
-		netif_addr_unlock_bh(dev);
+	if (!test_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags))
 		return;
-	}
-	netif_addr_unlock_bh(dev);
 
 	mutex_lock(&priv->mcast_mutex);
 	spin_lock_irq(&priv->lock);
-- 
2.43.0

