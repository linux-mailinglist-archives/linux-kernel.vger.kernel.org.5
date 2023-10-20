Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3B7D0D56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376903AbjJTKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376987AbjJTKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:35:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3481713
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:35:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adb9fa7200so147334466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697798150; x=1698402950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPV3+mSCa7UCq+L+t94qLITay8xgJ9TNT1tiFr6+L2c=;
        b=im8LOf5Aa3rFTDlDd4uCcX98bBMcf5l9mwHcjs9CvBC0Cy1QhSvKJZBurpHsBmNtHz
         akkOXLnSw+J1iIWa9jgI/4tyLTzWBRcAY9zL9d/gMFFO41A7RQ55wuDndVqqCA2XuP84
         PHXxz68Ify+PA6KM7RPdiogAZDkmCwjJkjvwmsikOez4B4PvYZ9p6Huqv5VtwYQG8Xrl
         dcMrzsIlTtEEU9MPj9Za6vBI4zgYd3N99YFvSrn1NWUMcntIEBgPtaPSYRMzHywTOGwJ
         2sVlHfr/mOK2iKcG3LLSGK7aSYMp0nIlfanqtgFtRvtz1Rg1d96tL3leJQDZ+Zv4IIJE
         Hukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798150; x=1698402950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPV3+mSCa7UCq+L+t94qLITay8xgJ9TNT1tiFr6+L2c=;
        b=gWQmtkQfNuITAvIVsXkazzZCzZyNvjOihV+6oJ6yAJTUyCbO4bSj1aa0PcoEgqQtGU
         VcefSKstAmYa3wxgOz7GaxrsESqg6Xq7+ZwCkdMgipZF8ihyn6IzhLwpKMl1su2s6Aio
         5Zp7dVhNzKfAQzwqon9j7o/dH8Vk6BjlMwDSEFY2/JoB40+1CEJNAaSHScMjMjGC1jKb
         Ndve5ihRgtwdnRekdwR6Inghf6Xd6klNxv/pGscVnzm8p03oU/FPTTqImPPHPxqtY0vU
         XFMsfYyh43jkYS50AFCvCRda/kJnra5yl4p5JikMQRzCCF9tfww/dXYfbm1UIcH6dbUh
         O9gw==
X-Gm-Message-State: AOJu0YyxFREjxJaUPX3LZKFlOLEQFd1ybzxe70vctwdwGY5sYpTo3Ktx
        s+hPAkx9M+PGxbc6mNvLy2VQhQ==
X-Google-Smtp-Source: AGHT+IHJToqlCc02RJhLLsWDtbne22EHGQDujcGIxJ09VOwX3CVtjhc4BmJbIkc8DjNLMYWuZ6+PBw==
X-Received: by 2002:a17:907:728f:b0:9a5:7dec:fab9 with SMTP id dt15-20020a170907728f00b009a57decfab9mr4012688ejc.9.1697798149982;
        Fri, 20 Oct 2023 03:35:49 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063c0700b0099c53c4407dsm1226701ejg.78.2023.10.20.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:35:49 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Add driver for NXP PTN36502 Type-C redriver
Date:   Fri, 20 Oct 2023 12:35:45 +0200
Message-Id: <20231020-ptn36502-v2-0-b37a337d463e@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFYMmUC/23Myw7CIBCF4VdpZi1mAOlt5XuYLggd7CyEBhqia
 fruYtcu/5OTb4dMiSnD2OyQqHDmGGqoSwNuseFJgufaoFBpiVKLdQu6NaiEsX1HBrtZtw7qfU3
 k+X1Sj6n2wnmL6XPKRf7WP0iRAsXQSxzsTSN5d/eW07rEQFcXXzAdx/EFaEvHCKQAAAA=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PTN36502 is used in the Fairphone 5 smartphone, add a driver for
it so we can soon enable DisplayPort over USB-C on this phone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Use FIELD_PREP+GENMASK for register values
- Move FIELD_GET for chip revision from macro to code (to align with
  new register definition style)
- Fix bad code alignment at ptn36502_bridge_attach function
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20231013-ptn36502-v1-0-98109a430efc@fairphone.com

---
Luca Weiss (2):
      dt-bindings: usb: add NXP PTN36502 Type-C redriver bindings
      usb: typec: add support for PTN36502 redriver

 .../devicetree/bindings/usb/nxp,ptn36502.yaml      |  94 +++++
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/ptn36502.c                   | 444 +++++++++++++++++++++
 4 files changed, 549 insertions(+)
---
base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
change-id: 20231013-ptn36502-5a87e507d36c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

