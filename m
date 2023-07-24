Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8775F5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGXMOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGXMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:14:23 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6510D1;
        Mon, 24 Jul 2023 05:14:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8f1L6lTpz9ynSj;
        Mon, 24 Jul 2023 20:02:46 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.222.124])
        by APP2 (Coremail) with SMTP id GxC2BwA3_lTGar5ky0byBA--.27936S3;
        Mon, 24 Jul 2023 13:13:24 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v5 1/9] swiotlb: bail out of swiotlb_init_late() if swiotlb is already allocated
Date:   Mon, 24 Jul 2023 14:12:37 +0200
Message-Id: <437209bd783fa3febc3a207acb7799a0ff5cf1f3.1690200598.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690200598.git.petr.tesarik.ext@huawei.com>
References: <cover.1690200598.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3_lTGar5ky0byBA--.27936S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxCFyrZr4rWFyUXry5urg_yoW8uFykp3
        43AFyvgF4jgas7ArW5C3WDZF1Yka1kK347urW5Wr13Jr15Jw45Kr1DKrWakrWrWFW8WF4S
        yFy8ZF1Fv3W2qw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
        vfC2KfnxnUUI43ZEXa7VUjmZX5UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

If swiotlb is allocated, immediately return 0, so callers do not have to
check io_tlb_default_mem.nslabs explicitly.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 arch/arm/xen/mm.c         | 10 ++++------
 arch/x86/kernel/pci-dma.c | 12 ++++++------
 kernel/dma/swiotlb.c      |  3 +++
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 3d826c0b5fee..882cd70c7a2f 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -125,12 +125,10 @@ static int __init xen_mm_init(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
-		rc = swiotlb_init_late(swiotlb_size_or_default(),
-				       xen_swiotlb_gfp(), NULL);
-		if (rc < 0)
-			return rc;
-	}
+	rc = swiotlb_init_late(swiotlb_size_or_default(),
+			       xen_swiotlb_gfp(), NULL);
+	if (rc < 0)
+		return rc;
 
 	cflush.op = 0;
 	cflush.a.dev_bus_addr = 0;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de6be0a3965e..08988b0a1c91 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -86,16 +86,16 @@ static void __init pci_xen_swiotlb_init(void)
 
 int pci_xen_swiotlb_init_late(void)
 {
+	int rc;
+
 	if (dma_ops == &xen_swiotlb_dma_ops)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
-		int rc = swiotlb_init_late(swiotlb_size_or_default(),
-					   GFP_KERNEL, xen_swiotlb_fixup);
-		if (rc < 0)
-			return rc;
-	}
+	rc = swiotlb_init_late(swiotlb_size_or_default(),
+			       GFP_KERNEL, xen_swiotlb_fixup);
+	if (rc < 0)
+		return rc;
 
 	/* XXX: this switches the dma ops under live devices! */
 	dma_ops = &xen_swiotlb_dma_ops;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2b83e3ad9dca..66fc8ec9ae45 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -384,6 +384,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	bool retried = false;
 	int rc = 0;
 
+	if (io_tlb_default_mem.nslabs)
+		return 0;
+
 	if (swiotlb_force_disable)
 		return 0;
 
-- 
2.25.1

