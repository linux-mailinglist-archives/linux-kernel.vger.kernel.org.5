Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64BE75A4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGTD25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:28:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3DF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:28:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666edfc50deso255979b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689823732; x=1692415732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOBPZEd7GO5bOVU93EomlLr6fy4u0fAwVai5NlTK4qI=;
        b=iun6+ASZGI0sU3iFgPFeqYBIT1wuJH7wIckALTtwON4eaY06xEGDnbZ8/AjOquEvUg
         B8zylO1anH8htwUTeRs4NOedNvOiz5VIdb3oXSoYSs+2RFz9LzSaVm1m4chwe5WOU6ug
         0+4Z3DQVPBzryOUCJXspHjs1UrQdbhvP9DbQuvMhcW+IbibzEVBr918jWczN0pJ+s7Y8
         rB1IX/JlW376iVheZvYTCKFRhy/3mtzms6ipmXybvmnL+eUh/sc1rZWX6SFg+AzFH6oR
         lvqGX0VYgiAWzXEQOB+q4mF2Aqx4x0Hfi0AeqmAlayGEpOipRjaV9xb11XyZYkquPBU4
         dalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689823732; x=1692415732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOBPZEd7GO5bOVU93EomlLr6fy4u0fAwVai5NlTK4qI=;
        b=WEWbTAbuLEJq5+hEjNjKEpPmFMqy50zzNUNLBC7D8WPrjoBDIcvjxjmXg8vOuZRWjO
         BVY7zBSyBAChflIID7gf2OmW/gN8tuZVs+pw6nErkN5ff85LobGURIq9ULpFZBi+al8P
         WdMO7gDnjASmkPngqSOhrSOpPtuhDRt7hEQWaWuckRr1Qbr0HwiWa95U+pcKgaKqo/ot
         Qhn6zPTLtJDJAvKi7qoRhO98P5N3tmCBYB+tHJ5eUTY75j8Tys9Mqv1hUJ1hqqFvbGJq
         TZo3QU6pOEzUTpZssCFy5fJQoSby2ly78cKuFG8XvC5WQ5snAu4rwCLdrtPHWZLFVCQM
         G9og==
X-Gm-Message-State: ABy/qLanf0JnN2J+T1cgRGdBRVVxE/s24lCbvXp+FXFmP6GYqieCsgLM
        KSNq09bXvpHBruzIbp+aygBxzLQ8m7c=
X-Google-Smtp-Source: APBJJlFxA/gzK44ZlbTOYuKv2CRVDPWSxBG2tC7PiQMre3UoqJobaYyu3RUYcad+Wl8jIM7QL76ACA==
X-Received: by 2002:a05:6a00:1988:b0:656:c971:951 with SMTP id d8-20020a056a00198800b00656c9710951mr6176601pfl.8.1689823731912;
        Wed, 19 Jul 2023 20:28:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7920f000000b006829b27f252sm14713pfo.93.2023.07.19.20.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 20:28:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] regmap: Disable locking for RBTREE and MAPLE unit tests
Date:   Wed, 19 Jul 2023 20:28:47 -0700
Message-Id: <20230720032848.1306349-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory
for regmap operations. This is incompatible with spinlock based locking
which is used for fast_io operations. Disable locking for the associated
unit tests to avoid lockdep splashes.

Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Fixes: 2238959b6ad2 ("regmap: Add some basic kunit tests")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/base/regmap/regmap-kunit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 24257aa9004d..9ff3018a46aa 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -58,6 +58,9 @@ static struct regmap *gen_regmap(struct regmap_config *config,
 	int i;
 	struct reg_default *defaults;
 
+	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
+					config->cache_type == REGCACHE_MAPLE;
+
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
@@ -889,6 +892,8 @@ static struct regmap *gen_raw_regmap(struct regmap_config *config,
 
 	config->cache_type = test_type->cache_type;
 	config->val_format_endian = test_type->val_endian;
+	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
+					config->cache_type == REGCACHE_MAPLE;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
-- 
2.39.2

