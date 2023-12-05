Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA097805C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442475AbjLEPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442448AbjLEPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F6383
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701790729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTGzUnuImaRUCmV4376iFTUXoCEDIuJDS3P/LYSpU0A=;
        b=X3VDZTJOIyjM+r/zrWFGz2HzLwIvhHgWoBvjeGyOLIR3N/yg4l8YzHOtUoYTqL3GGd5EFm
        rDNJLOmrRrYDxUfLFXhuSHpxAb+7cQABk+O89610qlGpU2zmUtRwBKkhxbPTdQyFBbM2Kc
        8CpkF5+cqWz5g1Q3/OWVe21lkRX3WI8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-rCF1DdzBOH-yKu4ezspFMg-1; Tue, 05 Dec 2023 10:38:12 -0500
X-MC-Unique: rCF1DdzBOH-yKu4ezspFMg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bfdc85e46so267271e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790685; x=1702395485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTGzUnuImaRUCmV4376iFTUXoCEDIuJDS3P/LYSpU0A=;
        b=Nk7D5AD3RNOn0EkIje91E9oRj6w895zuWuhUcy/QjIaSV1aEBMFVhCRNkfRbegR0+B
         NMQaT+/yVkkF/pJ9fsbPNgZ5ywQjRs/AIKxtiEJ4a86pCXi5i6fdrQyeDf5wiaQhSjFt
         hyKye379ZHeImAwrl22xzrU6Z7QA9tzHadF/6HNfE9oIKtuGRKKuVVJc4M9/RylZSX9d
         cb6t/ZhtTjSOjpV4Rj/1EgsVjRVCz+1sFhADkRSxWNHaB3vbAAAWvtidzZWUobzZllsC
         iD+03Mq591QytH39ZJC5KsRPTtObnEnGWWHZrXCkDI88kgjzf9g8RYyFmrovn9de3fnp
         eWqQ==
X-Gm-Message-State: AOJu0YwW6r9rTvwlMikmRvwRjBPTdW1zKrDOagoyXc1yXZ2EQLuBcLzZ
        NDB7yRmSGw9me+mr2Bbg569pu0FCdGRgft6LVh+npUqNZ4nxMdX3bTHgnAkVHyDZfRbt/lj2jsY
        cZx0fDfi2QpwjVtLSPivEjife
X-Received: by 2002:a05:6512:3ca4:b0:50b:fd29:7ed8 with SMTP id h36-20020a0565123ca400b0050bfd297ed8mr3862442lfv.3.1701790685296;
        Tue, 05 Dec 2023 07:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr+KaNPAgoT0SZAJFiDxNFtRx0nasxXdzFRVvIz/4kkZr/bUzYlPYolm2P7sHnNK/2XAOWUQ==
X-Received: by 2002:a05:6512:3ca4:b0:50b:fd29:7ed8 with SMTP id h36-20020a0565123ca400b0050bfd297ed8mr3862402lfv.3.1701790684999;
        Tue, 05 Dec 2023 07:38:04 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:912:71c8:c243:7b37:30b:a236])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402018f00b0054c21d1fda7sm1244578edv.1.2023.12.05.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:38:04 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 5/5] lib, pci: unify generic pci_iounmap()
Date:   Tue,  5 Dec 2023 16:36:30 +0100
Message-ID: <20231205153629.26020-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153629.26020-2-pstanner@redhat.com>
References: <20231205153629.26020-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of pci_iounmap() is currently scattered over two
files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
architectures can define their own version.

To have only one version, it's necessary to create a helper function,
iomem_is_ioport(), that tells pci_iounmap() whether the passed address
points to an ioport or normal memory.

iomem_is_ioport() can be provided through two different ways:
  1. The architecture itself provides it. As of today, the version
     coming from lib/iomap.c de facto is the x86-specific version and
     comes into play when CONFIG_GENERIC_IOMAP is selected. This rather
     confusing naming is an artifact left by the removal of IA64.
  2. As a default version in include/asm-generic/io.h for those
     architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
     provide their own version of iomem_is_ioport().

Once all architectures that support ports provide iomem_is_ioport(), the
arch-specific definitions for pci_iounmap() can be removed and the archs
can use the generic implementation, instead.

Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
Provide the function iomem_is_ioport() in include/asm-generic/io.h
(generic) and lib/iomap.c ("pseudo-generic" for x86).

Remove the CONFIG_GENERIC_IOMAP guard around
ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
function.

