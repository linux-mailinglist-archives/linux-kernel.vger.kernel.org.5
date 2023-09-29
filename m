Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4F7B31FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjI2MD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2MDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:03:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6B3193;
        Fri, 29 Sep 2023 05:03:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512FEC433C7;
        Fri, 29 Sep 2023 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695989032;
        bh=3MUaUo9a8Fm8As5/IOjHSuCfUaEwm9T5adZSB4Vnqgg=;
        h=From:Date:Subject:To:Cc:From;
        b=cyl3J2tDLRPPt9jYiTGEYEBg290PWjdMrmUJiF/yo6ecmFBfAmR6d91CL/xkPa+Iu
         JgTVPrxSCm67qIOzQcuVnBVlizrBXeuHNdBrlVhAEPypHh55iyF7PU+Tq2SJF6IP0X
         tDHtMuc3ZgoHeC+MHf7kp6B55HfbozQLQ2oca/LQjmPFzVRAe/IxeIkFaseavsLLpX
         R3V6tiW+qbqcoK7wnzr8plQSWSaQta08sUUcmsRmA2390bceInwgHQr6TRxScaEVmy
         wmb7OgahzSDnEDvWCokSAxXaWLgqsVWlGwf66NZiJMKJU+r6/6VB9ORhE3/eazYqE+
         Ztfr2xE1Km+RQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:03:43 +0200
Subject: [PATCH] clk: cdce925: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-rbtree-cdce925-v1-1-a36b459002f7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB69FmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyML3eScbN2ipJKi1FTd5JTkVEsjU12TtBRLy8Tk1GQTo0QloMaCotS
 0zAqwodGxtbUAgsvMvWQAAAA=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3MUaUo9a8Fm8As5/IOjHSuCfUaEwm9T5adZSB4Vnqgg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFr0mX++amLlVFsZvoIhPSHjijVKWoxwOO9Y8J
 ASdHYviIYuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRa9JgAKCRAk1otyXVSH
 0A6TB/9nUJ69vnNOOluHw2FCB457ryS///MmdvKl/opqNxEzzBTzIdIXhyXSjJbiXuEj1Xu5AW4
 r4p3GUeGvue/gb748+98q07wWHMnFj3bpofiKpYDhQRHYcisXWNF8Pg79Y7lT7BGq2rUAOndrRJ
 TTj+WYXg7KlizdQBmDgNVdZG045XekVH/Q29LrR55Y8aPxx6b867mLUkPxoBkoPjIe7YH8jIsqr
 PsaDk2COqPiNkTnJoDqq3L2Kfqf43vrZAcDArF2lwkAV7HyaLvxdXkALcukNsCMOxWtBsPVwuI1
 Xb+FvfNomVd6j90Llh+znmjHBqELBVGaKdSjc39pCmfTefNj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/clk/clk-cdce925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index cdee4958f26d..5ffaf1255ff7 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -647,7 +647,7 @@ static int cdce925_probe(struct i2c_client *client)
 		.name = "configuration0",
 		.reg_bits = 8,
 		.val_bits = 8,
-		.cache_type = REGCACHE_RBTREE,
+		.cache_type = REGCACHE_MAPLE,
 	};
 
 	dev_dbg(&client->dev, "%s\n", __func__);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230928-clk-rbtree-cdce925-4fd99acec42a

Best regards,
-- 
Mark Brown <broonie@kernel.org>

