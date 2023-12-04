Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58D803217
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjLDL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjLDL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C6D50
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD1C433C7;
        Mon,  4 Dec 2023 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691066;
        bh=mHja8axhsHXkDaKV6E+Gy/vhO170K/x0LJkgRVpgsKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfqFb3Q+q+KbsNMRhDvUAK/ugHVnAYEo780Lilzvxrp1kLwQ6TwUhySHx1xCppK9D
         3T4HrkoiBhATuMbgGBUTVQqGY2ORlNOsIQlcxF2GAYgdAcUn+msBqkjrzLGrJWb7Xw
         3TCAyEp19aUxS0bZs8zCB2XFkcjH/3UtMP6ju9VjQyFKY0pWwaQAfALuO61mvZ9rLg
         /cok18i/3aUmCd8mS8nbp6qYmuAcLa6IgFHwxBP5Ck1YSD4SMjQ/xjDrT8wjbZsovW
         VtPdLYxkYaj7RfqED2eMxE4rW5NWluFQQSYdCLo5LuH1ENd0n2EcVxKzfHz5Id44d9
         4MAfQlgB3B/Ug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 14/20] mips: spram: fix missing prototype warning for spram_config
Date:   Mon,  4 Dec 2023 12:57:04 +0100
Message-Id: <20231204115710.2247097-15-arnd@kernel.org>
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

arch/mips/kernel/spram.c:194:6: error: no previous prototype for 'spram_config' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/spram.h | 2 +-
 arch/mips/kernel/spram.c      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/spram.h b/arch/mips/include/asm/spram.h
index 373f2a5d495d..9f6a2cb1943a 100644
--- a/arch/mips/include/asm/spram.h
+++ b/arch/mips/include/asm/spram.h
@@ -3,7 +3,7 @@
 #define _MIPS_SPRAM_H
 
 #if defined(CONFIG_MIPS_SPRAM)
-extern __init void spram_config(void);
+extern void spram_config(void);
 #else
 static inline void spram_config(void) { }
 #endif /* CONFIG_MIPS_SPRAM */
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index d5d96214cce5..71c7e5e27567 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -12,6 +12,7 @@
 #include <asm/mipsregs.h>
 #include <asm/r4kcache.h>
 #include <asm/hazards.h>
+#include <asm/spram.h>
 
 /*
  * These definitions are correct for the 24K/34K/74K SPRAM sample
-- 
2.39.2

