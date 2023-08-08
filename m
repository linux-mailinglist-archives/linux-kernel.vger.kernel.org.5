Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4E773DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHHQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHHQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:22:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E7A25A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:49:28 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcae8c4072so3899849a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691509762; x=1692114562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMc/79F+2XKuxYwXqrQoYwy2p4KTqDsJfOhydisLsjE=;
        b=aAW8PoHqmlsuVoxEg4DCItGWrWcOs5LP+gQlE3x2RMXc8huziD8LDKmCptwS3vtaXG
         R1fND4xLHokMhy/le+hHFoqY/RE+zWkl5Y7DYB1fufC2fExdYHf+9Hwx/o1dPRBRz4tF
         gU2YlfstPleFEE1fXtlhvphgT+EjuPtcsx1KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509762; x=1692114562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMc/79F+2XKuxYwXqrQoYwy2p4KTqDsJfOhydisLsjE=;
        b=DKrpUoGjwH41noq8vJ3Vi414A3gtm/UMmaxbUH9Vnp7TDiXo6ipgEHJ9cPirwY5EzH
         74yW42oHCG5aXQJ84nnpgm4hmzv8MECDYqIF9Ro9cKEGAvEbbgW5LaXy6Nueu2bTtlZD
         d40nnOoXa08QpBtu8vQ4HFn1yKcvqIOBmtAfGLfDnjkl8ViMEN/VgDqThsdtidstDkny
         HUx1xMf34iRpTxPrhlsa9KlKMRPmowGoLcAOSW+WT3eQE9MX+s3KZDBOtsX6ycx0l+Qw
         yBUPyDa7w2uZswzNyuxbTFNzmz9u6oefAyPbG+bHpf4aJVWUtB9Ik7tXS+XK4CBMzIKl
         Ld+w==
X-Gm-Message-State: AOJu0YzXtbdzDgRAxxnu68nioBYLf1axziQhEk5TFJKOHeDTzs/iSnTH
        ziWqvjhG+HkHFArPC6q+FZnKAB0Zr261wSSuZXRN
X-Google-Smtp-Source: AGHT+IFH6xfQHdPraKgebydn6lkYt5QjWzWOu1zAuEH/23RdqhZJy/MAxmfPRk4wtNOeYQ4DQrs16g==
X-Received: by 2002:a17:902:7245:b0:1b5:2fdf:5bd8 with SMTP id c5-20020a170902724500b001b52fdf5bd8mr12580530pll.8.1691483595962;
        Tue, 08 Aug 2023 01:33:15 -0700 (PDT)
Received: from yuanyao.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001b7fd27144dsm8340168plh.40.2023.08.08.01.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:33:15 -0700 (PDT)
From:   Yuan Yao <yuanyaogoog@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Junichi Uekawa <uekawa@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Yuan Yao <yuanyaogoog@chromium.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
Date:   Tue,  8 Aug 2023 08:32:27 +0000
Message-ID: <20230808083257.3777012-1-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current packed virtqueue implementation, the avail_wrap_counter won't
flip, in the case when the driver supplies a descriptor chain with a
length equals to the queue size; total_sg == vq->packed.vring.num.

Let’s assume the following situation:
vq->packed.vring.num=4
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

Then the driver adds a descriptor chain containing 4 descriptors.

We expect the following result with avail_wrap_counter flipped:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 1

But, the current implementation gives the following result:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

To reproduce the bug, you can set a packed queue size as small as
possible, so that the driver is more likely to provide a descriptor
chain with a length equal to the packed queue size. For example, in
qemu run following commands:
sudo qemu-system-x86_64 \
-enable-kvm \
-nographic \
-kernel "path/to/kernel_image" \
-m 1G \
-drive file="path/to/rootfs",if=none,id=disk \
-device virtio-blk,drive=disk \
-drive file="path/to/disk_image",if=none,id=rwdisk \
-device virtio-blk,drive=rwdisk,packed=on,queue-size=4,\
indirect_desc=off \
-append "console=ttyS0 root=/dev/vda rw init=/bin/bash"

Inside the VM, create a directory and mount the rwdisk device on it. The
rwdisk will hang and mount operation will not complete.

This commit fixes the wrap counter error by flipping the
packed.avail_wrap_counter, when start of descriptor chain equals to the
end of descriptor chain (head == i).

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
Acked-by: Jason Wang <jasowang@redhat.com>
---

 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..da1150d127c2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
+	if (i <= head)
 		vq->packed.avail_wrap_counter ^= 1;
 
 	/* We're using some buffers from the free list. */
-- 
2.41.0.640.ga95def55d0-goog

