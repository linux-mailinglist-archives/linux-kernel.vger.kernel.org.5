Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19C77A21D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHLUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHLUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3186C1BE9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:59:48 -0700 (PDT)
Message-ID: <20230812195727.776541545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xWepluyiaqfIY/tanS5Ndfk5WwU6Id4g+TqNpVND6ps=;
        b=Aahc0HEMSZ+5wLZo9GpKM8Iw4g5bzUg1Lb7HiA2tnLTc1U37XqmuTlV4JbL6p8AZ/xzzHf
        X6tS8KiVekQe//GoZXua1GDA9vwYMo4dz0kX29MNJ4jo44W2+9fuq/LqGHDZVFpatCzfs/
        znT5yETlIX2+A0e3oHqgSfrr8ciCi9PRRoZD6fSe8Nz0OUDwN1zuv1VK6NkQbirTolttkQ
        G1FMO6zCwDFI3GB64z2F5T8gw+a5aQw8LXdgTXrkwWsFc6ozmqaIYUNW3ld7VxcPErrfCr
        rlDhjix+9FDzpoC9CcnmQGXSBz2q1F4VDJ6QLzJqxN1bPhmxTd6QTB9AX8HhJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xWepluyiaqfIY/tanS5Ndfk5WwU6Id4g+TqNpVND6ps=;
        b=kk93GCk+ApTsihgq5rS36mIo0KTVteSUPOhgvsMH7i1lXzTVTWUFhORdr702Dv7wOqYg5b
        tVdknO1+vkSy2uBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 04/37] x86/microcode: Include vendor headers into
 microcode.h
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:42 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Currently vendor specific headers are included explicitly when used in common
code. Instead, include the vendor specific headers in microcode.h, and
include that in all usages. No functional change.

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/microcode.h       |    5 ++++-
 arch/x86/include/asm/microcode_amd.h   |    2 --
 arch/x86/include/asm/microcode_intel.h |    2 --
 arch/x86/kernel/cpu/common.c           |    1 -
 arch/x86/kernel/cpu/intel.c            |    2 +-
 arch/x86/kernel/cpu/microcode/amd.c    |    1 -
 arch/x86/kernel/cpu/microcode/core.c   |    2 --
 arch/x86/kernel/cpu/microcode/intel.c  |    2 +-
 drivers/platform/x86/intel/ifs/load.c  |    2 +-
 9 files changed, 7 insertions(+), 12 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -2,10 +2,13 @@
 #ifndef _ASM_X86_MICROCODE_H
 #define _ASM_X86_MICROCODE_H
 
-#include <asm/cpu.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 
+#include <asm/cpu.h>
+#include <asm/microcode_amd.h>
+#include <asm/microcode_intel.h>
+
 struct ucode_patch {
 	struct list_head plist;
 	void *data;		/* Intel uses only this one */
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_MICROCODE_AMD_H
 #define _ASM_X86_MICROCODE_AMD_H
 
-#include <asm/microcode.h>
-
 #define UCODE_MAGIC			0x00414d44
 #define UCODE_EQUIV_CPU_TABLE_TYPE	0x00000000
 #define UCODE_UCODE_TYPE		0x00000001
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_MICROCODE_INTEL_H
 #define _ASM_X86_MICROCODE_INTEL_H
 
-#include <asm/microcode.h>
-
 struct microcode_header_intel {
 	unsigned int            hdrver;
 	unsigned int            rev;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,7 +59,6 @@
 #include <asm/cacheinfo.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
-#include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -20,7 +20,7 @@
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/intel-family.h>
-#include <asm/microcode_intel.h>
+#include <asm/microcode.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
-#include <asm/microcode_amd.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -31,9 +31,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
-#include <asm/microcode_intel.h>
 #include <asm/cpu_device_id.h>
-#include <asm/microcode_amd.h>
 #include <asm/perf_event.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -30,9 +30,9 @@
 #include <linux/uio.h>
 #include <linux/mm.h>
 
-#include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
+#include <asm/microcode.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
 #include <asm/msr.h>
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,7 +3,7 @@
 
 #include <linux/firmware.h>
 #include <asm/cpu.h>
-#include <asm/microcode_intel.h>
+#include <asm/microcode.h>
 
 #include "ifs.h"
 

