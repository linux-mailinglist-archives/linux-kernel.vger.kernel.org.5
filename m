Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4780C8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjLKMGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjLKMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:06:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AE0101;
        Mon, 11 Dec 2023 04:06:20 -0800 (PST)
Date:   Mon, 11 Dec 2023 12:06:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702296378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl2tlV75de7fhE43nzDquqVGhEpeyvXDyhkJdtCkFhg=;
        b=CSV5GCrjnhWOyeRyiG1gd1lW3n5w1K4rShwujEAYWRFM1i+Uq2VpmK4x3ugYSGaH+IRO42
        /NMyjBfCyN0+Zb7Z8brAUB4KN5oLq60+wgxEvXEjeUrISzSEs/xI74es0anz3vSaVsrfw5
        WiaQ0Bvr9sLlNjHVMPs+JjpOopVN5o5XyoEplaHIPrQJSAgQbO1VGaZMw0dpbsP4xTm3cX
        jmOBk4tlobgoj78Av99W4Nawz18jlfk4kgf0HkovoCpioFsHpgFIsazX1nq7NIOSLzHqcN
        XiI5WjLGhtIc+9gpBhSQB9j9wBftcOLo5cLd1LpudlKmdAC9k1pRVmdDaE71Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702296378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl2tlV75de7fhE43nzDquqVGhEpeyvXDyhkJdtCkFhg=;
        b=19+g0zAr8ZoeYSOT6DMBoQjarEol7zGO7mJ4nj1SIzdRJW2VBc3MeJIFrcFrOJLpvfhsn9
        YPSNbAc2yqAK5+Cw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Avoid sparse warning with cast to named
 address space
Cc:     kernel test robot <lkp@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231204210320.114429-3-ubizjak@gmail.com>
References: <20231204210320.114429-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170229637722.398.17541780401553649834.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     3a1d3829e193c091475ceab481c5f8deab385023
Gitweb:        https://git.kernel.org/tip/3a1d3829e193c091475ceab481c5f8deab385023
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 04 Dec 2023 22:02:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Dec 2023 11:47:15 +01:00

x86/percpu: Avoid sparse warning with cast to named address space

Teach sparse about __seg_fs and __seg_gs named address space
qualifiers to to avoid warnings about unexpected keyword at
the end of cast operator.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231204210320.114429-3-ubizjak@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
---
 arch/x86/include/asm/percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3859aba..e56a378 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -36,6 +36,11 @@
 
 #ifdef CONFIG_CC_HAS_NAMED_AS
 
+#ifdef __CHECKER__
+#define __seg_gs		__attribute__((address_space(__seg_gs)))
+#define __seg_fs		__attribute__((address_space(__seg_fs)))
+#endif
+
 #ifdef CONFIG_X86_64
 #define __percpu_seg_override	__seg_gs
 #else
