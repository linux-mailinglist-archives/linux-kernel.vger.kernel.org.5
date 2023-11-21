Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307997F2EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjKUNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjKUNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:44:49 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0F1706;
        Tue, 21 Nov 2023 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hiJfEbpD9iK5AcJXMTBgMWFg83Hq4/GNPWe0X0U3LtI=; b=JGDFqWokgaRiKZzHoR/GM+LEs+
        25yW1mgxdouCJk7khg7YCvIWYBR6V6xy8HsJCx098huXx/XC63aFPnjg9QXWJU7Vqe6xYMh2e/9nT
        hoa7pz1gbWSzrzOHoMOcotZhEpHeWiINyLKEgdwd1SBCK6NhV3Bf91/XHrD4nYpDgdA/tZf0iUwm6
        KMvdilbeAZvaj1QLCzNpIUPfSQq+vSpFdf6dsru86dHOlQBswiU+AbsdB5Hck+ZjWqX5/PWMz7xN4
        sF/vPDFNictilXveT+MtaQhUC+1NUWvEBq3J+YvjXKSo2niS7wwdmdCRdZBOluQtctnrDkxRvHfw1
        J8TD4OwA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44206 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r5R3K-00077t-28;
        Tue, 21 Nov 2023 13:44:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r5R3M-00CszH-6r; Tue, 21 Nov 2023 13:44:36 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/21] drivers: base: add arch_cpu_is_hotpluggable()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3M-00CszH-6r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 21 Nov 2023 13:44:36 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The differences between architecture specific implementations of
arch_register_cpu() are down to whether the CPU is hotpluggable or not.
Rather than overriding the weak version of arch_register_cpu(), provide
a function that can be used to provide this detail instead.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/base/cpu.c  | 11 ++++++++++-
 include/linux/cpu.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 58bb86091b34..221ffbeb1c9b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -527,9 +527,18 @@ EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 #ifdef CONFIG_GENERIC_CPU_DEVICES
 DEFINE_PER_CPU(struct cpu, cpu_devices);
 
+bool __weak arch_cpu_is_hotpluggable(int cpu)
+{
+	return false;
+}
+
 int __weak arch_register_cpu(int cpu)
 {
-	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
+
+	return register_cpu(c, cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 1e982d63eae8..dcb89c987164 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,7 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern bool arch_cpu_is_hotpluggable(int cpu);
 extern int arch_register_cpu(int cpu);
 extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.30.2

