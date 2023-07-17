Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB6756CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGQTRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGQTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:17:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EC0116
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:16:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89cfb4571so39252535ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689621419; x=1692213419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ6YReQN52ePsFxQCiGniW4yULFrXJ1nTk50bawBDOU=;
        b=QIYXFB0r9Zt37S8ztvgFWTvQOKTaEqO1T7XgB4RZwHDwOzuIiLH0BMTQDA0Fg8oFNX
         J0We84AOKGsuh7y7YSF0SCTEHJX6ElIex/HCYPrNn1MnDY0RUNDJzEU57GMRxZe0UPO/
         jQYkb6PhJz7gHgq/2oVqS0rZ2W/TNJSnQFDWage3vtju27KayjWF2gIYFFhtB0lJNoF3
         2Xflp5+2yU7R3y3jEcKO1wEcP5FO1u53JX80Y8PirHZqKe3Mz4DG2ErZax3ieDJmeP64
         3/f//R6vGRrthNgOf8OtkAVjpiG2M5jFLrFpH9cPedzjt72ZcMK2tiTBSmXBRPo2s9W4
         KC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621419; x=1692213419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJ6YReQN52ePsFxQCiGniW4yULFrXJ1nTk50bawBDOU=;
        b=fJSF/kuwuJUOVMR6ph6fu4Kk016g9tW+7iBz7czzLCgYvPgrUW7vf2aazsvIIetkGu
         AYvOk0UW6pjPgHfEwFbrfW5RWhJB81w2gF36wx1VdvFqfNXlGwtcF0YC0SEZ8/8t5UXM
         XtZnkwAkDooKDl3KbNTqlz8kN7Y667oamTipYjB1hazxYsHQyHeOQcT4KJ9JX5si/yWz
         ihkyxKzxGMZcN0OLYrCButzGE6rqRC6X0CupeDyV30ZfCg6WyXYPUIAky/q05skwtf88
         Z7IhG1QODsQF8CLKS1kW5HTWjtCKaNEvd3EB/T2wBGDtun6op5Q/6ZINAUKB2iN7lOby
         wgeg==
X-Gm-Message-State: ABy/qLYeeZwjx6y/xoJaEHuHpVj7+O5cdsmu1YJQ2ztBItSk38gW5aVI
        076w3u49qdGMJEAl2Et7q8birmQkeuobsBoWc1+SCg==
X-Google-Smtp-Source: APBJJlG+4z17qFTqJ4MlykwDUQClmB6anzNe6AMV5XAwfirSq7yaDz/xfl09bk+z7ASM0bD9+u5+aQ==
X-Received: by 2002:a17:902:ea01:b0:1bb:3e35:6416 with SMTP id s1-20020a170902ea0100b001bb3e356416mr1250281plg.56.1689621419409;
        Mon, 17 Jul 2023 12:16:59 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001b9df8f14d7sm210296plo.267.2023.07.17.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:16:59 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap-irq: Set IRQCHIP_MASK_ON_SUSPEND if no wake_base
Date:   Mon, 17 Jul 2023 12:16:54 -0700
Message-Id: <20230717191654.1303285-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hardware provides no way to control which IRQs are wakeup enabled,
then software needs to mask non-wakeup-enabled IRQs when going to sleep.

Fixes: 55ac85e942c6 ("regmap: irq: enable wake support by default")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/base/regmap/regmap-irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ced0dcf86e0b..d7e076cff6e1 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -728,6 +728,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 	d->irq_chip = regmap_irq_chip;
 	d->irq_chip.name = chip->name;
+	if (!chip->wake_base)
+		d->irq_chip.flags |= IRQCHIP_MASK_ON_SUSPEND;
 	d->irq = irq;
 	d->map = map;
 	d->chip = chip;
-- 
2.40.1

