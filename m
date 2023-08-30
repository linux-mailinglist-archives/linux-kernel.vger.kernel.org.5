Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5478DDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjH3S4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbjH3JE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:04:26 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F382CCB;
        Wed, 30 Aug 2023 02:04:23 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-48cfdfa7893so2328604e0c.0;
        Wed, 30 Aug 2023 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693386262; x=1693991062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRFnOrEZvLN5kMlEOUmKO68YNnlEwR47/rOgrclL5cI=;
        b=jlvC6N8qhEBBIJ8dSaDVs8838JK5R71fBpQhWBEEYdTPuWOSIL3s/QQXIobgtzTt6a
         kmmv2y8Gn+VHdQ3NVDYe//IwA4mcL/Dp6RKqkyMTlSwL7H++kt44MT9sEx1BF59plD4E
         /HzjWDqysaZ2TJTDdhG2IuAqbTn5ltoBgJ9gKe8I/g1Ze8gUTRf/nDJpv2wmWT4j+hlj
         mxK50NsIsoPn3H5nK6otbtsru3dVWlFMhoK9rS6XdNNR1zAmKgmIrnHeCiyVPs0D+x73
         EbEQig+E7KqokEZqu84ucpqE2/QxJUnDPOecyMENXpXwqyXHfPs/G11915Qg+C2DfubD
         gdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386262; x=1693991062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRFnOrEZvLN5kMlEOUmKO68YNnlEwR47/rOgrclL5cI=;
        b=kj0/lKMzeIzuFk7qJIC8wa1IRjTO1MsFivffQn+Ty5rQJpXtDLmQMEB/1xu8Dj4oCu
         kn/sOKL+IbgNvPGLOeV0e9XUpYVplDX3YNJ6k35VkkvPQNf4GbNrNJMIU3zK/v6US6nr
         xtlAhmcQ7a7RkKWTRvZ7L7YasNPeC7AswhkUX1yurR+Hq0VFwZFJVW/cQU8kCmRIeD4T
         27vgc12why9l2KuFI1MNbm/fV2ZZ4Zfj8ITzfOJpYg2m0aaKrxSJbQ+qj7144sZdBZS4
         FDyEze3StOpoXxfP01PQWt3NXoZwqUZ/PZD6H6AcinjVCrmWkq4mtzm47UA5D5xwIStM
         JO2g==
X-Gm-Message-State: AOJu0Yw6yBzYji++4FgNFu8aBQsZ4afL5NDT/kfaF+yox2JWsbi44lqb
        OIUqvUysj0ZlIaooUom/brU=
X-Google-Smtp-Source: AGHT+IFRF/QDUiw8HkrwOVzahLlEG5guebup/jA0oCLgscvJyaeOR/MUVQPM2c8W1nVG0Tzyudffzw==
X-Received: by 2002:a1f:4a02:0:b0:48d:4b:66df with SMTP id x2-20020a1f4a02000000b0048d004b66dfmr1520456vka.0.1693386262097;
        Wed, 30 Aug 2023 02:04:22 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id x4-20020a656aa4000000b00553dcfc2179sm9263226pgu.52.2023.08.30.02.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:04:21 -0700 (PDT)
From:   peteryin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com, peteryin <peteryin.openbmc@gmail.com>
Subject: [PATCH v4 0/2] ARM: dts: aspeed:Minerva:
Date:   Wed, 30 Aug 2023 17:02:09 +0800
Message-Id: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
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

v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org/
v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org/
v3 line : https://lore.kernel.org/lkml/20230830025133.3756506-1-peteryin.openbmc@gmail.com/

Change log:

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

peteryin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 385 ++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1

