Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3A792F75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbjIEUGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjIEUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:06:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98FCC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:06:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68becf931bfso1894619b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693944365; x=1694549165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vqCBIBiwOZGT1fmofn4LMCq696lV+gFASq7tQcSx8E=;
        b=g8tCJsgxDjmiIeRE++tl+Iw6/pj7KTuJlolOhyUNql69lq52gXp2jcMXVkKZ5qIPB9
         IqgKtiIHPiVQmxQMgoRIpvZ3YPXMIUeadCkfHXuZDbcivAKfh8htie1xvKR3jXUecm7G
         zvjixpSILTvievHTp721bf+BZPU8UvG22pOpURT6hd+O+zG+l9n65X2FiS3Jx9ATh3B/
         0r4rjL8DJ/S+iVIlRiJ/M99UsYDitKPAl9Vi1DGK4YvxrbKc4J//+1XozCSw1k1GD/7W
         CqMXZDycNJwGJZaXCCzrEmg0UBMaY4uEFkaCV245FNfwCGQYgAKug4C7UzG+QZy0Aq+1
         vHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944365; x=1694549165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vqCBIBiwOZGT1fmofn4LMCq696lV+gFASq7tQcSx8E=;
        b=bAEurIyVcVX9u8vjXNjy3cY0ua6nHinQU4AloMIiqBI7brhAhUxWdg7bag1rbIUagK
         LBiAGEwUqeiGvnJF8n1kw1fGD52uuxe9knKMhJB5ZzOeCg7Dn3cPocIauuDbx/jL82rA
         xTWXeGg1fph8pvgH2/7eV26QwYQxc7wYbW/depPKvfqeQOR9krz0vxhjoI9eVKAugfPU
         Ay7UoBQ6PxUScPHnB5Ab+2aXNJdbhc3ClEzFdwEurTiH3nUEIDnekw7dnBO0L4f5Qi9k
         Imu/eggXU5XcEJM9aZ32B61myf+oj5w2HHBsXNW0o2fLSjqDORyjaoovUKTu/BRtOstM
         p/wA==
X-Gm-Message-State: AOJu0YyHd9QfAJ28HGX4yPQnSJpFqLfCMk1PdYDcNwhC2B8KJgl1CkiY
        6QHfpqP7TINfAkgr70PyeQ30vq34E50=
X-Google-Smtp-Source: AGHT+IGIKNHAJw9sZZBVLntg5ZJewFK6lDIBA4QJpQ+BdG+jPiSgW+Ib2c4raGraavbioOoROQR0qA==
X-Received: by 2002:a05:6a00:b54:b0:68b:e29c:b5f with SMTP id p20-20020a056a000b5400b0068be29c0b5fmr13202354pfo.32.1693944364606;
        Tue, 05 Sep 2023 13:06:04 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:df78:d646:9d2a:c5f6])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b006888029fd63sm9356091pfe.9.2023.09.05.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:06:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] xtensa updates for v6.6
Date:   Tue,  5 Sep 2023 13:05:59 -0700
Message-Id: <20230905200559.2824671-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the Xtensa architecture.

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230905

for you to fetch changes up to 03ce34cf8f50e4c62f9a4b62caffdba1165ca977:

  xtensa: add XIP-aware MTD support (2023-08-28 18:25:23 -0700)

----------------------------------------------------------------
Xtensa updates for v6.6

- enable MTD XIP support
- fix base address of the xtensa perf module in newer hardware

----------------------------------------------------------------
Max Filippov (2):
      xtensa: PMU: fix base address for the newer hardware
      xtensa: add XIP-aware MTD support

 arch/xtensa/Kconfig                |  3 +++
 arch/xtensa/include/asm/core.h     |  9 +++++++++
 arch/xtensa/include/asm/mtd-xip.h  | 14 ++++++++++++++
 arch/xtensa/include/asm/sections.h |  4 ++++
 arch/xtensa/kernel/perf_event.c    | 17 +++++++++++++----
 arch/xtensa/kernel/setup.c         |  3 +++
 arch/xtensa/kernel/vmlinux.lds.S   | 11 ++++++++++-
 7 files changed, 56 insertions(+), 5 deletions(-)
 create mode 100644 arch/xtensa/include/asm/mtd-xip.h

-- 
Thanks.
-- Max
