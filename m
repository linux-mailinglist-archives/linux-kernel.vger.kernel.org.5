Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348777F5D43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjKWLF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjKWLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC761BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32336C433C8;
        Thu, 23 Nov 2023 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737528;
        bh=PTPvyroKGj+bJmSOqebpW9CjBUzzYiO7xPn/MeixGLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXSKUa807rZ29ZDLQfJmvRhSi4N8WHovmHbAfyMVEficfSwAV9byFeM2EehuHMPvf
         2plHjQPIGprL9a+CvVI91LktsH4dCLOTw85PLAzRHbTDWS8PBJ+HD6a6zbcFYzYA7S
         /LF4mUwnNE/22hs/ycyxoIHFHiNWy/JLf4Gu9DuVWVIbobN3N9tuy8iVJrVYE3ouLt
         kJi1liD6r+5hhz0cNDST79u04zevwc68Rku5RvjzatdqYLmQop3cbiP1tDQ8ikihWg
         Ed5QrWidUanGzm2kwC1ytck42YRJYbIN/BD477srlxzuaH3tVo4HVndRuycbh+BrmA
         FTpBsaIVkDHAA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 1/6] ida: make 'ida_dump' static
Date:   Thu, 23 Nov 2023 12:05:01 +0100
Message-Id: <20231123110506.707903-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is no global declaration for ida_dump() and no other
callers, so make it static to avoid this warning:

lib/test_ida.c:16:6: error: no previous prototype for 'ida_dump'

Fixes: 8ab8ba38d488 ("ida: Start new test_ida module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_ida.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..f946c80ced8b 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -13,7 +13,7 @@ static unsigned int tests_run;
 static unsigned int tests_passed;
 
 #ifdef __KERNEL__
-void ida_dump(struct ida *ida) { }
+static void ida_dump(struct ida *ida) { }
 #endif
 #define IDA_BUG_ON(ida, x) do {						\
 	tests_run++;							\
-- 
2.39.2

