Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB58800AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378775AbjLAMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378807AbjLAMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC91715
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701433026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIU4mh01NIo3J+0bv0Z7Ok8zfrU9Sy5KFoYboE67XEg=;
        b=WKX3NhC8/gJn8CmP6fzH9EOMlC7PCUwBGiE3+48PKDyNzjQgkNAzfv0rDZ3dqBdkOViquV
        P1v7pWnO4njyddN0SN/3m471ZQnDlUQ/gTuhE5Hyj7xpH8+32WOq92bhfe9heivBuEayQt
        CLN77ESdyu8yFcpZyTrVa2Yi45CMvdE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-tplWXAJEPkqnPXDqWRFaJA-1; Fri, 01 Dec 2023 07:17:04 -0500
X-MC-Unique: tplWXAJEPkqnPXDqWRFaJA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-423f2ad71c9so5378081cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433023; x=1702037823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIU4mh01NIo3J+0bv0Z7Ok8zfrU9Sy5KFoYboE67XEg=;
        b=RLQl7NPbdGe/0b8gNc5vTeDkvXwzab3ymmmpz+YdeVUx4DGU4IHKe0TEDnI/EnBMtZ
         Hc/ebWCDbXfQi9lxDKUAZnBU7I6KYQmsaWEXDvre2GXiPzUe1hbfvHLFMdGNU2YxbLzX
         3JewRWtL/km+s6nl0+wIlFBT+NgpQOZuSxDrmnfo+U9L8FGdX1jSiUtLC95tOXNbU3Wn
         D6c27tFYBbOlwh7+hyCaCG1D5pX2zLqyfmQQMPr5q9PL9P7+cdUDBP4rPWDy/ADE6LTd
         rGEyuMtpaJ1pQCVQPz4/41RSB0eVN/aFUuAulEK2sq1cL/xMxArXDKasp075LMCax0s9
         HI0g==
X-Gm-Message-State: AOJu0Yx2+dlVfz+xicdU+SIxqA0/38bSvm1WwBiEfiG2+GbwdKktWOds
        nlkqtTRtCsLfiBqUFW0bW5bpgzAPuQvgI8PQwlZMZjc3J6kyPL0z9GkEZlA4IArf0W13MvUuYw2
        wMry4MbJrzMMo1CUzAaGXIV1P
X-Received: by 2002:a05:622a:5505:b0:423:a6c8:7db9 with SMTP id fj5-20020a05622a550500b00423a6c87db9mr24035871qtb.6.1701433023437;
        Fri, 01 Dec 2023 04:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQfSS2UW2A54VtKLLtAF4bxHgHalN5nM46dpZI44qbzDLU3S4OQPiukfxEaRXrK+nRrdI9pQ==
X-Received: by 2002:a05:622a:5505:b0:423:a6c8:7db9 with SMTP id fj5-20020a05622a550500b00423a6c87db9mr24035847qtb.6.1701433023157;
        Fri, 01 Dec 2023 04:17:03 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm1426528qtr.29.2023.12.01.04.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:17:02 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        NeilBrown <neilb@suse.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Philipp Stanner <pstanner@redhat.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
Date:   Fri,  1 Dec 2023 13:16:22 +0100
Message-ID: <20231201121622.16343-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201121622.16343-1-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of pci_iounmap() is currently scattered over two
files, drivers/pci/iounmap.c and lib/iomap.c. Additionally,
architectures can define their own version.

Besides one unified version being desirable in the first place, the old
version in drivers/pci/iounmap.c contained a bug and could leak memory
mappings. The bug was that #ifdef ARCH_HAS_GENERIC_IOPORT_MAP should not
have guarded iounmap(p); in addition to the preceding code.

To have only one version, it's necessary to create a helper function,
iomem_is_ioport(), that tells pci_iounmap() whether the passed address
points to an ioport or normal memory.

iomem_is_ioport() can be provided through three different ways:
  1. The architecture itself provides it.
  2. As a default version in include/asm-generic/io.h for those
     architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
     provide their own version of iomem_is_ioport().
  3. As a default version in lib/iomap.c for those architectures that
     define and use CONFIG_GENERIC_IOMAP (currently, only x86 really
     uses the functions in lib/iomap.c)

Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
Provide the function iomem_is_ioport() in include/asm-generic/io.h and
lib/iomap.c.

Remove the CONFIG_GENERIC_IOMAP guard around
ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
function.

Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c      | 40 +++++++++++-----------------------------
 include/asm-generic/io.h | 37 ++++++++++++++++++++++++++++++++++---
 lib/iomap.c              | 16 +++++++++-------
 3 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 0a9d503ba533..cb7f86371b7d 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -135,42 +135,24 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
 
 /*
- * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
- * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
- * the different IOMAP ranges.
+ * Generic version of pci_iounmap() that is used if the architecture does not
+ * provide its own version.
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
+ * If you have special rules for your architecture, you need to implement your
+ * own pci_iounmap() in ARCH/asm/io.h that knows the rules for where and how IO
+ * vs MEM get mapped.
  */
 #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
 
-void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
-	uintptr_t start = (uintptr_t) PCI_IOBASE;
-	uintptr_t addr = (uintptr_t) p;
-
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+#ifdef CONFIG_HAS_IOPORT
+	if (iomem_is_ioport(addr)) {
+		ioport_unmap(addr);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..4177d6b97e0b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1129,11 +1129,42 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifndef CONFIG_GENERIC_IOMAP
 #ifndef pci_iounmap
+#define pci_iounmap pci_iounmap
 #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
-#endif
-#endif
+#endif /* pci_iounmap */
+
+
+/*
+ * This function is a helper only needed for the generic pci_iounmap().
+ * It's provided here if the architecture does not select GENERIC_IOMAP and does
+ * not provide its own version.
+ */
+#ifdef CONFIG_HAS_IOPORT
+#ifndef iomem_is_ioport /* i.e., if the architecture hasn't defined its own. */
+#define iomem_is_ioport iomem_is_ioport
+
+#ifndef CONFIG_GENERIC_IOMAP
+static inline bool iomem_is_ioport(void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+
+	// TODO: do we have to take IO_SPACE_LIMIT and PCI_IOBASE into account
+	// similar as in ioport_map() ?
+
+	if (port > MMIO_UPPER_LIMIT)
+		return false;
+
+	return true;
+}
+#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will be used. */
+bool iomem_is_ioport(void __iomem *addr);
+#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
+#endif /* CONFIG_GENERIC_IOMAP */
+
+#endif /* iomem_is_ioport */
+#endif /* CONFIG_HAS_IOPORT */
+
 
 #ifndef xlate_dev_mem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..adaf6246f892 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -418,12 +418,14 @@ EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
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

