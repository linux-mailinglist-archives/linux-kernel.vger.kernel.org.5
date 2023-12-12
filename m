Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8580FB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjLLXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjLLXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:31:31 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB2BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:31:37 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f2dc3a9bcso379699585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702423896; x=1703028696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:cc:to:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkrAqsNZDipecIKdgep5YJgfJkpnoeFR9tV2P0/CVI=;
        b=KorZdTK4vXEiX8LHPZHZg9MNeXR/Dn9uqdc2Xtp8tOesR+Zj8agsTI3JGdxAJFVcq8
         Oju5h756sQi6lAr+BlRBddDTZTwRo1Lg4mFdi+44vgRUROonmxcSf2rOC3mYxRsKtT8c
         ooLZ23Oump/hg9ugK9tc7weMXPnzQglq7klHPbdKck5QiOTRrpp0IIflU0Pc/3uRWLn2
         JWoQVtrZ92P+iQj6h38jt8LNKXrCBXG1WxRrpmN/YnZc6wS016naolx8gOoUHwre5y1+
         mF6TsFDc8MKKN8Gh6FBrgEBvPXX4djhQwaV3XsLp6nBF1FzLoPNNzccosMCMm/L7GNvX
         lHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423896; x=1703028696;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:cc:to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUkrAqsNZDipecIKdgep5YJgfJkpnoeFR9tV2P0/CVI=;
        b=Hl9gHkTyvjLi3DCbZ+XPrmAZhyTx51CGnDGFomXJsswMsFIDtl3Mgt+oi3Hdg1yhDQ
         64FtJy6wcHXVgd5GuMBg/2ZM1ASTHPpJEEQBDJLcmjFJPg/3Km7hWbxSRa4hHdLRMDbQ
         85DLzvjp/OYOB44QOHOVHnnTfAdi2ftUno2KeqYB+Sr1R1fdsws6j7dloYUP0tEftwOJ
         reUN8d6Tn1MHjxvPYKGkV9sDu3PmtM+ny34Bz/kOxecb6JjCCDODT1GJdNTaxktzx3AN
         9zFf9HVo8GMQEiVDwYZWUSUEw6vel6WzY98O/x0+rahJh4TOBPWHAL9tbY+NbV4QKOim
         bRVA==
X-Gm-Message-State: AOJu0Yz0AEfB9GtZYD/pW5z2mdKt1X0MmnLqkvVm6HYCOYc5K6Zr32D5
        QYYLD+7VS8t1p3OF6KnSvw==
X-Google-Smtp-Source: AGHT+IFnEBMb/1kNAabQhPqpIwzqhQ/yL/C2XGBrclcybcx7/0ZRWNO4HWvaIzYuvA4HpOmRNtE/pw==
X-Received: by 2002:a05:620a:26a0:b0:77f:5d7:6a66 with SMTP id c32-20020a05620a26a000b0077f05d76a66mr8537756qkp.23.1702423896604;
        Tue, 12 Dec 2023 15:31:36 -0800 (PST)
Received: from [120.7.1.23] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id bm27-20020a05620a199b00b0077d62e78db9sm4063251qkb.128.2023.12.12.15.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:31:36 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "<christian.koenig@amd.com>" <christian.koenig@amd.com>,
        Woody Suwalski <terraluna977@gmail.com>
From:   Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH v2] drm/radeon: Prevent multiple debug error lines on suspend
Message-ID: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com>
Date:   Tue, 12 Dec 2023 18:31:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to avoid multiple debug error lines printed on every suspend by 
Radeon driver's debugfs.

radeon_debugfs_init() calls debugfs_create_file() for every ring.

This results in printing multiple error lines to the screen and dmesg 
similar to this:

[   92.378726] debugfs: File 'radeon_ring_gfx' in directory 
'0000:00:01.0' already present!
[   92.378732] debugfs: File 'radeon_ring_cp1' in directory 
'0000:00:01.0' already present!
[   92.378734] debugfs: File 'radeon_ring_cp2' in directory 
'0000:00:01.0' already present!
[   92.378737] debugfs: File 'radeon_ring_dma1' in directory 
'0000:00:01.0' already present!
[   92.378739] debugfs: File 'radeon_ring_dma2' in directory 
'0000:00:01.0' already present!
[   92.380775] debugfs: File 'radeon_ring_uvd' in directory 
'0000:00:01.0' already present!
[   92.406620] debugfs: File 'radeon_ring_vce1' in directory 
'0000:00:01.0' already present!
[   92.406624] debugfs: File 'radeon_ring_vce2' in directory 
'0000:00:01.0' already present!


Patch v1: The fix was to run lookup() for the file before trying to 
(re)create that debug file.
Patch v2: Call the radeon_debugfs_init() only once when radeon ring is 
initialized (as suggested  by Christian K. - thanks)

Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
b/drivers/gpu/drm/radeon/radeon_ring.c
index e6534fa9f1fb..38048593bb4a 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -413,6 +413,7 @@ int radeon_ring_init(struct radeon_device *rdev, 
struct radeon_ring *ring, unsig
              dev_err(rdev->dev, "(%d) ring map failed\n", r);
              return r;
          }
+        radeon_debugfs_ring_init(rdev, ring);
      }
      ring->ptr_mask = (ring->ring_size / 4) - 1;
      ring->ring_free_dw = ring->ring_size / 4;
@@ -421,7 +422,6 @@ int radeon_ring_init(struct radeon_device *rdev, 
struct radeon_ring *ring, unsig
          ring->next_rptr_gpu_addr = rdev->wb.gpu_addr + index;
          ring->next_rptr_cpu_addr = &rdev->wb.wb[index/4];
      }
-    radeon_debugfs_ring_init(rdev, ring);
      radeon_ring_lockup_update(rdev, ring);
      return 0;
  }

