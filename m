Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949F77E2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbjHPNkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245602AbjHPNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC326A5;
        Wed, 16 Aug 2023 06:39:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564b326185bso3800988a12.2;
        Wed, 16 Aug 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193182; x=1692797982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sTITrOLS9p+5HZDFwbykK1NGLoyh4LNTkLdknhZrdNE=;
        b=hMIjjiR4q/0wPK8xLbgRyhMn8Zd9ICGyz8UEd+JAt5IZBcuJNOmH73/tzwV5o0AKjd
         nZwaSui3gXm7RwdbO8vy5ij/DlbjVpjON09GG7+Do35soBjDrLNk3SMRT0xiSgeKBcWo
         Oh1RIQzWihWpOXbE1DmRhdg8wiJYSxJNciHNDWZ4tuvoueBcX13vsEG2TJNs+BOxEstf
         2XTUG1D/jxevMkBChGNKcxuAEENjEVvQeBokpnN3LlLrPNGT+lsUTZSSUVlTlKyHI8W5
         6gQHMAigmH5VdmatKHK1XSmPJNepooEOFjXQwOmlAV+SATpAzqQAChk+ByhRiL+o6N2r
         ihgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193182; x=1692797982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTITrOLS9p+5HZDFwbykK1NGLoyh4LNTkLdknhZrdNE=;
        b=KiysYb577M4W49ETAEB0lV+qOp5mA0XTfrb570TwUiz+w7cfsmcM3+VRj0xbqhqWKB
         mp/NkG2wRa8b8LGl0WdyoaluNEg+QNHL7aivRTOMeNafgiwYo98Zz7vphIVRwUnUUoqF
         Izkn1oxO8MgAhj1DzDUgepnymrxL5g+ioSmQOs65ZhOtUK7CUOY6cZ0Qgv9PJEF6sgw0
         CCAOslHH0VX32m5KdeNmntE0lEc1vCWsrR7wBfEfngCvbDO9RXjesQoS9HJ/TTlr8kdV
         R6kt9uag4spWdr65Wftk1yVV9RKgrZn+cT5jE8ri3wYvFOWrTU7q4wSDbTRxLofg46r+
         hpSg==
X-Gm-Message-State: AOJu0YyDwwpKiDfvu0V8y9q1MPMlMY10PZybzzGM8ns4WgaaGK7QU+QK
        EFearYAwU/IG0dpywpHzxGk=
X-Google-Smtp-Source: AGHT+IF6J5YO3QTNHHvXhzJdMQX6uKS2Z0ALnT0CczHQxvXYnbkh0WczBCCsvBV6h3kLL0wpPJDxIA==
X-Received: by 2002:a17:90a:e645:b0:26b:1210:a48d with SMTP id ep5-20020a17090ae64500b0026b1210a48dmr1234125pjb.3.1692193181674;
        Wed, 16 Aug 2023 06:39:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o93-20020a17090a0a6600b0026b3773043dsm8391783pjo.22.2023.08.16.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Date:   Wed, 16 Aug 2023 06:39:29 -0700
Message-Id: <20230816133936.2150294-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some alarm timers are based on time offsets, not on absolute times.
In some situations, the amount of time that can be scheduled in the
future is limited. This may result in a refusal to suspend the system,
causing substantial battery drain.

This problem was previously observed on a Chromebook using the cros_ec
rtc driver. EC variants on some older Chromebooks only support 24 hours
of alarm time in the future. To work around the problem on affected
Chromebooks, code to limit the maximum alarm time was added to the cros_ec
rtc driver with commit f27efee66370 ("rtc: cros-ec: Limit RTC alarm range
if needed"). The problem is now seen again on a system using the cmos
RTC driver on hardware limited to 24 hours of alarm time, so a more
generic solution is needed.

Some RTC drivers remedy the situation by setting the alarm time to the
maximum supported time if a request for an out-of-range timeout is made.
This is not really desirable since it may result in unexpected early
wakeups. It would be even more undesirable to change the behavior
of existing widely used drivers such as the cmos RTC driver.

The existing range_max variable in struct rtc_device can not be used
to determine the maximum time offset supported by an rtc chip since
it describes the maximum absolute time supported by the chip, not the
maximum time offset that can be set for alarms.

To reduce the impact of this problem, introduce a new variable
rtc_time_offset in struct rtc_device to let RTC drivers report the maximum
supported alarm time offset. The code setting alarm timers can then
decide if it wants to reject setting alarm timers to a larger value, if it
wants to implement recurring alarms until the actually requested alarm
time is met, or if it wants to accept the limited alarm time. Use the new
variable to limit the alarm timer range.

The series is intended to solve the problem with minimal changes in the
rtc core and in affected drivers.

An alternative I had considered was to have the alarmtimer code guess the
maximum timeout supported by the rtc hardware. I discarded it as less
desirable since it had to retry repeatedly depending on rtc limitations.
This often resulted in error messages by the rtc driver.  On top of that,
it was all but impossible to support rtc chips such as tps6586x which
can only support wake alarms up to 16,383 seconds in the future.

The first patch of the series adds support for providing the maximum
supported time offset to the rtc core. The second patch uses that value
in the alarmtimer code to set the maximum wake-up time from system suspend.
Subsequent patches add support for reporting the maximum alarm timer offset
to a subset of affected drivers.

Previous discussion:
    https://lore.kernel.org/lkml/Y19AdIntJZGnBh%2Fy@google.com/T/#mc06d206d5bdb77c613712148818934b4f5640de5

----------------------------------------------------------------
Guenter Roeck (7):
      rtc: Add support for limited alarm timer offsets
      rtc: alarmtimer: Use maximum alarm time offset
      rtc: cros-ec: Detect and report supported alarm window size
      rtc: cmos: Report supported alarm limit to rtc infrastructure
      rtc: tps6586x: Report maximum alarm limit to rtc core
      rtc: ds1305: Report maximum alarm limit to rtc core
      rtc: rzn1: Report maximum alarm limit to rtc core

 drivers/rtc/rtc-cmos.c     | 11 +++++++++++
 drivers/rtc/rtc-cros-ec.c  | 38 +++++++++++++++++++++++---------------
 drivers/rtc/rtc-ds1305.c   |  3 ++-
 drivers/rtc/rtc-rzn1.c     |  1 +
 drivers/rtc/rtc-tps6586x.c |  1 +
 include/linux/rtc.h        |  1 +
 kernel/time/alarmtimer.c   | 13 +++++++++++++
 7 files changed, 52 insertions(+), 16 deletions(-)
