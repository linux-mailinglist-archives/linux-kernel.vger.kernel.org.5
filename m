Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E435977805B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjHJShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjHJShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DD52713
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:33 -0700 (PDT)
Message-ID: <20230810160805.193094420@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Yla6bgyMGJY6FRDLJy+QJ04amN52g+/SwC5xFVnIX7s=;
        b=zpyeHLs4q1IIzG3oVdAmqZn6FBkJqTeXYW/6Rft4wXxTLj4ICM7mAf0bUZ885XO1Efbcxq
        0/BK6OhoGfXt2fUqNVBhCNwWv5Q4yw5Q1H6CqxP9kz+3adr5RRLnpsGGz9IUk7E8xH2GYT
        tw7cEDqirwCr/1jyGvSY1QHE7vqXOc/RvjnoFNdxhrvDJbF8e2gemHK/zQrBg1UdLrNmZH
        Astt7SG5/WI4avhW4veqEhUl7/4ovChAIORW8ByAWAQ4kzuIAVAFxxqfzzJ7UsDEgYwTup
        zfh4aCxGAsitG1uN+tBNS0ZmI7HimX2C/vZKAcKmDC/oBnQpfU0n4G5lT2uFPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Yla6bgyMGJY6FRDLJy+QJ04amN52g+/SwC5xFVnIX7s=;
        b=pYr3vp6ReAHaL7w5dC/pUfJ4myEvxHIfo6R9M9FKf5GsHmHllXvjBEtQVqcydtqYdJlg8S
        0pcA/FBPcDtAYZCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 04/30] x86/microcode: Include vendor headers into microcode.h
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:32 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/microcode.h       | 5 ++++-
 arch/x86/include/asm/microcode_amd.h   | 2 --
 arch/x86/include/asm/microcode_intel.h | 2 --
 arch/x86/kernel/cpu/common.c           | 1 -
 arch/x86/kernel/cpu/intel.c            | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c    | 1 -
 arch/x86/kernel/cpu/microcode/core.c   | 2 --
 arch/x86/kernel/cpu/microcode/intel.c  | 2 +-
 drivers/platform/x86/intel/ifs/load.c  | 2 +-
 9 files changed, 7 insertions(+), 12 deletions(-)
---
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 320566a0443d..2e1a9d0582e7 100644
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
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index a995b7685223..0531983016c9 100644
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
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index f1fa979e05bf..3ca740451a3d 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 06015f304cb8..1ea5f822a7ca 100644
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
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1c4639588ff9..9fd67e68179f 100644
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
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a28b103256ff..dc0a3bed5f6e 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
-#include <asm/microcode_amd.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c9a53e330df3..73a3c22773c2 100644
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
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 467cf37ea90a..0ae0c3fd66a1 100644
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
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index e6ae8265f3a3..390862ab0357 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,7 +3,7 @@
 
 #include <linux/firmware.h>
 #include <asm/cpu.h>
-#include <asm/microcode_intel.h>
+#include <asm/microcode.h>
 
 #include "ifs.h"
 

