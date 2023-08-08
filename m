Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7FD773F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjHHQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHHQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAAEC1;
        Tue,  8 Aug 2023 08:56:20 -0700 (PDT)
Date:   Tue, 08 Aug 2023 07:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691480179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7r8h0H0D8Ip7rjL8jbIAPWfrJNA1pNePARCqpWioHo=;
        b=EguxfNjnjczzI0CxdMU/Hap8xpfHMrU4//46auIUQeti1iJt0F9cBumPY03Ql/S37i9VLA
        pydrlIl8hQtJDFueZSBiUxxfLQmCfzXi7KIax1u476MyRblYvF5GNwPf2itcyz2PJn+Vo5
        dBp0hqw0AR/o8I4iVInVJrClanmfw8gOwbJeu8r5kFoPQ6oUpC+poYMXmp5iI5JiVOXkcc
        ZpRMG3bnDQYPlHw6XbhMVZ/egJzXV22JilkhbAFF228xbHeYP+lAMh1kQTovBTL2Fl0wp8
        RDXK/8bw23k7vijSJvHq7Kt2JW5ELxgIos6UDglVLBgAG13h3GcyiXvqd4+MQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691480179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7r8h0H0D8Ip7rjL8jbIAPWfrJNA1pNePARCqpWioHo=;
        b=PpYstp+ASPKlfU8X8ecM6EpVrIQzPmGpktkVUxVROx+aYRjAZaTy1H44aJP8KYJxXqVw7m
        JyUlXGF9FrxXDbAg==
From:   "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/vdso: Choose the right GDT_ENTRY_CPUNODE for
 32-bit getcpu() on 64-bit kernel
Cc:     kernel test robot <yujie.liu@intel.com>,
        Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230322061758.10639-1-xin3.li@intel.com>
References: <20230322061758.10639-1-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <169148017876.27769.3198852854990349550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     39163d5479285a36522b6e8f9cc568cc4987db08
Gitweb:        https://git.kernel.org/tip/39163d5479285a36522b6e8f9cc568cc4987db08
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 21 Mar 2023 23:17:58 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 08 Aug 2023 09:31:43 +02:00

x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel

The vDSO getcpu() reads CPU ID from the GDT_ENTRY_CPUNODE entry when the RDPID
instruction is not available. And GDT_ENTRY_CPUNODE is defined as 28 on 32-bit
Linux kernel and 15 on 64-bit. But the 32-bit getcpu() on 64-bit Linux kernel
is compiled with 32-bit Linux kernel GDT_ENTRY_CPUNODE, i.e., 28, beyond the
64-bit Linux kernel GDT limit. Thus, it just fails _silently_.

When BUILD_VDSO32_64 is defined, choose the 64-bit Linux kernel GDT definitions
to compile the 32-bit getcpu().

Fixes: 877cff5296faa6e ("x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu")
Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230322061758.10639-1-xin3.li@intel.com
Link: https://lore.kernel.org/oe-lkp/202303020903.b01fd1de-yujie.liu@intel.com
---
 arch/x86/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 794f696..9d6411c 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -56,7 +56,7 @@
 
 #define GDT_ENTRY_INVALID_SEG	0
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(BUILD_VDSO32_64)
 /*
  * The layout of the per-CPU GDT under Linux:
  *
