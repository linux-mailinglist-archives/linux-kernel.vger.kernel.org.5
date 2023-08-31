Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29378E7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbjHaIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjHaIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:30:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200E185;
        Thu, 31 Aug 2023 01:30:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-565e395e7a6so398201a12.0;
        Thu, 31 Aug 2023 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693470624; x=1694075424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMjIF994q3qSA6WWBgnks3eIIMa6B1Wh1e0XtMkE9qw=;
        b=Zv10CyxDGvbyzCOfQzIEoPmY6w8tODbmdlBnYeQFD7KGpU3ARxb5Kg+mcV1QhL+09S
         5DJfneT7AvTU4bsfhKWt+GNyEylgrzBg1Jy9mVON5VJtjjn5cHSRGoP0lJTVA0Y+DfsM
         x32s8ezXRPTPPZbLbLO19COCTmqJh10nQSbPhvEWVx9DrXIJUJzn5vVuVJnCLUAa3ZuD
         IM3Xd3NFpmPE1tWEjIipMPezU0sXNtPUQXybsZAq9PvA0lHvHvOzsCyRamvmfm6dJSdp
         xgRO6sg0yQ1CB186prlKyJ6mAjWSd9mQamiX6vBAXBDEcEPEICbbuHVH5K/gyjFOc/y5
         CLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470624; x=1694075424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMjIF994q3qSA6WWBgnks3eIIMa6B1Wh1e0XtMkE9qw=;
        b=VCQfA6M1UYJEvecvOVxwRar9uocNO0VcvFyxi2+CGXfOwVzMuoR5yP8o+Rt8uMNIh3
         JjcipDD1oOE42EcLU8UJtpSpditoX/TPoGU/Yp7j76xyS9DN54kvd4700fZigFvCbl2j
         8u+bkVMrDeKoEXwiKDrwG6uQ7muUW77i4eEIn3pnh457Xevel6ss928uLhjFUcpTJC4U
         BNoslqBvSWJ2V052NvCWgANeg+ivfQOdhDjKjTmrXq/ejQkH7iaCEJdAIBmcrci8Pvzy
         yD408f0eizP1yVEC5cJzHVi3/wieIPWvnFMQxSERH+Q6nX6mKMnZupIZcmRfdJ35he8y
         AWrQ==
X-Gm-Message-State: AOJu0YxshJeYlgcefpBxJKRvj1WxraLoDSwhaDlLIGx2GRPU1gWsgYhp
        ZBPS1vQPLeGSOiyaNmUqfJY=
X-Google-Smtp-Source: AGHT+IGq02q6EYdzv4j+dIJgAqXae16JDV44BC6e7208bdXWcap4pw1HaygLxTRCG/9TzNfLH+F3bw==
X-Received: by 2002:a05:6a21:71cb:b0:11f:6dc:4f38 with SMTP id ay11-20020a056a2171cb00b0011f06dc4f38mr4826670pzc.55.1693470624065;
        Thu, 31 Aug 2023 01:30:24 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0068a46cd4120sm812253pfi.199.2023.08.31.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:30:23 -0700 (PDT)
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
Subject: [PATCH v6 0/2] *** Add Facebook Minerva (AST2600) BMC ***
Date:   Thu, 31 Aug 2023 16:28:16 +0800
Message-Id: <20230831082819.4000425-1-peteryin.openbmc@gmail.com>
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
v3 link : https://lore.kernel.org/lkml/20230830025133.3756506-1-peteryin.openbmc@gmail.com/
v4 link : https://lore.kernel.org/all/1d531692-5455-fbfd-0775-50856bf0fbc7@linaro.org/
v5 link : https://lore.kernel.org/all/5347163b-c225-d805-d851-fe28e6b57c56@gmail.com/
v6 link : https://lore.kernel.org/all/20230831072048.3966398-2-peteryin.openbmc@gmail.com/

Change log:
v7: 1.Change order before aspeed-bmc-facebook-minipack.dtb

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

