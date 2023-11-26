Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEB7F92F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKZOOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjKZOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:10:45 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95451FD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so462575166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007850; x=1701612650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbyP2Zi73bnd0S2o/T83yVRpeCdtsawXtPRoxH/XnQM=;
        b=NkpMhEZQk4x+jsusGMDW1mTUaLEbJSguvpcO5SLaZxqbqGp977Oph/Od++WHJiQPFB
         NIiQXKGwgQHfyJ2mJzVGWfjShO6V44YoBfGmsfE86+u9m7I+pgMj6Q3V7Xn4T+iZR2TW
         pLq63ghoK0LcSfVjuRd5dxKs9NaZxLXU3ktiuf/3brNM5BiUBkAp+hnztFM4TQ2v+Lub
         MYMwSiPi1avwWMtD77Nn2dCxLP9RSuCrVVLis/r7nUt5yI9yk59S4auvd7PzcY/ln/05
         sE3QEp325D2bDaFj3oE7sW2/Fu4v79bY8W4/6YcSvunEIQLFygseMaSoDPKKSLFtDyT3
         SNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007850; x=1701612650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbyP2Zi73bnd0S2o/T83yVRpeCdtsawXtPRoxH/XnQM=;
        b=LrxTqAmXV6vD08qxJRgDsEKHT7H0zSoiMuTWZmzR9iCwCEmxim4Nu6IyJk5ikN3vcM
         AvqagX4XPUNBqLukdShR20ld+HOTcFBhn0QKcinpXye1E4ZrUAMh4lt3MFS5OE+60QXd
         cz2oS+InQ6TwmOfebUBcGpCy5tZtX1QskFGkTeuBDpzkKdfDr/83SfK0YEddEgA5ZlX5
         Crl2emDPzycS3S4DyOzj/hSo205qDSWxd4151+kFCrQ5/BM4rzREJ64J0qtI1QwzC+0v
         FSz8GkSFQaqtVMHnO5/ONZ1e3VawKUAr6Loq+gqz3TVa91l7weJGr6tHpWcKd4nEW7+X
         mBaQ==
X-Gm-Message-State: AOJu0YxhgGRj79l3yEsR4wJ9EdOZ0uVBypvcW8lq6PRlyQV97fXITLXN
        elv8v8ECE485j6rZ4Wef+tXKLg==
X-Google-Smtp-Source: AGHT+IG8WYqSNV+yRm7gYJARX9o/IETAnxsjICztO2UgkFJE2qsQrNVuRfEZv4AjjgV19ya31vBx9w==
X-Received: by 2002:a17:906:cc53:b0:a00:1726:9e29 with SMTP id mm19-20020a170906cc5300b00a0017269e29mr5871087ejb.25.1701007850039;
        Sun, 26 Nov 2023 06:10:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:49 -0800 (PST)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        jgarzik@pobox.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 0/2] net: macb: Fixes for macb driver
Date:   Sun, 26 Nov 2023 16:10:44 +0200
Message-Id: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series tries to address stack traces printed when unbinding the
macb driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  net: phy: Check phydev->drv before dereferencing it
  net: macb: Unregister nedev before MDIO bus in remove

 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 drivers/net/phy/phy.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2

