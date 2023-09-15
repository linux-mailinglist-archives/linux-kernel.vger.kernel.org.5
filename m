Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC07A27D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbjIOUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjIOUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B03C2D45
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2325570b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808757; x=1695413557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrBmIK/7ZBFkfIJ+GoT9lofYoxjkLNz9RY+nH/vRJ5g=;
        b=Hyr26EoDc/3IqnsEj1f949dN52APUFRos05grk0rf4AGJZyPtHznjIR0CTCS/4+cRq
         VojOdZpad9u5YDfvohFTxfkmMdvB2fKfgH5WjVYcHZg4mHkXTFDj1JJ2uPBcf8fpK1Ur
         4hW9SjKDO9ijB/O5yVg825VstCzoqYWSOmFyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808757; x=1695413557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrBmIK/7ZBFkfIJ+GoT9lofYoxjkLNz9RY+nH/vRJ5g=;
        b=GbRoO05mjISOZEHqXKy6/NNXqT0/zXkDxCwTAIGrSjpXthCnfBUAW7jU7bNUOpB3Te
         QjtaC7YSYmH+49Dh7q4Lu2HAicVqP/xKMOrPeF1PwD6E8LscVsjkLBLM6fLYOQkwKaQR
         mOdbNj8/3C6tMT6aIL2Kx+71xUNcA0CMEelc9srvK9b2MESvaeHbAbpeZmiGqRRstrBn
         pGg5L5q9UoXbW+Swgbk31M6rFXmVjU/rj7DcTODolHr0aVXOZt9dohWYd2bERmzmcJIx
         3zfPHIkPERXd+uzheMrJnzkxn9dCN14ktTIQgyrgja7+8DbobjIxOKG60QCDS9RM/iQB
         xE1A==
X-Gm-Message-State: AOJu0Yw9q5J+CCJlTP7aDL0X2OaB7qI5GAB3sqJXOetjKE9481q5dvEd
        BGVTfDxEf+nooa65nKM9KTbXtw==
X-Google-Smtp-Source: AGHT+IHaSepHftYvn6j1J/8NjB2sQp1S0SXdFatkZesmqR96Dm0a8qXQYyp/030E766wL+sQ438gNQ==
X-Received: by 2002:a05:6a00:1490:b0:690:454a:dc7b with SMTP id v16-20020a056a00149000b00690454adc7bmr3035526pfu.28.1694808757000;
        Fri, 15 Sep 2023 13:12:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k192-20020a636fc9000000b0055bf13811f5sm2994033pgc.15.2023.09.15.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: ingenic: Annotate struct ingenic_nfc with __counted_by
Date:   Fri, 15 Sep 2023 13:12:35 -0700
Message-Id: <20230915201234.never.868-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=keescook@chromium.org;
 h=from:subject:message-id; bh=u7N1dQwnfrzLeR4rYuLcrvgfoIzHpMlv8osLJuSY2+Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqzjowlIzJmYXlgsM3m8LT0SCSdfQTsxoB/i
 acbRSZ+5eeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6swAKCRCJcvTf3G3A
 JsI5EACJLga/jCgx7S0K+M8EI9/HpJJsQ4twNYBlge15BlTjzWL6+s3zgE5f7UOcVRpkq67GHb+
 FeToD49bp07c9OF4Y2xbpjHB/lYhHing/bv51pliDDUlQLsWicGBOoaC2GT6lwt4fwpqSDtOa9A
 TA8a1qAJT9wj2WwiEU0Zj8IG49xkuILQt2a6r/pd5AgQQa/FUwVr15kSK7RmRRBejWggW+3rhCa
 rSgdqJU36g/RBkZcBEQHdRUimIo0VAeZ9ksIsMsxNhv3mxG4m9PXWkwjhDvGrmx+oK7OKRoTu2k
 2b37q/dOck12rVK7Zp7OSOXKN09n1QsFSsw20fa4OPreJeAcpFZMJIJPaMZoNvIrcK6RFg0WJQ1
 pDaE7yH8U+FQPEIKFguHdPM1dKoDzLxtbmLgyIguyoTQr5el7bk3wxn8X53JOGpA24BQxsHR8nL
 WygbnLNvYhmDscT7wuWQ8ROnjn25sZUe5TZsLWij0dZdYprGIOy7I5CNhKmP0M3znYsHEJG4/Fh
 kk175ctq9KqoZmyeJFNBddnk+nbM0Cve21DvPxLyd2Al1nEp8yF9gZzqm6fHeT560E3Vg88ih4b
 YvODs23KDa5lanCSm99HJ7GXcQAXIj3w2WYkXFMQXl7bUZ+xamamKcWJeD14/oVwjqAkI2rGARw
 G1gmn7q 2KMQ5WVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ingenic_nfc.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 6748226b8bd1..ce9ef4e65597 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -46,7 +46,7 @@ struct ingenic_nfc {
 	struct nand_controller controller;
 	unsigned int num_banks;
 	struct list_head chips;
-	struct ingenic_nand_cs cs[];
+	struct ingenic_nand_cs cs[] __counted_by(num_banks);
 };
 
 struct ingenic_nand {
-- 
2.34.1

