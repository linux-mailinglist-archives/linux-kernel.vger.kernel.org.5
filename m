Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E77D11C5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377585AbjJTOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:45:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26441106;
        Fri, 20 Oct 2023 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cDxywtFxZEUNp05zPiJtAEtgwzGlfWET0wpc3onEv/c=; b=GPLeDlz8NZPdqaalFptDuwkfgg
        He7H0OvnM01HQb/90N87NEqkU6/7q6cu4gz6Xs7vXcSbfp7Bp70zUtr/Ke9If3SzmZPlqAQ7rmWhL
        EHe8spTakoPB9vD4Pr41hd9IigIcOMiTRmrYY7FKvL717JjxKBfMVKRFAtG+6J6YQ3ltQ9mAod82n
        X3aVWQz4pNHflalnnwPbSN/wDU17gRc5FIejYsy2ev6TdzJYXtnWKpcShgQK+GlOyV7ixTK/oxQbl
        KzPVN4VkGq4BgegruPDZ7XKXnaj8wQURiijPn8xIZU5+2H/+TglV61dD4JDkxs1/a+kgCxCJ8A2FF
        THo5uZdQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49724 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qtqki-0000WW-22;
        Fri, 20 Oct 2023 15:45:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qtqkk-00AJHA-1u; Fri, 20 Oct 2023 15:45:30 +0100
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        linux-parisc@vger.kernel.org
Subject: [PATCH] parisc: simplify smp_prepare_boot_cpu()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qtqkk-00AJHA-1u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 20 Oct 2023 15:45:30 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_prepare_boot_cpu() reads the cpuid of the first CPU, printing a
message to state which processor booted, and setting it online and
present.

This cpuid is retrieved from per_cpu(cpu_data, 0).cpuid, which is
initialised in arch/parisc/kernel/processor.c:processor_probe() thusly:

	p = &per_cpu(cpu_data, cpuid);
...
	p->cpuid = cpuid;	/* save CPU id */

Consequently, the cpuid retrieved seems to be guaranteed to also be
zero, meaning that the message printed in this boils down to:

	pr_info("SMP: bootstrap CPU ID is 0\n");

Moreover, since kernel/cpu.c::boot_cpu_init() already sets CPU 0 to
be present and online, there is no need to do this again in
smp_prepare_boot_cpu().

Remove this code, and simplify the printk().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/parisc/kernel/smp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 2019c1f04bd0..989efc8c67a5 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -404,13 +404,8 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	int bootstrap_processor = per_cpu(cpu_data, 0).cpuid;
-
 	/* Setup BSP mappings */
-	printk(KERN_INFO "SMP: bootstrap CPU ID is %d\n", bootstrap_processor);
-
-	set_cpu_online(bootstrap_processor, true);
-	set_cpu_present(bootstrap_processor, true);
+	pr_info("SMP: bootstrap CPU ID is 0\n");
 }
 
 
-- 
2.30.2

