Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DE7B44B4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjI3XrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjI3XrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D58E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:47:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5889AC433C7;
        Sat, 30 Sep 2023 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117635;
        bh=aMzW1QSiY8RBcHGfZ8DGPquEYC27axc1gcOFIIgxAqA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XgkNhNEbjbyX0veAfaD4mTTkKHsDBNaSF9x0adY6Q46uXErAIml+li48Cvw12qLL7
         OpSDaXjcXbKaYgAxAx23I/p4bXEBWB9Ik9uXgPwcSPhQG3XWoTqUiJkaxvXQ1mTmT/
         K20GQV23oFxTBg6Ac83q/S2HonE/9l48GxXvzeVkq1myCOrrui8Hx7SrGlofkp7Qme
         ej7jn6ToMuYVOVsmYSsseUxXWpA3nbWAvmwA2Lnq8GZrYzJOB23q/R8hHKDuDXCI4L
         xEJ8wRdAv6bXBd4ZJlmEO1PkF4rzL18Hz5heKn+cAqIbtfon6Gvi1qAr8H2Aa421hE
         igV35sJTt9oZw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 00:47:06 +0100
Subject: [PATCH 2/3] mfd: max77686: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-maxim-maple-v1-2-cdfeb48a4d15@kernel.org>
References: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
In-Reply-To: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aMzW1QSiY8RBcHGfZ8DGPquEYC27axc1gcOFIIgxAqA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLN8pCkPwB4kw1gdR1PeqK5dGiX/Z2trkc2Ih
 xC5EfO0GWyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRizfAAKCRAk1otyXVSH
 0CJWB/9sj1d8od2LVnZxm1ghiFCjBcN8L+eo1MVxnOUzoXRUH3yWAH4l44htq2xYAQeCNtbVuH5
 m322mLKVNMDGXRT7ELQqh5atVBDZRUEEZHaa9CZl40BWHc8vu9s36MOb2nuAYtY5keDJJzLImlR
 zZAc4SqIYc0CkonK4rlawtAbW/kr/QUogOi0F/V4NXIa7fzNrZr9RFFw/A25FccSheUTKftBoBu
 Ced5eXwhPZvU1MhyTkgzjB5clYzCtHElIbMQNcW8J4qPMyPwqeXbjNWEKKl89D43G0693LytAUU
 sikoOJZF8MdYJGsGn87ZV28y9rHgJkEJ/tdOCVe2hF7RBvmF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mfd/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 91c286c4571c..0118a444a68b 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -108,7 +108,7 @@ static const struct regmap_config max77802_regmap_config = {
 	.precious_reg = max77802_is_precious_reg,
 	.volatile_reg = max77802_is_volatile_reg,
 	.name = "max77802-pmic",
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_irq max77686_irqs[] = {

-- 
2.39.2

