Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8375928B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGSKRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGSKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC91FC4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689761771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BuruPS9lhc1t9yWa6oN21bRI3YjjBxzYMDFcnENMa/E=;
        b=CmCh/qQzOagEpVIt5ez+uw8TaGeR0uwIjAaVOETlX1e3EpDn78cxUI4UZjOttKi3Gn5v30
        L95gFOIOXUz0GMogmsIfMI4XtY145ZHQmhPcZBik6WFrUOIL60x+QmMP7FcUHz9dLQCARs
        jDA3SN9iB6wfVPbf1tBwSzPS9pDKu4Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-HhHAsMx2MX-QHLE_5b58wQ-1; Wed, 19 Jul 2023 06:16:09 -0400
X-MC-Unique: HhHAsMx2MX-QHLE_5b58wQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31400956ce8so3670347f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761768; x=1692353768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuruPS9lhc1t9yWa6oN21bRI3YjjBxzYMDFcnENMa/E=;
        b=Wzsb2P4FrcEhzKbBpIHBJIaWYwN/hJNd8huVrtMLuNSCm2DZ2R2RHOXay42ao6imBL
         kKxKaQcXOTN+dgnorGAd7peLm0QCBTIj3j58s1LznXP5iryKRzpNoyLlzEpoZHZKn9dx
         IPD5oza7Y4yCV0MvxidX7EFsYE3h4mlwKsFGgL1mqQCbXGumMSsk8qCAQiUfTOOdSbCp
         ssIKLyT38M8vt8bl1t714pIyxoHRmeMk4KKqkFWpBIKS2yteVQTs/DWBdz4xn2B5Vygk
         HnD0rQa9rp/HpnH8mxQmqGiQR6JdugrDYzBAoTaEdfSJFr+4eT1QT8Q6vw6s1tO1T4lA
         xM8w==
X-Gm-Message-State: ABy/qLYicwo5ppUiBxeiES193JAiY7dAVDp6UiAh8ntiOhgvgp9FIvPe
        hgHUvi7Z+aJ724vK+ePhT6jFtTqc5Ewz/ZheQBEHj+Fa/UmiqZj8g6LiDLdNDhfLtyYnnH7NBii
        SD72CrHYUXqir72g3wqcxN6N88WaOEKybs1miXDEFJEneTWvA64AUn5YGk+saFjOJ+kz+WEkXT/
        v64g==
X-Received: by 2002:a5d:49c7:0:b0:315:94e7:e100 with SMTP id t7-20020a5d49c7000000b0031594e7e100mr1612375wrs.55.1689761768357;
        Wed, 19 Jul 2023 03:16:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvaNhr1gOmNY9eMZGDEyKAg8Zpg7qwsGNYJJBZQv3f1kiSVh1vC5Kv3hERFy3/FF+fPukITA==
X-Received: by 2002:a5d:49c7:0:b0:315:94e7:e100 with SMTP id t7-20020a5d49c7000000b0031594e7e100mr1612350wrs.55.1689761767914;
        Wed, 19 Jul 2023 03:16:07 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id m18-20020a056000181200b0031434936f0dsm4895611wrh.68.2023.07.19.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:16:06 -0700 (PDT)
Date:   Wed, 19 Jul 2023 06:15:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
might be easily misunderstood.

This attempts to improve documentation in several ways:

when used with dma_map_*, DMA_ATTR_SKIP_CPU_SYNC does not
really assume buffer has been transferred previously -
the buffer would often not even exist in device domain
before it's mapped, instead it normally has to be transferred later.

Add a hint on how buffer can be transferred.

Code comments near DMA_ATTR_SKIP_CPU_SYNC focus on
the use-case of CPU cache synchronization while in
practice this flag isn't limited to that.
Make it more generic.

A couple of things I'm thinking about left for a follow-up patch:
- rename DMA_ATTR_SKIP_CPU_SYNC to DMA_ATTR_SKIP_SYNC
  there's nothing I can see making it especially related to the CPU.
- drop mentions of CPU cache from documentation completely
  and talk about CPU domain exclusively, or maybe mention
  CPU cache as an example: CPU domain (e.g. CPU cache).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 5 +++--
 include/linux/dma-mapping.h               | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..782734666790 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -61,8 +61,9 @@ same synchronization operation on the CPU cache. CPU cache synchronization
 might be a time consuming operation, especially if the buffers are
 large, so it is highly recommended to avoid it if possible.
 DMA_ATTR_SKIP_CPU_SYNC allows platform code to skip synchronization of
-the CPU cache for the given buffer assuming that it has been already
-transferred to 'device' domain. This attribute can be also used for
+the CPU cache for the given buffer assuming that it is
+transferred to 'device' domain separately, e.g. using
+dma_sync_{single,sg}_for_{cpu,device}. This attribute can be also used for
 dma_unmap_{single,page,sg} functions family to force buffer to stay in
 device domain after releasing a mapping for it. Use this attribute with
 care!
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0ee20b764000..13295ae4385a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -32,9 +32,8 @@
  */
 #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 4)
 /*
- * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
- * the CPU cache for the given buffer assuming that it has been already
- * transferred to 'device' domain.
+ * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of the
+ * CPU and device domains for the given buffer.
  */
 #define DMA_ATTR_SKIP_CPU_SYNC		(1UL << 5)
 /*
-- 
MST

