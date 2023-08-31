Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1878E5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbjHaFw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbjHaFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:52:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77CE0;
        Wed, 30 Aug 2023 22:52:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so282251b3a.2;
        Wed, 30 Aug 2023 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693461174; x=1694065974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3cZF7dX+T51M1ilFDTmCciuWPN/WaDzWfsb09z2eis=;
        b=UM8qWgoNuen+u9V5xp7GGmyr6zMVhUcnkO/Rc5fZVDho1SXXINI8418gAMvnVM+Y1o
         CBcFw9sS9K8YwdCgD7z3Dw2Z7BsTkH2TzHP/MoVrrRLEa2haNx50uojyrg2lXzQ30h+M
         8yraOJWqUK4U0QRh1FJ56uAOcc6anyg6NNWuHfUSCizF3TVLuL31WZBjbpfgEuvxCDMY
         BZVeUsPkTiqm0rJir1e4B4uiLLwxbQSetURcHnjIGquaj+sDPG5gpzeevGIZDuT440ZS
         vAZikF8RKpg0guPc+XVLHL4vtRksPbjEtY+FlrnnP+gjyU63joE+J88cVHTVjK1K3dw9
         E8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693461174; x=1694065974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3cZF7dX+T51M1ilFDTmCciuWPN/WaDzWfsb09z2eis=;
        b=ao2VaQdOg7t1PkG350a44uNEEgDmH1RhyMxUPTYhb4WZ88g73v9gCya28Y/32htZHG
         P4Nt6UWOjmcSy8YEAydktzrdoVMuzkWJjk2lZVD5+7SmZDCl5a0UH3qtA2zFlI6dPRK3
         49exdYQOGphlpqiZSa3kfsHrqE7BBJ8+rb+x+dJoQv6ULVgwbLzppFJ81gfCcLCltLnY
         qKY+Ou9cNTa9UHf4E+GpnMoZcUtzenWEV8w4hVU0X99l0jMEz4x+4rU3wP7k8qKR9wK9
         +Kx+vMbP5eCqMGJkutSxcOVy3QVwEVM/vv6pVxcvuHe0/jvAPhc3SSJDR472dfY2hWy7
         SRDQ==
X-Gm-Message-State: AOJu0Yw81VNzPK5VOb5Udn+AAFFe42FDwd2kqeyvdFLYWCOJ6c6nRrxH
        lMOaPLRYi7dGCNbFWaSkcmk=
X-Google-Smtp-Source: AGHT+IEdJynyF1sPM1LXLbG7Nu+SIfBmaDaQ/AiHeUYK7hqPLOD64a5I0ezeV+XxRtQWw59aoXR+mA==
X-Received: by 2002:a05:6a00:850:b0:68b:fb93:5b4e with SMTP id q16-20020a056a00085000b0068bfb935b4emr4938014pfk.26.1693461174104;
        Wed, 30 Aug 2023 22:52:54 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b0068c97a4eb0fsm506731pfn.210.2023.08.30.22.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 22:52:53 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v5 0/2] *** Add Facebook Minerva (AST2600) BMC ***
Date:   Thu, 31 Aug 2023 13:50:27 +0800
Message-Id: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
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

Change log:
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

