Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896A780157
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355913AbjHQW4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356007AbjHQWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:55:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DA3AAA;
        Thu, 17 Aug 2023 15:55:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68859ba3a93so287897b3a.1;
        Thu, 17 Aug 2023 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312940; x=1692917740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh+5nG0InT7LNHQ/p3oDPeUDZ81KHTnafJfH8ijZp8I=;
        b=h4IYIQDD009m4B+8MG7SjeOdQqhkzD6DKr+01yLMuIwyWzuRLzylEhCRdbuMT2QXZ+
         2dWyPGPWkM5VFOfRojAZulLJYG76oS+tjvBRxPWN/HCdH9enqBPHBMFawWKoGXSraZXa
         kmBeVubsjCjGUzU/gdS/LkWqilw3Kmkcbozg5aQ1l4DeU0EtW5lBbq3ggyA5x6qDp+Nv
         CDnOuua7CsxskvpRk5UqdwisHRcCkot8VA9mc3J4YfzI2LqOWxQEX/HMWC0Vwam9EJlk
         pYlVd24IhIubg86iLEo+ZlZSGFyXn+aKi7q1k5TdwpayRUm8AfROpgaeu7xf/u9wy6WC
         d1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312940; x=1692917740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh+5nG0InT7LNHQ/p3oDPeUDZ81KHTnafJfH8ijZp8I=;
        b=QZ/6DaAJOB4iy8OpiyEGvvv2uihKyIe379PRaSGsofzHoFhOVwc7BrDo87pNYHpmxK
         ZeivyRKIno0UR1Mbc8UBSsANyOuXRTl6AwFlbkvv8AZLnG1IMbRCvgVtw9LA3VH3gNEJ
         2rXVLs0DT+kggUGH6RR07klYP7fV5NdIvxP1k1a01sB5yerAq/8tchdHfLFYSGqKluC0
         xiC4FZUy/3HWNTV/L0ks7h7J1qVpDMQvNtCl4iN71xRYrsz5TcRl1hNZZwJHIsModsli
         qyoBH9OzaoYsuwpPFZ9s4r/xEPCr73ESeO/BOcXXdPFl2uFbvAPdhLgIL+NZ6gQkXnPD
         Lg5g==
X-Gm-Message-State: AOJu0YxGgK1bEMk6DsTBjxuQZfMnqCovWu3toI8Nz2IMRPkYXzZCtUoD
        FdDEwAYhjKJ8Hrl4aZcenbY=
X-Google-Smtp-Source: AGHT+IGFDiI/Kl0Q+iqGejW5ozrRcr8OC9nK7Y2Puo6u6cCAmCZ+UpAp0xx/B9SdymZlMibOEyaAxw==
X-Received: by 2002:a05:6a20:1382:b0:13c:8e50:34b8 with SMTP id hn2-20020a056a20138200b0013c8e5034b8mr1153707pzc.35.1692312940462;
        Thu, 17 Aug 2023 15:55:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902869300b001b896d0eb3dsm295373plo.8.2023.08.17.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:39 -0700 (PDT)
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
Subject: [PATCH v2 0/7] rtc: Add support for limited alarm timer offsets
Date:   Thu, 17 Aug 2023 15:55:30 -0700
Message-Id: <20230817225537.4053865-1-linux@roeck-us.net>
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
alarm_offset_max in struct rtc_device to let RTC drivers report the maximum
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
This often resulted in error messages by the rtc driver. On top of that,
it was all but impossible to support rtc chips such as tps6586x which
can only support wake alarms up to 16,383 seconds in the future.

The first patch of the series adds support for providing the maximum
supported time offset to the rtc core. The second patch uses that value
in the alarmtimer code to set the maximum wake-up time from system suspend.
Subsequent patches add support for reporting the maximum alarm timer offset
to a subset of affected drivers.

Previous discussion:
    https://lore.kernel.org/lkml/Y19AdIntJZGnBh%2Fy@google.com/T/#mc06d206d5bdb77c613712148818934b4f5640de5

v2:
- Rename range_max_offset -> alarm_offset_max
- Use the new variable to validate the limit where possible

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
 drivers/rtc/rtc-ds1305.c   |  5 +++--
 drivers/rtc/rtc-rzn1.c     |  3 ++-
 drivers/rtc/rtc-tps6586x.c |  1 +
 include/linux/rtc.h        |  1 +
 kernel/time/alarmtimer.c   | 13 +++++++++++++
 7 files changed, 54 insertions(+), 18 deletions(-)
