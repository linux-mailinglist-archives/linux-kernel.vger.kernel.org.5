Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25449761A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGYNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjGYNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8540211E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A83061726
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1438DC433C8;
        Tue, 25 Jul 2023 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292929;
        bh=hMCNeSXwQytHGCgIoVl9q90tknzoEJ95XhZLTksbe2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i30Mdi+ObSX/DddiqBUFhH+lrNYNyVlnliMlm65DvWNF9v2kMj2VV9m/gcmb+R6ai
         8HVuAXnsFbIti0Faj2A23ZNut99GHsiE6j/CircdPswo/czk6DQQTa7wYYIi8jDwOj
         aW4tdUWW7pfW4aP5um+rivNwa7cSFbmNKwmV8VCqMpeFDRjqVVYWkGqA/F8rwO1K7W
         Wm22gPcB4XRbB/8COnoX2T7s3xWDzqLDzeh7M1bbnyFJOJioDs3PyJ+ArdIeHrGxgP
         DkSLapIDPw7U2FAfGflgDkIpkTpAqBRd3QW1Ocqaut/M3vhEASgsDctjiuiA/0bk3J
         M3a+lJo7K20Mw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/5] [RESEND] x86: apic: hide unused safe_smp_processor_id on UP
Date:   Tue, 25 Jul 2023 15:48:33 +0200
Message-Id: <20230725134837.1534228-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725134837.1534228-1-arnd@kernel.org>
References: <20230725134837.1534228-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

