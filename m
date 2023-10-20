Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF07D0B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376639AbjJTJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376612AbjJTJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:23:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 21423106;
        Fri, 20 Oct 2023 02:23:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id EE915604FCB31;
        Fri, 20 Oct 2023 17:23:30 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc:     Su Hui <suhui@nfschina.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date:   Fri, 20 Oct 2023 17:23:21 +0800
Message-Id: <20231020092320.209234-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtqueue_resize_packed() or virtqueue_resize_split() can return
error code if failed, so add a check for this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---

I'm not sure that return directly is right or not,
maybe there are some process should do before return.

 drivers/virtio/virtio_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..cf662c3a755b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	else
 		err = virtqueue_resize_split(_vq, num);
 
+	if (err)
+		return err;
+
 	return virtqueue_enable_after_reset(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
-- 
2.30.2

