Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E557C76F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442400AbjJLTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442337AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D2AE8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24327C43397;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=KULVDp/cUEx8aH2osEFULKgecu24MXP+d5KfOrr3QgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cipYbJQaj3jI1DJLuZVcGo1v4YYpnPYIBiBmsKP8DyylySViJ3hvfzUTgCfmTZNEe
         f5A1fnFeSzRbU01kZp5n4bgp/2zsro6ZZVbVPNBk7H6l83S9279KTBjLhcb6aP2u0E
         NmC3ciRcvALV+bYfWEMa2qQiaTRfHKsHy4uR/Fn8TS1axZhdVv4ybIvzjLrtFt1lQI
         iBunSGuJighPdbj/6ZGlAtMRng1iQKUw5OozDef5RCOPnWsfi3XyZDJF4jDylj9bMA
         IGzUWxPNvm/jgrlv4xT6U3YZwj44n9UmACvDf4K5T0ijSVAY7qpmp4FKUl0IY3OO9p
         7vz7OdgX58ZJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57069CE0CB3; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH nolibc 11/19] selftests/nolibc: don't embed initramfs into kernel image
Date:   Thu, 12 Oct 2023 12:32:25 -0700
Message-Id: <20231012193233.207857-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

When the initramfs is embedded into the kernel each rebuild of it will
trigger a full kernel relink and all the expensive postprocessing steps.

Currently nolibc-test and therefore the initramfs are always rebuild,
even without source changes, leading to lots of slow kernel relinks.

Instead of linking the initramfs into the kernel assemble it manually
and pass it explicitly to qemu.
This avoids all of the kernel relinks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Link: https://lore.kernel.org/r/20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net
---
 tools/testing/selftests/nolibc/.gitignore |  1 +
 tools/testing/selftests/nolibc/Makefile   | 42 ++++++++++++++---------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
index 52f613cdad54..5119f9f7afd2 100644
--- a/tools/testing/selftests/nolibc/.gitignore
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -1,4 +1,5 @@
 /initramfs/
+/initramfs.cpio
 /libc-test
 /nolibc-test
 /run.out
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 689658f81a19..ee6a9ad28cfd 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -131,18 +131,20 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
-	@echo "  all          call the \"run\" target below"
-	@echo "  help         this help"
-	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
-	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
-	@echo "  libc-test    build an executable using the compiler's default libc instead"
-	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  initramfs    prepare the initramfs with nolibc-test"
-	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
-	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
-	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
-	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  clean        clean the sysroot, initramfs, build and output files"
+	@echo "  all               call the \"run\" target below"
+	@echo "  help              this help"
+	@echo "  sysroot           create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  libc-test         build an executable using the compiler's default libc instead"
+	@echo "  run-user          runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  initramfs.cpio    prepare the initramfs archive with nolibc-test"
+	@echo "  initramfs         prepare the initramfs tree with nolibc-test"
+	@echo "  defconfig         create a fresh new default config (uses \$$XARCH)"
+	@echo "  kernel            (re)build the kernel (uses \$$XARCH)"
+	@echo "  kernel-standalone (re)build the kernel with the initramfs (uses \$$XARCH)"
+	@echo "  run               runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
+	@echo "  rerun             runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  clean             clean the sysroot, initramfs, build and output files"
 	@echo ""
 	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
 	@echo ""
@@ -195,6 +197,9 @@ run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+initramfs.cpio: kernel nolibc-test
+	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
+
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
 	$(call QUIET_INSTALL, initramfs/init)
@@ -203,17 +208,20 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
-kernel: initramfs
+kernel:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
+
+kernel-standalone: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
-run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+run: kernel initramfs.cpio
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log
@@ -227,6 +235,8 @@ clean:
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, libc-test)
 	$(Q)rm -f libc-test
+	$(call QUIET_CLEAN, initramfs.cpio)
+	$(Q)rm -rf initramfs.cpio
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
 	$(call QUIET_CLEAN, run.out)
-- 
2.40.1

