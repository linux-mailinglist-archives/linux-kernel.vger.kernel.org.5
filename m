Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D787B44B5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjI3XrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjI3XrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEFAC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:47:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B65C433C9;
        Sat, 30 Sep 2023 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117633;
        bh=D9GV1hfzFmmN89nebQOtTR7Dgz5pNeaIURrzo6kciCw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gSe91uYa5exoYVwZh590gzb3j1thFMwTho+iEBt7EvK5y4OAbloM201okxBQWw3Ae
         SKy5P7oXsLoycX0uRhNBLKK10RfvFRB6Lzgf16XFOgiSiokzVxfjw5mnu/JFG5G0/y
         aMnfwk6aCzT4lQYfi4eKNUtYWLQeYHfP3KktfzGjWiAuzssBIhU4PTE9HXEVbEEtxE
         8nsu5WRHv4thW9qtR+aG+R8Ihqh1vO3Rn4P1lu6KtUECzvxcrGYhtDwuOjRSHVcQM2
         7ZPFCVu2tVMlI3XfqhzD8tiHMyQH8G1FP4Q40uVbNfuPWL5GGSwJA60pkUlkLdNUcP
         l8B1A/QFx7PnA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 00:47:05 +0100
Subject: [PATCH 1/3] mfd: max77620: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-maxim-maple-v1-1-cdfeb48a4d15@kernel.org>
References: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
In-Reply-To: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D9GV1hfzFmmN89nebQOtTR7Dgz5pNeaIURrzo6kciCw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLN7zrDDT/QBAst0EkVTj921GiukbDZT+VYFQ
 SQ8HhvLpb+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRizewAKCRAk1otyXVSH
 0I4EB/0SpNvqu4iQWGekk4++F+2dBqh8OQG6fJVZXM73e52vg2ZMjLigZRkUJWcgyplYsU0oMDz
 JV9YXrzMV4b97qi1m+opVluJvPox/KokiBCeew/6b+LRAZcgbXpTi03WRmHWST5iyecZ1gdC5Zz
 VnDTZQ07ZUviAa6M/i2duysw55l/pSkQ5/PYetReXt+l0B8kAcnvD54NVDmuZeejK/v9uVZn+6r
 FoSfbhk64q5JV1lOEwhMfxiUcMccWFgGwDwrJUiZQsKh/AnvcvlGXUDFR4JGGq6pqdYl+ISb+J7
 JNow0R0n8TfvsN+V0IWHrF1clVw4d2t2nhN0sXKLFgu9LWDY
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
 drivers/mfd/max77620.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index e63e8e47d908..74ef3f6d576c 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -172,7 +172,7 @@ static const struct regmap_config max77620_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = MAX77620_REG_DVSSD4 + 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.rd_table = &max77620_readable_table,
 	.wr_table = &max77620_writable_table,
 	.volatile_table = &max77620_volatile_table,
@@ -184,7 +184,7 @@ static const struct regmap_config max20024_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = MAX20024_REG_MAX_ADD + 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.rd_table = &max20024_readable_table,
 	.wr_table = &max77620_writable_table,
 	.volatile_table = &max77620_volatile_table,
@@ -213,7 +213,7 @@ static const struct regmap_config max77663_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = MAX77620_REG_CID5 + 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.rd_table = &max77663_readable_table,
 	.wr_table = &max77663_writable_table,
 	.volatile_table = &max77620_volatile_table,

-- 
2.39.2

