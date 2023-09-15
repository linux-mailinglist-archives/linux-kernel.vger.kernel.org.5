Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B787A27CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjIOUNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjIOUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF382D71
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso2122999b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808742; x=1695413542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgir45P8c3Pig3O82d5C6ZtsdrQshUxHqzUl7LRBJ8=;
        b=JnSLagM2GJ/sivdTHmyoopz72F+W5Iem9lwet38/5o8TTRnue6roVp6C2v2YvVMq2L
         6gwOK4CPBIY77WwXwSCb7T1Fzqsel1doLmTZVmOELiplWOqlcwgO8Y4nepFndJMAwDTd
         wBwVSrNxI+jpXiegtIJp7i5q44KX1Yw/IDdbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808742; x=1695413542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbgir45P8c3Pig3O82d5C6ZtsdrQshUxHqzUl7LRBJ8=;
        b=ugWufxK6EA6u/ehIyFGLdESoCbjNWiXttGL9kavrqFl9oeoHXGVCwszNfeFfJPTKF6
         xRLh2kDY7VFJlXCdK//277+3m2f7jsng7vqfX4Hp+i2m/kfmpO5iGkmXqxJDTt3doqaU
         yb6dzXyXWMJtD5S3ISwXoY4VdR8i64obiB8Ou+Y0QtIpZOURCeInC1iM4VyCjrYr7yYc
         KASH5/ez+BIY62IA32cIx0xdcyINsfAidil0QogJaspAltPYUEJ9nfLpJDnkEtWp/Fk7
         msqmUh5ESAOzRZ9vMhDOita2/y9zVmXT2OLtTrEmrkuY6PerhxNe5anYo7r1DhnU8onW
         OyBA==
X-Gm-Message-State: AOJu0YydTf6igKNSOinVEWhMn3oLb8ILOcXrg0TlnegnzrKo5vLOVK74
        BQvyb+7FQYClwUSxTr1CvKKooA==
X-Google-Smtp-Source: AGHT+IFhBgyUlPiD5xyzulG3JBRm1U+iu40tZkfPFsrc4zrlynDTyADHna0tENdTjWY4mEIPQKAfVA==
X-Received: by 2002:a05:6a20:160e:b0:14b:887a:6d70 with SMTP id l14-20020a056a20160e00b0014b887a6d70mr3499753pzj.15.1694808742247;
        Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b0068c6e666066sm3327765pfi.111.2023.09.15.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: atmel: Annotate struct atmel_nand with __counted_by
Date:   Fri, 15 Sep 2023 13:12:20 -0700
Message-Id: <20230915201219.never.352-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Tdr7pAr2Wb4/8w/gmPSQOqizdA4eTmvQlqS8OoRKddg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqkv2XZPgk3DLyZFw3FAR71jSeYJBJnbdcTE
 k2PsyMAmBKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6pAAKCRCJcvTf3G3A
 JoNrD/9bXYCBxADrZNHe5KYuXZa2MpAe6bX4jbfGcBcOh/Ugaq5DHdiRZ1029txqS953Eg+J7pJ
 4a2Ae0PAfgHBWg+DTNZgpFuZdZVjmmA+C2Jek1oRG9j1sOPzK5g3dEKzqM0T3SCSG9ltaBGAaXB
 4mJ4oJVZsywrSPmpnBsHloni/CITMF65he+pl9MzG+gt8XiGtiVO9x82Ja5P+VDx3HnlQtkfvwJ
 uiZaJb0o3mZArnjWMPTMzx5Vr8FDd1RgiqgfdCuANBN9rBs4ZPZKbqK6dHz3KMLFxw34Vs9g5DW
 QL1OeYO/nsO9COQqGEG+Eju7ASKKedTGsFLqzdxxeORZre7+qJJkxSs/UcA8DHWkYS/HpZtvLtF
 BSBdlZHteJ/HlYfTPTWd/jIBjFsSdRUkKzIgDb4BPhSyHbrZ0jKOCs79l2Fk9mhZ+7DpLh83VpG
 lnaDwD5gbMFG6RFosKr+j2LMBNcqtLSNBJC57ZcgvECQNgGy3oFq+m0Mne3Sg68G3TnakTjFtI0
 lFmUUvubrfVj6jPZfm113wYcvENBIVGjC59zqFpg4AUbAOpULsLLbf4ihMaxOXG2yCI6Nb8bnRT
 tUygiBi5+DcAgoQCg4tO393PtyIKRx54A5CsFCeC8iCVwKqdd+FnSBzCCQOZkxU93X7wLijiaWp
 EOhkDTw GDHW+fKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct atmel_nand.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 3f494f7c7ecb..4cb478bbee4a 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -165,7 +165,7 @@ struct atmel_nand {
 	struct atmel_pmecc_user *pmecc;
 	struct gpio_desc *cdgpio;
 	int numcs;
-	struct atmel_nand_cs cs[];
+	struct atmel_nand_cs cs[] __counted_by(numcs);
 };
 
 static inline struct atmel_nand *to_atmel_nand(struct nand_chip *chip)
-- 
2.34.1

