Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181307DE390
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbjKAOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKAOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:30:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FEDDE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:30:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2f507c03cso3651558b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698849012; x=1699453812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOY9zZGB8DVCxMyDL1I2thOcY+vKDhA+US0rF09l4kw=;
        b=G6Sd+dz/ZQVylr954A0qtLFViRQP65xD5rDFu05glJAMZ/q4OYpVDevRDtrzWj06Xq
         fd275cqaz911SZsp+UYWoF+m/OcmxhNseVRwyi+C+QCxcoAwazY5wggydCQbUbD9LdnH
         696KcqJvT2TGhNnQcaXlvfr0CG+jWTK/OVK/9Au1BCddI5usVY9mhvup2E+J5nP/LcKF
         lxYUlwSyM9obdmyLkSRGS2ex38+SaDiew0z107dPpJ0aWg9QjvLLlY+KcZVYdwdJ5SF8
         mliKxjxqDD5nGGXKy31k9jzPawbldu+2gNi3DGlFyWRa2GYLVzQ7xgWiHW+mwJVhyfql
         D9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849012; x=1699453812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOY9zZGB8DVCxMyDL1I2thOcY+vKDhA+US0rF09l4kw=;
        b=r7P0dgj8Wnob3pIgaiv54yIgeLBCepY6wKeTx3xN6uQ/po/uGa8rvkoAfnPagLAQ7p
         KKVvwcWOw6t6GRKzTvgtONmobsE3ZrViE5jIxx5DQciXM11uJ9yiUnnygsrM8zHwwSo7
         MEmMYxhcR86BiQo2S0LTp6l6hN8H2SIdutobRYoWYcbZAEGliSwUhLbVagWjH83HjZAD
         UEdWll+1n4YSgqA6hW/lZPjuwMPRsNJfwNpdJtjuVQU5f4wfF1w5tgSAztB8odSOd7c/
         z0dAGBmFoaWYe5VL/ArnBYP8wpCtLrLulP01YizYoTegYI+z1z4QaC3OG3v9+yVY8hUw
         kIvg==
X-Gm-Message-State: AOJu0YzeFN7On/+0AtcI52Qb0lFaDuY0gXo6gGzZN233s2CKfhnECCUf
        Cmvs1rcmpUXvsM1Is9nNpYAIHK1ygkYT3b3wu1s=
X-Google-Smtp-Source: AGHT+IFfTDdmgoMv6igYHuPAWtvExAo75KCmRC08TOqliw/0+IGMasL8edcFp2RsF4aEe6WijaBEnQ==
X-Received: by 2002:aca:d10:0:b0:3ae:5c09:73ce with SMTP id 16-20020aca0d10000000b003ae5c0973cemr16363378oin.23.1698849012477;
        Wed, 01 Nov 2023 07:30:12 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a14ab00b0076f058f5834sm1469260qkj.61.2023.11.01.07.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 07:30:11 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] regmap: prevent noinc writes from clobbering cache
Date:   Wed,  1 Nov 2023 10:29:27 -0400
Message-ID: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, noinc writes are cached as if they were standard incrementing
writes, overwriting unrelated register values in the cache. Instead, we
want to cache the last value written to the register, as is done in the
accelerated noinc handler (regmap_noinc_readwrite).

Fixes: cdf6b11daa77 ("regmap: Add regmap_noinc_write API")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/base/regmap/regmap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 234a84ecde8b..ea6157747199 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1620,17 +1620,19 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
-		unsigned int ival;
+		unsigned int ival, offset;
 		int val_bytes = map->format.val_bytes;
-		for (i = 0; i < val_len / val_bytes; i++) {
-			ival = map->format.parse_val(val + (i * val_bytes));
-			ret = regcache_write(map,
-					     reg + regmap_get_offset(map, i),
-					     ival);
+
+		/* Cache the last written value for noinc writes */
+		i = noinc ? val_len - val_bytes : 0;
+		for (; i < val_len; i += val_bytes) {
+			ival = map->format.parse_val(val + i);
+			offset = noinc ? 0 : regmap_get_offset(map, i / val_bytes);
+			ret = regcache_write(map, reg + offset, ival);
 			if (ret) {
 				dev_err(map->dev,
 					"Error in caching of register: %x ret: %d\n",
-					reg + regmap_get_offset(map, i), ret);
+					reg + offset, ret);
 				return ret;
 			}
 		}
-- 
2.42.0

