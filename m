Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169627F92F6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjKZOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjKZOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:10:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38725FC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-549070a04baso4579344a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007851; x=1701612651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf3BBbGgK38KEJry5f+skZG4ReehlnPep5PbY6SoWGQ=;
        b=CFYFTrSxcrA8TfeWR3G1Y5sOoDm20rR8R3NFf7ESSCc1n4ILNyrT7g0Y6sTs38NX3S
         jUW8ttrPG+5UZ4PbQKYpoESwyo5BSFnVjZSMrCiS3iD6nd/Ys41qcLD2deUV0fVNz/9X
         wGjcLv2FrQiB9qz7albIHwfi51Rr/dBofveH27wAjBhFmi4iCzkuTSjgBDl+zc4FTJT3
         9f/PiDwuLdQxMKvLL9r2djR9lY5Ad8cucSlmk8SZwQSSKSfiUvHc56mnOKp/LbRsLWqJ
         1nDqoLj1CNesd3K+MAl3vzxIoVh53/xip0H+gwRNY4x+0v8esbFbCKYBPM5aa9O/0TnP
         w2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007851; x=1701612651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf3BBbGgK38KEJry5f+skZG4ReehlnPep5PbY6SoWGQ=;
        b=WuZaBt4KGPcc/NIMAw1eqKfPBKRnubGFT7aJx+7VwyyYbAjNzfu/yk4rZ0LSLw4NPt
         ruimV3Nwq9yVB6UuJt0n4qpDe91fB0qlXkzQXHJE4ccYJSzxG8ar1sjwndMZFMrGHAOv
         BfWRoj05z3LNPnccPI/OlATfHZ0kx692nXDESDe1mNnJhmy9r4+UpKRSTTuBHAdNoD86
         QQsctPj3iDRHU0RHWlI7Spk4J6GMoqnR/B/uqS5cbay2Nd5ZBBa4lo+m2usOSgem0MEA
         BN2NFGWNCIV47DlVb/+2QSq5x2/DIy1XgxX+lyDh/G0BA11sh/LXY2mZdYZaYGGRLsua
         2kSA==
X-Gm-Message-State: AOJu0YxxSnbwWM5YFXNThpEcack5bxv+CjptqY/ji9HPfShF3xnGx5A4
        okhDv5UMENiosoaEbgO34q2Gsw==
X-Google-Smtp-Source: AGHT+IFQxU7KH05yMJU+q5DjIE3FNct1n5ReGHCv7CyKkjdrnTGipQuhi7GpiH5b23rMBzVDJj8YEQ==
X-Received: by 2002:a17:906:4e:b0:a0d:a567:b92a with SMTP id 14-20020a170906004e00b00a0da567b92amr1525873ejg.39.1701007851676;
        Sun, 26 Nov 2023 06:10:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:51 -0800 (PST)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        jgarzik@pobox.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 1/2] net: phy: Check phydev->drv before dereferencing it
Date:   Sun, 26 Nov 2023 16:10:45 +0200
Message-Id: <20231126141046.3505343-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macb driver calls mdiobus_unregister() and mdiobus_free() in its remove
function before calling unregister_netdev(). unregister_netdev() calls the
driver-specific struct net_device_ops::ndo_stop function (macb_close()),
and macb_close() calls phylink_disconnect_phy(). This, in turn, will call:

phy_disconnect() ->
  phy_free_interrupt() ->
    phy_disable_interrupts() ->
      phy_config_interrupt()

which dereference phydev->drv, which was already freed by:
mdiobus_unregister() ->
  phy_mdio_device_remove() ->
    device_del() ->
      bus_remove_device() ->
        device_release_driver_internal() ->
          phy_remove()

from macb_close().

Although the sequence in the macb driver is not correct, check phydev->drv      
before dereferencing it in phy_config_interrupt() to avoid scenarios
like the one described.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..dd98a4b3ef81 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -165,7 +165,7 @@ EXPORT_SYMBOL_GPL(phy_get_rate_matching);
 static int phy_config_interrupt(struct phy_device *phydev, bool interrupts)
 {
 	phydev->interrupts = interrupts ? 1 : 0;
-	if (phydev->drv->config_intr)
+	if (phydev->drv && phydev->drv->config_intr)
 		return phydev->drv->config_intr(phydev);
 
 	return 0;
-- 
2.39.2

