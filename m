Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5281319B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573310AbjLNN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573251AbjLNN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:29:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D710F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:29:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so76307505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702560577; x=1703165377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkTXCXrHUkIYZAiXcbMUlKAwNq1xBlh137NstiChyxg=;
        b=o/YxV50+5ZNB6nKHdTLvI3Ifu6dXurc0j/fOBDhOCwa+zBnU9W5fOlp6x0E2WBZOTY
         maMbjZoQS/VDXU7xK6v1MyHD8wRkoUIwcn1y2WKQ6ezQ3Ns3KkdtW88bpOxKd6S4s10b
         JVAA40i5eU4qf1f11Bs4aygWHwr+LsQovEc8rDFKLmH0tr1ym50bND/9YDRr6nkiUXOK
         faIjIJodMavOtT6ReI0xwMwv+ZwLCuXSLIDNQpwbsdElqBk8Qg2Kg0u09cPoW5ofv7fx
         DA0gLFCqHrqKl6xFD7zewEzpMApTnEC3UCabZdV1mHiKxhjjdskobyDXv48NZoKcDRxY
         +eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560577; x=1703165377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkTXCXrHUkIYZAiXcbMUlKAwNq1xBlh137NstiChyxg=;
        b=T9/7qT0Vkki1Og+DLghUKzSBUvZmCZQ5fwmGehgFPlfUBXHjKkFMmT4was7PtXB1Ra
         K8rX+Mt9342n9fxV390aYdPF1hBXsHfX9dkxLjeUBRp8ARYOZF31cqn2eDsCHKdYMsBn
         v2S4/VW3HEt7tNp9ufXAHW3zymjGSik9w84u0nxQATI4AmTq0ypsYYu7vkhnA9kxEvvL
         1hPEa7AV//1nlvcvVt4PNkxlK4to9c/mRlak1uxpuuifd4oLl7oDbY6HYjYWEnAdXhoD
         E8j1gdtGCsDj8zcK2asrmSZH2MDMCQyZiY16sMyaDeB3ngYXStp1z+3mfFwqKHYnotZz
         rXfg==
X-Gm-Message-State: AOJu0YxviaFyOyfTMB9bhDUmbAI3VfV/q1kN2oRClVk+drGWW/1/f5ow
        S7il7fMcImI6FC8WAjor6AR3QA==
X-Google-Smtp-Source: AGHT+IFY8a/ikzRFmDNwTTeme387SJFOWFFd6jphJ+RMixQGZw483YvP9tBvX7Xri3w5b4Qm0adYhQ==
X-Received: by 2002:a05:600c:3b88:b0:40c:2a6c:a462 with SMTP id n8-20020a05600c3b8800b0040c2a6ca462mr2919054wms.78.1702560577533;
        Thu, 14 Dec 2023 05:29:37 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm13038759wmo.12.2023.12.14.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:29:37 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Use hugepage mappings for vmemmap
Date:   Thu, 14 Dec 2023 14:29:35 +0100
Message-Id: <20231214132935.212864-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow better TLB utilization and then should be more performant.

Before:

---[ vmemmap start ]---
0xffff8d8002000000-0xffff8d8012000000    0x000000046ec00000       256M PTE .   ..     ..   D A G . . W R V
---[ vmemmap end ]---

After:

---[ vmemmap start ]---
0xffff8d8002000000-0xffff8d8012000000    0x000000046ec00000       256M PMD .   ..     ..   D A G . . W R V
---[ vmemmap end ]---

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..f636336e6401 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1383,10 +1383,29 @@ void __init misc_mem_init(void)
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
+{
+	pmd_set_huge(pmd, virt_to_phys(p), PAGE_KERNEL);
+}
+
+int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
+				unsigned long addr, unsigned long next)
+{
+	vmemmap_verify((pte_t *)pmdp, node, addr, next);
+	return 1;
+}
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			       struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	/*
+	 * Note that SPARSEMEM_VMEMMAP is only selected for rv64 and that we
+	 * can't use hugepage mappings for 2-level page table because in case of
+	 * memory hotplug, we are not able to update all the page tables with
+	 * the new PMDs.
+	 */
+	return vmemmap_populate_hugepages(start, end, node, NULL);
 }
 #endif
 
-- 
2.39.2

