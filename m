Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23517A223F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjIOPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjIOPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:22:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B84E6E;
        Fri, 15 Sep 2023 08:22:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a9f88b663cso1411276b6e.3;
        Fri, 15 Sep 2023 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694791362; x=1695396162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7TkwZHs/PRD5jqG8XS0GhJeBL9DEeB5Kln8ua3e4jw8=;
        b=gLSEA3LZ4dSNKrXkCMgdK7dQY/n5Qrmkm9QSXnY9jZvYLnrjzqFaNVe/2iuxsZShWN
         CWVpZ2AA180yaAGVAXrqirf6E3Axh99ESrB/yLwMLJUm+qX5ferMa89HZjXqi+3zpsid
         xthxPciC8b7/k+8yWIcssiod/K6B+Jb8/yajJbu4e6brChX/QByieyfRUT+4BX0+HtN2
         9auX3kq+qEVrubRsYsHfCOXjIE7MmAAsp5JK7GYsJxf/wLabhG/y/DkxeZ/xccYBAOj9
         e+uYvVnjNcjWFPR5gBUdqkcubSjd6m54qsDSIa4BFKu1Ycr1wsEsYWimyxKM/7K1+Vcn
         YCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791362; x=1695396162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TkwZHs/PRD5jqG8XS0GhJeBL9DEeB5Kln8ua3e4jw8=;
        b=rR57NAQ1Z5mAupMpxUsXTpB7hLyVvMtLKVDfbdaEWqsilmmjJj8MZ37nHXemygOxfL
         phueeEG676qQAwYpB0tvt21cpEvhZThFPzcK2oVosntI67jPe705qWsRSsX1YvtBfMq3
         8/QeB/OdgTLIEW1SaJr4SvZVWXPHSZ4gTuERQ5hqJLtiM9WaNTkXkamnpiRfiRi82Bf7
         FXHUOCQ8IMFwmn2rzvV9tEt/HsX1/UYU5BoZHkzcU/GzQ8UIK7V9dXuv/ezSJQPEZl4d
         3lQrKpjwWoD+qtkDa4g/JQu+G4Sdl/4Ab89XDXpN70KPtlxSPySOd4MfpXXz1EVrq2jX
         8NSg==
X-Gm-Message-State: AOJu0Yx2E21m9nfLWRMdKNXYXwIhT9qPSbMV80XlUrpLR8DPPPiuDMMX
        9Td6Ct5wsehIvW/yKe3482xD/6RFAy4=
X-Google-Smtp-Source: AGHT+IEL+Yr0CGwfZZhB0KDx1QuhGUTRxcAaVnWW++nA2wqBX164STw3NvDW5LWF1KNVdI5OQ782kg==
X-Received: by 2002:a05:6870:e244:b0:1bb:ac7:2e34 with SMTP id d4-20020a056870e24400b001bb0ac72e34mr2235896oac.40.1694791361687;
        Fri, 15 Sep 2023 08:22:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c19-20020a02a613000000b0042bb03d3a2esm1104641jam.96.2023.09.15.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:22:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/2] rtc: alarmtimer: Use maximum alarm time offset
Date:   Fri, 15 Sep 2023 08:22:36 -0700
Message-Id: <20230915152238.1144706-1-linux@roeck-us.net>
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

Some userspace applications use timerfd_create() to request wakeups after
a long period of time. For example, a backup application may request a
wakeup once per week. This is perfectly fine as long as the system does
not try to suspend. However, if the system tries to suspend and the
system's RTC does not support the required alarm timeout, the suspend
operation will fail with an error such as

rtc_cmos 00:01: Alarms can be up to one day in the future
PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 after 117 usecs
PM: Device alarmtimer.4.auto failed to suspend: error -22

This results in a refusal to suspend the system, causing substantial
battery drain on affected systems.

To fix the problem, use the maximum alarm time offset as reported by rtc
drivers to set the maximum alarm time. While this may result in early
wakeups from suspend, it is still much better than not suspending at all.

This patch series standardizes system behavior if the requested alarm
timeout is larger than the alarm timeout supported by the rtc chip.
Currently, in this situation, the rtc driver will do one of the following.
- It may return an error.
- It may limit the alarm timeout to the maximum supported by the rtc chip.
- It may mask the timeout by the maximum alarm timeout supported by the RTC
  chip (i.e. a requested timeout of 1 day + 1 minute may result in a 1
  minute timeout).

With this series in place, if the rtc driver reports the maximum alarm
timeout supported by the rtc chip, the system will always limit the alarm
timeout to the maximum supported by the rtc chip.

The first patch of the series adds support for an API function which returns
the maximum of the requested alarm timeout and the alarm timeout supported
by the RTC chip. The second patch uses that value in the alarmtimer code
to set the maximum wake-up time from system suspend.

Version 1 of the series added support for storing the maximum alarm timeout
to the rtc core. This series is based on the original series, most of which
is now in the upstream kernel. It adds an API function to the rtc core and
uses that function in the alarm timer code to set the alarm time. It
replaces patch 2/7 ("rtc: alarmtimer: Use maximum alarm time offset") of
the original series.

v1:
    <fixme>

----------------------------------------------------------------
Guenter Roeck (2):
      rtc: Add API function to return alarm time bound by rtc limit
      rtc: alarmtimer: Use maximum alarm time offset

 include/linux/rtc.h      | 17 +++++++++++++++++
 kernel/time/alarmtimer.c | 11 +++++++++++
 2 files changed, 28 insertions(+)
