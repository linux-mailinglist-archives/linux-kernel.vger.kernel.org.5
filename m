Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E48805BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjLERXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjLERXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:23:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B70C0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701797002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEi7wv7QZl2s4sbtmNX6yC+kQMQhn1gNlg651IagIrk=;
        b=Mt6f2G5tDYamOtgN9Xqir5Fi3pS+beVEYLzJyM7BDpWk3Jopv2QssS7GQxhXwVu90bMZbM
        SNez0e9fQn2BoRjBT4H4jhVZoSoVjndjmFa8pY4jpjONMCi4zjCedaxnLqR2JeiQbbxTyp
        nmA/6cv50zSft1z9gCenbgsKrYbdZX8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-b-pJrCd-NZObOQwVT2qfiw-1; Tue, 05 Dec 2023 10:38:02 -0500
X-MC-Unique: b-pJrCd-NZObOQwVT2qfiw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bf2afb38fso376824e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790676; x=1702395476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEi7wv7QZl2s4sbtmNX6yC+kQMQhn1gNlg651IagIrk=;
        b=CmN/CZa9I54IZyHfcxcFWEZhwktekjyo+6HAST7rk6K58wDWJFOmqAgozEXGpzwTp3
         vs3X4Cf/gKj0gE1Bf2bu+sv4WmmQuOnCvt/xpUpKl4Ilalru85AZtxT2L1bXNiuc7bXQ
         YlrUxNlMLiRaVucbSgo2pLgT9sI6fOTuy1l/SBF+jcdZ/TdeaZI91oopUCLRB+5CBrto
         WQoRee6UqDIuZS3fCIR0Uge7p/qoos3khKqz7WGr7DJqyC8e7AiiAw2rbcFJIuzA+IHn
         xxWQozCspdwFSKi/aE4hYvCqIUFSSjqddElmfk+HT5DhiCTTp+Yt8bixKJyFmypYSqVK
         GpNg==
X-Gm-Message-State: AOJu0YyRk8x2Qj22QiKakiMuCHcwDofrsexXKa4f1373IX7bd5o243EG
        kUK5PJOCZqESs4TDEOPodpRJaeO6bM7O+2fH7PifdeZm0WgPhw3ybpY5GBes+XM7xK2eeAkjlL/
        XWCN3g0OZPapg7PZz6ji7xjN7
X-Received: by 2002:a05:6512:1111:b0:50b:f26b:62c7 with SMTP id l17-20020a056512111100b0050bf26b62c7mr4729373lfg.6.1701790676556;
        Tue, 05 Dec 2023 07:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGqMTlJ14Gf928cMDlm5yh3tCedSPeZ4SuUa6eCkLFuz+1zQTJ8Zd0HpQ56sRzZ/milPk0pQ==
X-Received: by 2002:a05:6512:1111:b0:50b:f26b:62c7 with SMTP id l17-20020a056512111100b0050bf26b62c7mr4729361lfg.6.1701790676236;
        Tue, 05 Dec 2023 07:37:56 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:912:71c8:c243:7b37:30b:a236])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402018f00b0054c21d1fda7sm1244578edv.1.2023.12.05.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:37:55 -0800 (PST)
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
Subject: [PATCH v4 2/5] lib: move pci_iomap.c to drivers/pci/
Date:   Tue,  5 Dec 2023 16:36:27 +0100
Message-ID: <20231205153629.26020-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153629.26020-2-pstanner@redhat.com>
References: <20231205153629.26020-2-pstanner@redhat.com>
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

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/Kconfig                    | 5 +++++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

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

