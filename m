Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3B811C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378965AbjLMSQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjLMSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:15:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FB0A7;
        Wed, 13 Dec 2023 10:16:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3360ae1b937so3694103f8f.0;
        Wed, 13 Dec 2023 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491360; x=1703096160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGFsEcnLWfQskkH/HBBeriUIEXqAgKL8+Y/z39zis/U=;
        b=DQm3jOX0GiWYveROu/pugi10THtutEEKijcAPXCm/kHQbFecwsOAigGNC/A2apCgrH
         c1YCdR67c1XK6L9FR8Nvi63hSf0OzNV9rU2Tvf1mAoN59FaRzZc+1ksInJ83geLH1S6T
         XxHFGGuLGQDzysh5PwTtpxOEIAUHbroBPa3H+vSw+GKyzRa1Huwiw+OWeaOS3qGsC863
         bHIZTjHmB6ILAIgmwEUjzWsNgz+0yFtsdRO9iU6XzN/xwU51GbkRbVoNuqoJuhTerAIP
         EjIWqiPFQ8Ic7XAeHyC97fSXcGKFWHoMNF7TpDG0pRYIyfKMcdvRP3ZHyjLNcxfBR8UW
         SLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491360; x=1703096160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGFsEcnLWfQskkH/HBBeriUIEXqAgKL8+Y/z39zis/U=;
        b=iEKoYW2j/EdYgOQ2HDfNUcd2XyOuhwuvgcFs2Rv0xmey2oqLvkjiOU9OR7sjiX3w2W
         695v1xynill2XsLhhqA919m49EOkw53vh/oT51BSP829cq+XrS6c+vlSvVXz13sAWq//
         3EoMTyIB4BEz/8FPZl/Wz6p1gvO1IJJjbmBMO203v+p3wdb+mLL6ASHKF7xpySywtSrI
         8abk0JTSQUFHnjpvnxn0xrPz/YV+nNh72qJPcFyTuEoYKtZhg9bOBqL4wi5itG/M+MQU
         USHMFpsxznJfIzYgWPAOck8hJARc+LWI8S7S1UL/lzh/Gn96a3ZKj2GhlwN2VvJJj3Wg
         FowQ==
X-Gm-Message-State: AOJu0YzsHIJqAT90rjeI28dOGItfsgmNhk7pfozFbjy/x6SpJTgTQNBO
        XE2GuhvpqXX6OmoiWXCsp7c=
X-Google-Smtp-Source: AGHT+IE9cHR0Goae7Zt7vuXUDTwV1Mv8t2gUcOTNuEiQVHOb16d0OW3R1laCb9C5gwG+u98v6nzOxA==
X-Received: by 2002:a5d:6611:0:b0:333:179:d8df with SMTP id n17-20020a5d6611000000b003330179d8dfmr4457400wru.26.1702491359661;
        Wed, 13 Dec 2023 10:15:59 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id e33-20020a5d5961000000b0033346fe9b9bsm13947762wri.83.2023.12.13.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:15:59 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH 0/2] net: add define to describe link speed modes
Date:   Wed, 13 Dec 2023 19:15:52 +0100
Message-Id: <20231213181554.4741-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple series to add define to describe link speed modes.

Hope the proposed way is acceptable with the enum and define.

This is also needed in the upcoming changes in the netdev trigger for LEDs
where phy_speeds functions is used to declare a more compact array instead
of using a "big enough" approach.

Christian Marangi (2):
  net: ethtool: add define for link speed mode number
  net: phy: leds: use new define for link speed modes number

 drivers/net/phy/phy_led_triggers.c |  2 +-
 include/uapi/linux/ethtool.h       | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.40.1

