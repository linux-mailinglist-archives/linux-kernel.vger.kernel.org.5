Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AD812FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572920AbjLNMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572930AbjLNMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:10:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E3BD;
        Thu, 14 Dec 2023 04:10:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33621d443a7so4312942f8f.3;
        Thu, 14 Dec 2023 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555847; x=1703160647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fU+RfKCvAOxC90gPUO7tsCa+73ka7kbfiICTTnAgH7o=;
        b=d2bTA4gcnkbc2tzrUYdZ1upxjTxlvMpAoJEGKbRISdvjlTJvxT28l/Mr9D7LKuOjfP
         FRhOnTSi8GtKfyZ8zvBr3fkNh75SkGThK0xGJoudmiq74Mfw6WfB2OC0Tb1RdKjHYsts
         EDEHxXAsEgUlGdpVroqPoCKmwbN/Y4Zn20lE/RMMOH4L0CNW1UhHQoO9wZr35hmpEPly
         Zcx9QBET/cRR2r9qyzp15FCBC74T7EjRijFcvjvLXCepsMbIzwEm6VmkFLsFl+xk7fHh
         Gpxp9+lo9o66WzRhVH7UdY77AHOD4xLjve5wMWtuN2KrfDU5EqJXlkdlLNxhDZlIJg86
         aLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555847; x=1703160647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU+RfKCvAOxC90gPUO7tsCa+73ka7kbfiICTTnAgH7o=;
        b=Lkln782nMaVNxrHYfZLCsW6wAQd6M1VpszFoo19Q6PFDS/66go5wLfRUampJ9yImcV
         PSgZhqjCwzBcrMn6bgsXPcJrNxYdACdz0CqNf70F8jdU/JESrMNdGmjmZ32ZygrRGb9L
         RrGYTAORNAz9h2fqBaIaHnUm2Pb/NHPcu3axZvV6MAZWppQbLxG00z6hhDviWIHRlRMq
         b+V/xJQQSNeIN+odLunrFgqgyjyPtMTICY9TRo/M0plrzZmpCFu/Ofy2O1fm5hEA6exQ
         RlaEbo5CJfO6Z6vrdoijTwB8RH4hxpKK3L4lJI1aeo2mF7EECVe7oFXr75xPozhi3/I1
         DF8A==
X-Gm-Message-State: AOJu0Yw21LJ747AzjVfoRZyqpe9GhhVllwcRfvQoosz0WTDenyte4k/R
        ER+52ck6ShHOHy6+idXgh00=
X-Google-Smtp-Source: AGHT+IEeu2dMsKCXgcMp2OW/EEqeOBX6hysQAyNoeL5TD+dZc4qpBqu/LmL2yHSWMF8i0kaTc18oXw==
X-Received: by 2002:a5d:6411:0:b0:336:4493:27f7 with SMTP id z17-20020a5d6411000000b00336449327f7mr611596wru.72.1702555847105;
        Thu, 14 Dec 2023 04:10:47 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm16026765wra.12.2023.12.14.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:10:46 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v7 0/4] net: phy: add PHY package base addr + mmd APIs
Date:   Thu, 14 Dec 2023 13:10:22 +0100
Message-Id: <20231214121026.4340-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series is required for the upcoming qca807x PHY that
will make use of PHY package mmd API and the new implementation
with read/write based on base addr.

The MMD PHY package patch currently has no use but it will be
used in the upcoming patch and it does complete what a PHY package
may require in addition to basic read/write to setup global PHY address.

(Changelog for all the revision is present in the single patch)

Christian Marangi (4):
  net: phy: make addr type u8 in phy_package_shared struct
  net: phy: extend PHY package API to support multiple global address
  net: phy: restructure __phy_write/read_mmd to helper and phydev user
  net: phy: add support for PHY package MMD read/write

 drivers/net/phy/bcm54140.c       |  16 ++-
 drivers/net/phy/mscc/mscc.h      |   5 +
 drivers/net/phy/mscc/mscc_main.c |   4 +-
 drivers/net/phy/phy-core.c       | 208 ++++++++++++++++++++++++++-----
 drivers/net/phy/phy_device.c     |  35 +++---
 include/linux/phy.h              |  57 ++++++---
 6 files changed, 253 insertions(+), 72 deletions(-)

-- 
2.40.1

