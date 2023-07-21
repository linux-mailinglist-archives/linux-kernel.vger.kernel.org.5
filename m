Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835075C164
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGUIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGUIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:21:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E5030C2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:21:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6jF613Y7z4f41Gc
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:21:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZT2P7pkhprcOQ--.24672S7;
        Fri, 21 Jul 2023 16:21:15 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/3] arm64: kdump: add support access protection for crashkernel region
Date:   Fri, 21 Jul 2023 16:17:26 +0800
Message-Id: <20230721081726.882-4-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZT2P7pkhprcOQ--.24672S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW8AF4DWrWrWFykGr48JFb_yoW5tF1xpw
        1DZr4rtr4UuFsakr93Jrsxuw4rJw1kKa4ag34Fkr1F9FyDGry3GF98W3W7ZFWUCr4Yga1I
        vFsYqFnYq3WUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F2
        4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42
        IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7-eoUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
are meant to be called by kexec_load() in order to protect the memory
allocated for crash dump kernel once the image is loaded.

This is basically revert commit 0d124e96051b
("arm64: kdump : take off the protection on crashkernel memory region"),
except for the crashkernel region has been fallen back. Because we didn't
do page-level mapping for the newly allocated region.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/include/asm/kexec.h    |  8 ++++++++
 arch/arm64/kernel/machine_kexec.c | 26 ++++++++++++++++++++++++++
 arch/arm64/mm/init.c              |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9ac9572a3bbee2c..a55388ff045e980 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -102,6 +102,14 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 
 int machine_kexec_post_load(struct kimage *image);
 #define machine_kexec_post_load machine_kexec_post_load
+
+extern bool crash_fallback;
+
+void arch_kexec_protect_crashkres(void);
+#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
+
+void arch_kexec_unprotect_crashkres(void);
+#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 078910db77a41b6..00392b48501d35c 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -269,6 +269,32 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Starting crashdump kernel...\n");
 }
 
+void arch_kexec_protect_crashkres(void)
+{
+	int i;
+
+	if (crash_fallback)
+		return;
+
+	for (i = 0; i < kexec_crash_image->nr_segments; i++)
+		set_memory_valid(
+			__phys_to_virt(kexec_crash_image->segment[i].mem),
+			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 0);
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	int i;
+
+	if (crash_fallback)
+		return;
+
+	for (i = 0; i < kexec_crash_image->nr_segments; i++)
+		set_memory_valid(
+			__phys_to_virt(kexec_crash_image->segment[i].mem),
+			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 1);
+}
+
 #ifdef CONFIG_HIBERNATION
 /*
  * To preserve the crash dump kernel image, the relevant memory segments
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2ab377520b2742..b544ed0ab04193d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -74,6 +74,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 
+bool crash_fallback;
 static int crashkernel_type __initdata;
 
 static phys_addr_t __init crashkernel_phys_alloc_range(phys_addr_t size,
@@ -199,6 +200,9 @@ static void __init late_reserve_crashkernel(void)
 	crashk_res.end   = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
 
+	crash_fallback = true;
+	pr_info("cannot allocate all crashkernel memory as expected, fallen back.\n");
+
 ok:
 	crash_base = crashk_res.start;
 	crash_size = resource_size(&crashk_res);
-- 
2.25.1

