Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC9807F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjLGEc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGEc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:32:57 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BBCD54
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:33:03 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b844357f7cso439747b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701923582; x=1702528382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=wT5VYrmQHNPb1qQ3+Ylr9AB94gfVkmZCFtEREN9DtQks6bAY4XrND3mEdttHR1wUFc
         iTMAjQlS3o3LvUrt8m1x0G1eUlxaF3TpDvc1sl6Iqnv8z3Q+K/pRmBXMRfRo4+yDjRGl
         ghcAxp3IzknCeqJbtDbB2MlB1RyGOM2LDvqOqWYvjd5uHkHxjkfAHdLuYfLhb8hWdMS5
         MTaSlG6GHaZbIC04MgNmA1u1mJJSYnxM0tRpJ+3m8orCYnGracbeMtYooR1sH/1hbjEg
         at7BC0WM+rm9qm5t8GXilCu/mYYtKbpy7L6s3BCL1IFgBtZvYBRa7wovb16RpUfuvPUR
         ELPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701923582; x=1702528382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=g9ac2S121q0/w9tZ02bvzRDjuynuYrXBnnODCi4bpXbTinSEuXm40uenoz6jmIldFU
         8AIj6T5w+35TT/0tDAzoDyaC0PyfcNXGIqjWONuMkRobgcdNgSxG2NPT+IbxSWkgBD3v
         XmKO+u5A7XnGVwj9l2OfDqferxHgbM2eJ/L01Y4JXUJ3sKt0fZzEY7R28QUEY5BCB7mH
         r0xsLXvt+0WrAazfJhPSMBGSpVW70/ts8br9zPueIXsIf+iYUxeJaIG6oI7uC+INh+FS
         WKVPsgdkHh94zyr3UPhrw3WxaciN4HFXRYq2ztnr7Vc/BXkBYbpU7EXpRY9/cBm4eniS
         6uaQ==
X-Gm-Message-State: AOJu0YwBq18fq/C2I2v+vqK2sztWge3g3zMeVNnd+F2Wtf772C15If0A
        KxVraIufMR9ABPcxoNnoayet6w==
X-Google-Smtp-Source: AGHT+IHJYbFIUTZB44VBOizgu6C4ZjGpZ8ov/2VlLfUy+pzKCRy95+hHpycf+1VuZxTdnNIi7xPU9A==
X-Received: by 2002:aca:1b02:0:b0:3b9:dcf0:63b9 with SMTP id b2-20020aca1b02000000b003b9dcf063b9mr615047oib.23.1701923581661;
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b006cea1e12564sm332971pfn.81.2023.12.06.20.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux.dev (open list:VIRTIO BLOCK AND SCSI DRIVERS)
Cc:     Li Feng <fengli@smartx.com>
Subject: [PATCH] virtio_blk: set the default scheduler to none
Date:   Thu,  7 Dec 2023 12:31:05 +0800
Message-ID: <20231207043118.118158-1-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-blk is generally used in cloud computing scenarios, where the
performance of virtual disks is very important. The mq-deadline scheduler
has a big performance drop compared to none with single queue. In my tests,
mq-deadline 4k readread iops were 270k compared to 450k for none. So here
the default scheduler of virtio-blk is set to "none".

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..5183ec8e00be 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-- 
2.42.0

