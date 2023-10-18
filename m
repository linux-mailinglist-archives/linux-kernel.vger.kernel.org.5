Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5A7CE4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjJRRhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjJRRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:36:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3213A8C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:34:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7daf45537so103000887b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697650451; x=1698255251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RelinbZSLZ3//bk7xHba+uKbmxohgasnEf6j21oUpLw=;
        b=a7XpdxI9/jImQGOdX1ZnCLLvTpYupqf/7YqC3ZseOX/rVPrAHBvQ0VS7wgeU/38X11
         N+YfP9xX5t99PyOvAdAI8Wq6obZunAbrlZywYOPOKcjqk2F990DWJ7Vpvs9yuIqr9N3E
         ecftQePU3BcQ3fjAbc95oanzR5Zk965tco3v3shtWGgSeAeq/nKrdmly+nDERnMDT3d4
         m4VzM4N9A1tH0VD8OQAefJr5Qg0twbQHWIiCYBM8/Eq5xZat291rrQkvPPnnd8RiQQga
         xiNzNps+G1ugnhzLO5w8obZj3V4UUScuj9jygQMPhRtTR3tPifZ380vimcZ9paunOGvW
         xttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650451; x=1698255251;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RelinbZSLZ3//bk7xHba+uKbmxohgasnEf6j21oUpLw=;
        b=GoB7N7Gm7TKPrvS28dSCsQ6ptZHp+7h+KdVClRHwtQHI2ZJ6benosBsL2TxnzBFbcz
         ZIag1vxuKVoi2P1Qx3bSoUiXUa9UyZmXM3qWVevjTXi4AbNPYoGB4up7mKEL/BRllR2o
         dhqDwrnQkhtgy32A9g0bINNzKQ8ZbKwGNU1/pe+DR6715QRQaa0XHT186EOhzHAXzYks
         +aag0krry0eTkjj/JMm98FriO+vVkpG/Ve6GS0Q41ItZvzed9bXs8ct7wllfCOgRfSIH
         m73YZDijtWB+gaAnIHGHZhgU1xvAfc5999y1mqMoSAkmZVZPvvJAwkNLlQpn+uJ+UFfN
         j+kw==
X-Gm-Message-State: AOJu0Yzd4MmY06PleXnMv5lcYrKBC1Xu4rchkriwGLGo5bamJGXd8zbm
        B+rPE5VXmsXeQx5lUMwRUhXH4PTCdMo=
X-Google-Smtp-Source: AGHT+IFsiXcsp74Srqa0t0XCrzb4lqNGBNpOooFM5tTTgsZ8v+vnRddeh9lJC9B5z3FHszNA4IPr1HJdIwM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:e89:0:b0:d9a:ce79:6298 with SMTP id
 z9-20020a5b0e89000000b00d9ace796298mr1114ybr.2.1697650451779; Wed, 18 Oct
 2023 10:34:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 Oct 2023 10:34:09 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018173409.1871540-1-seanjc@google.com>
Subject: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From:   Sean Christopherson <seanjc@google.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the comment explaining why swiotlb copies the original buffer to
the TLB buffer before initiating DMA *from* the device, i.e. before the
device DMAs into the TLB buffer.  The existing comment's argument that
preserving the original data can prevent a kernel memory leak is bogus.

If the driver that triggered the mapping _knows_ that the device will
overwrite the entire mapping, or the driver will consume only the written
parts, then copying from the original memory is completely pointless.

If neither of the above holds true, then copying from the original adds
value only if preserving the data is necessary for functional correctness,
or the driver explicitly initialized the original memory.  If the driver
didn't initialize the memory, then copying the original buffer to the TLB
buffer simply changes what kernel data is leaked to userspace.

Writing the entire TLB buffer _does_ prevent leaking stale TLB buffer data
from a previous bounce, but that can be achieved by simply zeroing the TLB
buffer when grabbing a slot.

The real reason swiotlb ended up initializing the TLB buffer with the
original buffer is that it's necessary to make swiotlb operate as
transparently as possible, i.e. to behave as closely as possible to
hardware, and to avoid corrupting the original buffer, e.g. if the driver
knows the device will do partial writes and is relying on the unwritten
data to be preserved.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/ZN5elYQ5szQndN8n@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/dma/swiotlb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 01637677736f..e071415a75dc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
 	/*
-	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
-	 * to the tlb buffer, if we knew for sure the device will
-	 * overwrite the entire current content. But we don't. Thus
-	 * unconditional bounce may prevent leaking swiotlb content (i.e.
-	 * kernel memory) to user-space.
+	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
+	 * the original buffer to the TLB buffer before initiating DMA in order
+	 * to preserve the original's data if the device does a partial write,
+	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
+	 * the original data, even if it's garbage, is necessary to match
+	 * hardware behavior (use of swiotlb is supposed to be transparent) and
+	 * so that swiotlb doesn't corrupt bytes that the device does NOT write.
 	 */
 	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;

base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.42.0.655.g421f12c284-goog

