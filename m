Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7677FC09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352479AbjHQQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353690AbjHQQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:25:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182813599
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:25:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1F3B2185C;
        Thu, 17 Aug 2023 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692289460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tdLhBp3be39Ow7LFRDBwp1xDxodnRBLEqLHCf0VZvMo=;
        b=oxKwcghehfbdrUqRVj4/PzmDdMI9PoQbClDGz3mEbkgYSpgbe/Byc2L1Q0fJIA9fgmkXqR
        3THUNz1nUZgeaIIHP943wE8UWPp3KaZlDe7Bs/NETJ4lETiZ0bmDw9XCdFfxehDPXcNLbL
        rRI7gR9NAhESSoSh5X3MbQzZAtMtwSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692289460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tdLhBp3be39Ow7LFRDBwp1xDxodnRBLEqLHCf0VZvMo=;
        b=7P/cc9/4QC3LZmv1uok8brIFiZjSikBG6Bk5V6R1NsBWHx1Cf6ADqEJ0oFAJZElSxwrgDT
        WZ1rT9qLmLqAVLDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 534412C146;
        Thu, 17 Aug 2023 16:24:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alex Williamson <alex.williamson@redhat.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Li Chen <lchen@ambarella.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Deming Wang <wangdeming@inspur.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Move DMA64_PROPNAME define to a header
Date:   Thu, 17 Aug 2023 18:24:08 +0200
Message-ID: <20230817162411.429-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid redefining the same value in multiple source.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/iommu.h       | 3 +++
 arch/powerpc/kexec/file_load_64.c      | 5 +----
 arch/powerpc/platforms/pseries/iommu.c | 2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 34e14dfd8e04..026695943550 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -28,6 +28,9 @@
 #define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
 #define IOMMU_PAGE_ALIGN(addr, tblptr) ALIGN(addr, IOMMU_PAGE_SIZE(tblptr))
 
+#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
+
 /* Boot time flags */
 extern int iommu_is_off;
 extern int iommu_force_on;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 110d28bede2a..17f86f93da09 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -27,6 +27,7 @@
 #include <asm/kexec_ranges.h>
 #include <asm/crashdump-ppc64.h>
 #include <asm/mmzone.h>
+#include <asm/iommu.h>
 #include <asm/prom.h>
 #include <asm/plpks.h>
 
@@ -1208,8 +1209,6 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 	if (ret < 0)
 		goto out;
 
-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
-#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 	ret = update_pci_dma_nodes(fdt, DIRECT64_PROPNAME);
 	if (ret < 0)
 		goto out;
@@ -1217,8 +1216,6 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 	ret = update_pci_dma_nodes(fdt, DMA64_PROPNAME);
 	if (ret < 0)
 		goto out;
-#undef DMA64_PROPNAME
-#undef DIRECT64_PROPNAME
 
 	/* Update memory reserve map */
 	ret = get_reserved_memory_ranges(&rmem);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index d593a7227dc9..16d93b580f61 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -395,8 +395,6 @@ static LIST_HEAD(dma_win_list);
 static DEFINE_SPINLOCK(dma_win_list_lock);
 /* protects initializing window twice for same device */
 static DEFINE_MUTEX(dma_win_init_mutex);
-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
-#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
 static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
-- 
2.41.0

