Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8EA80A7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574409AbjLHPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjLHPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:52:32 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73021724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:52:37 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9d4193d94so1351259a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702050757; x=1702655557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUg/znhTOIWnO1n9WUNrCkz7MCYRa0cNRXdZfa57rxM=;
        b=2GNma6WTvnX2ZM/RSDQ3MEaemiUC4QZ9NKeWp4HNL4R4GlzzPFOUQ7Q3Kb6OODPv7l
         SishtNxHzlh887P27mgmLOMYvkyGtyBkBjmmBH8qaQJyNURnRraK8BQ3URT0glCixsME
         dTt8kyuJDkwcczuBph+N76QmFCeC89t7vRuerzRqq5cb5YuHaatYPWld0aI6hsADby29
         ClYz3vvLc4yYWM3M2R74m6Y8UEBYyqUaYAn+ZKqWF3ApqtTvn+vOUYP5rsfCT1XmdQ0x
         zhLE1HoXwkm+LLL6jmDPJqYRpTNN0nOhAl81l3AOe3z37IRMRm5dU/pbXtO0hgw2p3N8
         qxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050757; x=1702655557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUg/znhTOIWnO1n9WUNrCkz7MCYRa0cNRXdZfa57rxM=;
        b=lixZldVaZcB4+Z/+wqK15B7EAPL33d1MCVxEeJmZQGepTUaD9/PU4QD+cp3i4vjv0d
         4AMqzgTBJnvrPfOz9FQNDb/0hCGZwG/WF2/qSKzwehxhqgA/uyk6HY7wQXZlYrL3jmun
         /KEdSTZXgLWiEbCP6lSkgELFzwmhKDgIftSEhTd5gleJTW+DPgYrM32NI2YTZley8LMi
         tCH3XHJ0jXghU7wT5ULpTVfQ/J4KIbyUgWi/I/aR5o5ftBTKPlKd4NoUKkqV/P+vHTFX
         G08UBg8Rv2/+0aCmVPojq9lYLAXUOa96ynVtvBOTvZ30VOtWse86986HPisuhzEDQjya
         uexw==
X-Gm-Message-State: AOJu0YwHTre4cFwiVD2P6xAKZhlk/WvLowO+6W9ZvJhqsp032VvgeCY6
        t81ORfSlv+wMjSI4QCL7qvc0CA==
X-Google-Smtp-Source: AGHT+IEvZm96yDwkXa4CYNB62gvIRQrwcn8Dogy1yVqamELwSIJAM+evvjcjOg0JkXwSpAfPt97sTw==
X-Received: by 2002:a9d:7519:0:b0:6d8:4bfb:eb4c with SMTP id r25-20020a9d7519000000b006d84bfbeb4cmr242635otk.9.1702050757188;
        Fri, 08 Dec 2023 07:52:37 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v3-20020a9d7d03000000b006d99d363723sm332032otn.63.2023.12.08.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:52:36 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 0/2] iio: adc: add new ad7380 driver
Date:   Fri,  8 Dec 2023 09:51:39 -0600
Message-ID: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is adding a new driver for the Analog Devices Inc. AD7380,
AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
simultaneous sampling SAR ADCs.

To keep things simple, the initial driver implementation only supports
the 2-channel differential chips listed above. There are also 4-channel
differential chips and 4-channel single-ended chips in the family that
can be added later.

Furthermore, the driver is just implementing basic support for capturing
data. Additional features like interrupts, CRC, etc. can be added later.

Also, FYI, this driver will also be used as the base for an upcoming
series adding AXI SPI Engine offload support for these chips along with
[1].

This work is being done by BayLibre and on behalf of Analog Devices Inc.
hence the maintainers are @analog.com.

[1]: https://lore.kernel.org/linux-spi/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com/

---
David Lechner (2):
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 467 +++++++++++++++++++++
 5 files changed, 596 insertions(+)
---
base-commit: 18f78b5e609b19b56237f0dae47068d44b8b0ecd
change-id: 20231208-ad7380-mainline-e6c4fa7dbedd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

