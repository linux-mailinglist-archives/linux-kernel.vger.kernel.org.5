Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791517FE490
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbjK3AJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:09:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFFF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:10:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0ccfc4fc8so391115276.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701303002; x=1701907802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmjQgaxxDn5r7HkZPUYCJ27qew3aSHzjX5AlpzkdkoY=;
        b=KCOIPM7jBghjlaNvqZNIMzRxk+NyDgmjBQ89cFR2w0ohLu6aBrZjaYfEEiYwvuhv6v
         6E8TuDuiCaH4aEZxU4K3bnKhrEIRIkJHQ1CXY5ZUeSuwIeAeDRSM2pDnNEi8WQrR7zMA
         NMijg9ahLR8QEuRc7DP2Cr9XZl91t8aXq796sJKXQUTzxuuczXk3dmHQlN/UXLmZKsbX
         kZhpkIGaQxkjYxjLGSaTdVOzPwMdNDLpauzMwVA+ihKnmCv7l18SDT4IKVU45amBwftL
         4izK2uTpqlzYAOATDdVCYDLsIur9uhBGes3kpOPUSMS4sXt3diDBx5zeIeCbrEGPKCv3
         1s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303002; x=1701907802;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmjQgaxxDn5r7HkZPUYCJ27qew3aSHzjX5AlpzkdkoY=;
        b=cfJ8tzZgfiqh/k7n3ix4rkvhIoOPRIdQzbHJRljMI13TBtsVppvh2eueVho0MGmGWE
         7w5jw+UdIUF1MMHH//xw8GIx8mnfaXJnwx2R9lUUSEeJ9YZDwcGlr/Xle6nahpngT0Kg
         tb6dMYQtucSC/MM+6ct+AqEh4bBwDK55dAB+yCQp2/3D1VsmpKz/rfx3L2yBfyJfgDsK
         IyceReofj4h/y7TsjdRWuZzwyAnsY7cmalvbzeAqSJzVH3mzqRJG0zfQ6hobGR7bKptv
         AOeyYK+mUoqklvMqsm7Ad+9l9MH7M9Tj91pmV3xI9BVKXaiWea9Jv9HZSe0fCpSedblN
         tovw==
X-Gm-Message-State: AOJu0YwqGUXpozt5HDbmPp2aKvuQebc/iH9itG/p59I6GUcmfvCBG2OA
        Q+OgSigTMt3KsmYPfXkF0ONaN9QSyw8=
X-Google-Smtp-Source: AGHT+IGkmKVAkhUhDCuNHCF6qsZZjcgx0kXiwfuTem15ifyWvEMkuHM1uhjC+KfnOKjPGQulGYD2XibZdq8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bac6:0:b0:db3:fd6a:7bdb with SMTP id
 a6-20020a25bac6000000b00db3fd6a7bdbmr395765ybk.2.1701303002773; Wed, 29 Nov
 2023 16:10:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 16:10:00 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130001000.543240-1-seanjc@google.com>
Subject: [PATCH] vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart
From:   Sean Christopherson <seanjc@google.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the vfio_file_iommu_group() stub and instead unconditionally declare
the function to fudge around a KVM wart where KVM tries to do symbol_get()
on vfio_file_iommu_group() (and other VFIO symbols) even if CONFIG_VFIO=n.

Ensuring the symbol is always declared fixes a PPC build error when
modules are also disabled, in which case symbol_get() simply points at the
address of the symbol (with some attributes shenanigans).  Because KVM
does symbol_get() instead of directly depending on VFIO, the lack of a
fully defined symbol is not problematic (ugly, but "fine").

   arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7:
   error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
           fn = symbol_get(vfio_file_iommu_group);
                ^
   include/linux/module.h:805:60: note: expanded from macro 'symbol_get'
   #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
                                                              ^
   include/linux/vfio.h:294:35: note: previous definition is here
   static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
                                     ^
   arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7:
   error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
           fn = symbol_get(vfio_file_iommu_group);
                ^
   include/linux/module.h:805:65: note: expanded from macro 'symbol_get'
   #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
                                                                   ^
   include/linux/vfio.h:294:35: note: previous definition is here
   static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
                                     ^
   2 errors generated.

Although KVM is firmly in the wrong (there is zero reason for KVM to build
virt/kvm/vfio.c when VFIO is disabled), fudge around the error in VFIO as
the stub is unnecessary and doesn't serve its intended purpose (KVM is the
only external user of vfio_file_iommu_group()), and there is an in-flight
series to clean up the entire KVM<->VFIO interaction, i.e. fixing this in
KVM would result in more churn in the long run, and the stub needs to go
away regardless.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308251949.5IiaV0sz-lkp@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202309030741.82aLACDG-lkp@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202309110914.QLH0LU6L-lkp@intel.com
Link: https://lore.kernel.org/all/0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com
Link: https://lore.kernel.org/all/20230916003118.2540661-1-seanjc@google.com
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: c1cce6d079b8 ("vfio: Compile vfio_group infrastructure optionally")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/vfio.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 454e9295970c..a65b2513f8cd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -289,16 +289,12 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
 /*
  * External user API
  */
-#if IS_ENABLED(CONFIG_VFIO_GROUP)
 struct iommu_group *vfio_file_iommu_group(struct file *file);
+
+#if IS_ENABLED(CONFIG_VFIO_GROUP)
 bool vfio_file_is_group(struct file *file);
 bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
 #else
-static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
-{
-	return NULL;
-}
-
 static inline bool vfio_file_is_group(struct file *file)
 {
 	return false;

base-commit: ae2667cd8a479bb5abd6e24c12fcc9ef5bc06d75
-- 
2.43.0.rc1.413.gea7ed67945-goog

