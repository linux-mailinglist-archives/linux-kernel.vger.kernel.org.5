Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7B7ACE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjIYCio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjIYCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2A136
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c0d329a8bso65663907b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609509; x=1696214309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJbsnopL5cu7DbnphUxyfvgHw2IoJrSW0tHSHF1oQbU=;
        b=Ztf+/RBK7/DfdKM716gDLwSs7CfJLsddLx3RMIR81Xu+HZvJj9IInORX4iMZfcGOv+
         URdbHltuvT4vKu2lNMfIorJcL6Hfup+ZQEGIhkPhZfJ7g375YdTte/rUE7bVnYsvWHTx
         p3IvWe3wS4zNA1ktV1a8uOvHsOJUc+mvG8HkIiX1XGAWu8pFqVGpZ9qhrK0sQQYq7QaQ
         WHxNwVZ1zbKoqYNfVsVwksqfgXwXjHKhBunZF7hbmFQaMld8ttNKhE1B0F9iq2wIk/uu
         g/j9UfejLRRR/7xNlnSRidbqBhxgr7Blc6gvI1nJonPZprtnuyYsVMfTuNWlW2NATbY2
         o+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609509; x=1696214309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJbsnopL5cu7DbnphUxyfvgHw2IoJrSW0tHSHF1oQbU=;
        b=xHNTDMRCYA4qx0t+2XDadJALWYScMDMCAnP6SeBQ8LXzFuQC2hsvD/gOtfRSJHjAiP
         L8ccJrEt7Yi2VtTY65yxNJj/nrvaYBcGGIcUGuMkm0hkzCxmeGiAj8O06/UKdxnMU9R0
         pBQmlgY1B6Xjj8Cv5Qs3yIeZmP5S1yK4RW84DozrB292fC5NdPb0LFStfcy7TGtwvckF
         lHKjg3+mU62q4404Tbe6cC0Y0pP/AZL3BCaAMhQuT15NGZH3aAeFKSq+aNUN7i2By7yA
         TXt9je1hYOTO7WSETympOMqukqO3DB07UrpSZgg3PEw4FvutEjoxYwEgYJM8YMYrnBuz
         w4rg==
X-Gm-Message-State: AOJu0Yzrkvy/X/4WG48ZD/r4XDKqdpd8XpGDrfCLp8u5iVnGS6eiNq/U
        +pojydbAvcqLIGKI1+1Gjw7q28u5BGE=
X-Google-Smtp-Source: AGHT+IHEdvAHT1bH+ey90Nwlvx2NR/b9T3G43eoC61WsR2z3FZurWPVSOhy2dPnRIRlNZotV9PHkNg==
X-Received: by 2002:a81:4958:0:b0:592:97c3:18d2 with SMTP id w85-20020a814958000000b0059297c318d2mr5260261ywa.15.1695609509188;
        Sun, 24 Sep 2023 19:38:29 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id i69-20020a819148000000b005869f734036sm2173971ywg.19.2023.09.24.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:28 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 5/8] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Sun, 24 Sep 2023 19:38:14 -0700
Message-Id: <20230925023817.782509-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925023817.782509-1-yury.norov@gmail.com>
References: <20230925023817.782509-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index a463125560c3..4dba15f2e970 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.39.2

