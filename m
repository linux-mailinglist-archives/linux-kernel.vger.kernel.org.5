Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1620C7D57D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjJXQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjJXQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:19:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7B83;
        Tue, 24 Oct 2023 09:19:36 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B62B6607328;
        Tue, 24 Oct 2023 17:19:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698164375;
        bh=x58O7/yeMCAwTvVvYfypW/Y5RY/B1MgCHBqd2HZdSiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baHTv0Q9SNhDPpjT/nA2urEKIhWdb+u2YwV8EXqJfF8sbpAiX9q/0UlN7Wxo5LB36
         d0WqNO17GD/3nVB9KNG+S1Nb3rfRJKUvrdOyEBd9MHOPCTsDuoCOv45Z2dNHcq1dCN
         sBmYuLFuAMgT/iVJlXpbIAST4i2ejJEuC2pbMXAEiYgMK9tkFQMa5Uky/LcDKEq8Xb
         Ln9e8eAOWvUyT4CA9/XpNxm0SPgXR5rlOrAu5TeIZGY3D8s6LEKJeG6LjxBxJRw6rp
         /WcSXWRJdTkmv6gx8tlVU9X49FCvAwhI+uvWy3t+//Op6qU8pc/6cevg8QtsKzdBX2
         P2Jpfo3Md/0Dg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9FA15482ADD; Tue, 24 Oct 2023 18:19:32 +0200 (CEST)
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
        kernel@collabora.com, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 3/3] clk: composite: replace open-coded abs_diff()
Date:   Tue, 24 Oct 2023 18:18:17 +0200
Message-ID: <20231024161931.78567-4-sebastian.reichel@collabora.com>
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

Replace the open coded abs_diff() with the existing helper function.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-composite.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 66759fe28fad..478a4e594336 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/math.h>
 #include <linux/slab.h>
 
 static u8 clk_composite_get_parent(struct clk_hw *hw)
@@ -119,10 +120,7 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 			if (ret)
 				continue;
 
-			if (req->rate >= tmp_req.rate)
-				rate_diff = req->rate - tmp_req.rate;
-			else
-				rate_diff = tmp_req.rate - req->rate;
+			rate_diff = abs_diff(req->rate, tmp_req.rate);
 
 			if (!rate_diff || !req->best_parent_hw
 				       || best_rate_diff > rate_diff) {
-- 
2.42.0

