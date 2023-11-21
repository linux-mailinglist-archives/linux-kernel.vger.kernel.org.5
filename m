Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455B7F328E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjKUPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjKUPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:42:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE797124;
        Tue, 21 Nov 2023 07:42:07 -0800 (PST)
Date:   Tue, 21 Nov 2023 15:42:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700581326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q25VFprGAjgQZW9cnQJWdfE/RGJs3617/YGSnFq5C08=;
        b=UgQZ4eXFHoREkyf9Y3DOFbuzhm40mB40rvvy9xAYFk799HpQH1PIPuwogCoSrIVHmopNQy
        3icYEu628dSYdsdL1bSh1x2eTE1k3/6UggqEGXShsZ2KkXX2lhwmpOjy0dJ2/3P1DcIblI
        4VQ21M1d/Cq3DRLSttGx2M5chiSZo72fkP+bqiT7/4FHuoXioCOuYbAlG30wfDGU+lCprM
        8HK9XnEvgmpUXov/1ErmBvSJ72gBUdjSaq7ywIdUCrIKWQYMqdT5MS2zOvNkn4UFgTiLPb
        AbGnmimUihrVanWRBdopz70kgmeqcPdi9ZIXQWYrVN6jkv9GheWVBnlCT/6F9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700581326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q25VFprGAjgQZW9cnQJWdfE/RGJs3617/YGSnFq5C08=;
        b=xMgXHt2IWwuA2c6Hf2/0XOMetlf5gEzIag3ZOktl8F5lyMiq85KNlOw/fJ1R/ZbivFlC1k
        ldXdOy5j2EZdNsBw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode: Remove the driver announcement and version
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231115210212.9981-2-bp@alien8.de>
References: <20231115210212.9981-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170058132557.398.3294713868649302266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2e569ada424c40ce27c99bfab4f9780619061c83
Gitweb:        https://git.kernel.org/tip/2e569ada424c40ce27c99bfab4f9780619061c83
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Nov 2023 22:02:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Nov 2023 16:20:49 +01:00

x86/microcode: Remove the driver announcement and version

First of all, the print is useless. The driver will either load and say
which microcode revision the machine has or issue an error.

Then, the version number is meaningless and actively confusing, as Yazen
mentioned recently: when a subset of patches are backported to a distro
kernel, one can't assume the driver version is the same as the upstream
one. And besides, the version number of the loader hasn't been used and
incremented for a long time. So drop it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231115210212.9981-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 666d25b..b4be3a2 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -41,8 +41,6 @@
 
 #include "internal.h"
 
-#define DRIVER_VERSION	"2.2"
-
 static struct microcode_ops	*microcode_ops;
 bool dis_ucode_ldr = true;
 
@@ -846,8 +844,6 @@ static int __init microcode_init(void)
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 			  mc_cpu_online, mc_cpu_down_prep);
 
-	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
-
 	return 0;
 
  out_pdev:
