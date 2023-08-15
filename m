Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662877D6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbjHOXhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjHOXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5613E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6887059f121so725774b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142612; x=1692747412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiYOATL4Yt0CXg+oEOLFMOCykgPiyRQW/lZP421Tl8g=;
        b=oyAmxVZ1Vfx8ISf3Ltk9F9p2m4nKztfLvmNcmi5JJfPy3lBwel5j8bD8e8bJg7wlDm
         ob91Eh8fK9lcs7DPYRuDODy4O7di3Cgxj038h67hePvpRDttH9ZLtSYMaszMa00YEEM4
         Yb1657fmOqvlQ4Eot9UDUZkUffLewAsXXlNKQZ7FwuCFFGZSK4aTaU2D2TkkPXG3a3GW
         HtSjCFWvGmradvjPXRk+JMTNHJGQdKJh46rGoV1NZPKnjcE4a37IAryZmtTj3IDCsMYH
         m27C7Zl2vtOiTvDc9WbGvT4U0Qm9pWfnevpG1OwTTspJZ5KSL7hXZVZ97dme0vnCE0ZF
         U1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142612; x=1692747412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiYOATL4Yt0CXg+oEOLFMOCykgPiyRQW/lZP421Tl8g=;
        b=dLKO7aqvcxIm0OOD7m6TtSkIxHB5MdWZsu2qya6JzFfa0K5PkI5C9uKKr+421eWIja
         BUWKQ1ZXqik2tiVTh9jUnv5qcLWDreiJCe3BHAvhL92EbWb33HuhJ7DYhBbOsEuN7sij
         IzKwVcuzfJq4709epHI+f3ypPwiqKEXGPDp0aJF8CPtXa3550gs0yIVm8no68NbwXoRK
         tmKefKLwTeVMLm8DsGh/6rVJLRNLzbEyugLgOWinUsVaYpuxpK4cAye23do38yU8Q42+
         aewjjIGiST9tpvmhXdUK1F3RVZU6A7UsYDu/Cv3RFPVEM9C4+xPjn30rxwmFdC5zAKSL
         ADNQ==
X-Gm-Message-State: AOJu0YzKw5b3gOONtwQTJfYL06xuI3jaHikjKe8P+LIHi+Q1B6Yfv1uv
        CCv23hv36+ihdLF0TUcs6weOdydmDIM=
X-Google-Smtp-Source: AGHT+IGw3e3HBJ3B2RxSt5fec/v+xG1BnUI9IMBKv0mv9x9Q79spXvimRIHSZd70+JUCn0raG+6trQ==
X-Received: by 2002:a05:6a00:1393:b0:668:69fa:f791 with SMTP id t19-20020a056a00139300b0066869faf791mr279325pfg.3.1692142611977;
        Tue, 15 Aug 2023 16:36:51 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78492000000b00673e652985bsm9823073pfn.118.2023.08.15.16.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:51 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 6/8] bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
Date:   Tue, 15 Aug 2023 16:36:26 -0700
Message-Id: <20230815233628.45016-7-yury.norov@gmail.com>
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

_reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
Doing that opens room for potential small_const_nbits() optimization.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2898ec2bdef1..c29140e27d20 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1356,7 +1356,7 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int len = BIT(order);
 
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, len);
 	return 0;
-- 
2.39.2

