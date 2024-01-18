Return-Path: <linux-kernel+bounces-30527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF4831FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E986E1F23D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E22E62A;
	Thu, 18 Jan 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUkXCAb4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB12E652
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607613; cv=none; b=dqxh3E5P8VbK9UxtRbkzdTeiplZjDDuYMHUbl/XaPhrl8Iw+QSzh0kIACsWq6DHK90NO5Irr2Sa6EWfivxypH/gWJsbuRudwlyydSHkNg9sk/0Qqi4BBvGsjsbHHJONPrKOW/HsiXqtu1wQLziqsMtoEy3IN0og6lnvmV6HVnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607613; c=relaxed/simple;
	bh=3H0/PUm19INCLpIv8lZ7mMSa24z+/2A2899KRBqjzRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spsCCX80VtXhtzuzvFsexiUh435TrDIljAtaQVuGE2oX0IuAMbx5aipIDJ7Vhk8M6V3tMI1wjqGiacCk+yLjIJ3frBU7LKVl1bBy3RtK+/QaUR42foWlzSVuoGKRrVRQtn3rrvgM0m3tP48PqMafSbVDFmpqRMkpeJj7tKCWcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nUkXCAb4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd2f472665so419971fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705607610; x=1706212410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aPW495Dn9XKu9eq4/g3SllgOOtpizGjdMGk5c2KiHI=;
        b=nUkXCAb4Fm5bxn7eBWh51/ApFEuauRltQor1g8kFVg83WGzquCQKb1xIx+pReuKrK6
         dBr+YoZ4F1bkEYKycZKmUcbQgYq28kT+NgRwsELQSOoZmPL+pj9YfrKdc3EfBHshUcCH
         1tffyZK6rqPmGnh9aUhDeh/40wumRL4wqpxJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607610; x=1706212410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aPW495Dn9XKu9eq4/g3SllgOOtpizGjdMGk5c2KiHI=;
        b=XcQQ2JC8iHjfa/acCSn3+5gsKTplXNp6Q406DFN0r/Dw9pLI1lJqpNnyf2+C1WsOg+
         EyRBgI+BEM/HwMKYioVjQ6Q2e2p//jr5W2JG9rDg6Wvz8uhF7meCtak5sZjs7MAvdYG1
         GPX/xYNzNvwQHsg2DKtM8ayljmyGp4tZ/yIC5waYuv6Cj5REqgmgkUDP9AY66tzfv0E2
         g0HWKQJElLrNAT8eDL4umTeUJzIN77RemDm9sWPrnKXcvuvpiwlBnQyQvgU6bAssUUib
         77BhtKOKpp5qEGh03wD/Xkrrsfc4GfOmIm9Sz1+BxThLopdnS2ASuiCcgX3TujP8O/JQ
         826w==
X-Gm-Message-State: AOJu0YxzPebgMVg9PWKhVDmVbTcJvfoHX62EA5mHaKwuyh//UYPfapaR
	ewdCYiQ7XkrPHqefjAU2vxcw3iYk0LYUvMXlcrCad+ce+LvNR0oeuGL7tjc0Sg==
X-Google-Smtp-Source: AGHT+IEQUXVT5KEHfXYHFybVLkF/rXq4pvbsHcbBHj4RJlJoq000BasTt83sR+KbR0Z2WXwNkpVTEw==
X-Received: by 2002:a2e:9d9a:0:b0:2cc:db7e:aac2 with SMTP id c26-20020a2e9d9a000000b002ccdb7eaac2mr836985ljj.58.1705607609722;
        Thu, 18 Jan 2024 11:53:29 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c00c200b002ccd3e8a59esm2333345ljr.121.2024.01.18.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:53:29 -0800 (PST)
From: Lukasz Majczak <lma@chromium.org>
To: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v2 0/3] Introduce EC-based watchdog
Date: Thu, 18 Jan 2024 19:53:21 +0000
Message-ID: <20240118195325.2964918-1-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chromeos devices are equipped with the embedded controller (EC)
that can be used as a watchdog. The following patches
updates the structures and definitions required to
communicate with EC-based watchdog and implements the
driver itself.

The first version of this patch was sent here:
https://patchwork.kernel.org/project/linux-watchdog/patch/20240117102450.4080839-1-lma@chromium.org/

Changelog
V1->V2:
* Splitted into three patches
* Supplement the watchdog configuration with min/max timeouts
* Removed struct cros_ec_wdt_data  and get aligned to watchdog framework
* Simplified suspend/resume callbacks
* Removed excessive log messages
* Reworked cros_ec_wdt_send_hang_detect() function to be more generic
* Usage of devm_* allowed to delete .remove module callback
* Changed MODULE_ALIAS to MODULE_DEVICE_TABLE
* Moved clearing bootstatus (on EC) to probe() and thanks to that
  got rid of .shutdown() module callback
* Fixed/removed comments, removed unused includes and general cleanup

Best regards,
Lukasz

Lukasz Majczak (3):
  platform/chrome: Update binary interface for EC-based watchdog
  watchdog: Add ChromeOS EC-based watchdog driver
  mfd: cros_ec: Register EC-based watchdog subdevice

 MAINTAINERS                                   |   6 +
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/cros_ec_wdt.c                | 202 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  78 +++----
 6 files changed, 264 insertions(+), 43 deletions(-)
 create mode 100644 drivers/watchdog/cros_ec_wdt.c

-- 
2.43.0.429.g432eaa2c6b-goog


