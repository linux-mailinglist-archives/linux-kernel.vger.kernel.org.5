Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45B97805F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358054AbjHRGqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358046AbjHRGpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:45:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1AE6B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:45:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-689fb672dc8so330849b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692341140; x=1692945940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/AW6OVix64uYufO+n3YwaFOFJRrri1APYCHLgST4Pk=;
        b=TNqQvI55sOwODQkNAVTwk8p0iWMdf6tVvcuHNCnhnkf4o/mjFFSaf1Jxii3XaZnoM8
         YGyxPkiRf4esm4ZkLOBLSvxLU6XgTLeoGMbE0adARB/s/Xte7nfpBRtjZhxjlBVOUYpw
         q9meADO04eNsS2mtM8x1gYmZpWibL2R9gAKIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692341140; x=1692945940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/AW6OVix64uYufO+n3YwaFOFJRrri1APYCHLgST4Pk=;
        b=X3oyALguol+U4pcV0Bz3d8yHlHZjgcoWsDYNUgmgYe3onnPLpy0kAdEJ24dljMu0Do
         ocOL368KPAuixzgNPkY3FCNL0LRZI87ZNj3Q6cWWef1N5gIfOlI6D1/yvoIST80aRg9u
         36u9tbtezyOzodOFKwDR8Tt7k9PMChpvpGdcNK9AU75Rr/pzilxbRUGKRjfp9JKX+qeF
         IaAEHW2u4csVXxq4EDBAGsdi5U6Qv6nUTeAOkXVAXwTzMElMGeR2O2E6jwpDkVTMEWm1
         6QBl9ljkCIlCenL+lkRj5UrVU/GGEJl6pr68kcU0/wuJ2NT5RZ0MjPHIHmjMSmOKGIsZ
         0Ytw==
X-Gm-Message-State: AOJu0YxNOBd7HfePI/6sZiXFxAWWQLtckCiAnYoNypvQaiG5cU46E7JL
        3J5WkseFW5ycBh6uxHoUeyxUAKo+6Xh2m9uTPr4=
X-Google-Smtp-Source: AGHT+IG5PS5tClmOeIQGf6BXI3cuGq8es0FpY3r5qTOCvHFz289bKpQRYo5qHOU1Zjv0jwFi9n8lUA==
X-Received: by 2002:a05:6a00:b8d:b0:689:efec:fc76 with SMTP id g13-20020a056a000b8d00b00689efecfc76mr1995037pfj.18.1692341140635;
        Thu, 17 Aug 2023 23:45:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a45b:137a:a8b1:201e])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b006870ed427b2sm833792pfo.94.2023.08.17.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 23:45:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: spi-nor: Check bus width while setting QE bit
Date:   Fri, 18 Aug 2023 14:42:23 +0800
Message-ID: <20230818064524.1229100-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_nor_write_16bit_sr_and_check() should also check if bus width is
4 before setting QE bit.

Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
Suggested-by: Michael Walle <michael@walle.cc>
Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2: https://lore.kernel.org/lkml/20230816104245.2676965-1-hsinyi@chromium.org/
---
 drivers/mtd/spi-nor/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 614960c7d22cc..1328128dfe65c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -870,7 +870,9 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 		ret = spi_nor_read_cr(nor, &sr_cr[1]);
 		if (ret)
 			return ret;
-	} else if (nor->params->quad_enable) {
+	} else if (spi_nor_get_protocol_width(nor->read_proto) == 4 &&
+		   spi_nor_get_protocol_width(nor->write_proto) == 4 &&
+		   nor->params->quad_enable) {
 		/*
 		 * If the Status Register 2 Read command (35h) is not
 		 * supported, we should at least be sure we don't
-- 
2.42.0.rc1.204.g551eb34607-goog

