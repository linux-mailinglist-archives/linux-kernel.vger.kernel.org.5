Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123D7E1E6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjKFKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjKFKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:33:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1699
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:33:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso2168200f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699266799; x=1699871599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlw5HxIULTW6/Y+wZ7qEz5z78H/my/JnN6AqQuvllNo=;
        b=WPRBBWX3uYXHjnG4cN1t9SOL7xnD2U4rn66tf52L1f9zcPESNEgcvuk6ZHNBr+5sxp
         45ilXqSiWLq48TV9Sou5eTKFGe1o3JjI23wNZu52vLpIGxYR539tz1Bl5DY/Aa0l7XMk
         napLjUxiZ8VIcHTQVUX35UcpvSB2rX1Y3hYgqzBNkQ6P98P27PEHXU2LdJSXqiFznWgt
         tRqMTb/M18rMiH1SroqfH3usviStWu6j6ayBqSkiQtTjBpfke+8vYLwziJ2UpOZswMn/
         +sLXot5U7Ikj1GFI4PzeHdA7nMpmHU0gsNHKbm9zntCkkXCq1QXgzQy396DsxYsvyQYc
         MmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266799; x=1699871599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlw5HxIULTW6/Y+wZ7qEz5z78H/my/JnN6AqQuvllNo=;
        b=FL9wexUojQdggELCJQLF4JHJjbpGdUFKgr5KtpkXqlSIptb220s4TcqHUuc85VyeE7
         6JIDeCfwALR4aQ4Bq0O9xfwkt+QGmiw3eYzThdktGcYzXnJdlKFTjRMV19KfMP4zUHUW
         fQvsdWanGX/FC5A5jFQJEg2xyOF6/FIeswmfEc+Jjr82uWAySTHoU+TPnu9ujPjsXKh2
         J8mo+HY3P8WsEWYAdVo7vCK8gaEcQqYdtiQQcuDD0B9fUfdczR0zzJcfjLZ8vPFJAwhw
         X+yVn359E+9/TC77i0HNxq6iyQJMd6+/rYSt/cb1GPknryCXM9tcTxoxIqE7UEhFs1LL
         kNFA==
X-Gm-Message-State: AOJu0YzoE2W+6msgGwHiJBXm1LJ0PSb94lBLkwxzA6K7IfFMNQE2kUFA
        uuX715XpysAiFVha3uuvcCo0Rw==
X-Google-Smtp-Source: AGHT+IHzv/E3x2UyZHstlPEHYl4kHcZKQvmPeHGYQ167btT+c+1bBfLcj35EW0Wc7pkdgodfZZ7zXw==
X-Received: by 2002:adf:ed4f:0:b0:32d:a366:7073 with SMTP id u15-20020adfed4f000000b0032da3667073mr9251507wro.14.1699266799485;
        Mon, 06 Nov 2023 02:33:19 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056000114100b0032415213a6fsm9033602wrx.87.2023.11.06.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:33:19 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH 0/6] pwm: meson: dt-bindings fixup
Date:   Mon,  6 Nov 2023 11:32:47 +0100
Message-ID: <20231106103259.703417-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to:
* Fix the incorrect bindings for the s4 type of pwm that was introduced
  while converting the documentation from txt to yaml format.
* Introduce a new compatible for the existing PWMs to better describe the
  HW in DT, instead of describing settings.
* Make the introduction of a new pwm variant (s4) slightly easier.
* Migrate the supported SoCs to the new compatible.

Usually, I prefer to send to dts patches separately. This time it seemed
important to illustrate the change. I don't mind splitting this out and
re-spinning if this is annoying for the maintainers.

Jerome Brunet (6):
  dt-bindings: pwm: amlogic: fix s4 bindings
  dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
  pwm: meson: prepare addition of new compatible types
  pwm: meson: add generic compatible for meson8 to sm1
  arm: dts: amlogic: migrate pwms to new meson8 v2 binding
  arm64: dts: amlogic: migrate pwms to new meson8 v2 binding

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 101 +++++-
 arch/arm/boot/dts/amlogic/meson.dtsi          |   4 +-
 arch/arm/boot/dts/amlogic/meson8.dtsi         |  16 +-
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts   |   2 -
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts     |   2 -
 .../arm/boot/dts/amlogic/meson8b-odroidc1.dts |   2 -
 arch/arm/boot/dts/amlogic/meson8b.dtsi        |  16 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  24 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  28 +-
 .../dts/amlogic/meson-g12a-radxa-zero.dts     |   4 -
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |   4 -
 .../boot/dts/amlogic/meson-g12a-u200.dts      |   2 -
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   4 -
 .../amlogic/meson-g12b-a311d-libretech-cc.dts |   2 -
 .../dts/amlogic/meson-g12b-bananapi-cm4.dtsi  |   7 -
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi |   4 -
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   |   4 -
 .../boot/dts/amlogic/meson-g12b-odroid.dtsi   |   4 -
 .../dts/amlogic/meson-g12b-radxa-zero2.dts    |   8 -
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     |   6 -
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    |   6 -
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |   2 -
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   8 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |   2 -
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   2 -
 .../boot/dts/amlogic/meson-gxbb-p20x.dtsi     |   2 -
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |   2 -
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi    |   2 -
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  26 ++
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |   2 -
 .../meson-gxl-s905w-jethome-jethub-j80.dts    |   2 -
 .../meson-gxl-s905x-hwacom-amazetv.dts        |   2 -
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |   2 -
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |   2 -
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     |   2 -
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  26 ++
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     |   4 -
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   |   2 -
 .../amlogic/meson-libretech-cottonwood.dtsi   |   6 -
 .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     |   6 -
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |   2 -
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    |   2 -
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |   6 -
 drivers/pwm/pwm-meson.c                       | 312 +++++++++++-------
 44 files changed, 407 insertions(+), 267 deletions(-)

-- 
2.42.0

