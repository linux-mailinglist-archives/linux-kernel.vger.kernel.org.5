Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926C802E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjLDIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjLDIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:47:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4C9B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:47:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB18C433C8;
        Mon,  4 Dec 2023 08:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701679649;
        bh=yWpIH3H9GnySfKiZ2biNF5eZOOjjW8G9znn26WMmWq8=;
        h=From:To:Cc:Subject:Date:From;
        b=Bt3tvQd17fxJG1QhyKLzWmqZhTgFXCUi8NohfV/BqaRjuxBDL9Fj93TEqKVCQ3prU
         cECFd3wX7hGQ1ZsUi1sVIDMP1aDiiYTgo30xsobza+llJl7HUKfOl7kkwRGQroloEl
         yd2Q8qCHNPURUuMjaU/6j+kOWycz0WtS3sXUOyrE3qfJ0RfyJuklEFWgs1tcOV3oXr
         x869c6XKfR4pe6BA3BUr8dc6woUP3GgRaQiA0e9xzy5syhPrdc0yyIIv0EFZ11zBg+
         El8TBWLd6TH3ElkOkDmVHbNPpODQxtFJYZbsMQLOInyjm0yqJ75sqGIHTuYHICIIgG
         yggzDxlBMAi+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/xen: add CPU dependencies for 32-bit build
Date:   Mon,  4 Dec 2023 09:47:01 +0100
Message-Id: <20231204084722.3789473-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Xen only supports modern CPUs even when running a 32-bit kernel, and it now
requires a kernel built for a 64 byte (or larger) cache line:

In file included from <command-line>:
In function 'xen_vcpu_setup',
    inlined from 'xen_vcpu_setup_restore' at arch/x86/xen/enlighten.c:111:3,
    inlined from 'xen_vcpu_restore' at arch/x86/xen/enlighten.c:141:3:
include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_287' declared with attribute error: BUILD_BUG_ON failed: sizeof(*vcpup) > SMP_CACHE_BYTES
arch/x86/xen/enlighten.c:166:9: note: in expansion of macro 'BUILD_BUG_ON'
  166 |         BUILD_BUG_ON(sizeof(*vcpup) > SMP_CACHE_BYTES);
      |         ^~~~~~~~~~~~

Enforce the dependency with a whitelist of CPU configurations. In normal
distro kernels, CONFIG_X86_GENERIC is enabled, and this works fine. When this
is not set, still allow Xen to be built on kernels that target a 64-bit
capable CPU.

Fixes: db2832309a82 ("x86/xen: fix percpu vcpu_info allocation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/xen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 9b1ec5d8c99c..a65fc2ae15b4 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -9,6 +9,7 @@ config XEN
 	select PARAVIRT_CLOCK
 	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
+	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MCORE2 || MATOM || MK8)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
-- 
2.39.2

