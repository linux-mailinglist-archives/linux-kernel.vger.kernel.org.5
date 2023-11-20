Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA07F0DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjKTIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjKTIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EABD70
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so1374733f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469992; x=1701074792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOeweRIPTzisv61dwOGKybnTDN8hrPF1gwr4IaPej8U=;
        b=AELpa+2CXCkaWfwEbbZ8yxg91im79/l4D8Gwtc2ZpsFdgHqJsRuUgDw6UhLW5iUOaw
         0FiEdlYw4OISlH1GyTUZDr29CvwOIgdNDK0oPgR86lR0W/jLE7v9hHi6iLgYyLWovcuN
         8nur0uYIW1Bf8YnNDsbaRiwB+QzOKdU3PPW0g2zlGNNzThYS9G50PTb54wQqWJqVmp35
         DK7fjMSqVZYV8AucUi0StDRhUmkXmIespw3zSaSJiIQ4tZeXBzA04osOpfQSZbzKSLyb
         AgzfNjoIwXTBvehl4Hw9Ac5lQJbtfpQz5vVVuhNcs6g7HIe3K7xK2Q2rF8/7mnnLfpo6
         uxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469992; x=1701074792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOeweRIPTzisv61dwOGKybnTDN8hrPF1gwr4IaPej8U=;
        b=pKffiwesQz05MNeX1zHg6inMJDmG8JXQus/3BGmG2w/sxJAIllSL5+tMziVlJ1BwYj
         5r+LD256f7mE2eu0NzmWc/wCKB4Jxz5lyTG+Tq5X0WNzyMSbrE2tyIpgbSvBZYuJAL40
         CQ6XphHQ77y5ix/804CmVkLo4WSpq7pmCGoK+p0AF8NbEX+i4eAG44+Ig3RMMWeqaz1Q
         inA88DcWJQbe3Zm9uiwYo8g7gDD0DHeftih07cZeqFPD9upTVLZ+9O2kDgqACV5o3Qdg
         Vu0J8SJs3U5brcGOzvCoLp/SGhHGRZdGCK5ZExui72R0xez9HxEg+g66JFTwiKb1io7P
         Ep9w==
X-Gm-Message-State: AOJu0YyOvMdm52pQAvq4z1ugHOxEl++MHNcIpowHsdmf3x0cwRizz98l
        8OeB0UQax48UdiFDvQOhdUwtsA==
X-Google-Smtp-Source: AGHT+IGEwTzVgPi+XFKHAI7QWLlDbO9F0/k65IkPe/o0Zgw1EIxZFufAS/j1wVNsDC3NMAVavifbbQ==
X-Received: by 2002:a05:6000:2ce:b0:331:2f9e:e8a8 with SMTP id o14-20020a05600002ce00b003312f9ee8a8mr6641722wry.8.1700469992303;
        Mon, 20 Nov 2023 00:46:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:31 -0800 (PST)
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
Subject: [PATCH 07/13] net: ravb: Rely on PM domain to enable gptp_clk
Date:   Mon, 20 Nov 2023 10:46:00 +0200
Message-Id: <20231120084606.4083194-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64 based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0fc9810c5e78..836fdb4b3bfd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2762,7 +2762,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2786,7 +2785,7 @@ static int ravb_probe(struct platform_device *pdev)
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2806,7 +2805,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2869,8 +2868,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2893,7 +2890,6 @@ static void ravb_remove(struct platform_device *pdev)
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	/* Set reset mode */
-- 
2.39.2

