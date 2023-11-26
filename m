Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BFB7F92F5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKZOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKZOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:10:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842C102
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-549070a04baso4579356a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007853; x=1701612653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G30K0Y0szZ7FUxHtENoJCMPPG9CnH+Xt3mCwLqz9nTs=;
        b=R0MX3P5LKjKuWKFRvvhT4ZhtCc0A76L6j7srJtLOFr4VpkDDxABcnOCbS3IMDtAjsU
         5lhC4La+Jnp26BQT/2WynYmzyHKY0+LVBATBCT8hWyXDpZDl4umD5LBJgF1zNxdn5z7T
         qQx2FMIu5Z3ySuqZj5TPTCBhe0OksBcfNJxm17K7VGYQ281TRLEVD5mCJJGvO+Dsdau8
         68Rs//BWrI6PDntJU1oUFdWfIHYBJbXhozuVBIaw2WJFwB2pipzPGceFTEIja9KUgCsK
         +fpPJgabDHuQauXLlIuuD3AoJW1Af3ngyZ0+eTgjk3q93y5vdkESaH7G8/n3WjENvTxr
         o5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007853; x=1701612653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G30K0Y0szZ7FUxHtENoJCMPPG9CnH+Xt3mCwLqz9nTs=;
        b=NUQoPOY9d6sc5D08UUDEVDEeZBnC+rhdc7gJuN+yrIBaelTNMl3MMOxjy5IpxmFQa8
         eApgNFxT8joN++pDv+EUfx4LZ+pAgnJfawX0wvIH05/3RkDbS+ThGtV5+nbh/XEIWy52
         W4nfDXpCQCkA4FEyb4q/VzA3iT5sM+y7VE6uUPtsc0ta3LenpUdE1S7HGeZhvoaCiM4e
         uyndG9oozmH9tDdXYr4sebY1gFy1beyn5eXMkHsi/OYZjY+5jfdH/OiDXlxihnDz5dMw
         MmfnU5L0zAdlbAyM2uQxcYbJkGzDO5uNLz6THsCe8GHlNMEl0LcgPUTKeqS9OGibTUxG
         F0Mw==
X-Gm-Message-State: AOJu0YxMeaWZdWqLbgcPC/nIzKCE2W0DoH/YPYCrXq+u0bHQgCgznV8x
        Rx8ax7vPy85/0RmQXo9YfY4BXw==
X-Google-Smtp-Source: AGHT+IHchuuV9GIsfhQWjw/7BZ/J4Ph2nLVq3ar7gUWKPuajHEh5h7gDvjAB7XKvfY1lncPbjEnouw==
X-Received: by 2002:a17:906:10d7:b0:a0c:87e4:8097 with SMTP id v23-20020a17090610d700b00a0c87e48097mr2048227ejv.66.1701007853102;
        Sun, 26 Nov 2023 06:10:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:52 -0800 (PST)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        jgarzik@pobox.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Date:   Sun, 26 Nov 2023 16:10:46 +0200
Message-Id: <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
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

unregister_netdev() calls the struct net_device_ops::ndo_stop function,
which in the case of the macb driver is macb_close(). macb_close() calls,
in turn, PHY-specific APIs (e.g., phy_detach()). The call trace is as
follows:

macb_close() ->
  phylink_disconnect_phy() ->
    phy_disconnect() ->
      phy_detach()

phy_detach() will remove associated sysfs files by calling
kernfs_remove_by_name_ns(), which will hit
"kernfs: cannot remove 'attached_dev', no directory" WARN(), which will
throw a stack trace too.

To avoid this, call unregiser_netdev() before mdiobus_unregister() and
mdiobus_free().

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cebae0f418f2..73d041af3de1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
 
 	if (dev) {
 		bp = netdev_priv(dev);
+		unregister_netdev(dev);
 		phy_exit(bp->sgmii_phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
-		unregister_netdev(dev);
 		tasklet_kill(&bp->hresp_err_tasklet);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.39.2

