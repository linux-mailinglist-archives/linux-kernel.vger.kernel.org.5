Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1D7F7479
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbjKXNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:02:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74790110;
        Fri, 24 Nov 2023 05:02:14 -0800 (PST)
Date:   Fri, 24 Nov 2023 13:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700830932;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2WoqphQa08ilBa/Wdt28ASnV8BgNEE4rSutt3haeXKU=;
        b=OJcxRTylPJPUbQbDBmMf7deHJuscmSZT3NApgBlLtseA0j6ckf/VfCTWOgtR5DeFwhAQZM
        9LAvQMs0q0ihnKl7Mni+NVKEs8KskFMnjK7SNJn5im0hGQ3NgmN08qulDA/VuHSvd7Mqxh
        H3jJ3F6IKYxCgBwLezqwIMsILRpKtfLeBTr1dlhvmTfHnB0WIEBuuqzzqpv9S1dE6s7Yd+
        wrTEzhwg7iN7DTTl56vJ5b/AHZQhZkgXbcEfwAG6v4ZEPRzmN0XAoKWuJMi6b2QG1XEp0h
        AmdntZiPbgZ28ocyzIcFxD1zDhe4vxwQj8APyoPxOEr5Fo5W7PD95d6K+m5aNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700830932;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2WoqphQa08ilBa/Wdt28ASnV8BgNEE4rSutt3haeXKU=;
        b=p3E/IMxHJFUhF1yAPFfRTS8JOPXurIBEfwvpfKH8/n5GeD4w0FtJQw93l0v/Du88P+8IyQ
        DRS+45L21z2xKJDQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel_epb: Don't rely on link order
Cc:     James Morse <james.morse@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>, Gavin Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170083093117.398.8055972416269136622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5bfa0e45e9e7212b87fe1564ab45f146c7d56e5f
Gitweb:        https://git.kernel.org/tip/5bfa0e45e9e7212b87fe1564ab45f146c7d56e5f
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 24 Nov 2023 09:38:53 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Nov 2023 13:54:31 +01:00

x86/cpu/intel_epb: Don't rely on link order

intel_epb_init() is called as a subsys_initcall() to register cpuhp
callbacks. The callbacks make use of get_cpu_device() which will return
NULL unless register_cpu() has been called. register_cpu() is called
from topology_init(), which is also a subsys_initcall().

This is fragile. Moving the register_cpu() to a different
subsys_initcall() leads to a NULL dereference during boot.

Make intel_epb_init() a late_initcall(), user-space can't provide a
policy before this point anyway.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/cpu/intel_epb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba9..f18d35f 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -237,4 +237,4 @@ err_out_online:
 	cpuhp_remove_state(CPUHP_AP_X86_INTEL_EPB_ONLINE);
 	return ret;
 }
-subsys_initcall(intel_epb_init);
+late_initcall(intel_epb_init);
