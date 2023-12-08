Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8992980A07A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573470AbjLHKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjLHKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:20:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECA1708
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:20:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3332e351670so1773000f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702030824; x=1702635624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LI2cPVtpfspTOTHLatTsMeq1yG49Tg1pPBonSn3WXmM=;
        b=DQtsWe5GEiwk/RGOgQYa3ghTQuUTZMxpZU4aeKBhZ6SbyDqyqHeuhICCiw4jh9zzuu
         Bss6YXFC0jeH8X8ubeH4y7FUlxgzaMIeV+kJBus3T1t9MUf3nwalqlb/n4eQArBFQC1u
         CT+dgvRUCo4AJj9btZNMTmBi99BXgtma7c6D/mQzDdR3H3H6H1fK16wmdhxVDK3mEmia
         PwbueeesmwpnQWmELFQm5sNL+Hp8VNYPPQ8lcyZ3vIA9k1CXuJSFQoIT03Goo2tfWe1j
         JIdFZ/xqf7Qgj1u/emIY9JOq9eJoox/nxQkJhLW5RmrvYVPyMk2SJu7l/fi4OFXzk9bN
         Mfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030824; x=1702635624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LI2cPVtpfspTOTHLatTsMeq1yG49Tg1pPBonSn3WXmM=;
        b=Pzwo63goZnRJ0YTREaQgK32QrxIJTqz9KeYibDAzkpWspdpCXI5NTdov8cp/cNDTSi
         XeIB7mCCq8rH7ONkBoLBGIlKsznEOCBV7TGkdddU7vSnPABTOeJ/Fz7aoHbJM3XcQ5Zb
         BWbv0GEEXTyFrDLoN/94menWf78Oc370pDJBor/W996kX/njqIua7u6xmOR9ET8aXTX6
         dMkzjYuWs30+kUhZpo5WKZKK47apptpGlMM4ahiZ38cB5HMHrzMOUQQGP3DkQ7yjrB2b
         2/RLb/h1m446686ZSxc7Wjlz4KgegSyvf2XSZs5taODxuhag42bU93kxp3nDlAidPqYh
         scRA==
X-Gm-Message-State: AOJu0YxR1kxmgc9/0PELeby1J2V+xi0gCadcMcGL7UyX+b1dSJDOmRkX
        wWgnLXEVUIGvffDDj6ERyVvodw==
X-Google-Smtp-Source: AGHT+IFbM56mrm6YbDUOYY9EVLDFpuMqLJIZtsfB6U2sCK+rI8mTcbMUA4dKKEC0PeuK17ZtFrhJMQ==
X-Received: by 2002:a5d:4145:0:b0:334:bc62:4b32 with SMTP id c5-20020a5d4145000000b00334bc624b32mr608180wrq.224.1702030824459;
        Fri, 08 Dec 2023 02:20:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b003334926fb81sm1678026wrs.90.2023.12.08.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:20:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/2] gpiolib: protect the list of GPIO devices with a mutex
Date:   Fri,  8 Dec 2023 11:20:18 +0100
Message-Id: <20231208102020.36390-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I figured that - since the descriptor locking is going to take some more
time - we should at least start the conversion and protect the GPIO
device list with a mutex.

Patch 2/2 here is actually a v2 of the original submission.

v1 -> v2:
- add a patch renaming two functions
- protect the list in gpio_device_find() too
- coding style tweaks

Bartosz Golaszewski (2):
  gpiolib: rename static functions that are called with the lock taken
  gpiolib: use a mutex to protect the list of GPIO devices

 drivers/gpio/gpiolib-sysfs.c |  26 +-----
 drivers/gpio/gpiolib-sysfs.h |   6 ++
 drivers/gpio/gpiolib.c       | 166 ++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h       |   1 -
 4 files changed, 94 insertions(+), 105 deletions(-)

-- 
2.40.1

