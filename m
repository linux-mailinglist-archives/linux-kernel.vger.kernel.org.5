Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4778392E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjHVFTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHVFTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:19:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5958DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:19:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8b2d6784so60234587b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692681589; x=1693286389;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xunZavdtzjWt01wC1liiJk4wBcvrULtLqNfhy014qNU=;
        b=rkHhc7WKUcOMHjlY8RyBSC2krnfGkUy//kcCShbQusjC8mAbLwFKsyXNJ5l2WO7HIj
         3VBSMt+T/NHvQnUR8vT7mFZRKE+VqRQFbkZ/iXnps8N6z8kOtDmpCHICT+wgzkyMIIo5
         HG1TMbKY+SH7A7inrcpi2K7fvCG4FgwGMTZfIQuwCRf+rAcCWeaDh8uyPfyMaVRjU1io
         QE+D+k9QNdp6oOH0kPFc6z+61zTOSMa6riIQO92/8+6yDOH0+p06JA/52GL6wBsyXfBd
         T4jsI4MuZYG1METEP/nKOleTx7YeQwaCfbbvmUL71Uh9kMXUOee0dz6Tv+lp2IuoLXT3
         1jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692681589; x=1693286389;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xunZavdtzjWt01wC1liiJk4wBcvrULtLqNfhy014qNU=;
        b=G/3gM+plM0o7H1oE+34kfEiZA0z/3nJS4nEEoeQLe22YrOoI5hfdrwBzdClabJg94T
         uY1790+Os3vy3n0a14sIQ0+xtiamZmoDX0xfDe7Q6LRwtTSlSUWQi1KA5Rf+VHEgz5Uf
         hkdKA0FDgzCv4qkqB8goQE2DouZ4O20Tr1WnS8J/ANW1StJnPkhBjdq0vkOvyPxoqq/A
         atU5dAQtJhnnF56bq8klWvBcOGdMxLwRx6Hjpd3ks2jPxMRzVswuOuzZ8zAJM/K33xO7
         gHjSvKnJol5e5POhCI8cKNZDrtj/KgdoF3yDScGq+GAj8nnRJRdd2+wsH1xwE81oilpI
         AP1Q==
X-Gm-Message-State: AOJu0YxqbnWKCGuzpIYLivev0VzgkYSTvxQXLe//9DwrYt+TNF3gWzIi
        560xQI7KAX90FXm1B++klsnsq4XH86h48Yrxyss=
X-Google-Smtp-Source: AGHT+IF5G8ksHuUSIQRak/vPBr8Iztca28dWLuc+zQekjuE7jRbspllhQUu6SQDizDotRsqiawmOOK3GhE/WHqTJyoc=
X-Received: from anikett.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2551])
 (user=aniketmaurya job=sendgmr) by 2002:a25:41c1:0:b0:d4f:638b:d806 with SMTP
 id o184-20020a2541c1000000b00d4f638bd806mr71733yba.8.1692681589061; Mon, 21
 Aug 2023 22:19:49 -0700 (PDT)
Date:   Tue, 22 Aug 2023 05:19:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822051938.2852567-1-aniketmaurya@google.com>
Subject: [PATCH] i3c: master: Fix SETDASA process
From:   Aniket <aniketmaurya@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        joychakr@google.com, manugautam@google.com,
        Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a I3C DT node has a static_addr and an init_dyn_addr,the
init_dyn_addr is reserved in i3c_master_bus_init() and then
the static_addr is reserved in i3c_master_early_i3c_dev_add().
But if the dynamic address is same as static then above
procedure would fail.
Add a check to pass i3c_bus_get_addr_slot_status() when static
and dynamic address are equal.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a7800..87283e4a4607 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1308,7 +1308,11 @@ static int i3c_master_get_i3c_addrs(struct i3c_dev_desc *dev)
 	if (dev->info.static_addr) {
 		status = i3c_bus_get_addr_slot_status(&master->bus,
 						      dev->info.static_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
+		/* Since static address and assigned dynamic address can be
+		 * equal, allow this case to pass.
+		 */
+		if (status != I3C_ADDR_SLOT_FREE &&
+		    dev->info.static_addr != dev->boardinfo->init_dyn_addr)
 			return -EBUSY;
 
 		i3c_bus_set_addr_slot_status(&master->bus,
-- 
2.42.0.rc1.204.g551eb34607-goog

