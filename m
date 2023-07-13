Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A067525C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGMO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGMO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D99270D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LptuTpvFDZBRRZm7T2FbpKgVlUR80XdDNd96fLSIzt8=;
        b=LvrqV1TcRpV+O9JO/Nd+ErK9B3KCZeAxwkot2wDfW1ymwNzHSbiRXDWzY4HtSSFm5OROBU
        b2KYrZgb38/8AoKBp6ig1F5cUx2VUDMfuoQ9o1AU1wmk9zO33y6PJIPjWK4g80ZQdI2iaL
        x44/NuuRbnET2gMyOZ/2TsB4e9v8/vQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-UuHX7QVrOaKiCwlKvKf5PA-1; Thu, 13 Jul 2023 10:55:55 -0400
X-MC-Unique: UuHX7QVrOaKiCwlKvKf5PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45E9E3C0F67B;
        Thu, 13 Jul 2023 14:55:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A28F66CB;
        Thu, 13 Jul 2023 14:55:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related cleanups
Date:   Thu, 13 Jul 2023 16:55:47 +0200
Message-ID: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups+optimizations primarily around offline_and_remove_memory().

Patch #1 drops the "unsafe unplug" feature where we might get stuck in
offline_and_remove_memory() forever.

Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
nicer.

Patch #3 handles the case where offline_and_remove_memory() failed and
we want to retry later to remove a completely unplugged Linux memory
block, to not have them waste memory forever.

Patch #4 something I had lying around for longer, which reacts faster
on config changes when unplugging memory.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

David Hildenbrand (4):
  virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
  virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
  virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub
    Block Mode (SBM)
  virtio-mem: check if the config changed before fake offlining memory

 drivers/virtio/virtio_mem.c | 168 ++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 56 deletions(-)


base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.41.0

