Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4321E7BAFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjJFAvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjJFAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:09 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF78DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:06 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso960048fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553465; x=1697158265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj54Gl1jd+w9QgbJ5IpGgS95Y27Kw5ws4fL1QKoqHoA=;
        b=tG8HUy4JAU0I0ARM0XEMccY4swQP4zaVTcuxZW5auZ1HghCJRZF8RUV2C2s974M9HB
         slcL1chsk16XQWqVHoxgOFV26j6hM4/8jfNZl56ni/UJPzRRTH8ODOaVun0MsG7AGEUL
         xYiht4RnMqtPPINGkm9d0bOe3S1zcfOdmKeBC+yor/qV0BF9CSJl4RB5ssWxm1XKygb4
         xtjs8RmNzqNYMF+T5FJFrnCCjGPGAtSo2T+302aEP7vWJgGlhaAtH1J76IYfW71fS23g
         oVua5HBcUbQrRehAOVFIMQhAyHjG3LbtPmbt+LRpSBTnmx+aWVyDj0U/W0fdzd/b4vZT
         o7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553465; x=1697158265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dj54Gl1jd+w9QgbJ5IpGgS95Y27Kw5ws4fL1QKoqHoA=;
        b=P7s0Tjcl9gIurn7b3CSlQXx0WTDdacFKkF2tJseQBWhd+5obawyWuQko7UUktTiyrD
         imYIiC3G2xhifOYli7bRhGczvgbLajlRMp4JlTuGkpSquqADxFTPIpv2+Uo5ZMYT3l79
         IyMJXiD+Pk4It+phWkYSqstBnjLw0SXrLZHugPPuQhzf2fFEQRas78T/t0Hm9tD0weY5
         IKPZkbwnqoEcKX++oAnTkIUKYMhVe/0rNk7nxxoNpKXas1Iw/4JDmgoEjnYW/eC4vbDB
         /YrFVsHpIVk2drXWrxInuMOV2HnNCN+03NTDV03aKuZNCQQCEVlW0xlF6WPzuzU94Wgl
         +YNQ==
X-Gm-Message-State: AOJu0YzlUxVXB4xN25P7+vXI878nj1dumiOcuxXgVh6epfGe0CuRaL2Q
        t2WcW/8BpnPf9O4+Ymbh2p8y1w==
X-Google-Smtp-Source: AGHT+IG1hSjqGVvnbK0ZQXLALAHV4h6eK08b8Sg1VE/BxT+UJ3tKdYKuqZ0DT9gCvR470zCjPxGqCw==
X-Received: by 2002:a05:6870:96a3:b0:1dc:7e71:d471 with SMTP id o35-20020a05687096a300b001dc7e71d471mr7341864oaq.31.1696553465199;
        Thu, 05 Oct 2023 17:51:05 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:04 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/17] iio: resolver: move ad2s1210 out of staging
Date:   Thu,  5 Oct 2023 19:50:17 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is working towards moving the ad2s1210 resolver driver out of
staging (after 13 years!). It involves a bunch of fixes and improvements
to make proper device tree bindings and use standard IIO sysfs attributes.

This series has been tested on actual hardware using a EVAL-AD2S1210 evaluation
board. (Note: not all device tree features have been implemented in the driver
since the eval board doesn't support them out of the box. We plan to add them
later if needed.)

---

v4 changes:
* Dropped applied patches:
  * "dt-bindings: iio: resolver: add devicetree bindings for ad2s1210"
  * "staging: iio: resolver: ad2s1210: read excitation frequency from
    control register"
  * "staging: iio: resolver: ad2s1210: refactor setting excitation
    frequency"
  * "staging: iio: resolver: ad2s1210: rework gpios"
  * "staging: iio: resolver: ad2s1210: remove config attribute"
  * "staging: iio: resolver: ad2s1210: add debugfs reg access"
  * "staging: iio: resolver: ad2s1210: use regmap for config registers"
  * "staging: iio: resolver: ad2s1210: use devicetree to get CLKIN rate"
  * "staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE"
  * "staging: iio: resolver: ad2s1210: always use 16-bit value for raw
    read"
  * "staging: iio: resolver: ad2s1210: sort imports"
  * "staging: iio: resolver: ad2s1210: remove spi_set_drvdata()"
  * "staging: iio: resolver: ad2s1210: check return of ad2s1210_initial()"
  * "staging: iio: resolver: ad2s1210: remove call to spi_setup()"
  * "staging: iio: resolver: ad2s1210: fix use before initialization"
