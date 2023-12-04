Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD87380321A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjLDL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjLDL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185A1FC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390ECC433AD;
        Mon,  4 Dec 2023 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691072;
        bh=XNLXB9C9iANjifHx1nMXhDMMAGyy9Qfh4bqOEZ796KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Io8rgrO6IONkw5FdvdLvBhvUKSNRrK/QWiQKGpgJoqXoJ2squCFeHfzLDaPf5HICZ
         rD9evFe+7fhYFUQaycqFh8VadEs4JStBSUlWWWqassmTEO6MSgKXM+dwEdx7uXiptY
         RTAnjkW6LDKYBrBMbD/58lMlFjzJoKI6XuaTVSkeZQjdWhp9kr39JM3MrUdHFVaC1e
         iSnR1WlI3slJkVH9RrM0x6A2jWJUvXDb59se3p+pdjIbsG0KsGjzc1VR7f11gTmr2O
         sks6Gmbxyo6bC9WjO+u7rKWdDXN6t3f5T3iypVlVcWHModGPt1+Ohlf5oLej1fIQxV
         j+ATqkXkHK/Gw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 17/20] mips: suspend: include linux/suspend.h as needed
Date:   Mon,  4 Dec 2023 12:57:07 +0100
Message-Id: <20231204115710.2247097-18-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
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

A couple of functions are defined by the architecture and declared in
linux/suspend.h, but mips is lacking the corresponding #include statement
before the definition:

arch/mips/power/cpu.c:16:6: warning: no previous prototype for 'save_processor_state' [-Wmissing-prototypes]
arch/mips/power/cpu.c:26:6: warning: no previous prototype for 'restore_processor_state' [-Wmissing-prototypes]
arch/mips/power/cpu.c:36:5: warning: no previous prototype for 'pfn_is_nosave' [-Wmissing-prototypes]
arch/mips/power/hibernate.c:6:5: warning: no previous prototype for 'swsusp_arch_resume' [-Wmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/power/cpu.c       | 1 +
 arch/mips/power/hibernate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
index a15e29dfc7b3..d8ef7778e535 100644
--- a/arch/mips/power/cpu.c
+++ b/arch/mips/power/cpu.c
@@ -6,6 +6,7 @@
  * Author: Hu Hongbing <huhb@lemote.com>
  *	   Wu Zhangjin <wuzhangjin@gmail.com>
  */
+#include <linux/suspend.h>
 #include <asm/sections.h>
 #include <asm/fpu.h>
 #include <asm/dsp.h>
diff --git a/arch/mips/power/hibernate.c b/arch/mips/power/hibernate.c
index 94ab17c3c49d..192879e76c85 100644
--- a/arch/mips/power/hibernate.c
+++ b/arch/mips/power/hibernate.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/suspend.h>
 #include <asm/tlbflush.h>
 
 extern int restore_image(void);
-- 
2.39.2

