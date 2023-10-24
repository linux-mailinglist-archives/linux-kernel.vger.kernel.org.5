Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9CD7D57D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjJXQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJXQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:19:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DA2A1;
        Tue, 24 Oct 2023 09:19:36 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3494B6607324;
        Tue, 24 Oct 2023 17:19:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698164375;
        bh=r5h0r4C6WuS6YaXUWi5dy7ZxeGnh1BcenNgCKge4E2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N89hTeneZ72qS/H3QXeA1c54E4oF+hYpxHnrkwPhhj1gpx2GKmaY+Q3laZp5tOykv
         isKa9er62kBNVNG2Ud0EUSwu8bpL0FUKr2QcStvnqpnJ2Ymp4pdUMTdsqOcGCjt0If
         qBdO32Pef0JavTxHUCH+5VsrfJeiVH3ti7O+p3F6zUAkvSr7af3rJpKMrWHjbqLeNe
         Y4HltnzAeOmX23Vk1MYdfGRa65UOkWsn8025R1wvQNuq+tLLDbOHJAVeqL1/os7zRM
         UFpeG9Hs2gJhhcqYeZLMttyCDuAEY6KNtyK8Px85xlbwvsfx2U3Rtxe12+D6sHr6sC
         dre61Yd6qyOUQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9DAF3482ADB; Tue, 24 Oct 2023 18:19:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 2/3] clk: divider: Fix divisor masking on 64 bit platforms
Date:   Tue, 24 Oct 2023 18:18:16 +0200
Message-ID: <20231024161931.78567-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024161931.78567-1-sebastian.reichel@collabora.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock framework handles clock rates as "unsigned long", so u32 on
32-bit architectures and u64 on 64-bit architectures.

The current code casts the dividend to u64 on 32-bit to avoid a
potential overflow. For example DIV_ROUND_UP(3000000000, 1500000000)
= (3.0G + 1.5G - 1) / 1.5G = = OVERFLOW / 1.5G, which has been
introduced in commit 9556f9dad8f5 ("clk: divider: handle integer overflow
when dividing large clock rates").

On 64 bit platforms this masks the divisor, so that only the lower
32 bit are used. Thus requesting a frequency >= 4.3GHz results
in incorrect values. For example requesting 4300000000 (4.3 GHz) will
effectively request ca. 5 MHz. Requesting clk_round_rate(clk, ULONG_MAX)
is a bit of a special case, since that still returns correct values as
long as the parent clock is below 8.5 GHz.

Fix this by switching to DIV_ROUND_UP_NO_OVERFLOW, which cannot
overflow. This avoids any requirements on the arguments (except
that divisor should not be 0 obviously).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-divider.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..94b4fb66a60f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *table,
 			 unsigned long parent_rate, unsigned long rate,
 			 unsigned long flags)
 {
-	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	int div = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		div = __roundup_pow_of_two(div);
@@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	up = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 	down = parent_rate / rate;
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
@@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
 	unsigned int div, value;
 
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	div = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 
 	if (!_is_valid_div(table, div, flags))
 		return -EINVAL;
-- 
2.42.0

