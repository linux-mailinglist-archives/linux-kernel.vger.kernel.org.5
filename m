Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D97F9C53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjK0JFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjK0JEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5709E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54afdbdb7d2so3422162a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701075890; x=1701680690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFPzyYcg2nUUJpJ3l3C/kpW+QQW8M0KLB90b9p9tNMM=;
        b=aBN5G60RGOPaDQLtt8UsvGBjnXb3POhSF2ghUsdTfzN2oXHfPrmoNJltef434ClBBO
         slK79P+pSwgj3DbfC8MAnMzoSNSm5kQqhB2Sucdk2xin8VM6DmkyXmpkOcP/JMtljC+S
         rmj8beatuLWIZU1Rmhk25ht5R1OpW1JR5wI31s2wx3UYguaz2dFzsqnvq9/3Cp9zWYaZ
         akhcNadPZOx86mqInbdYP9I942UpBG5hXpsYXsh0t+NNaIMa5LRrUtZGV/+ZDUruXlzt
         m7YVObIX0lhe2FAV0ETx95B1txsNYBPYfdkY0h5qStGrBs+RBHdnP9teTM7rbMer6O//
         vRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075890; x=1701680690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFPzyYcg2nUUJpJ3l3C/kpW+QQW8M0KLB90b9p9tNMM=;
        b=OEKOW4MsZbgIL0JC5VZy6Mi1nix5OM+UMdy7+b04PPJOArZM/snwcRjfcOOlySmnDf
         VqWnLJVffzjH/7/s7sRF97N393DUjDWeTNiAInk5bMvYrEjmhHYpajUjOyMwG/m1WL6q
         VxAYuUpSdyKo7C6EKBT/4ZMi1hsrx3EjDsGdo9QwTooXjh0xkTfTqvou7WMIe973yGjJ
         Zuo7SetVlwIBWVFaTR7Qf0h/HKZRPeyNwwscAP56TdR+xiDfVzUWlWEnGwleMYAKXD3b
         uZkcgv//ZeCjtgaP0L4dyHXGZurwD9E/gEQTryGvjizeZ+ASZy1MZK+60P/Hlk4FVBQ1
         OuDA==
X-Gm-Message-State: AOJu0YwWwtmAiTAINVJZxdnZzEz5QCScpWm7DZJFSUdM0Q0S7f9QR9ez
        VAtkypCoewcWdYqo4CSOCtnQkg==
X-Google-Smtp-Source: AGHT+IG75ahxVbdOpMa6yVtBJCLfLwgBcjelwbDYnqzwJwKosGZ3obiYPvVpMGx+sQuqdwUax2Sqow==
X-Received: by 2002:a17:906:8916:b0:9e6:1dc9:9807 with SMTP id fr22-20020a170906891600b009e61dc99807mr5225024ejc.77.1701075889980;
        Mon, 27 Nov 2023 01:04:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm5456539ejb.153.2023.11.27.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:49 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        robh@kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/6] net: ravb: Keep reverse order of operations in ravb_remove()
Date:   Mon, 27 Nov 2023 11:04:26 +0200
Message-Id: <20231127090426.3761729-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S SMARC Carrier II board having RGMII connections b/w Ethernet
MACs and PHYs it has been discovered that doing unbind/bind for ravb
driver in a loop leads to wrong speed and duplex for Ethernet links and
broken connectivity (the connectivity cannot be restored even with
bringing interface down/up). Before doing unbind/bind the Ethernet
interfaces were configured though systemd. The sh instructions used to
do unbind/bind were:

$ cd /sys/bus/platform/drivers/ravb/
$ while :; do echo 11c30000.ethernet > unbind ; \
  echo 11c30000.ethernet > bind; done

It has been discovered that there is a race b/w IOCTLs initialized by
systemd at the response of success binding and the
"ravb_write(ndev, CCC_OPC_RESET, CCC)" instruction in ravb_remove() as
follows:

1/ as a result of bind success the user space open/configures the
   interfaces tough an IOCTL; the following stack trace has been
   identified on RZ/G3S:

Call trace:
dump_backtrace+0x9c/0x100
show_stack+0x20/0x38
dump_stack_lvl+0x48/0x60
dump_stack+0x18/0x28
ravb_open+0x70/0xa58
__dev_open+0xf4/0x1e8
__dev_change_flags+0x198/0x218
dev_change_flags+0x2c/0x80
devinet_ioctl+0x640/0x708
inet_ioctl+0x1e4/0x200
sock_do_ioctl+0x50/0x108
sock_ioctl+0x240/0x358
__arm64_sys_ioctl+0xb0/0x100
invoke_syscall+0x50/0x128
el0_svc_common.constprop.0+0xc8/0xf0
do_el0_svc+0x24/0x38
el0_svc+0x34/0xb8
el0t_64_sync_handler+0xc0/0xc8
el0t_64_sync+0x190/0x198

2/ this call may execute concurrently with ravb_remove() as the
   unbind/bind operation was executed in a loop
3/ if the operation mode is changed to RESET (though
   ravb_write(ndev, CCC_OPC_RESET, CCC) instruction in ravb_remove())
   while the above ravb_open() is in progress it may lead to MAC
   (or PHY, or MAC-PHY connection, the right point hasn't been identified
   at the moment) to be broken, thus the Ethernet connectivity fails to
   restore.

The simple fix for this is to move ravb_write(ndev, CCC_OPC_RESET, CCC))
after unregister_netdev() to avoid resetting the controller while the
netdev interface is still registered.

To avoid future issues in ravb_remove(), the patch follows the proper order
of operations in ravb_remove(): reverse order compared with ravb_probe().
This avoids described races as the IOCTLs as well as unregister_netdev()
(called now at the beginning of ravb_remove()) calls rtnl_lock() before
continuing and IOCTLs check (though devinet_ioctl()) if device is still
registered just after taking the lock:

int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
{
	// ...

        rtnl_lock();

        ret = -ENODEV;
        dev = __dev_get_by_name(net, ifr->ifr_name);
        if (!dev)
                goto done;

	// ...
done:
        rtnl_unlock();
out:
        return ret;
}

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since [1]:
- none; this patch is new

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 805720166ef3..9cad10db59b7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2894,22 +2894,26 @@ static void ravb_remove(struct platform_device *pdev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	clk_disable_unprepare(priv->gptp_clk);
-	clk_disable_unprepare(priv->refclk);
-
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
+
 	ravb_mdio_release(priv);
+
+	/* Stop PTP Clock driver */
+	if (info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
+
+	/* Set reset mode */
+	ravb_write(ndev, CCC_OPC_RESET, CCC);
+
+	clk_disable_unprepare(priv->gptp_clk);
+	clk_disable_unprepare(priv->refclk);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
-- 
2.39.2

