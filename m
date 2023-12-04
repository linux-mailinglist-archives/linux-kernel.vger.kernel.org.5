Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52550803BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjLDRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjLDRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:46:23 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D711D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:46:30 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67ad9844cb1so485436d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701711989; x=1702316789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ7nufbcG8tDPdedYVGPu9R5Pdg0mWlTFvGUddsQp5w=;
        b=DFBObIakU3zeP37b1Zwl5T4nZMG4sIbBK6EnUpEj9EE70hq7GeqGaRxuGIYJOCiQEt
         VN3YdvmdosESlTWAJJxwKlHgtJFkxRT2FW5MX7plZEppHgF8v5CtVC8gCSXTmdkv7oVL
         SQrhd5EtCb1hXRAqeLpHIfJ4TFGWViLXno3BbUOzVxnUv8CTCL+HaTRJMQ5prOG/IFdE
         3HSwstWapn2/dM7xakZvUQC7laCfX41YtK+F65SvYcuqC3ewkn/Pk3ALCeJ1ghVQVXGy
         kftWZQ9LGxcakiz7aQ7/yRPU8Qy1WNQVRtGBVvy2hja2cMPdK/puDwkQxk9dH1bIiX60
         hyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711989; x=1702316789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ7nufbcG8tDPdedYVGPu9R5Pdg0mWlTFvGUddsQp5w=;
        b=Gji71VjNiOGDY6kFWtiPkJt+aXW6INkNNgP15NbZg3MxKQBHePSmxekgut2v5lisZv
         h52b3W9xM6Bet7Qd8v+uWiLaC01nonFwY8czk3Ps+X1mEk2sUHjGoFsu1HLU6Cz61O7V
         zJl5LSNCEQ0bWgb1tfNK1nU+IWh8cxvBx3etQIfdfUl920+CnAUbV/1YeUb6kVT8LmI9
         65cweF1j9UZCgG1g01oo1BgkH4UXbh5GWE71/gFHlGbzPzmwgI/Y3RrRupuBWbC7sWpF
         GA2HbuPl7XyDX+VZW264XK5etO3qBPmTMFizDbn7xS6YzH9d90x2L+Ckm0MfAsk4faZ7
         m02g==
X-Gm-Message-State: AOJu0YwusVR8BsY3zLbj9vkDnSzitoBp7QpGtscTYTiYAIZ//RYEzDEs
        vxpm26OoQM/5jYg9tldFaasVGAXxOGO2U6oAm0RSQw==
X-Google-Smtp-Source: AGHT+IHQGfujTXGkRN7as8P//5Jvemxpz4EFi5vbNzfDpScMjgfE4b6YpEUMJS6+vdmRHdPFMY/4tQ==
X-Received: by 2002:a05:6214:1910:b0:67a:a9aa:29a7 with SMTP id er16-20020a056214191000b0067aa9aa29a7mr6857445qvb.2.1701711988887;
        Mon, 04 Dec 2023 09:46:28 -0800 (PST)
Received: from m2max.tfbnw.net ([2620:10d:c091:400::5:2355])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077d71262d38sm4406478qkg.60.2023.12.04.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:46:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: [PATCHSET 0/2] Get rid of import_single_range()
Date:   Mon,  4 Dec 2023 10:43:54 -0700
Message-ID: <20231204174550.1252585-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking at this today, I noticed that the 'iov' argument to this
function is totally dead code. Patch 1 gets rid of it, and with this
function and import_ubuf() now being identical, converts the callers
to just use import_ubuf().

No functional changes here, just a cleanup removing some dead code.

 drivers/block/ublk_drv.c         |  9 ++-------
 drivers/char/random.c            |  6 ++----
 fs/aio.c                         |  2 +-
 include/linux/uio.h              |  2 --
 kernel/trace/trace_events_user.c |  4 +---
 lib/iov_iter.c                   | 13 -------------
 net/ipv4/tcp.c                   | 10 ++++------
 net/socket.c                     |  6 ++----
 security/keys/keyctl.c           |  5 ++---
 9 files changed, 14 insertions(+), 43 deletions(-)

-- 
Jens Axboe

-- 
Jens Axboe


