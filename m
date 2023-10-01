Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64167B46D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjJAK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjJAK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B348C2;
        Sun,  1 Oct 2023 03:29:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135BCC433C8;
        Sun,  1 Oct 2023 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156172;
        bh=NLkjuLmP8ZHYnEDlj9aw8Js+zXvvGMzVaSTTo6mhlJI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h94iLeeqZl36APi1CtZvm5ODPxtO7cF3jsnYoCpYWU5A8zhuwG3edgDAgtHJDft8Y
         ZbBbhfXY3ugURGEnbRW/BTPfZ0p6oIpFgX/qlOQSkQyrTSEJLOrj7Fszm489COONg8
         3yNn4Q1oqycHWioeR2vSxCfqzQpI1eA47/bA/07iICpzpZLJGu1TZ4wjH+pDElt4ZJ
         g1afprbCiN7hJB2x4sfCuPwfTjUClM9PaQdm7HjsjvmFE8j1RD5SS67qy+oIGGLNCV
         7C5urw1DBsIBC/JFG4WaTjshVG1z58sGaz8hxEhm3VMaC51iWBY4yeiwGDp9zR5OEh
         UrWDQif/WLf4A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:50 +0100
Subject: [PATCH 3/7] mfd: tps65128: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-3-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NLkjuLmP8ZHYnEDlj9aw8Js+zXvvGMzVaSTTo6mhlJI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoCz9xvqGhKfg8tzTHfgVMKj3oUoEfVznXkh
 DRdf4iplgOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKAgAKCRAk1otyXVSH
 0JgYB/9tFhdkiGLUdd2CiJeWJ+o8d67mOgVKhnMxUtwpHTV6XePrRackmx9vj53/jRL7ZGWvSp5
 Ls3/2/yH9ApuED88sGthiPVwJVb6ZuPW4eH0fzLotAqHOzRkMy9wvGovM5F/4MHYCn1KsqvKYUG
 7H9/uZmsd/M6r70qFAr6W2PoR4Yn/7Yy8sGWo3YBgRhq18wV2nXPF782Sk4hgc7QPh2hgwrWgha
 gEZtZ1HRN6IfDdIQC9YGoPQNswT/9xURPfgKOli0EMxzZJnSkJlDRjZ241zmhqNREsYm+NxkpQQ
 jyjokFg+9AvZ/cLpDHD9RbHpA/4qT9LXbREn4ZksSBEZAPk+
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
 drivers/mfd/tps65218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 11e4e52b56be..427a2b97f117 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -127,7 +127,7 @@ static const struct regmap_access_table tps65218_volatile_table = {
 static const struct regmap_config tps65218_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_table = &tps65218_volatile_table,
 };
 

-- 
2.39.2

