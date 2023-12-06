Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1F807296
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378952AbjLFOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjLFOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:37:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05317D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:37:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333a3a599fso473667f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873448; x=1702478248; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VW3Q3pYivZ0nqLu9afJmoH7SdepQ5nT0zPYa9KiyjuA=;
        b=rtj/JkfcEE84dqHxkBKomp1ycakWlsQRrhgUqH3GQY0T07ZsCAsPOSKxSl+Qyf1Mya
         zRVXmdfYqMZq5wIgUhFJyQHCSb25QWPliz5+EiaxXmDUGdOMEfPwq4APYJGF4Nw5Rw1m
         b+dzqAOlBAJqnVAu0uB5nrIqaLI+wAYOCRIbofJe+MiPFS/xtOAbhBv0GTkILE0lPIKd
         wZeSVsNlR3q4JSZrF+xSUJGZuH3IdrcgisEa8EiMxdPHxllFCn21FzrA0ZxEZoZX8nAN
         qb/kB0+04d4GlWPotK69WIZn0G2A5t8U5cymMpb2SHQWvKKGnj3OuO0PPdsVN1ys68bq
         uDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873448; x=1702478248;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VW3Q3pYivZ0nqLu9afJmoH7SdepQ5nT0zPYa9KiyjuA=;
        b=cn7JqCVmGjjqwT8Kie18JjOxv8wAz06xeuWkDYBLcHZXyK/74Zx6yETkMSyuGkRHLz
         3iknBrxVLkRpVDHydDR8/onKUBPAsYkx9UswfKz0SuMtLAwYpjQ1a8OtTaZzpgZOqFNX
         FssCLxbIOebfygMNTYC8E1p3w3fNBOHeSggJ0tHAN9jUCCI2baH0mdgparFbW90n7FbJ
         MxEsg81Y+ilgln1RIf4zhPwKyE+Tv9c0BgB7bbs3TL+lfULsNpgxZK88bXLIBzIllAfz
         DP7jJFcgABmjfqvTCG0nBpEuoRb/ASVTEksGaC1zVz2G5DR92xCVHDOIegg0tnjpr/eK
         G+uA==
X-Gm-Message-State: AOJu0Yz6JZN8ScrK5nStAIGBRJC8IUgjNvBK0rsgXcFEptGSQy99y540
        B2XpfBUrZYuY/taRKtYyG10V0vtQb89fXVNlx5g=
X-Google-Smtp-Source: AGHT+IGEfgHWhI3i0hf5O74h0s9YQTUHmBfTR0yRIKQM71/4+mYNuyHDYdRRnr1gnYUuNd8DlAYpWg==
X-Received: by 2002:a05:600c:4e90:b0:40b:5e56:7b68 with SMTP id f16-20020a05600c4e9000b0040b5e567b68mr1640147wmq.177.1701873448401;
        Wed, 06 Dec 2023 06:37:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm25776814wmb.14.2023.12.06.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:37:27 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:37:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/imagination: Move dereference after NULL check in
 pvr_mmu_backing_page_init()
Message-ID: <13f4278e-af9c-4092-9196-bc0e6b76f1eb@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code dereferences "page->pvr_dev" and then checked for NULL on the
next line.  Re-order it to avoid a potential NULL pointer dereference.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index c8562bfc0dcd..4fe70610ed94 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -316,12 +316,14 @@ pvr_mmu_backing_page_init(struct pvr_mmu_backing_page *page,
 static void
 pvr_mmu_backing_page_fini(struct pvr_mmu_backing_page *page)
 {
-	struct device *dev = from_pvr_device(page->pvr_dev)->dev;
+	struct device *dev;
 
 	/* Do nothing if no allocation is present. */
 	if (!page->pvr_dev)
 		return;
 
+	dev = from_pvr_device(page->pvr_dev)->dev;
+
 	dma_unmap_page(dev, page->dma_addr, PVR_MMU_BACKING_PAGE_SIZE,
 		       DMA_TO_DEVICE);
 
-- 
2.42.0

