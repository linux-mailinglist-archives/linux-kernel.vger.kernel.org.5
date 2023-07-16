Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F478754F65
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGPP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:26:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C212E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:26:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5768a7e3adbso71610267b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689521208; x=1692113208;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ij9R2Z06Y24vfZ3xZGQuB/hd5tnY6d6rJhNbcQ7ZzmA=;
        b=OG5pf6zzYcwxOGd2/rZY4B/CzoE8/HEVedwT6RPZkCe9QfHLny6WGGE1d/ciioNsmi
         qL5Ut06P6rrWjJ/ukdo7F/FSpickKKpejr/JopMcm3E9l0zvo6Tqwonpt7ziBpDc2HwD
         9OAwyP/cTaoNjigukc7eDk8qrYpieYMRSdGW+6llHlbO4xAu9OkrLOm8BRdrNC6TCi5j
         bWj8aSXEMPM8mYLH0tvSJTlam40OqdIo0aEgnT3gv3xz2+fYdBKEPuUDxoJUeRxsYzyU
         GugIiSdAew5O0z5BaC4o4nEHEmfC8jfwm75oU6HS2a44fClJDRLvF4K1x++pEoErE1EW
         W5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689521208; x=1692113208;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij9R2Z06Y24vfZ3xZGQuB/hd5tnY6d6rJhNbcQ7ZzmA=;
        b=WUDzGD6OM+bc3aSYRa0r1a8P1xuDDZmcbe0kWNfufs/59MGgTrcQaIjCUA73RQPWFX
         qpjmvAKZuqRV0vOCHWjSPUfPZs5e4/Uoly/29VE5SsV4/pTFzeTLbRaI1UXeh5FKPusn
         B0jVXbdurDV0mBJB2u8HEyr7ttZqEzNYOPnbSufmbv9Ak41mpaTSHAm2drPNXPm1/0Dv
         kBxF4OreRy1SEMiguUhYDWEn76gWi6iYw8TCEFLZIunZKIl8occ/gokw2P53TCUXvP6l
         uG3kGliAFTSXy8OSTlw+0+GBw1TKNkvJAQve7SocXmG4agxO6vRi8NmKt/fdY5863d0b
         ++oA==
X-Gm-Message-State: ABy/qLZq/tR2BkbcILSXCtUEL//kCS4J2hwVOXiXGIq/FcMpIA/P0L3v
        3PE1Ei0D8Tku70A3SbheMhYIha+8DtRsN/eunDRyFg==
X-Google-Smtp-Source: APBJJlFtlleXDrak9K321xWoTyzRr580cVKyg6iV9qhBzfhWa+614ayqE48xQj8U/60RsHxxKpah/u5+I4/AhUXZmRU=
X-Received: by 2002:a0d:ea87:0:b0:577:38a8:38be with SMTP id
 t129-20020a0dea87000000b0057738a838bemr8638151ywe.23.1689521208127; Sun, 16
 Jul 2023 08:26:48 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 17:26:36 +0200
Message-ID: <CACRpkdYNOMEUTJ-=N9ZR5w+mAKcTGLCoz7kgUgioC9Ytz9TZKg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm mostly on vacation but what would vacation be without a
few critical fixes so people can use their gaming laptops when
hiding away from the sun (or rain)?

Details in the signed tag as usual.

Please pull it in at your convenience!

Yours,
Linus Walleij

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.5-2

for you to fetch changes up to 04e601f2a71c804422a91df813e19fda5f4b845e:

  Merge tag 'renesas-pinctrl-fixes-for-v6.5-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into fixes (2023-07-13 00:05:52 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.5 series:

- Fix a really annoying interrupt storm in the AMD driver
  affecting Asus TUF gaming notebooks.

- Fix device tree parsing in the Renesas driver.

----------------------------------------------------------------
Biju Das (1):
      pinctrl: renesas: rzg2l: Handle non-unique subnode names

Geert Uytterhoeven (1):
      pinctrl: renesas: rzv2m: Handle non-unique subnode names

Linus Walleij (1):
      Merge tag 'renesas-pinctrl-fixes-for-v6.5-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into fixes

Mario Limonciello (4):
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options
      pinctrl: amd: Drop pull up select configuration
      pinctrl: amd: Unify debounce handling into amd_pinconf_set()

 drivers/pinctrl/pinctrl-amd.c           | 61 +++++++++++++--------------------
 drivers/pinctrl/pinctrl-amd.h           |  1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 28 ++++++++++-----
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 28 ++++++++++-----
 4 files changed, 63 insertions(+), 55 deletions(-)
