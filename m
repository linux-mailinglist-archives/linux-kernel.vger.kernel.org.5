Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C95803BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjLDRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjLDRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:03 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5033A129
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:09 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d858670630so2500476a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711308; x=1702316108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSgbctHdB3nT3F64Pa0svm72epawKOhkGz5KAA6x7XU=;
        b=yNxFS4yZHpi2urwGRYlxv3gMUuSd/nEIq6nqv/B2NaxzsqTIUBAWBcJo0xBVVN8Ojo
         GATMjxQtA2VMfCyKsLDkijbYy4NjiPqgxbtKsWn2ms/P7npV0ZhqcICMvMhf4y3NXXus
         +1cJAyhHJb95UYN70CnDPG9AwQh+hfMpO5a7Y1wRpBeFy7tV/s8vku40Kr3OsseoAPit
         26NlrOJmbE8g2YNrZHvbJfXNqWQe8SptvrqissbAIT7H0pcSIAG/FzC6pp6KIuBR3sga
         YsDI6MIRpYRn0MfBKidNb0zo/YicQ8C0Bi+6mDnq0d/8dvW+G7z56zbmU71h6YEQ62wM
         k5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711308; x=1702316108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSgbctHdB3nT3F64Pa0svm72epawKOhkGz5KAA6x7XU=;
        b=TlVZCc6E9Jlh1ZV/EXEAJhBhxhqaY2eE1/Fid4ur4BKlJa6jsAAYuQq3qj2P379AEd
         KreqvjOBOMwl2rBtxItFg6gCbJiV7Ah6PsLMcV4FLkownvCtwqc+ZYLu6CPPWVIXNQQH
         udS3rVSD72fWqOlOdoBv9VF4yYYwAn2GFqiNS5+IAzwzJFGQ9xpOSsmyx05RQvdRi5Hw
         6saj4AllPSxYkqQ0dORislrT3O8DzXgV9uj5jq2mFnxS7YzZOdY38JOAbcH79IbCKbFW
         +eW/zqNIEKr4u1JX+Iva0Vcz0xwD87z7A7zKbr9mzN8LSXXmKEIQ8WwL+EKL5fBighee
         nfKg==
X-Gm-Message-State: AOJu0YxL9555BF338OFVpLH0Os/MnVtzpTtNEPqxbkTDD7tFaMOa9/WB
        KPLaOLeE+9u248bNt+65dXvy4XmZbvlihfyL4bs=
X-Google-Smtp-Source: AGHT+IFuhLxuodlCfJZ98oWkvvbGD90kBp5dagSX7pMM4e2JBaL3lrkJk+JRFZm+pi12hlED/ZXSeQ==
X-Received: by 2002:a05:6830:2a8a:b0:6d8:74e2:b009 with SMTP id s10-20020a0568302a8a00b006d874e2b009mr7388038otu.71.1701711308682;
        Mon, 04 Dec 2023 09:35:08 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:08 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Date:   Mon,  4 Dec 2023 11:33:26 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are working towards adding support for the offload feature [1] of the
AXI SPI Engine IP core. Before we can do that, we want to make some
general fixes and improvements to the driver. In order to avoid a giant
series with 35+ patches, we are splitting this up into a few smaller
series.

This is a continuation of the work started in [2] which has been applied
to spi/for-6.8 [3]. This series must be applied on top of that series to
apply cleanly.

Once this series is applied, we will follow up with the 3rd series that
implements the offload support. The offload support will also involve
the IIO subsystem (a new IIO driver will depend on the new SPI offload
feature), so I'm mentioning this now in case we want to do anything
ahead of time to prepare for that (e.g. putting all of these changes on
a separate branch).

[1]: https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offload
[2]: https://lore.kernel.org/linux-spi/20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-6.8

---
David Lechner (9):
      spi: axi-spi-engine: return void from spi_engine_compile_message()
      spi: axi-spi-engine: populate xfer->effective_speed_hz
      spi: axi-spi-engine: remove spi_engine_get_clk_div()
      spi: axi-spi-engine: fix sleep ticks calculation
      spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
      spi: axi-spi-engine: implement xfer->cs_change_delay
      spi: axi-spi-engine: restore clkdiv at end of message
      spi: axi-spi-engine: remove delay from CS assertion
      spi: axi-spi-engine: add watchdog timer

 drivers/spi/spi-axi-spi-engine.c | 116 ++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 39 deletions(-)
---
base-commit: 8e6a43961f24cf841d3c0d199521d0b284d948b9
change-id: 20231129-axi-spi-engine-series-2-5f0a6053dea0
