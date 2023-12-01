Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507E8003D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377627AbjLAGZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377615AbjLAGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C491729
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701411948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Zt79wZvYhz4gi4hOOtVo1AQdfO7nRSajk5T4VGHojQ=;
        b=RUiLUZENr5QGR9V3SkFpLuR3FTBvaHwG+btecFM0V2laJY7c2gVHDeRf+7eKLzjWoyLeqS
        nEjr1L8d2Iyib0y73Tsfyj+omN4HqGM4FqVQbjuIRshiOaZ97jmY1yxDSKogTFIb+vFMDp
        Hv3Nmc6gnybfzkO23H5wld8MMD25QdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-VG3zhdtUPFCBKXDt90IU9w-1; Fri, 01 Dec 2023 01:25:46 -0500
X-MC-Unique: VG3zhdtUPFCBKXDt90IU9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22309185A780;
        Fri,  1 Dec 2023 06:25:46 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 813FE1C060AE;
        Fri,  1 Dec 2023 06:25:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        mick@ics.forth.gr, changbin.du@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o
Date:   Fri,  1 Dec 2023 14:25:38 +0800
Message-ID: <20231201062538.27240-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was introduced in commit fba8a8674f68 ("RISC-V: Add kexec
support").

It should work on CONFIG_KEXEC_CORE, but not CONFIG_KEXEC only, since
we could set CONFIG_KEXEC_FILE=y and CONFIG_KEXEC=N, or only set
CONFIG_CRASH_DUMP=y and disable both CONFIG_KEXEC and CONFIG_KEXEC_FILE.
In these cases, the AFLAGS won't take effect with the current ifdeffery
for AFLAGS_kexec_relocate.o.

So fix it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..82940b6a79a2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -11,7 +11,7 @@ endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
-ifdef CONFIG_KEXEC
+ifdef CONFIG_KEXEC_CORE
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
 endif
 
-- 
2.41.0

