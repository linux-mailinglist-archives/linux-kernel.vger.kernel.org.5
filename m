Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486A7E396E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjKGKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjKGKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:30:22 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E469B;
        Tue,  7 Nov 2023 02:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AMLeOPj97UWFUJITi7pviQd/DMBECoV/Ju2iA1XroZM=; b=iWpNzX/iPGoOYZQkZm1FIQXbPq
        l/1gVppyboPmC6oMcfXlstcdMZwkQemSDC3sAWAcxjAeobj3XzuPCbPhXny1YZMJO2nRHG63r3Mh0
        jNvRH7k+2oC8ySGSAk8U2dvBaMevMXVHN0gC+MMpsqaWK0L8ihN0bQUJoxLPTYxrKgZM+Pjlih3fs
        LcT8t4CZjhVC6MPxRxQ/d17Q4R2MW+G5mBgCs6797LrxnXap9B7GaDDQT/BHu44vMbeZ+KHsAGb5e
        MKJai+jRkoPwqj8S97N9deRW2n8XWFl+QX4UABVhRevJwiRLKylNLlAEpPAjcV2W5jTxW4wJunXYc
        Rs7uQr5g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54898 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r0JLU-0000GD-0Y;
        Tue, 07 Nov 2023 10:30:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r0JLV-00CTxS-QB; Tue, 07 Nov 2023 10:30:09 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC 10/22] drivers: base: Move cpu_dev_init() after
 node_dev_init()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 07 Nov 2023 10:30:09 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

NUMA systems require the node descriptions to be ready before CPUs are
registered. This is so that the node symlinks can be created in sysfs.

Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
are registered by arch code, instead of cpu_dev_init().

Move cpu_dev_init() after node_dev_init() so that NUMA architectures
can use GENERIC_CPU_DEVICES.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Note: Jonathan's comment still needs addressing - see
  https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
---
 drivers/base/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/init.c b/drivers/base/init.c
index 397eb9880cec..c4954835128c 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -35,8 +35,8 @@ void __init driver_init(void)
 	of_core_init();
 	platform_bus_init();
 	auxiliary_bus_init();
-	cpu_dev_init();
 	memory_dev_init();
 	node_dev_init();
+	cpu_dev_init();
 	container_dev_init();
 }
-- 
2.30.2