Add TODOs for follow-up work on the "generic is not generic but
x86-specific"-Problem.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/iomap.c         | 46 +++++++++++++------------------------
 include/asm-generic/io.h    | 27 ++++++++++++++++++++--
 include/asm-generic/iomap.h | 21 +++++++++++++++++
 lib/iomap.c                 | 28 ++++++++++++++++------
 4 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 91285fcff1ba..b7faf22ec8f5 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -135,44 +135,30 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
 
 /*
- * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
- * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
- * the different IOMAP ranges.
+ * This check is still necessary due to legacy reasons.
  *
- * But if the architecture does not use the generic iomap code, and if
- * it has _not_ defined it's own private pci_iounmap function, we define
- * it here.
- *
- * NOTE! This default implementation assumes that if the architecture
- * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
- * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
- * and does not need unmapping with 'ioport_unmap()'.
- *
- * If you have different rules for your architecture, you need to
- * implement your own pci_iounmap() that knows the rules for where
- * and how IO vs MEM get mapped.
- *
- * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
- * from legacy <asm-generic/io.h> header file behavior. In particular,
- * it would seem to make sense to do the iounmap(p) for the non-IO-space
- * case here regardless, but that's not what the old header file code
- * did. Probably incorrectly, but this is meant to be bug-for-bug
- * compatible.
+ * TODO: Have all architectures that provide their own pci_iounmap() provide
+ * iomem_is_ioport() instead. Remove this #if afterwards.
  */
 #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
 
-void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+/**
+ * pci_iounmap - Unmapp a mapping
+ * @dev: PCI device the mapping belongs to
+ * @addr: start address of the mapping
+ *
+ * Unmapp a PIO or MMIO mapping.
+ */
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
-	uintptr_t start = (uintptr_t) PCI_IOBASE;
-	uintptr_t addr = (uintptr_t) p;
-
-	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
-		ioport_unmap(p);
+#ifdef CONFIG_HAS_IOPORT_MAP
+	if (iomem_is_ioport(addr)) {
+		ioport_unmap(addr);
 		return;
 	}
 #endif
-	iounmap(p);
+
+	iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..58c7bf4080da 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1129,11 +1129,34 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifndef CONFIG_GENERIC_IOMAP
+/*
+ * TODO:
+ * remove this once all architectures replaced their pci_iounmap() with
+ * a custom implementation of iomem_is_ioport().
+ */
 #ifndef pci_iounmap
+#define pci_iounmap pci_iounmap
 #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
+#endif /* pci_iounmap */
+
+/*
+ * This function is a helper only needed for the generic pci_iounmap().
+ * It's provided here if the architecture does not provide its own version.
+ */
+#ifndef iomem_is_ioport
+#define iomem_is_ioport iomem_is_ioport
+static inline bool iomem_is_ioport(void __iomem *addr_raw)
+{
+#ifdef CONFIG_HAS_IOPORT
+	uintptr_t start = (uintptr_t)PCI_IOBASE;
+	uintptr_t addr = (uintptr_t)addr_raw;
+
+	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+		return true;
 #endif
-#endif
+	return false;
+}
+#endif /* iomem_is_ioport */
 
 #ifndef xlate_dev_mem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..2cdc6988a102 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -110,6 +110,27 @@ static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
 }
 #endif
 
+/*
+ * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT provide its
+ * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that the generic
+ * version from asm-generic/io.h is NOT used and instead the second "generic"
+ * version from lib/iomap.c is used.
+ *
+ * There are currently two generic versions because of a difficult cleanup
+ * process. Namely, the version in lib/iomap.c once was really generic when IA64
+ * still existed. Today, it's only really used by x86.
+ *
+ * TODO: Move the version from lib/iomap.c to x86 specific code. Then, remove
+ * this ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT-mechanism.
+ */
+#ifdef CONFIG_GENERIC_IOMAP
+#ifndef iomem_is_ioport
+#define iomem_is_ioport iomem_is_ioport
+bool iomem_is_ioport(void __iomem *addr);
+#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
+#endif /* iomem_is_ioport */
+#endif /* CONFIG_GENERIC_IOMAP */
+
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..eb9a879ebf42 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -418,12 +418,26 @@ EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
+/*
+ * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT provide its
+ * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that the generic
+ * version from asm-generic/io.h is NOT used and instead the second "generic"
+ * version from this file here is used.
+ *
+ * There are currently two generic versions because of a difficult cleanup
+ * process. Namely, the version in lib/iomap.c once was really generic when IA64
+ * still existed. Today, it's only really used by x86.
+ *
+ * TODO: Move this function to x86-specific code.
+ */
+#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
+bool iomem_is_ioport(void __iomem *addr)
 {
-	IO_COND(addr, /* nothing */, iounmap(addr));
+	unsigned long port = (unsigned long __force)addr;
+
+	if (port > PIO_OFFSET && port < PIO_RESERVED)
+		return true;
+
+	return false;
 }
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
+#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
-- 
2.43.0

