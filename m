Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF27DC60D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjJaFnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjJaFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:36 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050ADF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:31 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ba46683a88so780813241.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698731010; x=1699335810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BN5lROM9MRyHGe8lVBr4I6TzwXVR+UBWrkwp6izM3io=;
        b=RCbhwY/rdJcXierfz01xM69UU1rLjRvVRgt1DftMKp6mm2HWmMRMu7FRdUu+wch803
         KmxPcNq2UUugMqQ4tYgEBIzoI0HyeQiVCcPiG1GUwnh0e9vYj+TrB2IE7XCT7Y2NiwEG
         5ZYQiFr4vypyH/ZRo/A4Ppc+nqV7p9BJhcyQt58G6QyhmqIIqB3ZahczozKX6yFjgDQK
         DOqymXkvfKqgOa7sB6N22W3NMRBQWU3MIZbnwt9TGt1BKsR21cNU3v4hk+Mo20+mVgeA
         alZuK3cUFnILMQdKEqp4pHA6Sj+nwDgAkjGNKW6LW91SIBsVixyL6i2xJrKvAVmQ9kiN
         AZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698731010; x=1699335810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN5lROM9MRyHGe8lVBr4I6TzwXVR+UBWrkwp6izM3io=;
        b=pm2sh2y4xAtq20Vfr/ta/iHQrNm/6i968zqHUvQiOtKF/Vxk76py9K7/Vb2gR1DOuZ
         qUL7pSXYJc9WvVml1ocWd2bmPBzoyCQFPe3ozP5916TYPUFqVxIs0f10KxZUFMk+tx+0
         572wCy04npI83pq+RZb9ScMmZvfyMaxfynXx4HwxKFguRw8JnaAT35RKx5hRgYd91DoW
         ZkhPA3bQekfawG8Fhr0D5Twcc+WMK6p9JJniTiWdlOuFtXfA+A4vRMHmoKp8S56Qv02p
         yLgNjvdBauVSfaluZOnAbC8+6xDxZVL9l4GNzKkidbhOg0OM7i30+2BXSoyZD4WMv84R
         9WqQ==
X-Gm-Message-State: AOJu0Ywzz2n/Dv2iPByOUAc3mb2neTJVGjoGoxbE8NyG95trvF/DCS1j
        /vesCkYnCeeCt3XRRIFNmX4V/J6rO0A=
X-Google-Smtp-Source: AGHT+IGf9VcGJPPZEtrLQxJFWuMROjez46iQ3AkTREovi1OE/PIr7vSK5gqd4mwN1RkF97rXemc0LQ==
X-Received: by 2002:a05:6a20:6a05:b0:17a:fcda:4a6b with SMTP id p5-20020a056a206a0500b0017afcda4a6bmr11077930pzk.13.1698730481554;
        Mon, 30 Oct 2023 22:34:41 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:40 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 00/11] Type encoding info dropped from variable and function names in NIC driver part2
Date:   Tue, 31 Oct 2023 11:04:23 +0530
Message-Id: <cover.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series consist of fixes to issues found by checkpatch

Pavan Bobba (11):
  staging: vt6655: Type encoding info dropped from variable name
    "qwBSSTimestamp"
  staging: vt6655: Type encoding info dropped from variable name
    "qwTSFOffset"
  staging: vt6655: Type encoding info dropped from function name
    "CARDqGetTSFOffset"
  staging: vt6655: Type encoding info dropped from function name
    "CARDbSetBeaconPeriod"
  staging: vt6655: Type encoding info dropped from variable name
    "wBeaconInterval"
  staging: vt6655: Type encoding info dropped from variable name
    "qwNextTBTT"
  staging: vt6655: Type encoding info dropped from function name
    "CARDqGetNextTBTT"
  staging: vt6655: Type encoding info dropped from function name
    "CARDbRadioPowerOff"
  staging: vt6655: Type encoding info dropped from function name
    "CARDvSafeResetTx"
  staging: vt6655: Type encoding info dropped from variable name
    "pCurrTD"
  staging: vt6655: Type encoding info dropped from variable name
    "apTailTD"

 drivers/staging/vt6655/card.c        | 90 ++++++++++++++--------------
 drivers/staging/vt6655/card.h        | 18 +++---
 drivers/staging/vt6655/device.h      |  4 +-
 drivers/staging/vt6655/device_main.c | 18 +++---
 drivers/staging/vt6655/rxtx.c        |  2 +-
 5 files changed, 66 insertions(+), 66 deletions(-)

-- 
2.34.1

