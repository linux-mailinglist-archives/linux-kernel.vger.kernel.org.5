Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828AE7F0DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjKTIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjKTIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C383
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507975d34e8so5695959e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469977; x=1701074777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOUwHQ3tIEPqVxD003y/axANZjYq9yXWHmQwKicRxv4=;
        b=P92POmTiejhtLFaKk/Zb3U4EsmqIV2OndDcFEc7nNsB0JqJMB/HCB7o9MspiH5oH+m
         O5YNOXGGjvXw0wEn++AanepKVZckI5GIlWm3FyFQkVkBxmYLY3Jw1y259T+7+PXK/RLk
         BiSRwOnOYFoVV/p6IQnGJc74iDvOuk6HqDxJ63OFu3kyZoumVPX2mGeWirDJOD8CXLMV
         ooMJXRlK0fO7nOHhfd+xpknj4enkjPTTQDzIPxEp8L7GvHrjsJQirnpw1Azem4hESCKi
         0qh3Upwwz7629XZCVt4cB37lJWpe1X9E+ICzR0sqVpTz10wRhjPCMob+2IznSwg6IHQ1
         5RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469977; x=1701074777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOUwHQ3tIEPqVxD003y/axANZjYq9yXWHmQwKicRxv4=;
        b=wEEJfY0ytx7T3KZ5KhZgefwJFvhIdmDQtx+LRKVNCttgNqqaqJTrtSrpHvh5ZOv8mY
         fci3O4+kua5b12o62HlMmCVz9sXi4/KEa5lYXVS7Xw8gxGNKtNyELee/UTYlk7c8zXQe
         X6bVVT+ftdm2aHMablz0RZpmb2d58OKny4ToCAva3Kh47GTsYp0H4RmaeZIRyK+b5K7T
         i07CL2ZeK6G1eRz1BYDNn2XgGqReX3URbpsIwQg7d1VF0ilfv/HKlBg8PFBBZqc0tcIT
         koF/d2ZDUY1A1dePlxN4QZBcC01H4VcWeAUBki6EGjezZie2qb3Qho/aS289K2svhGOn
         hp+g==
X-Gm-Message-State: AOJu0YxzWKFxcbOOj4hAxP147oH3csV/TDsNkrZXQWLmS6BqiaAhhz76
        mb/ot2vp1CmkjhiylQuV+nJQhA==
X-Google-Smtp-Source: AGHT+IGA8m5mvMi46rvFWOb3dW/RQ2+4PUYMypdqU5+qjOpHXpylOvvBjm42GzDhIUkn/YKsVRHuSA==
X-Received: by 2002:ac2:549c:0:b0:507:b935:9f5f with SMTP id t28-20020ac2549c000000b00507b9359f5fmr5263073lfk.24.1700469976750;
        Mon, 20 Nov 2023 00:46:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:16 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/13] net: ravb: Add suspend to RAM and runtime PM support for RZ/G3S
Date:   Mon, 20 Nov 2023 10:45:53 +0200
Message-Id: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds suspend to RAM and runtime PM support for Ethernet
IP available on RZ/G3S (R9A08G045) SoC.

Along with it series contains preparatory fixes and cleanups.

Thank you,
Claudiu Beznea

Claudiu Beznea (13):
  net: ravb: Check return value of reset_control_deassert()
  net: ravb: Use pm_runtime_resume_and_get()
  net: ravb: Make write access to CXR35 first before accessing other
    EMAC registers
  net: ravb: Start TX queues after HW initialization succeeded
  net: ravb: Stop DMA in case of failures on ravb_open()
  net: ravb: Let IP specific receive function to interrogate descriptors
  net: ravb: Rely on PM domain to enable gptp_clk
  net: ravb: Rely on PM domain to enable refclk
  net: ravb: Make reset controller support mandatory
  net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
    pm_ptr()
  net: ravb: Use tabs instead of spaces
  net: ravb: Assert/deassert reset on suspend/resume
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb.h      |   2 +
 drivers/net/ethernet/renesas/ravb_main.c | 220 ++++++++++++++++-------
 2 files changed, 160 insertions(+), 62 deletions(-)

-- 
2.39.2

