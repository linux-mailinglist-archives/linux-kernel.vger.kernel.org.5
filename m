Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A57CC0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjJQKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:47:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A7B0;
        Tue, 17 Oct 2023 03:47:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso2724775e9.3;
        Tue, 17 Oct 2023 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697539666; x=1698144466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DngmYhquuUYsmqR6CkC7bFKb939k4yPlXBwM4OfGx8w=;
        b=PLduQQK10k3f3TVtlifoqM5/+H8HsSCsphJLXZ4wC+RDiIcyfY2KDVdxTjg/SScPpY
         bmrw5uU6IJcBvvpJJuXwE8SUNrlRvLJ9SvFqkgeOGgExwQlrTSAlZe+zoaRlDlqoAzcK
         EKW4jHCujmN1+tOdkVBVJgGXa+oEpnjQuUvx2mRNkTEWTfxHg5F2nLNVpPnaHd6HhPHN
         ERBUEnGsLCr2rWEUrCZ/xkYNFZRgSARGklk8oxVdXXyQvuSMe1cxAgJJaGEfZycFVZ2D
         Pzcs69gid1ObQUT09A82yu7Pt4hwtJ759DewnfUHjOgTo2FJ9GYz1DdCa9mdTjVfnQUL
         oi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539666; x=1698144466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DngmYhquuUYsmqR6CkC7bFKb939k4yPlXBwM4OfGx8w=;
        b=UxXXZu/VUpHNsi22ZCVT12+XAFh4k9ANy88nX6sey+JHpm6fiwyXudSd56YBg7Jejq
         vykylsEQB5HoDLEyZUNLuDb96yzRilkUnZgOYWQhLf0j+yMCaI5fjTJ8Kj/6dUmd67FA
         zOmUQ5Vnw+QyLFzVhFZTag/ID3ILEDgDPMiwAfWqfkug2xBPXJj/GPD/hwvbi2XM+gNQ
         2xgqlU6GaVy+KE3IM7DMCqBivWR3jlF/SgYqgi06ggRZS8xg4o52e9MN8/APrKCoM8fV
         iMTV6QMpVhgR5+2NOq8HLPwhOUOUMB32OOPLlPK6UAK9yFGJ+bRMGQ2XwuNQlGEVnOi7
         RMSQ==
X-Gm-Message-State: AOJu0Yyz1J+JcDWkhrXs7xvIKBTQ4ThYjQ3Kx2oFeKQpnW5kfgLq8HLD
        6vNe9V7S4M9Pj1uWZHwjmUxVnKVytLApzQ==
X-Google-Smtp-Source: AGHT+IHdE/vTp1u3u+UEAzAp8nMSLvbdXoZx/WxT6B2rUO1tDVu3mSXH6yQaUgMhYEP9dUoXoGrdqQ==
X-Received: by 2002:a05:600c:a01:b0:405:3f19:fc49 with SMTP id z1-20020a05600c0a0100b004053f19fc49mr1343875wmp.34.1697539665699;
        Tue, 17 Oct 2023 03:47:45 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e26d:77db:3f90:862b])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b0040652e8ca13sm9582037wmq.43.2023.10.17.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:47:45 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] Add missing port pins for RZ/Five SoC
Date:   Tue, 17 Oct 2023 11:46:35 +0100
Message-Id: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi Geert,

This patch series intends to incorporate the absent port pins P19 to P28,
which are exclusively available on the RZ/Five SoC.

Cheers,
Prabhakar

RFC -> v2:
* Fixed review comments pointed by Geert & Biju

RFC: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahadev-lad.rj@bp.renesas.com/T/

Lad Prabhakar (3):
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  riscv: dts: renesas: r9a07g043f: Update gpio-ranges property

 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 263 ++++++++++++++++++--
 2 files changed, 242 insertions(+), 25 deletions(-)

-- 
2.34.1

