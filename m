Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DC805709
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjLEOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjLEOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09B18B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701785956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g2FwUnRexMbJ1eWu7b0mx103R9bklO0D/KfjDegM/pc=;
        b=CSNH3mmcDLOWFMbBUeqFcGj9VYP+cFOncVhwjPXOX+SvGn/bCYjr1Xmm69bWLnXUGZ14ZM
        8dM61/uoBtUEKu346tXpQzar2O+6olvJHEyAQLf9eB/IorLSflQVaeo9ZqwVqNxOiButG3
        pwJsDTJSBpwNVZ+V0gLbO155h0Pzhvc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-Hw2K6gyFNtS8WtP7wZHbSQ-1; Tue,
 05 Dec 2023 09:18:43 -0500
X-MC-Unique: Hw2K6gyFNtS8WtP7wZHbSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9218638130AC;
        Tue,  5 Dec 2023 14:18:42 +0000 (UTC)
Received: from localhost (unknown [10.39.195.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 117495B7C;
        Tue,  5 Dec 2023 14:18:41 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David.Laight@aculab.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] virtio_blk: fix snprintf truncation compiler warning
Date:   Tue,  5 Dec 2023 09:18:40 -0500
Message-ID: <20231205141840.1854409-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4e0400525691 ("virtio-blk: support polling I/O") triggers the
following gcc 13 W=1 warnings:

drivers/block/virtio_blk.c: In function ‘init_vq’:
drivers/block/virtio_blk.c:1077:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                                    ^~
drivers/block/virtio_blk.c:1077:58: note: directive argument in the range [-2147483648, 65534]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/block/virtio_blk.c:1077:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a false positive because the lower bound -2147483648 is
incorrect. The true range of i is [0, num_vqs - 1] where 0 < num_vqs <
65536.

The code mixes int, unsigned short, and unsigned int types in addition
to using "%d" for an unsigned value. The only place where a 16-bit value
is needed is during the config space access. Use unsigned int and "%u"
consistently to solve the compiler warning and clean up the code.

Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp@intel.com/
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/virtio_blk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

v2:
- Use unsigned int instead of unsigned short [David]

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..dc69a40fbf08 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1019,20 +1019,23 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
-	int i;
+	unsigned int i;
 	vq_callback_t **callbacks;
 	const char **names;
 	struct virtqueue **vqs;
-	unsigned short num_vqs;
+	unsigned int num_vqs;
 	unsigned int num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
+	u16 num_vqs_u16;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
-				   &num_vqs);
+				   &num_vqs_u16);
 	if (err)
 		num_vqs = 1;
+	else
+		num_vqs = num_vqs_u16;
 
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
@@ -1068,13 +1071,13 @@ static int init_vq(struct virtio_blk *vblk)
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
 		callbacks[i] = NULL;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
-- 
2.43.0

