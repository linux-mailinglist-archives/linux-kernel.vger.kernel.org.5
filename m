Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E687A27D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjIOUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbjIOUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CE2D67
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:13:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso21426825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808783; x=1695413583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M49lx0SrOSxw3SwYD5z4lDni11acdMA1KrbMre3cHA=;
        b=DY1mxFbh8oyQBVBSke3Qb3cDb5AdkNpTTL1bcxjv+x1t6TPMJMi8fyr/nVJ44TkzTm
         onrDJs+HnHbP5r8UOkkS3f1+mzKAebSq2o3C+mcjbnzHjLrhmpGWDhWguudCnCncMsZ3
         /PTs10DvWPeS7bomZ650s7kYIkMcZ2lWPexlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808783; x=1695413583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M49lx0SrOSxw3SwYD5z4lDni11acdMA1KrbMre3cHA=;
        b=m+JbmTnEvT6UzkQyDuLqFESSVQmFkFuMLtZKvLtGTj1wL73rGge5j/km7KsM+jdfUh
         FgPr3UYInz1E4UtCpVmxy3SI2dfe5FVFAZ7G/wumQiAoB0JYpsha/zmWWb2SoYEc1/Q9
         74RUT3loqNvsX1TfCA9fdIuKSiWKAd4XhkiV6xuphFdVFXlfoRbOykOETgdyIlgitKw7
         GUD3prU78MIAxkBwrbwPeBOep7P2y6N53CsQoESsvng4xG0fp46EkyQznAqTjkWt2BJj
         bEyLnwTuPaABSjLyEFfzI15lZWkoYJ1TRT77TBYOJlzchZal0BqlElLXrrxRiJKGvsPF
         sSoQ==
X-Gm-Message-State: AOJu0Ywngm6Vm70PBSSow5ted07ITMlRFo6HGwm+DAJtqXDhoMROrboc
        +kSaz8QKxhvgVCDOHrnL/LhHWA==
X-Google-Smtp-Source: AGHT+IHmJsBEHRSFwHd9H6oVJRsl62rZFBTkjbPN1AjmLjm/eZ5VnEB4AJ5MbrK8A+rBSdegqn0n2A==
X-Received: by 2002:a17:902:db08:b0:1be:1fc:8ce0 with SMTP id m8-20020a170902db0800b001be01fc8ce0mr3734260plx.12.1694808782967;
        Fri, 15 Sep 2023 13:13:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001bdd512df9csm218663plb.74.2023.09.15.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:13:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Manuel Dipolt <mdipolt@robart.cc>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: sunxi: Annotate struct sunxi_nand_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:13:01 -0700
Message-Id: <20230915201300.never.057-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=keescook@chromium.org;
 h=from:subject:message-id; bh=9LgHW2ESmAWnpC8VkPKIjSNhD9+xewvO1BU6xLYCYys=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLrN7bH2fSvx7Pk5xVsFyM9ZP63U7SCER0Gx/
 1a7bYV9DdCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6zQAKCRCJcvTf3G3A
 JjKID/9gXg8w66qZfCGmvAX8Ub+SGXwCmA3YOfUDES+znbHz9/CripNvDDfLLhe5EVL5h3kJO6m
 35FkrSXVpHWljoV3QAOyH34CLD+X7WoBY2hQCne3oLauVtJFKYHDi+1xiM60MUD1cJm+7bbrPJR
 Ywyhs6nkYn/yLxhuQB0Fg1lA7qfOoQSt/ZGI/pRPV9ehSOb6n0owmVEYm1v+VZjAxzACRWjjEzJ
 +MmwR6qVCBlwlOD/h9f+V0KeODYE1O4HuqtBZSp8eTEEP1kjtc92Zh+EPRzpvDwywIzQFygFFgU
 R5CTNEBEP+5eUFeKYDnan3QUhZzTJnNk5c9NXJ3lpIe9/q204g/M2+fpbPFY1UGEagTqKyI43tG
 eh/NDIHf3zTaM5cZpHL++wvYoz1PzEpxmgQMhi/gkJKk8p9LixpYEHQx1WGSlvkbLs22CqHGZB0
 +qB8wd1Rlxqkds0B9k3Nm73iul/qPyRkx82+hWrle4r77c4F0aMZyQJx1sSZXAL74oUSuZ2n14m
 /04J/LRUq8a/BALl+3ZyJVurqFg5w7rtQEcqho0TVyRT8YEn9PvICX4HaJwQuPcfk7mY79YwlIv
 qzUUZprHpLJZTbfjJvdTAgUje2fPni05Ab33Ntka+sBFJpOgRhy66zEWzU5ChzUyC4SK2vfYD4t
 b0+mhO7 VDdYbzZw==
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

As found with Coccinelle[1], add __counted_by for struct sunxi_nand_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Manuel Dipolt <mdipolt@robart.cc>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9abf38049d35..4ec17c8bce5a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -197,7 +197,7 @@ struct sunxi_nand_chip {
 	u32 timing_cfg;
 	u32 timing_ctl;
 	int nsels;
-	struct sunxi_nand_chip_sel sels[];
+	struct sunxi_nand_chip_sel sels[] __counted_by(nsels);
 };
 
 static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
-- 
2.34.1

