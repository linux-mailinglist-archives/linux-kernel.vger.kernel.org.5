Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A7797748
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbjIGQYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbjIGQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:23:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A093A92;
        Thu,  7 Sep 2023 09:13:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a1af910e0so975755b3a.2;
        Thu, 07 Sep 2023 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103132; x=1694707932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz1CUuX4Lqr3H9YMZSLBvjxqKju+LCrPSB9wRJoy7og=;
        b=BlVCb3azkLRVGNKo6+R+1RSuFdSMh5elq2YO/VcsteBPusmMDi7ok3+zEUFpncSD4/
         eBWcnzcLY/zyN5dUgrG6wDKdEBsCCqmYh7iSaOUFXQw07EW7y4K69cqR1v2r6bvzGH9L
         yeBcKlPXgtJXetzf+iYyePg4B3kAjVK0PC8mIn8v5JkLtKvWtAR5Sh1zlLgITgeRfvBl
         dn9rVtTlYoMYRd5Ae4svthuI7nyi2SFwjegRh/LjkI3Wq4JltoaVHMDvwmdp8PiRl/Ii
         LIgLD7sxLKsYRvVdjZUZCWb2vmmOtkFZWowzN0rd6yqSbtgks2ksbVC0DJW0xNtOoBL9
         SPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103132; x=1694707932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz1CUuX4Lqr3H9YMZSLBvjxqKju+LCrPSB9wRJoy7og=;
        b=DcFaSTbLvOm2PUG7SW9u3D4LDNclqEGsCwEV4PY2VKnLHyVxpFiQstKosAsANli+Uy
         eHjkKT1V01uTy2XTh982LCAtSMiqd/bfvuZKoQ4uGGL0c5E6lKSlUHy46xhbAP4EpcS+
         uk8rEZZHC5k4nhMLJplMfT3plwUwZRB8tmNkwaf2DmHVhcD+BuYPCcn3ZiBfN9Sa3aBl
         882TKbxIOthqCOB61BHAWkZksRz8w3F9CaCscuOI6yjo6iVyy6wB4ckniJWrZ+dFazGk
         Eu5eJcIkirD/mz99rVZsyMjMaa5osVYGJcMFlr01H2Lm8z6rz57uFGB1flq1S8ATZud8
         0ChQ==
X-Gm-Message-State: AOJu0YxkAmKYVKiAj9Kq0S/fAu62x39KLWxb7xoKZUdwrWjI2w5o0+oy
        6NFOIBYgkFkjcLYTvHWnGEzSwGz9Z6Omhw==
X-Google-Smtp-Source: AGHT+IGkO+3/kmpKI6RcvIIJP4NO5biUIJlKEEfNyHd+ec55kHccx3KTzS3/hkpRB7iMaDNNiON7QQ==
X-Received: by 2002:a17:90b:1e0c:b0:26b:6df8:eb69 with SMTP id pg12-20020a17090b1e0c00b0026b6df8eb69mr14694789pjb.1.1694069253770;
        Wed, 06 Sep 2023 23:47:33 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b0026b55e28035sm800439pju.52.2023.09.06.23.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 23:47:33 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v9 0/2] Add Facebook Minerva (AST2600) BMC
Date:   Thu,  7 Sep 2023 14:45:11 +0800
Message-Id: <20230907064514.1764010-1-peteryin.openbmc@gmail.com>
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

Summary:
Add linux device tree entry related to Minerva
specific devices connected to BMC SoC.

Change log:
v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org/
v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org/
v3 link : https://lore.kernel.org/lkml/20230830025133.3756506-1-peteryin.openbmc@gmail.com/
v4 link : https://lore.kernel.org/all/1d531692-5455-fbfd-0775-50856bf0fbc7@linaro.org/
v5 link : https://lore.kernel.org/all/5347163b-c225-d805-d851-fe28e6b57c56@gmail.com/
v6 link : https://lore.kernel.org/all/20230831072048.3966398-2-peteryin.openbmc@gmail.com/
v7 link : https://lore.kernel.org/lkml/20230831082819.4000425-3-peteryin.openbmc@gmail.com/
v8 link : https://lore.kernel.org/all/136c0434-a588-877e-54e5-dd1078ff94a3@gmail.com/

v8->v9:
  - Remove dts jtag1.
  - Remove blank line between tags.

v7->v8:
  - Fixed dts path

v6->v7:
  - Change order before aspeed-bmc-facebook-minipack.dtb

v5->v6:
  - Correcting the arrangement order in Makefile.

v4->v5:
  - Remove redundant blank line.
  - Correcting the arrangement order in document.

v3->v4:
  - Seprate dts document.

v2->v3:
  - Fixed commit description.
  - Add sgpio line name to sgpioP.
  - Add ipmb debug card bus.

v1->v2:
  - Add facebook,minerva-bmc in aspeed.yaml
  - Use stdout-path
  - Add Makefile

v1:
  - Create minerva dts file.

Peter Yin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1

