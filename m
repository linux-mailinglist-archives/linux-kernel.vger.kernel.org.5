Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312D7B551B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjJBOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:10:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF92AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:10:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so160504945e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696255836; x=1696860636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wbehdpfeTskgBGeNboTr1Vt3I7y4UPyUbI3qTqn6yY=;
        b=qbe+GG1k4scQTfjMY0gNish5fb0uflshUS9QfF0/TnG4dqjayTkAGAXiMso/zT0YeG
         n/qFr8hUxkwETbq2StvC55t78FLNAN3hYAxeDkRWVdnANHNTtHMvLDCfMWCdRBjXDS/a
         tjvnGS81crq6gLA9MNR5TglsQzxGzxFGjzDsy6DgBMqwH20VRgWEhpGUl7DlLoaCiPBt
         9iqt2Icv0XIUAXiUWLKGwhXuA/p6IZkRm/75ejjCinIZdBz2fFV3l1BIIUs3bc0BMy5q
         7Z0MDMEmMd5D/FgqDSuncc0vS+x48ZPI1u4+Zzrbfr7bUGwl6/dUBDQ6mk3ccq6CA40U
         Cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255836; x=1696860636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wbehdpfeTskgBGeNboTr1Vt3I7y4UPyUbI3qTqn6yY=;
        b=KacX6ovWzaAPwYzragAaoIz1VfteR8f1xYKjuWdyJ3Cg2/L5sg9MtvT78bjiCM81JH
         DRO8N+ftkdbkks5Ru7/reIy4QcZsQwtaUlyvAaJz2JtO1bzPZ9RfN+0xtCssV+xmuIIT
         LKZdyoyHcdgzbCEf/ZoR/vVAAUiBOQaC+RErCuwUDZN5AVO+ORpWEiQRybHZ5rkYKSd6
         y1dScAEaUgjT9NyIrwJcuQhkaXJUmqATX1COPKgXp8+GYTzpdQOYQsHPRTfcTM54HXUO
         mSzYOjqiDvRBvAIFrs1CSPftMXkpQf1PULZeCQKMfj96zugda4pBVAT17InFaWzVCgHY
         CN4Q==
X-Gm-Message-State: AOJu0YzjXEXFmbgMFJ/HhIC0gz/+ifrw8kmDNbxhZ032cTIJbfnWDABG
        YnLVnBn5BRqpstA/Wm451rYJ8Q==
X-Google-Smtp-Source: AGHT+IHak2pzWxI31EARsFs3PYfLjm4QWGcS1E6hRazzJjbQPUoLCM7VWxR3/LzQtmwlQLZKnGLI1A==
X-Received: by 2002:a05:600c:2214:b0:3f7:cb42:fa28 with SMTP id z20-20020a05600c221400b003f7cb42fa28mr9119350wml.28.1696255835696;
        Mon, 02 Oct 2023 07:10:35 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fcf2:65f1:853c:13be])
        by smtp.googlemail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm7361911wmr.33.2023.10.02.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:10:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Mon,  2 Oct 2023 16:10:18 +0200
Message-Id: <20231002141020.2403652-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Libretech cottonwood board family.
The 2 boards are based on the same PCB, with an RPi B form factor.

The "Alta" board uses an a311d while the "Solitude" variant uses an s905d3.

This patchset depends on the usb support for the gl3510 [0]
Without it, there will be dt check warnings and usb may not come up properly.

Early u-boot support may be found here [1]. It will be submitted after
DT is accepted in Linux. As usual with Amlogic, u-boot must be packaged
with closed source binaries ([2] for the a311d, [3] for the s905d3)

Prebuilt bootloaders are available from libretech [4].

The devices are shipped with libretech's u-boot pre-flashed in SPI NOR.
If necessary, the boot source may be changed to MMC using the onboard
switch.

Happy hacking ...

[0]: https://lore.kernel.org/all/20231002122909.2338049-1-jbrunet@baylibre.com
[1]: https://gitlab.com/jbrunet/u-boot/-/tree/cottonwood
[2]: https://jbrunet.baylibre.com/pub/amlogic/fips/fip-collect-aml-a311d-cc-20230701.tar.gz
[3]: https://jbrunet.baylibre.com/pub/amlogic/fips/fip-collect-aml-s905d3-cc-20230820.tar.gz
[4]: https://boot.libre.computer/ci/

Jerome Brunet (2):
  dt-bindings: arm: amlogic: add libretech cottonwood support
  arm64: dts: amlogic: add libretech cottonwood support

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-libretech-cc.dts | 133 ++++
 .../amlogic/meson-libretech-cottonwood.dtsi   | 610 ++++++++++++++++++
 .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
 5 files changed, 836 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts

-- 
2.40.1

