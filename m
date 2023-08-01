Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6776A61D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHABQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHABQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECD10E3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E1661375
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A374C433C7;
        Tue,  1 Aug 2023 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690852565;
        bh=S11F+NWoAl/iB4WLBF7AD+NtSYu1hrv1RpQ5SOg0s/o=;
        h=From:To:Cc:Subject:Date:From;
        b=TYv+1xxilTBwlcwqNalAZyf60X+M3peXB9sCH4spd2jQPMYKSx99CxMtwdQgIeRMA
         uaYeT6jI0iYT2IzkC5vDnn5xJfple7xf8dcjAdEinh82wr/JZ4P/PqQjKJg1ZhTGRH
         9FPp/VzxhdBBcwcAXdGoQ6ZsYBFwiJi16jOSo3vXsLnLAs5NwwyXfu4CW2hVtVXO0y
         nqXPeqAxHvktaFmL9TSaVWwbXW01xIRkb0+uEZXKeLQRwaj/rSDWwkKfEDqgvE+7rT
         opnOaqVbyE4UJE+z/+EsrsE+G80WsJdz2JLHpqWmcvVwGzj5Kxp5H22BO61GZH1DjC
         A981TCiaX6FHQ==
From:   guoren@kernel.org
To:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, wangrui@loongson.cn,
        andrzej.hajda@intel.com, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com, guoren@kernel.org
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
Date:   Mon, 31 Jul 2023 21:15:54 -0400
Message-Id: <20230801011554.3950435-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When cmpxchg failed, no memory barrier was needed to take. Only
when cmpxchg success and the new value is written, then the memory
barriers needed.

 - cmpxchg_asm:   Unnecessary __WEAK_LLSC_WB for the fail path would
		  reduce the performance of the cmpxchg loop trying.
 - cmpxchg_small: Miss an necessary __WEAK_LLSC_WB when sc succeeds.
		  It's a bug because there is no memory synchronization
		  when sc succeeds.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/loongarch/include/asm/cmpxchg.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
index 979fde61bba8..6a05b92814b6 100644
--- a/arch/loongarch/include/asm/cmpxchg.h
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -102,8 +102,8 @@ __arch_xchg(volatile void *ptr, unsigned long x, int size)
 	"	move	$t0, %z4			\n"		\
 	"	" st "	$t0, %1				\n"		\
 	"	beqz	$t0, 1b				\n"		\
-	"2:						\n"		\
 	__WEAK_LLSC_MB							\
+	"2:						\n"		\
 	: "=&r" (__ret), "=ZB"(*m)					\
 	: "ZB"(*m), "Jr" (old), "Jr" (new)				\
 	: "t0", "memory");						\
@@ -148,10 +148,8 @@ static inline unsigned int __cmpxchg_small(volatile void *ptr, unsigned int old,
 	"	or		%1, %1, %z6	\n"
 	"	sc.w		%1, %2		\n"
 	"	beqz		%1, 1b		\n"
-	"	b		3f		\n"
-	"2:					\n"
 	__WEAK_LLSC_MB
-	"3:					\n"
+	"2:					\n"
 	: "=&r" (old32), "=&r" (temp), "=ZC" (*ptr32)
 	: "ZC" (*ptr32), "Jr" (mask), "Jr" (old), "Jr" (new)
 	: "memory");
-- 
2.36.1

