Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA477D6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjHOXhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbjHOXgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D903013E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdef6f5449so17154245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142606; x=1692747406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MXMbfduNsWvc77oRSmnPlmSNU8ovvpGLo9LCB6NzM8=;
        b=f4bbNFRmU22uvlvSDb+GZMtx292gUoyz2khtCihMj0eWPFC9DKPq4qUD6N8wQkhust
         zFKImYWZeuBEkjq/Yrbsqbl4ia1F3n5gtfyINCFU0rISryN3p7ye5nzuf/B1pNZ5WkKB
         /LTtdGWb6kPoY/sva0doQDTq8QyCe0lUoQY//NsWrAw1cY7Sn1QvqNpRTHxpkKejDHOJ
         +UYIlb3eEwlBWjqr/RE1eDs9nxSbpBcIgBad9IjWV8oKa1V6FIcL759x4nWfD6JwFkjf
         /LGtMOLfQzaVohrTzkvbtp3PwIGP1iHy2pbMheKVhopwlauYvtD/lnUnInmfDRVaHiJG
         W4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142606; x=1692747406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MXMbfduNsWvc77oRSmnPlmSNU8ovvpGLo9LCB6NzM8=;
        b=blfGHp+2/hB0D0JKb9PJOqExgWyb1EiZXDhiXQDOYUu0o6fhVpR4snNfY7vOx3QxVT
         3oBqTlROky81HfFYrrr6i5c3Vlvz2BTIUPUDF1y/F5cHY28K/rKwlSlmEiSzltVvwGua
         afT2S0H280LAQxt2LtLdwSlkT+/grJUIHWJ/fY0EkEdyzYLWJHLj0Xed8uEbih1+Paif
         ehZOdu147w7zrMMJiTS45QJCDSBpMIjazcWHs/aw6swpw35ZNxTZZACAtpcrrAZZV+cB
         Oqkdrk3heDgM1wsLEVGvoQX3Nxk2h6DSWreHYeSbNooCZdr05qDDdSijVWFBkSxxCct/
         CXJg==
X-Gm-Message-State: AOJu0YyspZEU3ZoTyH9rYCFvwftt4Ao5QyAJml4ey70RAZmu89x7KaQ6
        Oga6tRgyiZxN9/oVBymTRXCiDTpRX+4=
X-Google-Smtp-Source: AGHT+IERQ9IKfxQP2jKRd8x7EC9qE5L8ytRPOupRf9Ktwlv7jH/SIuvsBxYTvgK3N9BND7qGB7OuNQ==
X-Received: by 2002:a17:903:2796:b0:1b8:8223:8bdd with SMTP id jw22-20020a170903279600b001b882238bddmr355939plb.59.1692142605829;
        Tue, 15 Aug 2023 16:36:45 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b001bde6fa0a39sm4104226plg.167.2023.08.15.16.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:45 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 4/8] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Tue, 15 Aug 2023 16:36:24 -0700
Message-Id: <20230815233628.45016-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 4c9f119240cc..b7ea47b9f09d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1354,9 +1354,12 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
+	unsigned int len = BIT(order);
+
 	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 		return -EBUSY;
-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, len);
+	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-- 
2.39.2

