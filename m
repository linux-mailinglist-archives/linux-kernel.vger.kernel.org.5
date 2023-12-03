Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC6802856
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjLCWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:22:30 -0500
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4ADA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:22:36 -0800 (PST)
Received: from [192.168.1.22] (193-81-119-54.adsl.highway.telekom.at [193.81.119.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id 461A6640D9;
        Sun,  3 Dec 2023 23:22:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1701642154;
        bh=S+NxOg1Q99NWR3DORvjhpBwkWsMbImN66Ggyq/z+X+w=;
        h=From:To:Cc:Subject:Date:From;
        b=PZj6DUZ1DkcMZ1sVexpfeRINlMzkmmzCFcZIG/MV0TXyrAlY5msfSTUjy52iJTG/h
         HNZeCSNpOzSZ2otsEfsz0vIrYNrOcr/BjlanFv6whZm5tlB8wGzLOUm1R154dLmofQ
         /1bNFMd+ZDFrXbwrhSbi3sPXf0+rBz9ciNbsiFQk=
Received: by camel3.lan (Postfix, from userid 1000)
        id 6C5F254029B; Sun,  3 Dec 2023 23:22:33 +0100 (CET)
From:   Matthias Reichl <hias@horus.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Matthias Reichl <hias@horus.com>
Subject: [PATCH] regmap: fix bogus error on regcache_sync success
Date:   Sun,  3 Dec 2023 23:22:16 +0100
Message-Id: <20231203222216.96547-1-hias@horus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0ec7731655de ("regmap: Ensure range selector registers
are updated after cache sync") opening pcm512x based soundcards fail
with EINVAL and dmesg shows sync cache and pm_runtime_get errors:

[  228.794676] pcm512x 1-004c: Failed to sync cache: -22
[  228.794740] pcm512x 1-004c: ASoC: error at snd_soc_pcm_component_pm_runtime_get on pcm512x.1-004c: -22

This is caused by the cache check result leaking out into the
regcache_sync return value.

Fix this by making the check local-only, as the comment above the
regcache_read call states a non-zero return value means there's
nothing to do so the return value should not be altered.

Fixes: 0ec7731655de ("regmap: Ensure range selector registers are updated after cache sync")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Reichl <hias@horus.com>
---
 drivers/base/regmap/regcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 92592f944a3d..ac63a73ccdaa 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -410,8 +410,7 @@ int regcache_sync(struct regmap *map)
 			rb_entry(node, struct regmap_range_node, node);
 
 		/* If there's nothing in the cache there's nothing to sync */
-		ret = regcache_read(map, this->selector_reg, &i);
-		if (ret != 0)
+		if (regcache_read(map, this->selector_reg, &i) != 0)
 			continue;
 
 		ret = _regmap_write(map, this->selector_reg, i);
-- 
2.39.2

