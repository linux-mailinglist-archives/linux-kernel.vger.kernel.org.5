Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5820778DE27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjH3S6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbjH3LkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E641B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693395555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTX1jjRNGO8OcMeJufjnK0bfy5r6OmV10OVkYSeEhKk=;
        b=MvC+HfCFu21HB8c1f+5+kS+y4prHO2Y0UbhhYZ18ILGNL4QnCaX99AeGnWgUHyMdaYTp8p
        VMAuol6rHJMPWhtL/okpQo5egvhXoE+gAM9MB/AUxiUNCVSn5mnSUr5WNn0alGryWzbdgO
        8J52FQxI07+nL1RoE3ZfPGnCWfYLiX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-vpS9i7EZNOObdnNWiyPNYA-1; Wed, 30 Aug 2023 07:39:10 -0400
X-MC-Unique: vpS9i7EZNOObdnNWiyPNYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF2A885CBE2;
        Wed, 30 Aug 2023 11:39:09 +0000 (UTC)
Received: from localhost (unknown [10.72.113.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6F7CC15BAE;
        Wed, 30 Aug 2023 11:39:08 +0000 (UTC)
Date:   Wed, 30 Aug 2023 19:39:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <ZO8qWQg23JT2lWNg@MiWiFi-R3L-srv>
References: <20230829121610.138107-7-bhe@redhat.com>
 <202308300910.e0i4piJT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308300910.e0i4piJT-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/23 at 09:49am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes v6.5]
> [cannot apply to linus/master next-20230829]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230829-201942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20230829121610.138107-7-bhe%40redhat.com
> patch subject: [PATCH v2 6/8] x86: kdump: use generic interface to simplify crashkernel reservation code
> config: x86_64-randconfig-r022-20230830 (https://download.01.org/0day-ci/archive/20230830/202308300910.e0i4piJT-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300910.e0i4piJT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308300910.e0i4piJT-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: vmlinux.o: in function `reserve_crashkernel_low':
>    kernel/crash_core.c:369: undefined reference to `crashk_low_res'
>    ld: kernel/crash_core.c:369: undefined reference to `crashk_low_res'
>    ld: kernel/crash_core.c:370: undefined reference to `crashk_low_res'
>    ld: kernel/crash_core.c:369: undefined reference to `crashk_low_res'
>    ld: kernel/crash_core.c:370: undefined reference to `crashk_low_res'
>    ld: vmlinux.o:kernel/crash_core.c:371: more undefined references to `crashk_low_res' follow
>    ld: vmlinux.o: in function `reserve_crashkernel_generic':
> >> kernel/crash_core.c:453: undefined reference to `crashk_res'
> >> ld: kernel/crash_core.c:453: undefined reference to `crashk_res'
>    ld: kernel/crash_core.c:454: undefined reference to `crashk_res'
> >> ld: kernel/crash_core.c:453: undefined reference to `crashk_res'
>    ld: kernel/crash_core.c:454: undefined reference to `crashk_res'
>    ld: vmlinux.o:kernel/crash_core.c:454: more undefined references to `crashk_res' follow

Thanks for reporting. This one has the same root cause as the i386-randconfig
building. It's because crashk_res|crashk_low_res are defined in
kernel/kexec_core.c, but referenced in generic reservation code in
crash_core.c, while in this lkp's randconfig, CONFIG_KEXEC_CORE is
unset, CONFIG_CRASH_CORE=on. Then undefined reference to `crashk_res'
and `crashk_low_res' are reported.

Below patch can fix it. I will post v3 to contain this.

From 5a5bda3b5b1e370b789489d87516c8f1fb966c46 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 29 Aug 2023 22:38:15 -0400
Subject: [PATCH] crash_core: move crashk_res and crashk_low_res definition
 into crash_core.c
Content-type: text/plain

Both crashk_res and crashk_low_res are used to mark the reserved
crashkernel regions in iomem_resource tree. And later the generic
crashkernel resrvation which references them will be added into
crash_core.c. So move crashk_res and crashk_low_res definition into
crash_core.c to avoid compiling error when CONFIG_CRASH_CORE=on while
CONFIG_KEXEC_CORE is unset.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  5 +++++
 include/linux/kexec.h      |  4 ----
 kernel/crash_core.c        | 16 ++++++++++++++++
 kernel/kexec_core.c        | 17 -----------------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d64006c4bd43..daa87b8730d3 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -9,6 +9,11 @@
 #include <asm/crash_core.h>
 #endif
 
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..e762b0435c39 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -22,10 +22,6 @@
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 61a8ea3b23a2..d76e7280c651 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -28,6 +28,22 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* Location of the reserved area for the crash kernel */
+struct resource crashk_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+struct resource crashk_low_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+
 /*
  * parsing the "crashkernel" commandline
  *
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..03ee65546df6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -55,23 +55,6 @@ note_buf_t __percpu *crash_notes;
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-
-/* Location of the reserved area for the crash kernel */
-struct resource crashk_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-struct resource crashk_low_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.41.0

