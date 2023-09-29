Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8727B2953
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjI2AHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2AHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097BF3;
        Thu, 28 Sep 2023 17:07:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406589e5765so4603445e9.0;
        Thu, 28 Sep 2023 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946058; x=1696550858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8MO+V9BSn3lqUf4u1am2/WES2bAF3+wTi6NHVIZgf4=;
        b=IHaGG/F/TzsWt3U9o22qSqcCamxtxsWBfkbNDw4BMKmUpC5afFmdBg70e2T6gmg+C1
         vP6G50zTG3BusEjKPwt/7C5jfJXICQbjDVfT3xSJRhslIgDsxGkH2JRv/KRmvH5iVoek
         YgHLY+51wU8Z0LOV16NNq1FAJd7hTC3lzALZAceP65hxjw/JSmKIebWf/lccwk3U7FDz
         0S9Nsvr4hEL/fH6rTPTjwl/hMFUOTvshl6hUXlHdtwREd2lCTJOESZXcCLMezvtH1B42
         6qCPInK/eHHW1gXtNdqdMv5YkUubkTs9i3Zh+r+YyXYzOu7p1tboZLUKAkbi8U+5eo+X
         iHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946058; x=1696550858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8MO+V9BSn3lqUf4u1am2/WES2bAF3+wTi6NHVIZgf4=;
        b=kxKNs3FXeCg0B2+aodq6wzFkjuVafmNI5pNqsXRe+EOoY3TR4OUGxhCGrU16fddxku
         zREizLRZQTlKy3WQsAVqT9JLDAVbzpebkMtkrXSIDN0eMNmATmrRPGti4W6HfHZMQfjM
         C7WShh7UQ0EFbZK5+vXyVKonfXR+GTP2MlWu2SBqD4PgS15nD4gAqH/NuydsC4Vt8NRN
         J6cAdG7G4rUWiIS7xBYwTI7FyPalvS0y+aoXLryhu58DWcUTZcYE2OzYr7+Y205+uf42
         9vRBXNo4Opc8/vpSUWWQXZ78ZeOzfrBnbv8kCX5ST3C1xWR+g/EKSFfLZJ23CrF9VtSZ
         Ld3g==
X-Gm-Message-State: AOJu0Yw2VRM00IgjoZuIq5aaozDUiTonmgtzqF9KcYgX9H4BFn9Y5TMc
        M91s677Ntm5VJgiJzahJKWY=
X-Google-Smtp-Source: AGHT+IEtRcSt9NVo1uDsW5hbfoZYLFuod5ANYVN39ChaMR/+GUeRCvkoEW0Pz+Q+0bhKT3iivXQNsA==
X-Received: by 2002:a05:600c:207:b0:3fe:f74c:b4f6 with SMTP id 7-20020a05600c020700b003fef74cb4f6mr2440929wmi.17.1695946057510;
        Thu, 28 Sep 2023 17:07:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:37 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Enable peripherals on RZ/Five SMARC EVK
Date:   Fri, 29 Sep 2023 01:06:59 +0100
Message-Id: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi All,

This patch series does the following:
* Adds L2 cache node and marks the SoC as noncoherent
* Enables IP blocks which were explicitly disabled and for
  which support is present
* Enables the configs required for RZ/Five SoC

Cheers,
Prabhakar

Lad Prabhakar (5):
  riscv: dts: renesas: r9a07g043f: Add L2 cache node
  riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
  riscv: dts: renesas: rzfive-smarc: Enable the blocks which were
    explicitly disabled
  riscv: dts: renesas: rzfive-smarc: Drop dma properties from SSI1 node
  riscv: configs: defconfig: Enable configs required for RZ/Five SoC

 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   | 13 +++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 23 --------
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 55 +------------------
 arch/riscv/configs/defconfig                  | 52 ++++++++++++++++++
 4 files changed, 67 insertions(+), 76 deletions(-)

-- 
2.34.1