* Added new patches:
  * "staging: iio: resolver: ad2s1210: do not use fault register for
    dummy read"
  * "iio: event: add optional event label support"
  * "staging: iio: resolver: ad2s1210: add register/fault support summary"
  * "staging: iio: resolver: ad2s1210: remove fault attribute"
  * "staging: iio: resolver: ad2s1210: simplify code with guard(mutex)"
* Fixed DT property name in commit description of "staging: iio:
  resolver: ad2s1210: convert resolution to devicetree property"
* Fixed compile error in "staging: iio: resolver: ad2s1210: implement
  fault events".
* Fixed angl0 hysteresis raw values when assigned-resolution-bits != 16.
* Fixed missing word in "staging: iio: resolver: ad2s1210: convert DOS
  overrange threshold to event attr" commit description.
* Fixed missing static qualifier on event attribute definitions.
* Dropped used of X/Y modifiers on sine/cosine channels.
* Changed type/direction on some events.
* Added event *_label attributes.

Link to v3: https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com

v3 changes:
* Dropped applied patches:
  * "staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault"
  * "iio: adc: MCP3564: fix the static checker warning"
* Dropped "staging: iio: Documentation: document IIO resolver AD2S1210
  sysfs attributes". We will attempt to use existing ABI for faults/
  thresholds in a future series.
* Added description of A0/A1 lines in DT bindings.
* Added power supply regulators to DT bindings.
* Moved sorting imports to separate patch.
* Renamed fclkin to clkin_hz.
* Added __be16 sample field to state struct for reading raw samples.
* Split out new function ad2s1210_single_conversion() from
  ad2s1210_read_raw().
* Split out new ad2s1210_get_hysteresis() and ad2s1210_set_hysteresis()
  functions.
* Fixed multi-line comment style.
* Added notes about soft reset not resetting config registers.
* Made use of FIELD_PREP() macro.
* Added more explanation to regmap commit message.
* Removed datasheet names from channel specs.
* Replaced "staging: iio: resolver: ad2s1210: rename fexcit attribute"
  with "staging: iio: resolver: ad2s1210: convert fexcit to channel
  attribute".
* Replaced "staging: iio: resolver: ad2s1210: add phase_lock_range
  attributes" with "staging: iio: resolver: ad2s1210: add phase lock
  range support"
* Added additional patches to convert custom device attributes to event
  attributes.
* Added patch for to add label attributes.

Link to v2: https://lore.kernel.org/r/20230921144400.62380-1-dlechner@baylibre.com

v2 changes:
* Address initial device tree patch feedback
* Drop "iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro" (related cleanups
  also dropped for now, will address in a future series if needed)
* Apply improvements as a series of patches to the staging driver. It is
  not quite ready for the move out of staging patch yet.

---
David Lechner (17):
      staging: iio: resolver: ad2s1210: do not use fault register for dummy read
      staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
      staging: iio: resolver: ad2s1210: convert fexcit to channel attribute
      staging: iio: resolver: ad2s1210: convert resolution to devicetree property
      staging: iio: resolver: ad2s1210: add phase lock range support
      staging: iio: resolver: ad2s1210: add triggered buffer support
      staging: iio: resolver: ad2s1210: convert LOT threshold attrs to event attrs
      staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
      staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
      staging: iio: resolver: ad2s1210: convert DOS mismatch threshold to event attr
      staging: iio: resolver: ad2s1210: rename DOS reset min/max attrs
      iio: event: add optional event label support
      staging: iio: resolver: ad2s1210: implement fault events
      staging: iio: resolver: ad2s1210: add register/fault support summary
      staging: iio: resolver: ad2s1210: add label attribute support
      staging: iio: resolver: ad2s1210: remove fault attribute
      staging: iio: resolver: ad2s1210: simplify code with guard(mutex)

 Documentation/ABI/testing/sysfs-bus-iio            |   15 +
 drivers/iio/industrialio-event.c                   |   55 +
 .../Documentation/sysfs-bus-iio-resolver-ad2s1210  |   27 +
 drivers/staging/iio/resolver/ad2s1210.c            | 1194 ++++++++++++++++----
 include/linux/iio/iio.h                            |    8 +
 5 files changed, 1061 insertions(+), 238 deletions(-)
---
base-commit: 2d3dff577dd0ea8fe9637a13822f7603c4a881c8
change-id: 20230925-ad2s1210-mainline-2791ef75e386
