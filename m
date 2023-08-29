Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310878BCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjH2CkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjH2Cj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C0CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a8506f5b73so2807441b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276762; x=1693881562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScVDkb9hH2uA/Tte+J+EKjScTHH6zU1pOaL5akYS0lo=;
        b=n5xTVdjVTaUVS1MCywVkwZ/7PX31UR+R9X6SnSG4h0DRpAAME8Oms8NeQAFzO+p8w3
         rFp0D/hy4rVze5qXKg8y8sKmWV4W3j2FZN76MzYIFZM0h81U8Qy97qC0FJ80UZUaR41u
         BKSc8lP/o8wYRWgfyZ1M7WfMz+2alvvTxRa3ZVBPioWe/93DrQbLpWDK5G5gLyo47LUk
         U5fKMpkG8Ofi9KFmgXdKJINs6REpu7P8XWDVeapL7mJrC+uTm89aDwL7d2kev2JGfY6m
         lPQZ3czelBAbNJe/4TftxJo2H+mAO20BkQ1FdjtaiHFnKqrhy/+AwLYqFlBwQHmSD0O+
         gj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276762; x=1693881562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScVDkb9hH2uA/Tte+J+EKjScTHH6zU1pOaL5akYS0lo=;
        b=EnrfsAauCjpEoWdGqcWD7rVuXf4I+It8q8MRcThKxHz8zhaCa8OH6Ws1Xsyhv2oaWX
         OsbnIn5YLmQ0QrO7ySrSh+QqxUGdCXrRVtkUwtZRA8APqdosKGEi3BjCxOmeOtfnMB0s
         /1HHI7xnLTLOrYewP0E26jEZrWwRNniV1Vln9qb+6EQ6qQTpWliAWctiwHIFYFRZbfYP
         8kSYI/WokXWVpz8wC25+caCCJu+yNKSUplKfvI8Og/AQunuvjhBDJfPjFW+OKlYSz24B
         CtvvCFT0G95kCL6AR8vcBI3hudGwNjdVUFkP3/ObM1mk78pmv64ps1c7CIK/jA6cMWyE
         t6uQ==
X-Gm-Message-State: AOJu0Yw4KTBSwMOvfnm+qcXqe5DdDpgH2rrjNreFGUgHSUNuc9A3XT5N
        yJZmavn97Jdb69o9pp6BAkpZNtvRXgs=
X-Google-Smtp-Source: AGHT+IFRGENj1ra4fF4Djf04NbfElx/VkQZv1DCZrB3q0FHakUiW0DXGTb8PA9D7tG5N55saKjudqw==
X-Received: by 2002:a05:6808:df4:b0:3a7:725f:476b with SMTP id g52-20020a0568080df400b003a7725f476bmr11845657oic.41.1693276762447;
        Mon, 28 Aug 2023 19:39:22 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id z8-20020a056808064800b003a3860b375esm4046099oih.34.2023.08.28.19.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 5/8] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Mon, 28 Aug 2023 19:39:08 -0700
Message-Id: <20230829023911.64335-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear().

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0fabcb0e4628..56595ce513f5 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, pos + BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.39.2

