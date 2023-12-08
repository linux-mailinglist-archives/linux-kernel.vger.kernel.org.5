Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1383809D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573268AbjLHHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjLHHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC31733
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702020656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMJ0khluh69+oGYQ45qNovXMn1kcyTft2Ss07SyrAMA=;
        b=OeooZJQFxMz5qZ7k8kW4ot6lZeF3nalCVzOvzdvbkGUTAo5ZQfw6DJY8UjlH3Q0rf77BBL
        kC/hCePL/GW5ujzzdo3l6oDnlqYAGx85Ock1fKrLw+MguDLu3+o/szU3qMeFYU9x46LRas
        Q+QtQmyzpbhLBjox74qFDMLT4RVPUe8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-fgcVBsYqNd-Y6txwm1BDyQ-1; Fri,
 08 Dec 2023 02:30:51 -0500
X-MC-Unique: fgcVBsYqNd-Y6txwm1BDyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 939181C05ED0;
        Fri,  8 Dec 2023 07:30:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7C5A8CD0;
        Fri,  8 Dec 2023 07:30:44 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com,
        Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/5] loongarch, kexec: change dependency of object files
Date:   Fri,  8 Dec 2023 15:30:32 +0800
Message-ID: <20231208073036.7884-2-bhe@redhat.com>
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in arch/loongarch/kernel/Makefile, building machine_kexec.o
relocate_kernel.o depends on CONFIG_KEXEC.

Whereas, since we will drop the select of KEXEC for CRASH_DUMP in
kernel/Kconfig.kexec, compiling error will be triggered if below config
items are set:

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

---------------------------------------------------------------
loongarch64-linux-ld: kernel/kexec_core.o: in function `.L209':
>> kexec_core.c:(.text+0x1660): undefined reference to `machine_kexec_cleanup'
   loongarch64-linux-ld: kernel/kexec_core.o: in function `.L287':
>> kexec_core.c:(.text+0x1c5c): undefined reference to `machine_crash_shutdown'
>> loongarch64-linux-ld: kexec_core.c:(.text+0x1c64): undefined reference to `machine_kexec'
   loongarch64-linux-ld: kernel/kexec_core.o: in function `.L2^B5':
>> kexec_core.c:(.text+0x2090): undefined reference to `machine_shutdown'
   loongarch64-linux-ld: kexec_core.c:(.text+0x20a0): undefined reference to `machine_kexec'
---------------------------------------------------------------

Here, changing the dependency of machine_kexec.o relocate_kernel.o to
CONFIG_KEXEC_CORE can fix above building error.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311300946.kHE9Iu71-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/loongarch/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 4fcc168f0732..3c808c680370 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
-- 
2.41.0

