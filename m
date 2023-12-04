Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E5802A36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjLDCTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73BC3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701656387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEYLn+UWJXzVvOdXDQoSl0HV2uxdkFhIxrNZEqvidvw=;
        b=MGJi+ZdrtezuwyY2qyF5EBGsmAYOd8JTuD/nQx4+mPQhTMbVtYolzvhjpNQis6Lons6MHU
        4ESNJ5sOruQ9AsgPBwPPWrYb27ojydSl3iSKkw/+vuU4nX+dT7We+8GW3drN5a5aKEW/dx
        77QewwRWPfVed8C3Ue9vLIQ2erHiU94=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-IJdQXgyNMci1xrid06S4Qw-1; Sun,
 03 Dec 2023 21:19:41 -0500
X-MC-Unique: IJdQXgyNMci1xrid06S4Qw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F151E1C041BF;
        Mon,  4 Dec 2023 02:19:40 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F2A9492BFC;
        Mon,  4 Dec 2023 02:19:39 +0000 (UTC)
Date:   Mon, 4 Dec 2023 10:19:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
        ignat@cloudflare.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, eric_devolder@yahoo.com
Subject: [PATCH 1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
Message-ID: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
from CRASH_DUMP, compiling error is reported when below config items are
set:
-----------------------
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
......
-----------------------

-------------------------------------------------------------------------------------------------
arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
 8 |         VMCOREINFO_NUMBER(VA_BITS);
   |                           ^~~~~~~
include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
   |                                                                ^~~~

arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
   |                                                                ^~~~~~~~~~~~~
arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
   |                                                              ^~~~~~~~~~~
   |                                                              MEMREMAP_ENC
arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
   |                                                                ^~~~~~~~~~~~~
arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
-------------------------------------------------------------------------------------------------

Currently, riscv's ARCH_SUPPORTS_KEXEC has dependency on MMU. Before
dropping ARCH_SUPPORTS_KEXEC, disabling CONFIG_MMU will unset
CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE. Hence
crash_core related codes won't be compiled.

---------------------
arch/riscv/Kconfig:
config ARCH_SUPPORTS_KEXEC
        def_bool MMU
---------------------

After dropping ARCH_SUPPORTS_KEXEC, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
CONFIG_CRASH_CORE can be set independently of CONFIG_MMU. However, there
are several macro definitions, such as VA_BITS, VMEMMAP_START, VMEMMAP_END,
MODULES_VADDR, MODULES_END are only available when CONFIG_MMU=y. Then
compiling errors are triggered.

Here, add CONFIG_MMU ifdeffery in arch_crash_save_vmcoreinfo() to export
those symbols when CONFIG_MMU is enabled.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/kernel/crash_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index 55f1d7856b54..8706736fd4e2 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -5,17 +5,19 @@
 
 void arch_crash_save_vmcoreinfo(void)
 {
-	VMCOREINFO_NUMBER(VA_BITS);
 	VMCOREINFO_NUMBER(phys_ram_base);
 
 	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+#ifdef CONFIG_MMU
+	VMCOREINFO_NUMBER(VA_BITS);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
 #ifdef CONFIG_64BIT
 	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+#endif
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
 	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
-- 
2.41.0

