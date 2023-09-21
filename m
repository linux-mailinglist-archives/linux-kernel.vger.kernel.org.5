Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED987A9E78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjIUUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjIUUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:01:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250C561EA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503065c4b25so2041620e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316667; x=1695921467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dbJ671h4+Zrpefl6Lm2RwGWdFjdR10s5YR4gHySBBk=;
        b=NQ94HS2zaHbq4AX1gzgwj4jFQPBZDwQCxvMzkbmKz3dFU/u3k8mOxKiWOusqxpt7EC
         Zpy0wlQDdNx6/86hPjnKmXF2ye6It4lJ/gcxLDOS2yKcs2NFZAuYMGula2Yi2rSPqHxu
         WVU03d5VtlO+Q8z75gvkzGNM1oygM9TPxEskcZgcA1/2mP2FE/14TnvLxTYIZGyCpHqe
         nqq36hrqxOuwHxui6CtmT89qH/WTuA1T9unLJ2mfPEh7FXgYtUXq0aPi8oKOR4DykvIx
         kBPi8vkfDqidkLQj9hXH83N8wOMScG+itcdXBJo/G3UEAEF/3FTtU052ntt8eUNRaeq1
         tfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316667; x=1695921467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dbJ671h4+Zrpefl6Lm2RwGWdFjdR10s5YR4gHySBBk=;
        b=WgBXSBqezE7IIrAt69vBDRNl8rBoXI9Oba5XHQ2VW61uSl0Fs6VMVZHXbnF/J7hltv
         oacvYwJlGzRxAEdfJYiTHrhnVuXChbLn9C9rgvqkiwlUFfttQr05GjAA5AUv6A65l2G/
         lBG/7wXiRYC5askmTr+YIevD4VzeIPJ9lHTWmORNkfkqojdHctJr0VhVRZQZKvKqOtOp
         DimKDRVId8rB1T3Bt8IHR1WujEJZpFvHDdf9qKGVZv5Kn6ST55MDSywXtiM1uKrZqJF+
         hQdQLavF5qk6n6LsGU01hKeJYvlNPVfALwlKJBScRZ5LdhWy1PM8Wca7NQoUBVqnMhcx
         2jRA==
X-Gm-Message-State: AOJu0YyMkyCrmitcU+3HEvAgNSra8hnlTqoBqR7TBj9AlWhITXHaxgWF
        qhK+TQwcb+6VtbuPhbAklkr+BanYmSVG6psgt6q8VcPA
X-Google-Smtp-Source: AGHT+IFl1Y1y2zMR1iNlW+1IiVeZ0qyN3wFDv4S8/6ruNMMK2i/+yZoG4piAY0plFw/WCYJXxcy+mQ==
X-Received: by 2002:a05:600c:152:b0:404:2dbb:8943 with SMTP id w18-20020a05600c015200b004042dbb8943mr5711734wmm.2.1695307452618;
        Thu, 21 Sep 2023 07:44:12 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:12 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/19] iio: resolver: move ad2s1210 out of staging
Date:   Thu, 21 Sep 2023 09:43:41 -0500
Message-Id: <20230921144400.62380-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending v2 with proper `PATCH v2` prefix.

Changes since v1:
* Address initial device tree patch feedback
* Drop "iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro" (related cleanups
  also dropped for now, will address in a future series if needed)
* Apply improvements as a series as patches to the staging driver. It is not
  quite ready for the move out of staging patch yet.

This series has been tested on actual hardware using a EVAL-AD2S1210 evaluation
board. (Note: not all device tree features have been implemented in the driver
since the eval board doesn't support them out of the box. We plan to add them
later if needed.)

One thing left over from the staging driver that probably needs more attention
still is the fault handling (both the fault threshold attributes and how
userspace gets notified of fault conditions). We considered adding these as
events, but the fault conditions are related to internal measurements in the
chip that aren't available as channels.

Since the chip is designed to read the fault register each time we read the
data registers for one of the two channels it seems like faults should be
associated with channels one way or another. Would it make sense to add extra
channels for the internal signals that only have fault events (mostly with
IIO_EV_TYPE_THRESH)? Or would it make sense to add a new "flags" channel type
where the "raw" value is bit flags? Or something else?

Here is the table of available faults for context. Sine/cosine inputs are
internal signals.

| Bit | Description
+-----+------------
| D7  |  Sine/cosine inputs clipped
| D6  |  Sine/cosine inputs below LOS threshold
| D5  |  Sine/cosine inputs exceed DOS overrange threshold
| D4  |  Sine/cosine inputs exceed DOS mismatch threshold
| D3  |  Tracking error exceeds LOT threshold
| D2  |  Velocity exceeds maximum tracking rate
| D1  |  Phase error exceeds phase lock range
| D0  |  Configuration parity error

David Lechner (19):
  dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
  staging: iio: Documentation: document IIO resolver AD2S1210 sysfs
    attributes
  staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
  staging: iio: resolver: ad2s1210: fix not restoring sample gpio in
    channel read
  staging: iio: resolver: ad2s1210: fix probe
  staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
  staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
  staging: iio: resolver: ad2s1210: use devicetree to get fclkin
  staging: iio: resolver: ad2s1210: use regmap for config registers
  staging: iio: resolver: ad2s1210: add debugfs reg access
  staging: iio: resolver: ad2s1210: remove config attribute
  staging: iio: resolver: ad2s1210: rework gpios
  staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
  staging: iio: resolver: ad2s1210: refactor setting excitation
    frequency
  staging: iio: resolver: ad2s1210: read excitation frequency from
    control register
  staging: iio: resolver: ad2s1210: rename fexcit attribute
  staging: iio: resolver: ad2s1210: convert resolution to devicetree
    property
  staging: iio: resolver: ad2s1210: add phase_lock_range attributes
  staging: iio: resolver: ad2s1210: add triggered buffer support

 .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 +++
 .../sysfs-bus-iio-resolver-ad2s1210           | 109 ++
 drivers/staging/iio/resolver/Kconfig          |   1 +
 drivers/staging/iio/resolver/ad2s1210.c       | 948 +++++++++++-------
 4 files changed, 857 insertions(+), 351 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210

-- 
2.34.1

