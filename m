Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654CD7F7D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:21:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0241BFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:21:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CF0C433C7;
        Fri, 24 Nov 2023 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700850092;
        bh=xi/B/K1H8OvKVsxH1/1c5JnIHvryKND5dQUNfJeOLY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpTYWCQc4kFWOXmHMtKEgLlY5wKgKU/cEBbyuCxBj9/K/0UdB7z+8FyartXTlRDSI
         BJFcK41qX6KcyJ5WbXvJ8fh5fCCfWZaRedPNzPuYe1X9Y4PkDX0fslGDsm2e0rVhZI
         pJYLVn9ppfaQFzUK/+uIJsKd1ET/4YXlw6doSFes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.6 442/530] sbsa_gwdt: Calculate timeout with 64-bit math
Date:   Fri, 24 Nov 2023 17:50:08 +0000
Message-ID: <20231124172041.551376645@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darren Hart <darren@os.amperecomputing.com>

commit 5d6aa89bba5bd6af2580f872b57f438dab883738 upstream.

Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
introduced new timer math for watchdog revision 1 with the 48 bit offset
register.

The gwdt->clk and timeout are u32, but the argument being calculated is
u64. Without a cast, the compiler performs u32 operations, truncating
intermediate steps, resulting in incorrect values.

A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
timeout of 600s writes 3647256576 to the one shot watchdog instead of
300000000000, resulting in the watchdog firing in 3.6s instead of 600s.

Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
the order of operations explicit with parenthesis.

Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.14.x
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/sbsa_gwdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -152,14 +152,14 @@ static int sbsa_gwdt_set_timeout(struct
 	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
 
 	if (action)
-		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
+		sbsa_gwdt_reg_write((u64)gwdt->clk * timeout, gwdt);
 	else
 		/*
 		 * In the single stage mode, The first signal (WS0) is ignored,
 		 * the timeout is (WOR * 2), so the WOR should be configured
 		 * to half value of timeout.
 		 */
-		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
+		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);
 
 	return 0;
 }


