Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462F78E720
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbjHaHXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHaHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:22:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F81A3;
        Thu, 31 Aug 2023 00:22:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso3144735ad.3;
        Thu, 31 Aug 2023 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693466574; x=1694071374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Lofyhd33uMBJ+ToOK+tKMDmw25lr78BBj5RQAypyI=;
        b=fGmT5k2Rt/KX9atWbXcYn2+uxQNG80IgJmcx0hdDEo7pUF14QFkbxmQtB0PdunFtOg
         wbho6ulJ9s2U9UNc31BR88U8ckHd6j1pal2Rpqv8/JSlc/kXsGs0bjYLq6JisSC/IXsd
         Nc6a/aWKtFqhyCVyqa6OFTaeh3FTtsAgtugIIfIuBCvc6chvWk/a24VXAYW/gwRHewJz
         GHZGdc9HNgEuogfsv2dD01E7NW+LD+ax8jwy4qXytS9hyZZlvW5+M8wp1CPTkdSKHc2M
         QAXQ4i8qcm0psleVWGuYzTBSban6dCoRA8MFRloAFpdQnRAEDUH3G1hjL/Y0Tlasw3Mr
         6vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466574; x=1694071374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+Lofyhd33uMBJ+ToOK+tKMDmw25lr78BBj5RQAypyI=;
        b=Doqf+TTaiceeQeSOyiKfPmabOO9IgjHVSjLYJQU5MR6NG+aHUN4Z1OgEhuZL+HxZVl
         Vt9QJX4HbGxWywonEwYQ16VKFXrJrI/4iSNXbeKtepQkrIaUGvNZL36QR44bSwlY3AMy
         jxOjZfTbPFjR6Na7sKyVAi20JyktaYGkbB4sA7jzMpZ82aQa0XBQDkd1IZwhhZrdJcji
         igyTVVAu4T1RzCa3x0sb3LQgKL+CZZrI/afoKajSwBdB7Wqz0rpTxTQdig9ViEcWVESL
         L4rIqhtjRoavXCJ50WlrDaii2ljYWLeBzihBGCUsDQc1IyBxsHPiltFKr2uxRy9wHTyp
         kFBQ==
X-Gm-Message-State: AOJu0YyHL+/d3wEKGThpfWHQtp4GPCCh7Bzv4rzr6RcfSpdMSzrSP6BJ
        Lk/q/6ovrONTnK9fuvjsac7lHjcizGpLsQ==
X-Google-Smtp-Source: AGHT+IEHk+t1Wy+PMcS1vCgFZpM2AFndRd8x1kKereWVkYMryh93skTwtd4kPQtLBaNqkpEiRwmAvA==
X-Received: by 2002:a17:902:ea11:b0:1bd:f69e:6630 with SMTP id s17-20020a170902ea1100b001bdf69e6630mr5152249plg.65.1693466574056;
        Thu, 31 Aug 2023 00:22:54 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001bf8779e051sm628794plg.289.2023.08.31.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:22:53 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Peter Yin <peteryin.openbmc@gmail.com>
Subject: 
Date:   Thu, 31 Aug 2023 15:20:45 +0800
Message-Id: <20230831072048.3966398-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Subject: [PATCH v6 0/2] *** Add Facebook Minerva (AST2600) BMC ***

v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org/
v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org/
v3 link : https://lore.kernel.org/lkml/20230830025133.3756506-1-peteryin.openbmc@gmail.com/
v4 link : https://lore.kernel.org/all/1d531692-5455-fbfd-0775-50856bf0fbc7@linaro.org/
v5 link : https://lore.kernel.org/all/5347163b-c225-d805-d851-fe28e6b57c56@gmail.com/

Change log:
v6: 1.Correcting the arrangement order in Makefile.

v5: 1.remove redundant blank line.
    2.Correcting the arrangement order in document.

v4:
    1.seprate dts document.

v3:
    1.Fixed commit description.
    2.Add sgpio line name to sgpioP.
    3.Add ipmb debug card bus.

v2:
    1.Add facebook,minerva-bmc in aspeed.yaml
    2.Use stdout-path
    3.Add Makefile

v1:
    1. Create minerva dts file.
*** BLURB HERE ***

Peter Yin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1

