Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE06790BDC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjICMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjICMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:19:35 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AF116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 05:19:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5924093a9b2so5703777b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693743570; x=1694348370; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QL9imMV80v+Zfe3OIs9ZVWD3rABHoxSOtlkMQoYDT7M=;
        b=S5ah337HP2f+KpBu/FOVyRpBxP6NckZp9HYnEMFR/wPDpjuhbT9tEWQfqc2JMzGrhA
         r2ZTmv7/rLkSpKrcb5zXuajEc8a2/vCCLnYA3oTweCcAGz4rqOCwibgNmPLYi2KHx5Kn
         59DqFAnxTfIyTzFV/K5JFpxZeKJzpSs3/8v2YZ4gZGf+KVwEgrvxcp4dzRnGn4/ifksS
         dv6OH669aE19ktNTN7EEr1Ot8GbgXSQ5B4B+2DDBPdGaCKpwdl8bYQMSdFzbuwYxWg5c
         Vv+CuBoe3IGVceojXP6e8uAe/gEFUKKZU2/Cr5DyA8w5dWw3jzFvrb4CZSv+Er4kmFoV
         F5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693743570; x=1694348370;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QL9imMV80v+Zfe3OIs9ZVWD3rABHoxSOtlkMQoYDT7M=;
        b=NF3MTp3E5zgdGrkAZcHKTNM6HWOd204wWCic9JZTLKouE6m5hTWSkGfnPh7tMoMDa8
         2TBAB5f1IKHjYR60dsKJwarh1U4WoZYPOV4MeIz7heU54Um7MYvNmngYsYBa6DF6dDay
         rNlOgn2wCp5/KHbVrFy/QBIfLGjnl9NmG7CnuNIAYE+iXLEITLRJ2XfzQUU1PI2JOWa4
         KNzDdM3C4hYdJNng/EICchB3iF0StG9jsEL0b9ui/PwRxgxV7ZM3mYFIShvmKefsX3Mt
         uhSvsoXmNiggqURraROtk7GEkRHVIKS5XgC0ZPvolx0eD5cke55Als6W9XS/xxpXqKkW
         67uQ==
X-Gm-Message-State: AOJu0YxbhJSxAMcO/DsBBgdzpQ19wbSD8ymHtNOAdK2gHOlsq6VCFoME
        Y1TQ1Pn+YwalWiVEr06bYJDkLmMamYo/z3d0EN7zckz8cag=
X-Google-Smtp-Source: AGHT+IFwZ0wc9OOWav73KozOKIjxmA0YdMUVUttZhT+0UhydDhM/JgHCwiSKycmUdYrAx1pcGyT3bTHSNZ4DRgoKzgc=
X-Received: by 2002:a05:690c:d0f:b0:599:8bd:5bdf with SMTP id
 cn15-20020a05690c0d0f00b0059908bd5bdfmr6108373ywb.50.1693743569290; Sun, 03
 Sep 2023 05:19:29 -0700 (PDT)
MIME-Version: 1.0
From:   Kenta Sato <tosainu.maple@gmail.com>
Date:   Sun, 3 Sep 2023 21:19:13 +0900
Message-ID: <CAF1eZtsBzGb_UxOqZpNiEsk8Uk7DkqPh5AnYRRNc_kkr-tFasQ@mail.gmail.com>
Subject: usb: dwc3: some USB devices not working after 6.4.8
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using the FriendlyElec NanoPi R4S board.
When I update the kernel from 6.4.7 to 6.4.11, 6.4.13, and 6.5.1, it
doesn't recognize some USB devices.

The board has two USB 3.0 ports. I connected 1) BUFFALO USB Flash Disk
(high-speed) and 2) NETGEAR A6210 (SuperSpeed) to each port.
1) is often not recognized. On the other hand, 2) was working while I
was testing.
Regardless of whether a USB device is connected, I could see the below
message on dmesg:

[    0.740993] phy phy-ff7c0000.phy.8: phy poweron failed --> -110
[    0.741585] dwc3 fe800000.usb: error -ETIMEDOUT: failed to initialize core
[    0.742334] dwc3: probe of fe800000.usb failed with error -110
[    0.751635] rockchip-usb2phy ff770000.syscon:usb2phy@e460:
Requested PHY is disabled

Is there any idea on this?

The cause seems to be related to this commit. I tried reverting this
change and the issue seemed to be solved.

From 317d6e4c12b46bde61248ea4ab5e19f68cbd1c57 Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <jszhang@kernel.org>
Date: Wed, 28 Jun 2023 00:20:18 +0800
Subject: usb: dwc3: don't reset device side if dwc3 was configured as
 host-only

commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7 upstream.

Commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
system_suspend in host mode") replaces check for HOST only dr_mode with
current_dr_role. But during booting, the current_dr_role isn't
initialized, thus the device side reset is always issued even if dwc3
was configured as host-only. What's more, on some platforms with host
only dwc3, aways issuing device side reset by accessing device register
block can cause kernel panic.

Fixes: c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
system_suspend in host mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20230627162018.739-1-jszhang@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.4.8&id=317d6e4c12b46bde61248ea4ab5e19f68cbd1c57

I will be happy to test any patch or provide any extra logs if needed.
Thank you!

Kenta Sato
