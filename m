Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837437FB8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjK1LCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjK1LCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:02:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF33D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:02:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a0b65cbf096so402135966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701169331; x=1701774131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlZ7iRVbsbRidcAsAmtD7uKZxC1LTM8QUx5hPAqk8yg=;
        b=W2Trhb0JSVRC4Id5dnhE6AaKDRq/+PwC2mTMKfTcKwLmc8/W99ODvGQ4A+JrHZwZxs
         LSx/d+M/mjiM/QSwDQCeFYOywRW5ODXqeWAXzEqYFhp6iuzas5lUUCzZYM6eIJIb0Uoh
         2ssG1fib4MVVtq7S6eXqW1u9IQgLykrMw7LrxreACwxIKT46zdaIeawdqsUajkEPobwB
         nxq0QSAjef1FONMUKZJecjnXNvCs7kGGgzCmEPVQg69QYmBJFHKz+xg9XStKCGOjnUeG
         OXBRtjyz08Z8rJUxwKl/NQj7kHJyLXnxMRjIJKRQQstkR+sZSzEsrKFQdomwJmm6wXlt
         xd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169331; x=1701774131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlZ7iRVbsbRidcAsAmtD7uKZxC1LTM8QUx5hPAqk8yg=;
        b=NNv83wunK8RgHWWB5a2jxBGuABletT3L8WwmQcqbbGPm/kmnrL/QSfv+KMtFrwLx20
         hdK4fl5wCjcY0Qkq2DI6wLSfSHHWyooSuY9D9ESCwJo/ZWo5YlAzFuZWgOIIMA0AiO8k
         8x+TXpah48saWh42aZHKz9KY7ZgXcloleP1AvbsfiIwweSuGsYnMTosl0/QM6GQnRfOn
         /k+ZuSfQA/6NVc7r9FS9ZhtedWwtrWosDxorTbhBoEFLwlLqbLinUWlXBEsPz6RWAaZ3
         RoDcJTQ3hZC4L8nkIfmoYL6+XXD5s09E90+FTAgC2RTzGDq4uQ8Ij5AEMZ/7t1A+0EIo
         9sRA==
X-Gm-Message-State: AOJu0YzXF8rR+gisZss2hZYs2zmsj4J88USWS5O2rAoAIhTYhaW1jXmx
        L/gfUQ1Opf0h3rd2eknoJ1Lo4g==
X-Google-Smtp-Source: AGHT+IFUj+xpwnpY3qS1pNq5O+DvIQpTB85bW2X9Y3htbbDBUWs40lSNUrXAQgbY77iHKyKck0o3ow==
X-Received: by 2002:a17:906:209e:b0:a0a:f9af:c159 with SMTP id 30-20020a170906209e00b00a0af9afc159mr8796679ejq.25.1701169331054;
        Tue, 28 Nov 2023 03:02:11 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906111900b00a0435148ed7sm6784897eja.17.2023.11.28.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:02:10 -0800 (PST)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 0/2] iio: temperature: mlx90635 Driver for MLX90635 IR temperature sensor
Date:   Tue, 28 Nov 2023 11:59:22 +0100
Message-Id: <cover.1701168726.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

There is a new contactless sensor in Melexis portfolio. MLX90635 is just
1.8x1.8mm in size, but with factory calibration offers instant usage
in every project. It offers wide refresh rate range that is configurable
between 100ms and 4s.

Driver currently provides temperature calculations, power management and
changes to the refresh rate. Since sensor is aimed towards the consumer
market there is really low number of EEPROM write cycles available, so
driver changes refresh rate only in run time registers to avoid writing
to EEPROM. Reading EEPROM is not available in Sleep Step mode, so I am
using caching at the driver initialization to ensure that measurements
can still be taken in Sleep Step mode.

Changes v1 -> v2:
  - dt-bindings are now enum according to the comments from
    Krzysztof Kozlowski
  - expand the path recipient list for the patches using
    get_maintainers.pl
  - driver cache and probe (and some style) adjusted according to
    comments from Jonathan Cameron
  - improve DSP version detection (make it clearer)

Crt Mori (2):
  iio: temperature: mlx90635 MLX90635 IR Temperature sensor
  dt-bindings: iio: temperature: add MLX90635 device

 .../iio/temperature/melexis,mlx90632.yaml     |   19 +-
 MAINTAINERS                                   |    7 +
 drivers/iio/temperature/Kconfig               |   12 +
 drivers/iio/temperature/Makefile              |    1 +
 drivers/iio/temperature/mlx90635.c            | 1071 +++++++++++++++++
 5 files changed, 1108 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/temperature/mlx90635.c

-- 
2.40.1

