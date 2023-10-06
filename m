Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F617BB42D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjJFJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJFJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:28:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B669F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:28:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso336802766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696584508; x=1697189308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bSbH7Mb5GSQSJoLnedL80ZckH8kE8PXIhbQkOYsiAY=;
        b=ctBP8Wu6EGT5d4AIgtSyKAxgswhuhNimhODPxanXXTUzxWbsQyrQCvCAIGTstLGQdd
         Fh+LlxddVTfFjrCFZ6OpxXJ3A6XKj45D6i70x5HPr12AECnaN8GIbBzGk1/GSMNB1rR2
         hnMJ+HdUiRts40i/OEwm/q0YnZz7pxsYTNqQ0Xh7A1YaGK29uQf6wxNovm9a5wNTP1Af
         oqaegudRRhIwuWqwOkv7eauPkECUPT0k4rgSLm93ERLsnh/Kk6Br5FuyScU1cqXPJIJs
         8kltacJr2td54+aHZfokpNkXqNm7J4/7PWtlHQ1Hrlvcf9omnxQVma2UQrIwfWzV5KVp
         SVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584508; x=1697189308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bSbH7Mb5GSQSJoLnedL80ZckH8kE8PXIhbQkOYsiAY=;
        b=vrB/PQs8sT6gc4bjpjNVkREvaE3Hohn7KYORWs3/1xcWCQryF3jgXgrTV8rfe6sww7
         lAFmyDQ56TIpqTNCovUAPbsw0r8S8XX3qfDOMdlsJklCW8II4tL3IXhrIIg5Yo8kY2BO
         tWTmTkKssFpzynvnzYlRxKdSEFAfWbkp0mxfKAETrmkWatxawC0LqCuDO9lEC2go9bE8
         nsBxNQE7tx5iGviCJlCVkGt+xmg863VnIVOIdc3bxIO4thX9W+aTPnvjqzv8xaKQhLYC
         d4kNCQqYTVS1bfBjvIhfWIQcWYMgCAamUKaRboCAIHlWgZIpYiOxEJ25q/8hlSVgvnMa
         cNiw==
X-Gm-Message-State: AOJu0YxtKibcYywFe1VYnNhuj45JSx8ji3ojhbfJvtebfAA+YEpPLf19
        wVTBR/GXw0J0mDApXsQ9p1eqwA==
X-Google-Smtp-Source: AGHT+IEWs2nqngYhYzn5PhBtTkMncovhJGe77kZVyEsxhmq2G52pUMuisPqS3lS0pHUT7j2+rUcvfQ==
X-Received: by 2002:a17:906:3f04:b0:9ae:5568:b6a8 with SMTP id c4-20020a1709063f0400b009ae5568b6a8mr7480532ejj.10.1696584508014;
        Fri, 06 Oct 2023 02:28:28 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709063b9900b0099bc2d1429csm2573006ejf.72.2023.10.06.02.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:28:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: dts: minor cleanup for v6.7
Date:   Fri,  6 Oct 2023 11:28:23 +0200
Message-Id: <20231006092823.94839-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006092823.94839-1-krzysztof.kozlowski@linaro.org>
References: <20231006092823.94839-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.7

for you to fetch changes up to 73f20a373811b303fc5bd8f3d5a4c5c1582f1ba2:

  ARM: dts: nuvoton: add missing space before { (2023-09-24 20:56:01 +0200)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.7

Few cleanups and improvements: split joined reg entries for Ethernet in
omap3-devkit8000, add missing spaces before '{' (MediaTek, Nuvoton) and
cleanup whitespace around '=' (MediaTek).

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      ARM: dts: omap3-devkit8000: correct ethernet reg addresses (split)
      ARM: dts: mediatek: add missing space before {
      ARM: dts: mediatek: minor whitespace cleanup around '='
      ARM: dts: nuvoton: add missing space before {

 arch/arm/boot/dts/mediatek/mt2701-evb.dts          |  2 +-
 arch/arm/boot/dts/mediatek/mt6323.dtsi             | 58 +++++++++++-----------
 arch/arm/boot/dts/mediatek/mt7623n.dtsi            |  4 +-
 arch/arm/boot/dts/mediatek/mt7629-rfb.dts          |  2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts  |  4 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts |  2 +-
 .../dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts |  4 +-
 .../boot/dts/ti/omap/omap3-devkit8000-common.dtsi  |  4 +-
 8 files changed, 40 insertions(+), 40 deletions(-)
