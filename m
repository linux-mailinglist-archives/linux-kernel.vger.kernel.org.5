Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B577B9F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJEOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbjJENxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:53:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B2139
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:59:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f2719ab2so92056b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696474755; x=1697079555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ids3/+45hUvtPMVAGYEAW18IR7eG26OSuvk1q0KIeuI=;
        b=FGMGqy6NdreEQmknJnTxdfzb0g7+R+QZ5XXvrcschnSESAUJkX0aQRSl3gb8wuJfJj
         uxm6N9mGTpvXb4QH/5JaK1FWkBiyhRp5oOUR+51TjHDxy+9S0xRwccVLfLuPLCc0A2oc
         /MKDOrmBx3amZtSWFZds+tpLV1BM+Iqmu5e2euCYLNSVxhP6xm9WbykXc4QIJcLqlECX
         NBTQ5E6HmpAjYDNxtQ9KqNiYj9VV6mzorahh8ih8tnjAKusLG5jBOs+Kj/OY8SeoUyP/
         6R2fjghUlJlNMtFeh27+Wi9+jnvKDzUnH7J2LQaHIFcay96/njsWCWjL8PfcZFFAsw9Z
         Yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474755; x=1697079555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ids3/+45hUvtPMVAGYEAW18IR7eG26OSuvk1q0KIeuI=;
        b=Hc+pW++HP8X91UJix3F0UoRRJkkHs5qLH+6rRgfDxkpF5hTuNTQNnuOFN79kGUGVI5
         vX5eG5AVe+QzjcQcdW81RtVB8UjjJmrcb1Ryu6KkwLbbDNJ3jPlM6/0ES96PCQncWpP3
         P0K959UGfA2q7NpumFm6iEwRP+YYUxqxYdMEVz52hncrX50tz0DckiaWovdts0LWhoQw
         9Kx9hX8GGCGWF7rEaHOngBkZPDYn6m7NxgyO3MWFn2MckR9ktZfMb2ZrrCLu1NT+i9SO
         kHsSr1TWj2QSY4qSLgs2+O+mj/84EilHb5/kGfKdPQQxWrCbNaOyjvfiwFAdMNY2S2wf
         gA9A==
X-Gm-Message-State: AOJu0Yxj0biFBe9LODTHtrX6ev8LZkR5kO/BCtNkRZY5jcznpnDsi/ih
        WrYmLXraAy0JB6TP5MQtRv5jqvmloC+lQsMM/+VfWw==
X-Google-Smtp-Source: AGHT+IHhyPq2bAIXq1Er7nrpaR11YBXxhlcU8ii3pCisXRHmjRUTM4omwHgQA+YxqvflG1dDFWM5wA==
X-Received: by 2002:a05:6a21:a587:b0:163:c167:964a with SMTP id gd7-20020a056a21a58700b00163c167964amr4845452pzc.1.1696474755450;
        Wed, 04 Oct 2023 19:59:15 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:a16d:fce2:497:afb7])
        by smtp.gmail.com with ESMTPSA id b18-20020a637152000000b005782ad723casm269265pgn.27.2023.10.04.19.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:59:15 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC v2 0/5] gpio: add pinctrl based generic gpio driver
Date:   Thu,  5 Oct 2023 11:58:38 +0900
Message-Id: <20231005025843.508689-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revised version of my previous RFC[1]. Although I modified
the commits to make them look SCMI-independent, they are still posted
as RFC because I have never tested them on real hardware.

(background)
I'm currently working on implementing SCMI pinctrl/gpio drivers
on U-Boot[2]. Although the pinctrl driver for the kernel[3] was submitted
by EPAM, it doesn't contain the gpio driver and I believe that we should
discuss a couple of points on the kernel side to finalize my design for
U-Boot. 

So this RFC is intended for reviews, especially to raise some issues.

1) how to obtain a value on an input pin
   All the existing gpio drivers are set to obtain a value on an input
   pin by accessing the hardware directly. In SCMI case, however, this is
   just impossible in its nature and must be supported via a protocol
   using "Input-value" configuration type. (See the spec[4], table-23.)

   The current pinconf framework is missing the feature (the pinconf
   parameter and a helper function). See patch#1, #2 and #3.

   Please note that there is an issue around the pin configuration in
   EPAM's current pinctrl driver as I commented[5].

2) DT bindings
   I would like to propose a generic binding for pinctrl based gpio driver.
   This allows a "consumer" driver to handle gpio pins like as other
   normal gpio controllers support. (patch#5)

3) generic GPIO driver
   Based on (2), I tried to prototype a generic driver in patch#4.
   Thanks to a set of existing pinctrl_gpio helper functions, except (1),
   It seems that the driver can be implemented not relying on pin controller
   specific code, at least for SCMI pinctrl.

I will appreciate any comments.

-Takahiro Akashi

[1] https://lkml.iu.edu//hypermail/linux/kernel/2310.0/00362.html
[2] https://lists.denx.de/pipermail/u-boot/2023-September/529765.html
[3] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01082.html
[4] https://developer.arm.com/documentation/den0056/
[5] https://lkml.iu.edu/hypermail/linux/kernel/2308.2/07483.html

AKASHI Takahiro (5):
  pinctrl: define PIN_CONFIG_INPUT
  pinctrl: always export pin_config_get_for_pin()
  pinctrl: add pinctrl_gpio_get_config()
  gpio: add pinctrl based generic gpio driver
  dt-bindings: gpio: Add bindings for pinctrl based generic gpio driver

 .../bindings/gpio/pin-control-gpio.yaml       |  55 ++++++
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-by-pinctrl.c                | 165 ++++++++++++++++++
 drivers/pinctrl/core.c                        |  19 ++
 drivers/pinctrl/pinconf.h                     |  10 +-
 include/linux/pinctrl/consumer.h              |   8 +
 include/linux/pinctrl/pinconf-generic.h       |   5 +
 8 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml
 create mode 100644 drivers/gpio/gpio-by-pinctrl.c

-- 
2.34.1

