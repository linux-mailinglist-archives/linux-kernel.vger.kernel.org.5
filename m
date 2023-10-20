Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890417D1310
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbjJTPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377717AbjJTPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:42:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C41B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:42:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a397a7c1cso1226556276.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697816538; x=1698421338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSLHEcMIztGYBTo6xVAEhhfF1F5jUZmJAk48UL6Ld3c=;
        b=kXP8E3uq+Ns3U5c485fgD5Z4dGpow9YuvULKvKwGJ8/sFL5ULqgZ9xis/0m8kaa4G4
         6rcRxDafLa1ARrNSM+HoNgOKs5AKc59/i557XSvgBnKn8pPsmX5lwKB4j7gySj/eY4PX
         xuri448y3FCk/s0cj13mH712iJ+3Wtrqy6QSoOz55XQXSuy15tsVDUMesoBIYyDa1mcO
         clZukieZlGNZ64qszOjjOhGBHfcc/9iZ5Ip+QKiXLThXu2zIpM4SvNfphWRe5Hh63r51
         5nsVZTUbbDxAF4m4+7Wgoc9n/Mzqy5v//hKbwWZRIs1MaVTCztloGP/r8s75ZUt7Rn4i
         LA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816538; x=1698421338;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSLHEcMIztGYBTo6xVAEhhfF1F5jUZmJAk48UL6Ld3c=;
        b=wNHpzb4b7VuGYUdTLhWe6IoJybyq8LpyJLwF3+QL9NMi6GJrnYZXtLeobwcBO/l0gP
         +K6JOcbu3acmpm+hBpkouUP50WWh44aB6fPCe+LcuIzgKuGj4ywIrrI/m/Yciq32rwEG
         W2jO2TxShGv1vVuSJq+CTqCKCcuH3yKlXqOiJdHVxcbyuSxr4H8jqMMiRHR0OJqnZtiZ
         d01HFHgmz5dK06OV8eIuCG0uMEvwuplOifdxcc5K0dQmeir9kUjQ4fFoDOx8xbSh+45L
         VJrVh1MRgn+AKADoo6+LQHSqbGtP0hhTjnRtD0PbPnG1UstTlrCAa+iJq0rfbs/dSdQr
         AFeQ==
X-Gm-Message-State: AOJu0YwPQc0jXXawSEMkVx1cBC6r1oWWE80K3G60uoBROK3wsNe6/k3D
        Q1MFuybdfuTZTamrIyeMwXA/3pB8uvk=
X-Google-Smtp-Source: AGHT+IGhtVqmbhmyJB3o1gXFA1kvTKqCvhyQl8OMzZz2qJpav2nsj7ZAINPu/3UyJ5C0TJe5CDGuJudpgf0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c5c1:0:b0:d9a:ce79:6298 with SMTP id
 v184-20020a25c5c1000000b00d9ace796298mr41424ybe.2.1697816538334; Fri, 20 Oct
 2023 08:42:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Oct 2023 08:42:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020154215.2191840-1-seanjc@google.com>
Subject: [PATCH v2] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From:   Sean Christopherson <seanjc@google.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/all/ZN5elYQ5szQndN8n@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Rephrase blurb about memory corruption to make it clear that not clobbering
    unwritten memory is hardware behavior (I'm belly laughing at how stupidly
    obvious that sounds). [Robin]

v1: https://lore.kernel.org/all/20231018173409.1871540-1-seanjc@google.com

 kernel/dma/swiotlb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 01637677736f..fd5dacd0628d 100644
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
+	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
+	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
 	 */
 	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;

base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.42.0.655.g421f12c284-goog

