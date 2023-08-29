Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73FF78BCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjH2CkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjH2Cj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29167CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a88e1a5286so2974199b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276764; x=1693881564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxHdr7gJ1K3Uc14nC1QOYk1MzYVSa0hY81XoEGmet+8=;
        b=WgLyd2LCehbhZ9P2jI5WAJFV2QrsAkYNbo6sHozidJCCjFgEW5/mj1vtarfKeRLRxl
         cqbzH0ihKyFWzvr/pILWt7lwQBDENYfhTZc2mCS9hn9IZOSY4zWU+ohgJs1nvm3J5mTA
         hZ5vV2Hr8LJa9rqM14nuNAxZuVYSJykpWCOHO/qX6J8Bu0fHpwIH6U9Ad6hcx9fpxNxY
         mQXY0xZIis7S4Ogxr4hELGs0HX4gVCYT8m8l29+H6XImXZaTGcyyS7QFw8DPpdRjaBEH
         6Rb07daNwOQ+YvsjFv5AMGZKCFMFwhNOtbo2Dmi/Pjf7Rjp99ACthuTFDF/r0cKrGbbM
         Pqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276764; x=1693881564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxHdr7gJ1K3Uc14nC1QOYk1MzYVSa0hY81XoEGmet+8=;
        b=GWknDV8mw/KXBgpqrHayFw/H3LwcQtx5ugYQecBlS7szLHMUhAspBzztatNx6Rm7g+
         rCn5nJHvmTaioanBJFYPpVpaSALHK68SX5Qo1EeWzU+kbkc5AezbV6FBeEeIQsu9rlQ+
         f03SgxIejAOQdIcWjpHGvMTzzKQl6x+NywfHZRzQdvVgrlCBllkWRnHo4HFLXWmd/BkE
         F2ZOSUMdIB4uifTr9Gx5sqI9D/QAflMIsTp/jq/W/3puA4vHjGa2R7865QkG54gVEAKD
         io7FGfLaAimAsPtso2M+/PZS7s491dBftm9hNOuZMkN4EmsRmcjyOQgtJ/bDzAfHuZ3g
         1tFg==
X-Gm-Message-State: AOJu0YxoIFfltmScLDg5pzNrrEIpIj1ZTYfQixeL9BERcWyJtMfs2qCu
        WzXD4AsjkqRd1etxnLySsJsGuCTXwLQ=
X-Google-Smtp-Source: AGHT+IEAqCdyyfSqOP1+x1XT50fcC0rJqAdABE34AT4toXxNsIpZmwupDCWFDx6Z29wBN+hLlSYIRg==
X-Received: by 2002:a05:6808:f91:b0:3a7:4876:6044 with SMTP id o17-20020a0568080f9100b003a748766044mr14754473oiw.52.1693276764105;
        Mon, 28 Aug 2023 19:39:24 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id q12-20020a056808200c00b003a89019d5fesm4028275oiw.51.2023.08.28.19.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:23 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 6/8] bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
Date:   Mon, 28 Aug 2023 19:39:09 -0700
Message-Id: <20230829023911.64335-7-yury.norov@gmail.com>
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

_reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
Doing that opens room for potential small_const_nbits() optimization.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 56595ce513f5..c94340c4ba86 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1352,7 +1352,7 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int len = BIT(order);
 
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, len);
 	return 0;
-- 
2.39.2

