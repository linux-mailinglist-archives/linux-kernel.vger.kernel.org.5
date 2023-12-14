Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1003812F20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444141AbjLNLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444102AbjLNLqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD48123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1029664a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554381; x=1703159181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzZ0BgGaxayTSFzsb/BEZRjubDF9VvMmh4DxIfBVmak=;
        b=I69wKj6ciyjUxJ7QD/w621gbHVWbppXUhhnZ+Pw2vfjD8ysGHonveitzmjV0HB8mh2
         IvfhpZ+S7Pm6BoW8V1eVcmePUjQI9SofLtPnOHA4dCR+fHx5rKqhNE7DQ36cWzmlEaYq
         8iWDPRf2R0QDU4T3+u47GbIGofv5MGz4AOuTjxQkHUK9b+Hod/kH98vj2H3YtMetKvV8
         a4bcab/zx04lAVQfa/bvp8ConLHmtSAOH6Dxq+9xnp+mKBIwaj1IJGrUBOQu2llmExbH
         Y26J2rISYlvGRem8LXGGok/FeVXkOcQxaR2QRvMY4ENlVPazClO/5UascgOx4uWxPBww
         T56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554381; x=1703159181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzZ0BgGaxayTSFzsb/BEZRjubDF9VvMmh4DxIfBVmak=;
        b=XMbFviI722G8q8s6SKQRnwua4MdzBSIIJ9EBew/4P8FgCl2fQdjDeUUFOKqq08ZDrX
         7wnJU/GdwxZMWUmX4lH0qOqtoM59VXdTtkpCeMF02HBuxmrWi4VLwWcuDhPVlujCqe5U
         T1v28OnM5d4iHy0dKeNcWAj968mKsDSPKy+9ygOyFyJQ8xutcxcMN6XJ6yBNJ9AR2LhB
         aqBvRY9U/CM3F7CPcY5yIW1DcVckVa5H3dp9OjGuIXyFv4idXoHJno9usk92L4QQkUi8
         pZ58d30jpSjRfa35Tm3WaSAw5YM4Vag9VvUtxa5tPjqAwu7t50KaPAkFHo4RM2/lA7yp
         Ok9g==
X-Gm-Message-State: AOJu0YwsTn9zU3H3mWqCTfujO9fRe3p4qXJTCLEtjNcclSYShclP56m8
        xXXoEXDFAKF5ii8Y3cbdYUQ4pQ==
X-Google-Smtp-Source: AGHT+IGrfsWF2TK37JNT1iRMcyS+d6NKRvQ7j5MzSSkR+QkO1AqE2szxYNqX3A233KgAaRlYFdYN5g==
X-Received: by 2002:a17:907:5c7:b0:a23:f56:98e1 with SMTP id wg7-20020a17090705c700b00a230f5698e1mr903990ejb.18.1702554381683;
        Thu, 14 Dec 2023 03:46:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:21 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 02/21] net: ravb: Rely on PM domain to enable gptp_clk
Date:   Thu, 14 Dec 2023 13:45:41 +0200
Message-Id: <20231214114600.2451162-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
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

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64-based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in the rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus, remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in the Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8e67a18b2924..aa5e9b27ed31 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2780,7 +2780,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2806,7 +2805,7 @@ static int ravb_probe(struct platform_device *pdev)
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2830,7 +2829,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2893,8 +2892,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2932,7 +2929,6 @@ static void ravb_remove(struct platform_device *pdev)
 	if (error)
 		netdev_err(ndev, "Failed to reset ndev\n");
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2

