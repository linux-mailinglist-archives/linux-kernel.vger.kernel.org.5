Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F577B46D3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjJAK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjJAK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E739D9;
        Sun,  1 Oct 2023 03:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1713CC433CB;
        Sun,  1 Oct 2023 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156175;
        bh=QFovpwpspTFAgCNiGSH+/tKFEI4TJzP/NJt5hGNuj3s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OE6KWzpxlfsTLmMg1nTi5oqSm5is2FaHGDsMmJHoC8RPLYXfx1nwDOeOdfvzMuVLM
         GAujla+K74K3W0hRw9dAllhGMsi9IvSip6uhijslE7RDQTrl/jvCv+FuTgNjly6amo
         C1SlQmDj6BTcaYwZ3ukHpjDaSOHFhKtAGHIEOLSZ3pMwQCqcHAnNoIBfrnw1mZhbST
         Ivcy8aLnKaDM2NWTHsam0UB8gYQcH1rd2KDh59yyAdvijH1wNWkT3AY1d9BBy3bcHx
         16rhgR9C4y4KDepYfhNx63u4fpDqoEHegaKq9AaIkFaW02amq1o1BeGf1feESEEUNe
         w0iLnYyULl8eQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:52 +0100
Subject: [PATCH 5/7] mfd: tps65910: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-5-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QFovpwpspTFAgCNiGSH+/tKFEI4TJzP/NJt5hGNuj3s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoDmQK2/Qt0MHtnMY9wVm3+0fPuhKDsVLKu3
 3runPv4yP6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKAwAKCRAk1otyXVSH
 0Et0B/4t3DKIsjdp8lxHkOn4d9/YA+Rlq8mV6orroChC10glYNM/6lKfxFfUCZ08mnMJmj8iN6W
 rRbQlOrggWsmy7i7NEpbQs7xtwuS99+Y2+5jFZquu3f8s/yRLrhtVPkDHTd8Rlid3Bu7V6+Z7xw
 zJemNCMh4UiruHRW14+Z4FlFSEa3gRJvU22HL2m0mmg9ybGKxrJmA7UWdEUJ/NwI4LZ+v+pCmRl
 4TvUMLgdZS016OEi+F/s4CRKSTikhw8/k6akn8BJieIo3lqD+ma3/t2tUY3umJNXZAREARjRJ+Q
 BXJolslsf4siHdKC4+otdI+Kpj4paZh5DQN27JPiMIVybiJN
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
 drivers/mfd/tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 41408df1712f..307d30da274b 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -281,7 +281,7 @@ static const struct regmap_config tps65910_regmap_config = {
 	.val_bits = 8,
 	.volatile_reg = is_volatile_reg,
 	.max_register = TPS65910_MAX_REGISTER - 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int tps65910_ck32k_init(struct tps65910 *tps65910,

-- 
2.39.2

