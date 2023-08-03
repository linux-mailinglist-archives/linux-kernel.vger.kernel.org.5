Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920A976E317
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjHCI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHCI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BB3AAC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2955161CC6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7B5C433C7;
        Thu,  3 Aug 2023 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051189;
        bh=hMCNeSXwQytHGCgIoVl9q90tknzoEJ95XhZLTksbe2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuxYNCGQKNCXWTWgqyDHBWFCFoMrZ5izJ5PJiOCdXR+7iXP1x+RO4EWU5RMJ7wJC0
         k4Cm+vzZvn39TkxcUa0I9DuCaFb7ckZ/gjA0IkQAk4IRqAvzxSpmDgQ469Eq/oLGIf
         YWw7F2fIbwFLviztYUcUq7NSI39x1ksjTAt4wc3RDHWidtdCiCe9pNPD5uyx2SpSIl
         fHeYga/UWaiY/lrFCRgXwiZCyj4zbpwznqZB6h2jQ0jTIlkUNcwm8kPyTH4CcUIS1e
         6NwDXGbm1Ij1HwzSwHbYLaxrNxsCP2eDLd7vKmNjpcB/LMMeryZkzbOXeC0tOXDX6U
         2tWBn39fnGSzg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/7] x86: apic: hide unused safe_smp_processor_id on UP
Date:   Thu,  3 Aug 2023 10:26:14 +0200
Message-Id: <20230803082619.1369127-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803082619.1369127-1-arnd@kernel.org>
References: <20230803082619.1369127-1-arnd@kernel.org>
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

When CONFIG_SMP is disabled, the prototype for safe_smp_processor_id()
is hidden, which causes a W=1 warning:

/home/arnd/arm-soc/arch/x86/kernel/apic/ipi.c:316:5: error: no previous prototype for 'safe_smp_processor_id' [-Werror=missing-prototypes]

Since there are no callers in this configuration, just hide the definition
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/apic/ipi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e8c840d..9bfd6e3973845 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -301,6 +301,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_SMP
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
@@ -329,3 +330,4 @@ int safe_smp_processor_id(void)
 	return cpuid >= 0 ? cpuid : 0;
 }
 #endif
+#endif
-- 
2.39.2

