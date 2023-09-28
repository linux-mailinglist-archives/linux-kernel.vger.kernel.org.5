Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADA7B184B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjI1Kcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjI1Kci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:32:38 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF230122;
        Thu, 28 Sep 2023 03:32:35 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77409065623so789583285a.0;
        Thu, 28 Sep 2023 03:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897155; x=1696501955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rXaHGJtfkoHYQGJjVadzc/ugaC86pv9lFBvW3UfqOM=;
        b=OJFYG8Cog9qHBXI9wahGHsW3jylHn+vHtZe+03sw8mfjRgxjDel8ojQNBqRcbG7Viw
         QBhIVDnreDEjHmg/AQj+tQbQl+5J+p5nvJ0xMcWSdNHptYa5PKKwjRXSERjMAhn5gEi/
         iHMS3ww9H2Ka19ECtZ8khjOeGwDpWyFHcupRWLMxsL5yHbhveGFIHWpb90w+DhLsN2il
         9aP7V9MF3VjebCRAgLqLqZOvJFSCUzTs95cmp+jYevCZE5vBevmbp7qMZMnRi0FXwD9r
         S8hv4I+sPvYdqYe+hd81wHWxN2hlhj7MK55YjNwslpvms//QJPntIxyBXbywF03Bw0Hq
         3qfw==
X-Gm-Message-State: AOJu0Yz+qkEbSGPeqouoycCEHFpNs339audbsuSVqJ0hCCxOILliQivk
        lAr5zjKeu8Cd4KZci929pHvKcuuPqba2nw==
X-Google-Smtp-Source: AGHT+IF/T4XpKgP4zynzo8wu0vsB/i56c+MQL7Y78e6OBoSzeQt6SrlBVkPqXq+d0zVrVCgRnigbAQ==
X-Received: by 2002:a0c:aaca:0:b0:655:d9d8:2c33 with SMTP id g10-20020a0caaca000000b00655d9d82c33mr592430qvb.53.1695897154650;
        Thu, 28 Sep 2023 03:32:34 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:cb84:45fc:12dc:6d10:9889])
        by smtp.gmail.com with ESMTPSA id e3-20020a0cf343000000b0065d13c3b77esm205291qvm.1.2023.09.28.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:32:34 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: [PATCH] docs: move riscv under arch
