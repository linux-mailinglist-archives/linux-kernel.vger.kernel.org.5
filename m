Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42597B46D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjJAK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjJAK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18DE0;
        Sun,  1 Oct 2023 03:29:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203C1C433C9;
        Sun,  1 Oct 2023 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156178;
        bh=81ol02msEB01/NcMPVgugti07kEIWXohMOsoa/ioGpY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=e9Sm3PMS6VQE6vdLBrv8d1Uf59Viz0tDVjf6eqMURdDpTgEnZ/WtBNLSQ9qGSqE3f
         pPBSiFXXS2gW7KWSTzVSX854IPlUsbSJCEz5M1QiWLlPK0zY9HYujA1fVBXn1kdBIQ
         e1lspOZccDHEdLXguJs8EgbKZ8n9XqLrmyQdwBh/iwwqiPc+n2s3gaJBLQaIyxEx4a
         z6Gy0B0wF0cz/d/gP4mb8DjpaWhGl4tt+lqXp9oVOoKAAVCDpxP9+VX7e0sIM+NOu7
         a8oFPbIkAClzVsaVWvyhKo87J+dLt0BO5a26OWmEo2/lzPh4G0lekR0oyw4EY5+t2/
         vRpyIRn4XG6LQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:54 +0100
Subject: [PATCH 7/7] mfd: twl: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-7-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=broonie@kernel.org;
 h=from:subject:message-id; bh=81ol02msEB01/NcMPVgugti07kEIWXohMOsoa/ioGpY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoFMIIpewrFmcaDtdsWcw4kILq4xQOQEEJcq
 qqWTgwxageJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKBQAKCRAk1otyXVSH
 0I1TB/9XK+0FAoLrIqX2yf2A5OetRN4h4IXkuQHFOYzDlrhosx0/8s0CfJAT2vpe8ZfIAJpazRK
 kCffT4kP3+voI07IKlmRkcIp8YdzBHpl3WudYgDxoCIsAWSHtdPoYeuAmoSlLSsJb5fNv7Zczg5
 LTgcFyXQJD+hlr/KfY97jZ1LkZlbr7eokbvGdd3CtyjEM80Nem/mCoELPKRquT+y2XgIKcli9KF
 LqkuWSVLTXpbXtqAGPqQZX5iYqLCICmjxA2EvVcK49EHEs5OQKFy/7cNZcLhcJXovKD8FkhQFw6
 PKh5OPcqnAK1AREiVJNYuTmrWPdiL/lDVxu/a+xCexjFnBCt
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
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ce01a87f8dc3..1c1fefbeeb80 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -312,7 +312,7 @@ static const struct regmap_config twl4030_regmap_config[4] = {
 
 		.reg_defaults = twl4030_49_defaults,
 		.num_reg_defaults = ARRAY_SIZE(twl4030_49_defaults),
-		.cache_type = REGCACHE_RBTREE,
+		.cache_type = REGCACHE_MAPLE,
 	},
 	{
 		/* Address 0x4a */

-- 
2.39.2

