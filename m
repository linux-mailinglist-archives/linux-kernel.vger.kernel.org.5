Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8E78E8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbjHaI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHaI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:56:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365DCE9;
        Thu, 31 Aug 2023 01:56:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26f6b2c8e80so426242a91.1;
        Thu, 31 Aug 2023 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472192; x=1694076992; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqSAx1bRusuwtKPOf+mGzUiMZP0y9vtf9jLXX1JcNAM=;
        b=XaFaODq0MVxBQ1xniBWlEgj9wWxcBu3nZoBsNryVmvShEuzsHxtv8jt+wVhhFSeFec
         PNGy/6VFuMSgouKA+Vd7RvCW/L7LWtpDdfkSW6tevawkByIBa4dJ1DDXq0gkiWyrR9i3
         DzE82apDoFq1niCD9VrBbN46f2VLELwSeQSHuQWmPScSTf63/JDP0s8z4ZTLoKQ7lYBW
         pnRkRlZViesZG9lo7ljcMHjruDx+1Q2wqPfs1N6q0BXEPQOIgeiCqie1FjtUDdFgxcMJ
         8ApEDFVRAGOFU4i0TOxbM1i8JWKHFjxErIwcA/N3iAak0vzR2sRQeM1ANHRqpvWhyI4h
         5TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472192; x=1694076992;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqSAx1bRusuwtKPOf+mGzUiMZP0y9vtf9jLXX1JcNAM=;
        b=eNsGjP/XNwQe3lOOuHYraPRT+31oW2U7TrIF/qhMvku7zFrzM2PS+gXJvCKRV+I97z
         7c7RaXRgIFcb1/naYvmJWG/wr/buqSB3QVKpClXIT6JCgjcfMnVOHnr8VcVGsKrgrjJy
         fEIW3dvJV6smd2X9ruti3lJ9Q/MyNtD0p+joZNgwAg4Gj/Z6UI5KmBnjzeeTGrBJCMn2
         lPo28ErdvDWT5AJZJLECgaheHNapfJTrPwCabINkDnovkH75hTOFxMQawhI7dSGT+CAx
         M96cHBeRGpo72RE9CKrIM3eYJIa5yLsVffp0b+bf87R8rs7vdXzoGWzOP28RKhKKZBh2
         yF0A==
X-Gm-Message-State: AOJu0YxmrdW13sblVekHwjJK21/hgqq7V0KJAIoUiQBJtIw+wDnV3KgR
        1SzNDKRLbCAsgK36bkAmXfjltn0HkYI=
X-Google-Smtp-Source: AGHT+IHNWYag3zb8L9EbQSCMBBQkUzJT0HHr8tZPfn9wzTui987x+cWy/dEn3JJnwLVfwPg5r/YutA==
X-Received: by 2002:a17:90a:5d0b:b0:269:142e:c2ed with SMTP id s11-20020a17090a5d0b00b00269142ec2edmr4478360pji.37.1693472192495;
        Thu, 31 Aug 2023 01:56:32 -0700 (PDT)
Received: from localhost.localdomain ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j16-20020a17090a061000b002676e961261sm3967923pjj.1.2023.08.31.01.56.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:56:32 -0700 (PDT)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Wells Lu <wellslutw@gmail.com>
Subject: [PATCH] regulator: rt5759: Fix cannot change operation mode.
Date:   Thu, 31 Aug 2023 16:56:11 +0800
Message-Id: <1693472171-30531-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong register was used in setting operaton mode function.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
 drivers/regulator/rt5759-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt5759-regulator.c b/drivers/regulator/rt5759-regulator.c
index c2553dc..3a2eaa7 100644
--- a/drivers/regulator/rt5759-regulator.c
+++ b/drivers/regulator/rt5759-regulator.c
@@ -70,7 +70,7 @@ static int rt5759_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(regmap, RT5759_REG_STATUS, RT5759_FPWM_MASK,
+	return regmap_update_bits(regmap, RT5759_REG_DCDCCTRL, RT5759_FPWM_MASK,
 				  mode_val);
 }
 
-- 
2.7.4

