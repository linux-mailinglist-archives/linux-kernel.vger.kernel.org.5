Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4779EC53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbjIMPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIMPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96AEBD;
        Wed, 13 Sep 2023 08:16:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4018af1038cso75538515e9.0;
        Wed, 13 Sep 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618181; x=1695222981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wHlb4TZdTg18dIQRSMHj1vLV5U+xhED8U8Tcp/nIAY=;
        b=pt7b3ELNkFkWz/Qm60VgX2GufJFrwa1Jyfk1gf+5HWsmKazqN7WIGvCiZ1raeuVAN8
         Y2KWvv6WcJMlEfeDBJ5jrPWWO4dnY5TuHhOw7eeuvk4kRHuVJX5nORLGO3K5UpsQyHRk
         P0CPOO6YOFFb2xx9Nyd7GakQJcomDstplGOjpRsyCqhsiNM7zfpXYIaO3ZcD30ttp8SX
         4jtUiau8/f1QLnMk4dh7qveEC7WKyVtcwVuLCwdVl89fucfoSGyGzYT/BmU9IIhlJyYU
         YFK56r1QMn/cfPQydccLLSPtDSyzCdDyy69s6Eg/aKuzjXwdtluitiAI2L5nspydZt28
         l5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618181; x=1695222981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wHlb4TZdTg18dIQRSMHj1vLV5U+xhED8U8Tcp/nIAY=;
        b=cFThWIVC+TgyDMp6FtCYpuoPw/M3Zr9nOnLXEEM45fHDhjcKWoMKm1PGvekPHsqiDb
         Df1e+IvUCO5ropQmq1X3VJJgFStKwwVI1W+M/QvGa1UyOyE+13ivSruq5dHWhzeG7NzB
         UgpUsNnqFIfKKKwl60YuI8GeS0DtA5zwXmbloes6ngqlvJZNGs+/ijx5IUZi38+zukcb
         2g6lBWc5dj3phN4MZQJNffLira375LqxyInRXt8MoiKSEADLBFWpO62FpDGyrRC1SrUi
         3jmriF2EojbLe8LZAYfAE2CclZzYl0YvmhcISwJpN0cwdJCNIJHmhFbRoTNYLlW93kQw
         xacw==
X-Gm-Message-State: AOJu0YyG/DCBq6f04o3ReB6xrzSW5g24TFqvf+rccYmw+zCdkMLAZxSc
        K1PLu1LQBV5lmR6kxSLkDgzNz37LYIyIsw==
X-Google-Smtp-Source: AGHT+IHDFXk9pLwaVNEfoWDOMr0cNYlA7ShKyzzr1OimlPOFw7rJqT0nMt26qj4IyJRDn5otb6IwgA==
X-Received: by 2002:a7b:c416:0:b0:403:bb04:2908 with SMTP id k22-20020a7bc416000000b00403bb042908mr2217447wmi.23.1694618180871;
        Wed, 13 Sep 2023 08:16:20 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6092000000b0031c52e81490sm15886631wrt.72.2023.09.13.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:16:20 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Add RTC for MStar SSD20xD SoCs
Date:   Wed, 13 Sep 2023 17:16:03 +0200
Message-Id: <20230913151606.69494-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series adds a new driver for the RTC found in the Mstar
SSD202D SoCs. It adds a basic rtc driver, the corresponding devicetree
bindings.

The rtctest (from selftests) has been passed on this driver, with the
following output:

# rtctest 
TAP version 13
1..8
# Starting 8 tests from 1 test cases.
#  RUN           rtc.date_read ...
# rtctest.c:52:date_read:Current RTC date/time is 17/05/2023 15:58:12.
#            OK  rtc.date_read
ok 1 rtc.date_read
#  RUN           rtc.date_read_loop ...
# rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s (with 11ms breaks after every read).
# rtctest.c:122:date_read_loop:Performed 888 RTC time reads.
#            OK  rtc.date_read_loop
ok 2 rtc.date_read_loop
#  RUN           rtc.uie_read ...
# rtctest.c:137:uie_read:skip update IRQs not supported.
#            OK  rtc.uie_read
ok 3 rtc.uie_read
#  RUN           rtc.uie_select ...
# rtctest.c:166:uie_select:skip update IRQs not supported.
#            OK  rtc.uie_select
ok 4 rtc.uie_select
#  RUN           rtc.alarm_alm_set ...
# rtctest.c:214:alarm_alm_set:skip alarms are not supported.
#            OK  rtc.alarm_alm_set
ok 5 rtc.alarm_alm_set
#  RUN           rtc.alarm_wkalm_set ...
# rtctest.c:274:alarm_wkalm_set:skip alarms are not supported.
#            OK  rtc.alarm_wkalm_set
ok 6 rtc.alarm_wkalm_set
#  RUN           rtc.alarm_alm_set_minute ...
# rtctest.c:324:alarm_alm_set_minute:skip alarms are not supported.
#            OK  rtc.alarm_alm_set_minute
ok 7 rtc.alarm_alm_set_minute
#  RUN           rtc.alarm_wkalm_set_minute ...
# rtctest.c:384:alarm_wkalm_set_minute:skip alarms are not supported.
#            OK  rtc.alarm_wkalm_set_minute
ok 8 rtc.alarm_wkalm_set_minute
# PASSED: 8 / 8 tests passed.
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes since v1:
- Changed the compatible from mstar,ssd20xd-rtc to mstar,ssd20d-rtc.
  So the driver, its documentation and the commit messages have been
  reworked accordingly.
- Re-worked the dt-binding, I have also simplified the commit message
- Re-worked the commit message for the driver
- Remove redundant logging message for the user in the driver, as
  requested by the subsystem maintainer. As these messages are helpful
  for debugging purpose, I have switched these to dev_dbg().
- Updated the list of maintainers (sorry for that).

Romain Perier (3):
  rtc: Add support for the SSD202D RTC
  dt-bindings: rtc: Add Mstar SSD202D RTC
  ARM: dts: mstar: Enable rtc for SSD202D

 .../bindings/rtc/mstar,ssd202d-rtc.yaml       |  35 +++
 .../boot/dts/sigmastar/mstar-infinity2m.dtsi  |   5 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ssd202d.c                     | 249 ++++++++++++++++++
 5 files changed, 301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ssd202d.c

-- 
2.39.2

