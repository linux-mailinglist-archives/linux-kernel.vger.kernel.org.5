Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8EB7ACE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjIYCin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjIYCij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80010C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:28 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d867acf14aeso2962075276.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609507; x=1696214307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2/iJp7YEu8PdZMEKuCIEse1RbUYsD5fSdjQh+4BcHk=;
        b=NtbkgJiVXkxa5m4QMqJ+LE7r/IMz2j+MPCXDH5+R2ZbD7ZAvDVe/11vpaR8DZKX7/x
         CJ5RHLbuFOU4h4lNVlTtdLePWgph0NNFd5/NidOVpMTm9IGZlrQETf+VN5Q0rh8DxsLQ
         XjvVo1SANZRCwX7pjBTZQpTE467UqBf/Az8Cd0xoZ9MsSAxwrosiFQrJrNne09WJQz3O
         y1opvf2iopJN+UVpsZ7Pub2ob98qiouXy5trxtJNLObju6mLYAHuy0n4NVhrWVlmMBx+
         lYUAoznPC/2UpD+S7B+2V7DKNT3x1KPc8CdAHiekHBEEeSbFNf75hva4nKxoCT3gihu/
         231A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609507; x=1696214307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2/iJp7YEu8PdZMEKuCIEse1RbUYsD5fSdjQh+4BcHk=;
        b=kJZGV3UyWyEojrPtfcuKug8LFlUeRIvpMUrohAMsBu9L7kaoaa4+bnfuuYuOpX0bLi
         L0g4EABMhTm6rVgZ3THg0fE7FJsrc0DmiVJ11DpAflBYyCfflqNO+Qu1zZVgXQAMeZks
         25XenBaLb1w3eibPE6JsVqC6HuZ4hAbz+oPPY1pYFGAkOlWFpr+TRuJzQfYizYYu6RT7
         l2XmPHPU/aB5r9vNmJa2DyB1Zm9Aos6r0txsoWuiS60ZoztvnkeFx0ZIB7nARrIpuMDF
         WoMbNMCfHll7WoQ0mSq+ndfkzsOx2Ayj+Ss2/kcgtAhhiv7x7uoqZkNzpXVFt/HVWjYK
         egSQ==
X-Gm-Message-State: AOJu0YyKA7t+HdPX0tgwSw57Zzyw9uYwXn6+gimwjpsW2nzx9liiaffC
        7eGQTTOatLWxfuzbUxVXacMBh6Qcm7k=
X-Google-Smtp-Source: AGHT+IECTl2sgU+j7IFSg6WmIHV60AB8YagBC945Ygd7a+AfT25UcyZXW/nes8sm96kOdINx9U6FMQ==
X-Received: by 2002:a25:aae9:0:b0:d86:66fc:eb19 with SMTP id t96-20020a25aae9000000b00d8666fceb19mr3600356ybi.19.1695609507450;
        Sun, 24 Sep 2023 19:38:27 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id q7-20020a5b0f87000000b00d749efa85a1sm1921876ybh.41.2023.09.24.19.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 4/8] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Sun, 24 Sep 2023 19:38:13 -0700
Message-Id: <20230925023817.782509-5-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index cb77b6b0e5e0..a463125560c3 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1350,9 +1350,12 @@ EXPORT_SYMBOL(bitmap_release_region);
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

