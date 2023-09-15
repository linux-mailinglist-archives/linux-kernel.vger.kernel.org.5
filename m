Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2337A27D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjIOUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbjIOUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4182D4F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so2431574b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808771; x=1695413571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0w8YyWBkyxxpFXFEsJXWeSdcXhaKX7qg2CNvqyy5fgg=;
        b=RyDAX7ACq5A92wSogwHmcvX3MKIc9KfQi0TZijDBgFjz2xT/h3BIZBqMAmzR4D2i6Y
         C/UJWt2DcZ7/vFrTfxp32PyUoOKV9vpq04fYLUeDvmk44vQDsqM0W3dv4qNPbgT9uVtU
         CfSdr2ZMBv/oIeEMbskzmmep/TqGctkGhQJDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808771; x=1695413571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0w8YyWBkyxxpFXFEsJXWeSdcXhaKX7qg2CNvqyy5fgg=;
        b=vccrkkXWYehLh8Rm8QkL81Cse3dcIJVfpC/fksDNLSq3SDhxeQEY8DCM0oWKbpkerD
         XAJVpGxfLSyOQmSfxvLnqudV4vJt+hkEehoS7psNh+CeCjNhwa1Ytg5md3abIzb0SJyo
         VKspmbVXqs4QFj4xva0qCPsaJ34EGmx/N06E8J7xTBn1BzTJ9KoUPDn4Hr0hjnFsQBmT
         H8VXXHlufpPVH7ZvcSu9RbIIcb7qqKvo4eO0ngC+XPnQHhfTIMTcgIUTq8N4X+PeoIZm
         cOBQZKn/6oiir9yxUBvjXG9lQo4dI3k3E6xAGmhyy4mPIMyeHRkXPY+vQfKt/b3TJO3y
         6KiQ==
X-Gm-Message-State: AOJu0YwnA28T771OUCHhdP1v9k2/oPaWovLI9vMryf+hKvXbWAmJbVLa
        KvJTI9JTzAP45Wi1D2BcZJn2QA==
X-Google-Smtp-Source: AGHT+IGEP+XX4TcWFwL6riCxf7EV59zw6/4+xl/jX5TKVK+vuyzRqiTZSZ3ZHUIdArWZJdh1HlOnLQ==
X-Received: by 2002:a17:902:ecc5:b0:1bf:13a7:d3ef with SMTP id a5-20020a170902ecc500b001bf13a7d3efmr3048022plh.66.1694808771246;
        Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001bd41b70b65sm3864242plo.49.2023.09.15.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: meson: Annotate struct meson_nfc_nand_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:12:49 -0700
Message-Id: <20230915201249.never.509-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=keescook@chromium.org;
 h=from:subject:message-id; bh=viN3aFTUGlYqsHbJQcNa6oOS8nJqeFdRFpqtC0E5D+8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLrBAAO11BUsQ+oKxBzlepi1zMsCl8lRLHvB4
 qk/2KM3zKKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6wQAKCRCJcvTf3G3A
 JtFUD/4hfU9qPge0NwGnOrmrFpYmEsF1rZXGB7tjkgsjW4R11jE9il/8UIN9g8stacwGCBzLUSS
 mH+V4qUpwjDF0Vgztzj5EOz7jL0SUK05t+kAfxhir1eu+TnBxzScuL5kBFOGrCgttmRtseZC1QI
 W+9JjUA8xzBc0eX1m4eYJ0HXcBky9b9mgpiVTgrh5ZL5aFlaEXos2XiL4dRwbR5e72Zb3wUCnDv
 yMj9FU25KEJUcfcKLFE5fwvgnTk4zYKoVa001Mc8YJgJAxBrKtX9htMtzaR4HmBK4KEEkMnMehB
 HVDtcTnjsrQ7AmRrkuLkAj1Bah6SCH5LQEhEg0xmyLSD4csxgBeBSJ4a6wbKdwMAzkIbm1o5ACt
 NqIVZYqLASf787XFgOE8PA+1FJHr9EnDESUCgjWz64KdBIhs4l2CJyA6id6v3XYLU5vzdkJrAqK
 HJfrvwTc7Bg2Vs1RoOyXRXGcdwYb4stM2Vp0f7BGUhvRDk5F+Vh6M80kPxS/rJwv+KWuAeCipEw
 RWcbhpHBVe4oPJ/HWaMDO+RcXNJscIUwz7fU3UMhLSggbkK/h4czEGJTOmpoOncxQK921laWWKB
 59G8tSqmjF3lRjjxBh3wvyKvp8D/Fiu7/pHROejMOREf89AymCCZDQtmwn6ug7Eu9gcc3qEKHQm
 gzt6Re4 SCuWvuVA==
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

As found with Coccinelle[1], add __counted_by for struct meson_nfc_nand_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Liang Yang <liang.yang@amlogic.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/meson_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 25e3c1cb605e..378f28ce6a74 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -128,7 +128,7 @@ struct meson_nfc_nand_chip {
 	u8 *data_buf;
 	__le64 *info_buf;
 	u32 nsels;
-	u8 sels[];
+	u8 sels[] __counted_by(nsels);
 };
 
 struct meson_nand_ecc {
-- 
2.34.1

