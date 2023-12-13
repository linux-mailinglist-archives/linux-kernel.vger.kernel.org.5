Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0395810EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378083AbjLMKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377954AbjLMKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD110A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702464579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dyerj4wk/ZFwQTySswA1kbRd7v7F1+vxDBdnemG6spU=;
        b=GoXB8MpnjsEnqtfZQFbMoa1/uOSeiUWZirHI5p/vBIw4JJkVbme0yAtot0hVgXwqLREXnz
        5pZ9jkIz3pEiFOqg/ncVkcDzkGI3nITREWev6oMOMxodnW8POsvoDOltSuhvwAJaVuHv6L
        RViqxJWR29SADJxorpyuPKDIG7c3jy4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AOZmAvsYOOyAb6Kfe1QRhA-1; Wed, 13 Dec 2023 05:49:37 -0500
X-MC-Unique: AOZmAvsYOOyAb6Kfe1QRhA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so109021866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464576; x=1703069376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dyerj4wk/ZFwQTySswA1kbRd7v7F1+vxDBdnemG6spU=;
        b=uToH5uZgSeJinUJml5rQekuAC10Z4Yj4+p8DMzNMreNu+QqVnB/ukQ6zbWS5ZI30+7
         OPKB0xFv3w7R1NdNv5XfMSXENRkGpn099eu6LgPVXzFFCacwbR92T6DyAKD40xTHlH/y
         VXiJ+XxlW/fYGU+bIIYKug/j4eV1oN6AjO9XVncfHNXLdciGqhFX+dswnegE9m2mlP6t
         +b6c5aSSRdJp3cxx06h89e6RFqKo5G7SyvJh8zowfiaj0ag4B+kpts4BpocXI4gFPAT/
         orkRcgtj9ERSKwXREURi90qtXwTOkzvWvqLrgWPMJyANNv4TVTGo4uig/jI8AQ+nMuva
         S8ow==
X-Gm-Message-State: AOJu0YxX6mJAJ+M+R0EWtGUCaFDNboME2yj5l+tWNv1ajXQVzXdvODS+
        VQ0MKB2m0GYUqodoouqZnZ7Bto6XcOcpxbvrKYLvd4hGLwJUT2QyXU0pvAJfVvZde4h3q5En0bE
        fOJQ3XGpMkMV3Y+DTEFut6JVk
X-Received: by 2002:a17:907:d384:b0:a1c:897e:fd9b with SMTP id vh4-20020a170907d38400b00a1c897efd9bmr9135603ejc.6.1702464576124;
        Wed, 13 Dec 2023 02:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHwvxol0UYRrnjRp/EV+tcv0oQi879MTwKQykw0mwBCh+8aBMLvjftjnEMfDz5MV5NX/PkIg==
X-Received: by 2002:a17:907:d384:b0:a1c:897e:fd9b with SMTP id vh4-20020a170907d38400b00a1c897efd9bmr9135587ejc.6.1702464575819;
        Wed, 13 Dec 2023 02:49:35 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:914:ed27:4fa9:dbce:10f5:d0b9])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm7527135ejc.3.2023.12.13.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:49:35 -0800 (PST)
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
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5 2/5] lib: move pci_iomap.c to drivers/pci/
Date:   Wed, 13 Dec 2023 11:49:19 +0100
Message-ID: <20231213104922.13894-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213104922.13894-1-pstanner@redhat.com>
References: <20231213104922.13894-1-pstanner@redhat.com>
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

This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
belong to lib/ because it is not generic infrastructure.

Move the file to drivers/pci/ and implement the necessary changes to
Makefiles and Kconfigs.

Update MAINTAINERS file.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                            | 1 -
 drivers/pci/Kconfig                    | 5 +++++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 6 files changed, 6 insertions(+), 8 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index edae86acdfdc..efa37ee81d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16762,7 +16762,6 @@ F:	include/asm-generic/pci*
 F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
-F:	lib/pci*
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..d35001589d88 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -13,6 +13,11 @@ config FORCE_PCI
 	select HAVE_PCI
 	select PCI
 
+# select this to provide a generic PCI iomap,
+# without PCI itself having to be defined
+config GENERIC_PCI_IOMAP
+	bool
+
 menuconfig PCI
 	bool "PCI support"
 	depends on HAVE_PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..64dcedccfc87 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/lib/pci_iomap.c b/drivers/pci/iomap.c
similarity index 99%
rename from lib/pci_iomap.c
rename to drivers/pci/iomap.c
index 6e144b017c48..91285fcff1ba 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -178,5 +177,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* ARCH_WANTS_GENERIC_PCI_IOUNMAP */
-
-#endif /* CONFIG_PCI */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ea1c830efab..1bf859166ac7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -70,9 +70,6 @@ source "lib/math/Kconfig"
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
-config GENERIC_PCI_IOMAP
-	bool
-
 config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..0800289ec6c5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -153,7 +153,6 @@ CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 obj-y += math/ crypto/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
-obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
-- 
2.43.0

