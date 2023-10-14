Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3F7C95E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJNSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjJNSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:20:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71EED6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso628394a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697307606; x=1697912406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6fOl+bxIlDqRdabWV4eMcPga/r08+UAl61pbyIP1Fbo=;
        b=CI/R2blfT4aj3bZA7FuBTBeCrJ5D1W2lHpUTuttuu2icJ7h6uiub6248pm+8c6M8NM
         m4fTxS5O9ojlGfEH93efaSgq3rTL5da5LiMNZQ9hT5+pw4kpUh1onmnSTYXxF7fk9MxP
         ThSlg1PWRHIKfB1jpIjpZHj28T/6vhLCDNLMiU6OPcD6dI4Pfsvee4yf1RDiapfdjs9q
         CAcuvii6W0pfYj11QwCEoNmtkPN2WBeGshP5tbkHqa7ZhomYk86kzPx98Z/DJJkx4HGH
         afxqRWLjuDPK0DbK1nbItP9BVuxmWK9TJaBHX+48xzzaLXjty4SHHz1Reoc6SEnnRn6O
         kMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307606; x=1697912406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fOl+bxIlDqRdabWV4eMcPga/r08+UAl61pbyIP1Fbo=;
        b=GUUZ5OD3FYs6KOIg+Pozaip6UdxQYr04FHt8kzS7j0LBAexqeZnv5Babk6m8zfSDhv
         IZCslJGYk3zuuqrydHUYcCCsbovAGNmbknboTJ/hsS+cMo6/3l9PuLE3FM8m0lCgpmcJ
         oBv3irF+twiQwm8hC9twRgXZeJPZpJiYzXiTaI2BuGVCjc5K2uC/C1kDZagwzXE+exUa
         7X+ZFmOrTRJ9Dkjdgu0AaPoM4S4F9MVF00OKbXsiHdKBQCEobG7voLu+blzHLxpooxXV
         SqiFYnjdpTr1sOhs49lVQ1uiMYA+/7IhQSQSVhjweAOCtpsB9/zZIV35RLSu729WlR5j
         nojw==
X-Gm-Message-State: AOJu0Yx1uqvTjmaCoUbY9gatUITUrLPi7mjY/tcxzbBNxYeQfqwqCPDr
        DDee8I3KMfLNqcNVU9iJRU2dJQ==
X-Google-Smtp-Source: AGHT+IFR9nQTum39uWgT3lfCZqNdApJtGkGJUxCRS85dC01cenjmbGl9KKwCRplUainYK5xaGtAtLA==
X-Received: by 2002:a05:6402:241a:b0:53d:bdd2:3d62 with SMTP id t26-20020a056402241a00b0053dbdd23d62mr11762343eda.30.1697307606118;
        Sat, 14 Oct 2023 11:20:06 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b005231e3d89efsm13032574edx.31.2023.10.14.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 11:20:05 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v4 0/3] clk: si5351: add option to adjust PLL without
 glitches
Date:   Sat, 14 Oct 2023 20:19:40 +0200
Message-Id: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALzbKmUC/y2NQQ6CMBAAv0L27JJuoQY9+Q/DoSmLbGgKtoRoC
 H+3oseZw8wGiaNwgmuxQeRVkkwhQ30qwA02PBilywxa6YoU1Wj9KgGdHzGJqQxhmHD2HiMnXpB
 db52yZ2OUg9yYI/fyOvr3NvMgaZni+9it9LX/smqIqNJ1aRptLgbpN7rNz5jKboR23/cPER/K6
 a0AAAA=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to address a problem I had when using the Si5351A as
a runtime adjustable audio bit clock. The basic issue is that the driver
in its current form unconditionally resets the PLL whenever adjusting
its rate. But this reset causes an unwanted ~1.4 ms LOW signal glitch in
the clock output.

As a remedy, a new property is added to control the reset behaviour of
the PLLs more precisely. In the process I also converted the bindings to
YAML.

Changes:

v3 -> v4:

- remove spurious | per Rob's suggestion
- simplify conditional clocks/clock-names per Rob's suggestion
- remove mention of clkout[0-7] still being admissible in the commit
  body of patch 1 - while the Linux driver still tolerates this, the
  new dt-bindings do not

v2 -> v3:

- address further comments from Rob:
  - drop unnecessary refs and minItems
  - simplify if conditions for chip variants
  - ignore his comment about dropping '|', as line would be >80 columns
  - move additionalProperties: false close to type: object
  - define clocks/clock-names at top-level
- drop patch to dove-cubox dts per Krzysztof's comment - will send
  separately
- collect Sebastian's Acked-by

v1 -> v2:

- address Rob's comments on the two dt-bindings patches
- new patch to correct the clock node names in the only upstream device
  tree using si5351

---
Alvin Šipraga (3):
      dt-bindings: clock: si5351: convert to yaml
      dt-bindings: clock: si5351: add PLL reset mode property
      clk: si5351: allow PLLs to be adjusted without reset

 .../devicetree/bindings/clock/silabs,si5351.txt    | 126 ----------
 .../devicetree/bindings/clock/silabs,si5351.yaml   | 269 +++++++++++++++++++++
 drivers/clk/clk-si5351.c                           |  47 +++-
 include/linux/platform_data/si5351.h               |   2 +
 4 files changed, 315 insertions(+), 129 deletions(-)
---
base-commit: b7c08e5d3824bc57182b308c1e158ddfdbe4cd00
change-id: 20231014-alvin-clk-si5351-no-pll-reset-ecfac0a6550c

