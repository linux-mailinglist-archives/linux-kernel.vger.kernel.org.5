Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DC7D6C83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjJYM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:58:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF88F;
        Wed, 25 Oct 2023 05:58:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bee11456baso4687075b3a.1;
        Wed, 25 Oct 2023 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698238698; x=1698843498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKssY7Y5qZz0OjqP1oL2c2x0KaPXiTplfs3rAHRoWHo=;
        b=aKlyC7l0aeU1CzVhbaLifyAmyWafC0vrRpl50KSlZ+3AuJoOtwfG7i75cWu4+JA1el
         +05p9yu818kP1XxGsynmic5BdJU/yv48eu5ajmCLaWWDhr+pEaSVBK2MHcas0Zjavd0+
         cfPSafc5SwrsTtXcN5VN4UT/nchAKb33qWSHqQn/aNIVeOkXTnsMdxLZtl+NTvd75/ns
         zcC2Q16itKDBr0JfgE3aWk5TqZrtFS1DPxBj+0OgJy0hK+YoNCi6d+cCEF+QQbyvUWnN
         Fa4CQCE0ppnkPwbGKkQ8itmVLTxTyN6E/hZHp/SoGdcfRIFVCI8E6+PAWhi6OPZrWoF8
         GXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238698; x=1698843498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKssY7Y5qZz0OjqP1oL2c2x0KaPXiTplfs3rAHRoWHo=;
        b=HHLCuTrJkaM+9/DLKU8F1iIj+8wtnb4jqxRz+IHv4BiCXhOJdycM1o0RI8evtITUXy
         XcvWZs8squkQ1zZYHFCtVe0nG2vWPk0MyEeMzKSjSeG+hvcflwWsFQUTF71CUOh1kXou
         B5TkvXasUN0nwpkmjF9pfDeJETDCKZugXcOaFY7N4M5HZVEAgkA7W9I1DFBGzKrPXmes
         jYLyoGZlsi+fTRoVoJP3LAjZBwhGY5YSkvjG2/gU99FawHkNlCYEZYrWgBgwm21qTv/d
         8UZmz4Y8kQzfypuLLxPKuMBGjcNz7roOKSZk889CqUwWiyQ7R6qEOoyNKaia8qGba0l6
         /abQ==
X-Gm-Message-State: AOJu0YyoHFSjlWruMS01e2wqOs4qALbpY6zLLr2vQjg6RZS20P1PLbZ0
        uU50WtgENkNMkMGo4C0VybHw/bvP3h5rZKD+
X-Google-Smtp-Source: AGHT+IF7u5zOkI2ZSeBYv1Vmh8U1NKHmyEJN2pzxKcBcv2+dRSJ2rJqN/f/ETo8o4HFp2LeHuAeU0A==
X-Received: by 2002:a05:6a21:1c82:b0:172:f4e:5104 with SMTP id sf2-20020a056a211c8200b001720f4e5104mr4521846pzb.20.1698238697699;
        Wed, 25 Oct 2023 05:58:17 -0700 (PDT)
Received: from sagar-virtual-machine.localdomain ([103.70.144.216])
        by smtp.gmail.com with ESMTPSA id a3-20020a655c83000000b005b3cc663c8csm7402302pgt.21.2023.10.25.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:58:17 -0700 (PDT)
From:   Sagar Vashnav <sagarvashnav72427@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sagarvashnav72427@gmail.com
Subject: [PATCH] lib/crypto/aesgcm.c:add kernel docs for aesgcm_mac
Date:   Wed, 25 Oct 2023 08:57:07 -0400
Message-Id: <20231025125708.20645-1-sagarvashnav72427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel documentation for the aesgcm_mac.
This function generates the authentication tag using the AES-GCM algorithm.

Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>
---
 lib/crypto/aesgcm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/crypto/aesgcm.c b/lib/crypto/aesgcm.c
index c632d6e17..eb55cc57a 100644
--- a/lib/crypto/aesgcm.c
+++ b/lib/crypto/aesgcm.c
@@ -73,6 +73,19 @@ static void aesgcm_ghash(be128 *ghash, const be128 *key, const void *src,
 	}
 }
 
+/**
+ * aesgcm_mac - Generates the authentication tag using AES-GCM algorithm.
+ * @ctx: The data structure that will hold the AES-GCM key schedule
+ * @src: The input source data.
+ * @src_len: Length of the source data.
+ * @assoc: Points to the associated data.
+ * @assoc_len: Length of the associated data values.
+ * @ctr: Points to the counter value.
+ * @authtag: The output buffer for the authentication tag.
+ *
+ * It takes in the AES-GCM context, source data, associated data, counter value,
+ * and an output buffer for the authentication tag.
+ */
 static void aesgcm_mac(const struct aesgcm_ctx *ctx, const u8 *src, int src_len,
 		       const u8 *assoc, int assoc_len, __be32 *ctr, u8 *authtag)
 {
-- 
2.34.1

