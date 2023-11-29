Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85FA7FD854
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjK2Nk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjK2Nk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:40:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81C1CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:40:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b427507b7so28262625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701265230; x=1701870030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+Pbp6mZjXY9AOVHyk09IUOp31RXPk8rQUCNdGc1tCY=;
        b=I+ruoS2RkHPoR0e1MzjmbnUvQ05fn4YS9FyrhZF6jxhEKz1XMqCDd7VQ2gor+hVCE4
         8wUsnB26Zq2oMbWB4ljyh7X8MM3w0zBIhB9eEDOI2NBNdBwY/gDwOS8wvBJo4c9iIzt8
         Sc/o0x0HGFMcRIEqTaX/VcoIEa1+mMbStTdgkBGS5tBF/0DfIXUQtJrig2DlWkv1gtyx
         5Wv3b1jOicPpjPFZjBqGK2wyVgzkBP6nsZal5UmWn9TlRo+i+7I15R30qk6Ya7gFR1lq
         leX+EXFVGd06iIwuZZBM2LO7FHlazshJkdpUVYeNS1wYQTb61+4mVs0NYYcWwkf+u9id
         F80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265230; x=1701870030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+Pbp6mZjXY9AOVHyk09IUOp31RXPk8rQUCNdGc1tCY=;
        b=jOxx+HcetJKEJw0NuzZcv/Ia785JOyffvigB8QhZbjrvotuQlozQa85LN8ze3HX8KI
         vT5bBgnGJNhDsXNcNLZC9dOrxQjwmX4w5xP4UeVlmyoL0P3iZLW+QcbynPNsO0eRp3xM
         hHmu6VzMkgnCF8uCcGrHNOr1TfJNTugpWY6EEPU4DfZecb91v+0DaUa2I9a+QRuaiKel
         i4CwhlKSLjAhEs8faPfmX8FftK2ot7cDpgZzJjrESiiwc1tTa9PxxvVN1TufozcG7rau
         oidB8/jzh7tyEK/WFmISzWO436iViQP3GgR3XmoejEB/hhiBh+5AvgPjRohBX3/JZady
         dwog==
X-Gm-Message-State: AOJu0YzdSOb9IXOvSlSKgRHbZp6rKMkd5yazCoFgDNHX3uqzrUUhFvLs
        nqC9rZ8mKLEl8jrgIrgc0OnUaQ==
X-Google-Smtp-Source: AGHT+IFimkB/NvQ9JKpZdb8dhZJPKiL5MbqRL7v7mEG3FmxZZdYg2Q3Ku0T1nbZi2786+HnKOlRtrQ==
X-Received: by 2002:a05:600c:19ce:b0:40a:3750:46ff with SMTP id u14-20020a05600c19ce00b0040a375046ffmr13442144wmq.11.1701265230308;
        Wed, 29 Nov 2023 05:40:30 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6101:5529:fe2d:d7eb])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004080f0376a0sm2285860wmo.42.2023.11.29.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:40:29 -0800 (PST)
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
        JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 0/4] pwm: meson: dt-bindings fixup
Date:   Wed, 29 Nov 2023 14:39:56 +0100
Message-ID: <20231129134004.3642121-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
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

This patchset aims to:
* Fix the incorrect bindings for the s4 type of pwm that was introduced
  while converting the documentation from txt to yaml format.
* Introduce a new compatible for the existing PWMs to better describe the
  HW in DT, instead of describing driver settings.
* Make the introduction of a new pwm variant (s4) slightly easier.

Uwe,
Patches #3 and #4 conflict with patches #18 and #68 of your pwm rework [3]
I understand such wide rework are difficult to handle. I don't mind
handling the rebase of the amlogic patches you have proposed if this gets
in first. Just let me know :)

Changes since v2 [2]:
* Drop DTS changes. These will be re-submitted later on. Possibly after
  u-boot gets support for the new compatible to minimise conversion
  problems.
* Position deprecated property correctly in dt-bindings for the old
  meson8 type pwm bindings
* Reword commit description of patch #2 to make more obvious it does not
  introduce a new HW support but fixes a bad bindings.
* Dropped Rob's Reviewed-by on patch #2. It seemed appropriate considering
  the discussion on this change.

Changes since v1 [1]:
* Fix typo in the new binding compatible documentation
* Disallow clock-names for the new compatibles in the schema documenation

[1]: https://lore.kernel.org/linux-amlogic/20231106103259.703417-1-jbrunet@baylibre.com
[2]: https://lore.kernel.org/linux-amlogic/20231117125919.1696980-1-jbrunet@baylibre.com
[3]: https://lore.kernel.org/linux-amlogic/20231121134901.208535-1-u.kleine-koenig@pengutronix.de

Jerome Brunet (4):
  dt-bindings: pwm: amlogic: fix s4 bindings
  dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
  pwm: meson: prepare addition of new compatible types
  pwm: meson: add generic compatible for meson8 to sm1

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 113 ++++++-
 drivers/pwm/pwm-meson.c                       | 312 +++++++++++-------
 2 files changed, 291 insertions(+), 134 deletions(-)

-- 
2.42.0

