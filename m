Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF27E39D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjKGKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjKGKcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:32:51 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C4D57;
        Tue,  7 Nov 2023 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s/nJSc12wTo3rC59/Tj7C6Qxk/YhPkpMlGmhBF4UOwQ=; b=iBWuSBO8byS44iey2YnZSgJM8U
        MFt1NMp2w5pAfZ6wCLyhFFlLsovAEisNzEANGVeTWzW/SvgUOWs8hzrl8E6fK+iTUQlweEEngqE3f
        clKt8RH9RkEOEHOUca70RLavt4Q4aMF3hqPZwPOI9vFg9kh++U7+bjIdhqcec+iRE9IOnhXewhCqH
        6LPO3PA4SHNnRIpc2kCc3AAFwOldWLYZ8485pEq5BSo1Ktymanumc1ZnMMGf0asTqW9d5XypAMciV
        XC9/SCnbDNdQN4NpBcW4WiP5nljAPkKxazCZz/vCJxqPKHMlq3Z6Rfls/ZgiL/ixuTbrlcSmxHnl7
        BTSz1Lxg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51274 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r0JMT-0000Kg-2d;
        Tue, 07 Nov 2023 10:31:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r0JMV-00CTyh-It; Tue, 07 Nov 2023 10:31:11 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH RFC 22/22] riscv: convert to use arch_cpu_is_hotpluggable()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 07 Nov 2023 10:31:11 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
arch_register_cpu().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/riscv/kernel/setup.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f8875ae1b0aa..168f0db63d53 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -294,12 +294,9 @@ void __init setup_arch(char **cmdline_p)
 	riscv_set_dma_cache_alignment();
 }
 
-int arch_register_cpu(int cpu)
+bool arch_cpu_is_hotpluggable(int cpu)
 {
-	struct cpu *c = &per_cpu(cpu_devices, cpu);
-
-	c->hotpluggable = cpu_has_hotplug(cpu);
-	return register_cpu(c, cpu);
+	return cpu_has_hotplug(cpu);
 }
 
 void free_initmem(void)
-- 
2.30.2

