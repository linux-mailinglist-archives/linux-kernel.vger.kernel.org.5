Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5707B46CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjJAK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjJAK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302BC2;
        Sun,  1 Oct 2023 03:29:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8A3C433C9;
        Sun,  1 Oct 2023 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156169;
        bh=pX3DD45tsnV3iImQ76eKtErG7EdvxzNMH/u0Fq7YL+Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QPZLVO+G0xQcjivZ9rf9EZB0v1mVaDSSXQSAiPRaGFdl8d+GcB55DAEUmYflB+gn4
         pg1VaczzD2rciuQhH2+yBKabfVb1pprZ8XvDj4aFPpP1q8E9o8gRglyHL8QW6YfiUX
         Jyen2aqUBF1VglNoFyuNbrjZZMtaIj/mI25JXUQij9GZ/x4DfBqCJDFBECFcHUmcpk
         OERVwsK2rm66YEYfDBDxEjjddYBSPKqW29tXRmc+GByEhie3FnRYn6pX7n4p3ZfYaK
         Yz3c6V1rvsLGDn1iu2p21gynbWiqBv6wrW6LuR0O8z56WYV1KexuUOzw2tfQLbs4ru
         DsaAzGSuF6SRQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:48 +0100
Subject: [PATCH 1/7] mfd: tps65086: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-1-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pX3DD45tsnV3iImQ76eKtErG7EdvxzNMH/u0Fq7YL+Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoA67sNocFji/GfAL6XKHLsVj66iX6QgTFRq
 B2h0jGCUVqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKAAAKCRAk1otyXVSH
 0OEYB/9zK/p1yuyWjf7wuwpd9ICEBeAoV52YT/8TaNEqzxdQTkaUYQkKIFpozOBxreixF+d41t6
 jYEDzyJuf2AHbwdAyX30LEAjKhAtSAUZpEzorEcm7frGUyUMoe6Zz0rcooTHBxWpYCa2W3g+rdT
 SAIBtD3WmBK8b98J6LGmkQg+g6pBVVKTjFhPDAOZLx/boyyfW9KRqGlq1IYWvAjyuU2CX81hTJg
 erF8j2I/6MeIzJs3QuP3xW0GsjA0dC58HtkPfPILUVtZgCZpUGS+QGNbd2gTNjTxL4yKm8ka/+x
 SOA9tPl0knouPPrioiSaQPaTM7g9vNw/wL43QiNtZkkTpa4v
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
 drivers/mfd/tps65086.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 9bb7d7d8dcfc..152179ee11ca 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -34,7 +34,7 @@ static const struct regmap_access_table tps65086_volatile_table = {
 static const struct regmap_config tps65086_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_table = &tps65086_volatile_table,
 };
 

-- 
2.39.2

