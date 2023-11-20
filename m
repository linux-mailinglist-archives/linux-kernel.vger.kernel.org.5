Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DD7F1FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjKTWAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjKTWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBABC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700517610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YknJrzt+mUcfRZD9fsxvrl+TzKmo/BIC31FKbthLKE=;
        b=g39P4wAXaqLdR++0cEPeKAVGHR6HhGaHz5p1cWabykc1HCiN0HOZ7yVrZGS+GHYV2o4Cke
        4yJzmblnZUVTFyibFHmYlJR1VJBCv9d6sbCGQsY4CBlrGYH8UZkcCq/EB52sGoMcQYhUrW
        fn5M9FUTrudBsqyZQBtMuY8QL+I3d0k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hYtjXP6RPCODIAcWWYxrtg-1; Mon, 20 Nov 2023 17:00:09 -0500
X-MC-Unique: hYtjXP6RPCODIAcWWYxrtg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1f93a01ef88so461184fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517608; x=1701122408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YknJrzt+mUcfRZD9fsxvrl+TzKmo/BIC31FKbthLKE=;
        b=Ww0m/fSbnY7AlFe6Ca/eE6f7s2jt7iclNgJJ2AoRe+D//S7GdSlDrtkVbAYN7V/EtC
         42SF/P5FMdIHllcNJ5lw3aq/pOoVhA8nSnqIBkUN6Gf2t1gqaSfKpeoD1LYw/ryUpGUM
         bzGkTNzvIjFF1G0z3L5CBv+QZLi/slZ9nyVibrSbrOGA6g3mLjFOSO01G8FE739Yg723
         zNPJ/fyb079m+KndchJI9aUH0LwSkBLvi9hSzUQRHmYvrWEpsj3c+483BfXK7ACylVoW
         0p3D6BCx7m+t1PehLAeGluUgeMvhJmRqZVAovCWM8rdDxsOMPlcUPCs/lsAij9Na/7Ld
         lC0A==
X-Gm-Message-State: AOJu0YzkFA6prAE4JlzgELeIIVSSrBUzZv3tSB0PsDuSK6+DagiQ6DKr
        XDIvlgNhuQyRjb12gxp16eITVbU8revZ174KtiWwc5+/2hsDExuTD52sCcYGI58qsd+JrFzedyF
        bRJQpeFJarL6P8sP7ZROAqgxx
X-Received: by 2002:a05:6358:199b:b0:16d:abd9:f29e with SMTP id v27-20020a056358199b00b0016dabd9f29emr6547707rwn.2.1700517608425;
        Mon, 20 Nov 2023 14:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCIi4ZtnWPYH5Nbuh+PP3GwGRiVhr5nrSG3asXMxcfimwvOxj/XDAQGiRIbPn9EQ4+9RYwPg==
X-Received: by 2002:a05:6358:199b:b0:16d:abd9:f29e with SMTP id v27-20020a056358199b00b0016dabd9f29emr6547661rwn.2.1700517608043;
        Mon, 20 Nov 2023 14:00:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32dd:2700:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id 3-20020ad45ba3000000b00677fb918337sm2762398qvq.53.2023.11.20.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:00:07 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, Philipp Stanner <pstanner@redhat.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Date:   Mon, 20 Nov 2023 22:59:43 +0100
Message-ID: <20231120215945.52027-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120215945.52027-2-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 drivers/pci/Kconfig                    | 3 +++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 5 files changed, 4 insertions(+), 7 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..b54cacbc1160 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -34,6 +34,9 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	bool
 
+config GENERIC_PCI_IOMAP
+	bool
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..d6d0abfe59e2 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/lib/pci_iomap.c b/drivers/pci/iomap.c
similarity index 99%
rename from lib/pci_iomap.c
rename to drivers/pci/iomap.c
index ce39ce9f3526..0a9d503ba533 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -176,5 +175,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
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
2.41.0

