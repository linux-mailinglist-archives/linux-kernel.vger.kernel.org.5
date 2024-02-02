Return-Path: <linux-kernel+bounces-49483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE074846AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64014292C55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D3604A8;
	Fri,  2 Feb 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="amGSXTrI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73355FDC1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863316; cv=none; b=PjJDxYjw/3VBgWOjO2IMOcf7MkOPGRm1c9ftIeBtctzhBggYbtJnRYAe9dmG9LPT7oacjo1Lyl9IymRzTwXDtlliJEbOTJiznT5DKi7/7YDbAShLACl5PrtyasAA6ayJ56nevKO/6wmBY+EaRQ0NNEVeP3yJMkQx2IqJvP6tNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863316; c=relaxed/simple;
	bh=c8nXesotZMA9LnHdIJYZ8HFoGcP/JrAFcXSleBRLlFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWatNw+bQmHdMXZQKaMPLD4pmqNq2Z8Z2aD80K2qlFl7e3W4SLEfvKCjkjXKyqupgg19+Ip7pRZBBwyZLn9Lh1x16hanR0aXwFufGbdjqeLqafzKsarc9VbffY+CfzcA3dOyE2clIoLQOrncplpApshzTzF0pdqIuXuFR91PnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=amGSXTrI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a370328e8b8so51711966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863313; x=1707468113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdLMh/tNWDl5PwogMkAYZJ3cvD9jAZpIph9cVcEu3a0=;
        b=amGSXTrIaTqr2QhMIcjJwSOeeC2knmiWJ3HIyaiihB2lDPLODmcPJ+8DoGI1XSClpN
         C0TdwaPgEhhq6S40KZtM7XR42fbKUGZq2DoKUS+6u62V2kgtdjmyA32hjMvpNvHvjCuY
         tlJPaIKXWaz0t1+ln9n82DoabcSf0HXEFVF/XU56W42SkncoJJqmhdxby8a/eYo8+BJ7
         dxjyl5DBnXJ6iUgje8wKwy6MS10PRj4Z/DmJcaot0e8s54yn/yptjVa2sb3A9EDgZquw
         Ck0oqCqUD7pJo5FMJe9CycW1MRBnY5NUp6vOUj4xQfoAZVqBb+RWAu9HBiUEkW/2SGwt
         mMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863313; x=1707468113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdLMh/tNWDl5PwogMkAYZJ3cvD9jAZpIph9cVcEu3a0=;
        b=rs8ACKAMMDRHN+uQTmBv6BtILjBR20lXK17Qrscimy9jAsRttR/DD92naJ8TWd0NGf
         ygqPX13cy/EZW1nTCXK9V92UY+KGzRfnsr2vWgJDyq5xN4hGhMspsvlXVxWi4kmscrXm
         U04uXKsih3kLUy7A1uBkiUOKeySBqbd1osbg4/Yn/aUgAcSpIkolc5pxXs0ufCgVMOhb
         1UwjQXUlkilykkBD4qDC8h0f+W/BYV1J/NXBIozXyZBqysqji2vhG1a+6864S30SheRN
         6wGXC9eH8X3QIT72BfLNvywnXf5f+Wpqx99lWJ93ziz6FPH+LTe9m+U+wBzSYW0MH9ol
         q/Ow==
X-Gm-Message-State: AOJu0YzR/XSLBXE1ijEeXjdx1BVKYC4KXNAHQGv1jZsw7aNvIzu0YZQu
	mOVO/G5HmVvAFzRj+vFCcZNvJrpHmaOcdeNDG98iqgl5KQUgFEdlWDpiR7VY2nc=
X-Google-Smtp-Source: AGHT+IEdxlZTup5lj+7djepr9X3NdWPssDNnsmV/JnqbxJuwWZ8VOhFN/E5iydxNwcEbW60qkwgG7A==
X-Received: by 2002:a17:906:ca02:b0:a35:e9f1:9690 with SMTP id jt2-20020a170906ca0200b00a35e9f19690mr920331ejb.22.1706863313115;
        Fri, 02 Feb 2024 00:41:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfy15tUjasHj3//aTI47mw3wKkfTJRaD/iGcE9BYbd9ZCTps8ujpQuUHjWiVec+S37MBzd6UIFP+2PFuVcl3b8fL0Xh/NY4qyUW06XAJbjLgUk59TIkVgMkSEfKTwTLVEEuXoRh93d+jOP929HLouK+U3rkOlKTeWXy9La71WB9cB2DfRHNnHiGFYJfHEIyuvOTtrNJcd/pC76K7ljp+SPac48n4Lh7W2fwGQ2VjkHP7OsqVtiLrF8e6wjslfwcL8++vTAbQ7Jj94FJSG24nUAL6Cgqo0TfbjzsYzXY1VsEckL5p+W/5monxmX6TWD8l/vL4nsdubaRNeNHqJZjaP4dWNfCJOHyCKAe1o24SInuZ35ovI4KKe34tEA8IC4cfi6lFwBaX4JrS0CSA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 02/15] net: ravb: Rely on PM domain to enable gptp_clk
Date: Fri,  2 Feb 2024 10:41:23 +0200
Message-Id: <20240202084136.3426492-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d371c4bed634..3181fa73aa32 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2780,7 +2780,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2800,13 +2799,13 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2826,7 +2825,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2889,8 +2888,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2925,7 +2922,6 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2