Date:   Thu, 28 Sep 2023 13:29:42 +0300
Message-ID: <20230928103134.2779459-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and fix all in-tree references.

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/arch/index.rst                                  | 2 +-
 Documentation/{ => arch}/riscv/acpi.rst                       | 0
 Documentation/{ => arch}/riscv/boot-image-header.rst          | 0
 Documentation/{ => arch}/riscv/boot.rst                       | 0
 Documentation/{ => arch}/riscv/features.rst                   | 0
 Documentation/{ => arch}/riscv/hwprobe.rst                    | 0
 Documentation/{ => arch}/riscv/index.rst                      | 0
 Documentation/{ => arch}/riscv/patch-acceptance.rst           | 0
 Documentation/{ => arch}/riscv/uabi.rst                       | 0
 Documentation/{ => arch}/riscv/vector.rst                     | 0
 Documentation/{ => arch}/riscv/vm-layout.rst                  | 0
 Documentation/maintainer/maintainer-entry-profile.rst         | 2 +-
 Documentation/process/index.rst                               | 2 +-
 Documentation/translations/it_IT/riscv/patch-acceptance.rst   | 2 +-
 Documentation/translations/zh_CN/arch/index.rst               | 2 +-
 .../translations/zh_CN/{ => arch}/riscv/boot-image-header.rst | 4 ++--
 Documentation/translations/zh_CN/{ => arch}/riscv/index.rst   | 4 ++--
 .../translations/zh_CN/{ => arch}/riscv/patch-acceptance.rst  | 4 ++--
 .../translations/zh_CN/{ => arch}/riscv/vm-layout.rst         | 4 ++--
 .../zh_CN/maintainer/maintainer-entry-profile.rst             | 2 +-
 MAINTAINERS                                                   | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h                         | 2 +-
 arch/riscv/kernel/sys_riscv.c                                 | 2 +-
 23 files changed, 17 insertions(+), 17 deletions(-)
 rename Documentation/{ => arch}/riscv/acpi.rst (100%)
 rename Documentation/{ => arch}/riscv/boot-image-header.rst (100%)
 rename Documentation/{ => arch}/riscv/boot.rst (100%)
 rename Documentation/{ => arch}/riscv/features.rst (100%)
 rename Documentation/{ => arch}/riscv/hwprobe.rst (100%)
 rename Documentation/{ => arch}/riscv/index.rst (100%)
 rename Documentation/{ => arch}/riscv/patch-acceptance.rst (100%)
 rename Documentation/{ => arch}/riscv/uabi.rst (100%)
 rename Documentation/{ => arch}/riscv/vector.rst (100%)
 rename Documentation/{ => arch}/riscv/vm-layout.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/riscv/boot-image-header.rst (96%)
 rename Documentation/translations/zh_CN/{ => arch}/riscv/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/riscv/patch-acceptance.rst (93%)
 rename Documentation/translations/zh_CN/{ => arch}/riscv/vm-layout.rst (98%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 837d7e78606a..3f9962e45c09 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -19,7 +19,7 @@ implementation.
    openrisc/index
    parisc/index
    powerpc/index
-   ../riscv/index
+   riscv/index
    s390/index
    sh/index
    sparc/index
diff --git a/Documentation/riscv/acpi.rst b/Documentation/arch/riscv/acpi.rst
similarity index 100%
rename from Documentation/riscv/acpi.rst
rename to Documentation/arch/riscv/acpi.rst
diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/arch/riscv/boot-image-header.rst
similarity index 100%
rename from Documentation/riscv/boot-image-header.rst
rename to Documentation/arch/riscv/boot-image-header.rst
diff --git a/Documentation/riscv/boot.rst b/Documentation/arch/riscv/boot.rst
similarity index 100%
rename from Documentation/riscv/boot.rst
rename to Documentation/arch/riscv/boot.rst
diff --git a/Documentation/riscv/features.rst b/Documentation/arch/riscv/features.rst
similarity index 100%
rename from Documentation/riscv/features.rst
rename to Documentation/arch/riscv/features.rst
diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
similarity index 100%
rename from Documentation/riscv/hwprobe.rst
rename to Documentation/arch/riscv/hwprobe.rst
diff --git a/Documentation/riscv/index.rst b/Documentation/arch/riscv/index.rst
similarity index 100%
rename from Documentation/riscv/index.rst
rename to Documentation/arch/riscv/index.rst
diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/arch/riscv/patch-acceptance.rst
similarity index 100%
rename from Documentation/riscv/patch-acceptance.rst
rename to Documentation/arch/riscv/patch-acceptance.rst
diff --git a/Documentation/riscv/uabi.rst b/Documentation/arch/riscv/uabi.rst
similarity index 100%
rename from Documentation/riscv/uabi.rst
rename to Documentation/arch/riscv/uabi.rst
diff --git a/Documentation/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
similarity index 100%
rename from Documentation/riscv/vector.rst
rename to Documentation/arch/riscv/vector.rst
diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
similarity index 100%
rename from Documentation/riscv/vm-layout.rst
rename to Documentation/arch/riscv/vm-layout.rst
diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 6b64072d4bf2..7ad4bfc2cc03 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -101,7 +101,7 @@ to do something different in the near future.
 
    ../doc-guide/maintainer-profile
    ../nvdimm/maintainer-entry-profile
-   ../riscv/patch-acceptance
+   ../arch/riscv/patch-acceptance
    ../driver-api/media/maintainer-entry-profile
    ../driver-api/vfio-pci-device-specific-driver-acceptance
    ../nvme/feature-and-quirk-policy
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index b501cd977053..db09a81d474b 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -71,7 +71,7 @@ lack of a better place.
    volatile-considered-harmful
    botching-up-ioctls
    clang-format
-   ../riscv/patch-acceptance
+   ../arch/riscv/patch-acceptance
    ../core-api/unaligned-memory-access
 
 .. only::  subproject and html
diff --git a/Documentation/translations/it_IT/riscv/patch-acceptance.rst b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
index edf67252b3fb..2d7afb1f6959 100644
--- a/Documentation/translations/it_IT/riscv/patch-acceptance.rst
+++ b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :doc:`../../../riscv/patch-acceptance`
+:Original: :doc:`../../../arch/riscv/patch-acceptance`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 arch/riscv linee guida alla manutenzione per gli sviluppatori
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index 945b078168b0..71186d9df7c9 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -10,7 +10,7 @@
 
    mips/index
    arm64/index
-   ../riscv/index
+   ../arch/riscv/index
    openrisc/index
    parisc/index
    loongarch/index
diff --git a/Documentation/translations/zh_CN/riscv/boot-image-header.rst b/Documentation/translations/zh_CN/arch/riscv/boot-image-header.rst
similarity index 96%
rename from Documentation/translations/zh_CN/riscv/boot-image-header.rst
rename to Documentation/translations/zh_CN/arch/riscv/boot-image-header.rst
index 0234c28a7114..779b5172fe24 100644
--- a/Documentation/translations/zh_CN/riscv/boot-image-header.rst
+++ b/Documentation/translations/zh_CN/arch/riscv/boot-image-header.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/riscv/boot-image-header.rst
+:Original: Documentation/arch/riscv/boot-image-header.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/riscv/index.rst b/Documentation/translations/zh_CN/arch/riscv/index.rst
similarity index 79%
rename from Documentation/translations/zh_CN/riscv/index.rst
rename to Documentation/translations/zh_CN/arch/riscv/index.rst
index 131e405aa857..3b041c116169 100644
--- a/Documentation/translations/zh_CN/riscv/index.rst
+++ b/Documentation/translations/zh_CN/arch/riscv/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/riscv/index.rst
+:Original: Documentation/arch/riscv/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/riscv/patch-acceptance.rst b/Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
similarity index 93%
rename from Documentation/translations/zh_CN/riscv/patch-acceptance.rst
rename to Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
index d180d24717bf..c8eb230ca8ee 100644
--- a/Documentation/translations/zh_CN/riscv/patch-acceptance.rst
+++ b/Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/riscv/patch-acceptance.rst
+:Original: Documentation/arch/riscv/patch-acceptance.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/riscv/vm-layout.rst b/Documentation/translations/zh_CN/arch/riscv/vm-layout.rst
similarity index 98%
rename from Documentation/translations/zh_CN/riscv/vm-layout.rst
rename to Documentation/translations/zh_CN/arch/riscv/vm-layout.rst
index 91884e2dfff8..4b9f4dcf6c19 100644
--- a/Documentation/translations/zh_CN/riscv/vm-layout.rst
+++ b/Documentation/translations/zh_CN/arch/riscv/vm-layout.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/riscv/vm-layout.rst
+:Original: Documentation/arch/riscv/vm-layout.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/maintainer/maintainer-entry-profile.rst b/Documentation/translations/zh_CN/maintainer/maintainer-entry-profile.rst
index a1ee99c4786e..0f5acfb1012e 100644
--- a/Documentation/translations/zh_CN/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/translations/zh_CN/maintainer/maintainer-entry-profile.rst
@@ -89,4 +89,4 @@
 
    ../doc-guide/maintainer-profile
    ../../../nvdimm/maintainer-entry-profile
-   ../../../riscv/patch-acceptance
+   ../../../arch/riscv/patch-acceptance
diff --git a/MAINTAINERS b/MAINTAINERS
index 283a60458d36..71f038c40f48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18498,7 +18498,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-riscv/list/
 C:	irc://irc.libera.chat/riscv
-P:	Documentation/riscv/patch-acceptance.rst
+P:	Documentation/arch/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 F:	arch/riscv/
 N:	riscv
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 006bfb48343d..d43e306ce2f9 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -10,7 +10,7 @@
 
 /*
  * Interface for probing hardware capabilities from userspace, see
- * Documentation/riscv/hwprobe.rst for more information.
+ * Documentation/arch/riscv/hwprobe.rst for more information.
  */
 struct riscv_hwprobe {
 	__s64 key;
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 473159b5f303..b651ec698a91 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -79,7 +79,7 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
 
 /*
  * The hwprobe interface, for allowing userspace to probe to see which features
- * are supported by the hardware.  See Documentation/riscv/hwprobe.rst for more
+ * are supported by the hardware.  See Documentation/arch/riscv/hwprobe.rst for more
  * details.
  */
 static void hwprobe_arch_id(struct riscv_hwprobe *pair,
-- 
2.41.0

