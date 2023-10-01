Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE957B46D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjJAK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJAK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9DD9;
        Sun,  1 Oct 2023 03:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9046CC433C9;
        Sun,  1 Oct 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156173;
        bh=zfzbAStTFVX6U2zX+aSRy9Gxw5q86a6AQxF5OD8cZgs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kYgcs4MzrMOL/3FutGcYUjOmXhy3zID2VXsANP1uqJ+tMBI+WUsfMlV9an3cMiFot
         Emhbe+pif2XLj6EsoMrcwVVwQ1Da22wPa/pyxZ97MgD/M9J44NZL0jvS8FmjhEZcHc
         mNms74eaUc4UVz72XfA3z+TP1t+zLhbbZxVCt2OFXNT3JoDWQqsMsklXz9TYQMAj+A
         8DJPEgz0DqteG+ke6zg/3GFAVbXxIafJU8HJWuO1L3wgdNOvuq7kPJmQ+rK/vY5bEm
         TpPGCWx4r+xlbXCFXHviQjirS17Zy+E1AkqKXb0MUkIH4nCf4jm/VLasmKESVY3hBl
         W2OWKQcEOHIFg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:51 +0100
Subject: [PATCH 4/7] mfd: tps6586x: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-4-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zfzbAStTFVX6U2zX+aSRy9Gxw5q86a6AQxF5OD8cZgs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoCBJzowV08mP3WavQ7vJbo+gp4biMRFj0Mm
 Cl+mj9prwGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKAgAKCRAk1otyXVSH
 0CSxB/9Q5nu+X+y2PK3fl/BaScyR4ZCLrkJpI70UUQdboSKX34Tp7x8f8VgYEtZ9pvEMHFzLwlw
 5mxN7zPM4/75eWcI7ftRFBhAA3c6ns8caS477V5zMQPY/kUCR25Y8pGJQAC4/DBgFygxyQtXEyU
 w/sqBwnQoJNseyYgGqA+X5fKbycHUH1hMKoOACSjKkjCyD7ps5AdbPJYrs/IVm7Ps3Z35tfQYwY
 F/6Q27qF7CYSeifH7k9KRVWrCrQVN2xI6PSAJdQvpc3yQ8iOtgvPcUPmQ4T/rViGCleAT0ceA2F
 auqkOnrGiQK0iKskzwXMDFSZDAzwr1V3/zFYVJkgapS94Qvi
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
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 55675ceedcd3..378ee626c04d 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -454,7 +454,7 @@ static const struct regmap_config tps6586x_regmap_config = {
 	.val_bits = 8,
 	.max_register = TPS6586X_MAX_REGISTER,
 	.volatile_reg = is_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static struct device *tps6586x_dev;

-- 
2.39.2

