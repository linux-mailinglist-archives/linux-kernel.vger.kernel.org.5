Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37237ACE58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjIYCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjIYCie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:34 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614AE3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59bc956b029so65523557b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609506; x=1696214306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCnx4Q0U1bWkD4Ey4yVXOeEthgG/6U2DrPecvVm9aaU=;
        b=AD7KcBZOJNn5Uh+dOGb+nwfML0NTwgblZ+/qA/KtEpBtpNYAR4XjTbpS696piwZGnb
         vhKAALu+T3w5YBfLhla6Lu2TpvS1JJNfLhdyWgcx6to86v3a3tm6fs42avJpTCJ0xGS+
         8O3Q3o5ZTkvMkimPGstKA6AdTxo0/gXUnOF9/aTspuumBq+va+frFadb/Iv7I8Iv9In5
         1VK5JvRIvedkPOWwA69ThGAdmVvxVgNdxR8cUkwd2clsfjZWMXYFIHmA43/dF2P7RQ6g
         Q/o9mluvkCVXAO7KX8yxMUDTdWNfydDoFy9XXHg2/w6L58e2b8SFOTp83+verhmVH0d4
         M/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609506; x=1696214306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCnx4Q0U1bWkD4Ey4yVXOeEthgG/6U2DrPecvVm9aaU=;
        b=lJY0tVopqu1f3saQhkDdYvgprJbZPxgYNwyCjKG0F+SIpKkGqpnuDVci39+s0KSKmy
         vIsM/WlLIlsR2qKLaEZS6mvH1Y1IkFufjD/ldMZSdZVeizQA3yOPYtms8EhURACLcXLh
         1K5963dnfhBmj1dgy0ZzBxL7bRl1QciXrqSxhoUJ19SATfxl+SovaY0KS22mRHqyFLAz
         IGUVtZALuUEh4gTWAXTNbcWEkmRPsX6yXr+i18I9+7/wbZ4/h2f00gpzSm8LjnM2D5Vu
         C7GJ9NPu9H8I4hzasMKWGKmqTPDA9EE0fKA0lc07ihSnwsqKqXQxz9xhaBxI3hPuSu4E
         FfGQ==
X-Gm-Message-State: AOJu0YwYYN8jnnWfZvpw4emf6kECs74sr22AtVg83xnJvriFltB+puhp
        Opk50DtqHjHbHNNX97Vr9Sua1D2kL3Y=
X-Google-Smtp-Source: AGHT+IGxbMojuQk5LyFWvPbjY6wLmYFRlQk4J1JgMzhLjvw7soYqY5b0qphGC88Sbm5e7YmHQoIC4w==
X-Received: by 2002:a05:690c:3104:b0:59f:672a:ffd3 with SMTP id fb4-20020a05690c310400b0059f672affd3mr2385361ywb.21.1695609505916;
        Sun, 24 Sep 2023 19:38:25 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id t17-20020a818311000000b00589dbcf16cbsm2182481ywf.35.2023.09.24.19.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 3/8] bitmap: fix opencoded bitmap_allocate_region()
Date:   Sun, 24 Sep 2023 19:38:12 -0700
Message-Id: <20230925023817.782509-4-yury.norov@gmail.com>
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

bitmap_find_region() opencodes bitmap_allocate_region().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 421f2fc384f4..cb77b6b0e5e0 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1315,10 +1315,8 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
-			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
-		return pos;
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
 	}
 	return -ENOMEM;
 }
-- 
2.39.2

