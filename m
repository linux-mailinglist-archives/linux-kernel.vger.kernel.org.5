Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB693791145
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352310AbjIDGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:14:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2DCE6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 23:14:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed286169so917291b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693808072; x=1694412872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ypb7k0otVq6eC7pO2i8Tc3phnCnFLJFKEC4oYPS6f4=;
        b=aU9O6akGj0opOUTWEd+bjgBO1naPwY+pZ9oJMGndA9/FUTOshu3h6k8aH1iAGcpODh
         /WIWevO4Lz2gTcIXHtnXcvrU3Bd+kWwSFB5jwXWhMV4ilXr649G9lMuDFBGbRqoke5lp
         qrcPJ4PENTYNP920wMq/Rbyk9SBbkETCtwETod/7NNRRQxPfjLUvCJg7nsZTAps1jkfI
         TIhoSEzeVTlrJK7OXFBfNRV5u7Kce7TVITNgiqhpZzrGZOtIz6beVP5C/lVN7l3JMbbu
         irS8GyizEmpc/XC3uk2syscrthJQJyZF6F0IvKcduwU+rG/nCnHyGS+dEE0uC2QKlmuj
         gHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693808072; x=1694412872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ypb7k0otVq6eC7pO2i8Tc3phnCnFLJFKEC4oYPS6f4=;
        b=JlqtuPgvbPWVlix6dONm50JQkizizqnN8PZHobmFAbKUAsvGsmKbh+GnqL2gf9kt9T
         nDHsBj3x/pV0EK9ehZN4mpGmVyEaT5EN9gbgWNC3L2nUSIiYu9MsHSwVOtjy46taJpW7
         pdOU6+sDhXP6nY7XES3kA7djiY3HcRS3h8RDYo682JUifpxw4Z9wAYYZMsqlSFc2AJj4
         lvvmR8f5s1xSFL338ZFhEZWnk1AnF4NHZ3YM8FqZbFe/LhemGDCBAz7GZZ3I1Bbv5mj6
         4b+9xJkM0DGLlhW0IL6Fx2yVGa36BOQXz09z0NZQlEa472tNnsr+eLuHKjAXgPgtrDI2
         vn/g==
X-Gm-Message-State: AOJu0YzO+8PPaOr572DQxzr9HuU5B93VDr436Acxa5LaAkWYZ7U5UCXg
        mPe1QgE0Jp+kTviv6EeG7j1xCw==
X-Google-Smtp-Source: AGHT+IFnnyXtaTN3uKtZijN84zL4eh2k0aLZkCYLJYhH1so77+cHFDePDfPC0UKfIzFEmDTPSxa/Hg==
X-Received: by 2002:a05:6a21:3299:b0:138:2fb8:6b42 with SMTP id yt25-20020a056a21329900b001382fb86b42mr13014430pzb.14.1693808072551;
        Sun, 03 Sep 2023 23:14:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b006889348ba6esm6573542pfu.127.2023.09.03.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 23:14:31 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date:   Mon,  4 Sep 2023 14:10:45 +0800
Message-Id: <20230904061045.510460-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following codes have an implicit conversion from size_t to u32:
(u32)max_size = (size_t)virtio_max_dma_size(vdev);

This may lead overflow, Ex (size_t)4G -> (u32)0. Once
virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1fe011676d07..4a4b9bad551e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.34.1

