Return-Path: <linux-kernel+bounces-46020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A0843957
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861BA1F24C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3F67E66;
	Wed, 31 Jan 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="brNrM1Tq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B361671
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690512; cv=none; b=nuDbDY1RMuQRYY+PtF6iyC7hCueV+sU4VNCLk5FX8TtYErH4g47Yviy8dDaRp6L7R8Vks/kD5PNxDL4nSsXswT09JfmSI0wFA01WpH+U+SlBppIRytpDMjL5Tv16kmN6P4gsW1w7mTLugU1vOS0rhltrwuvA8WtReJV1lnYRP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690512; c=relaxed/simple;
	bh=wv9pwCG0Owxu9SDT/z9arM+oZlxF2tOjU78JH/h+iBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McQhqYL5vh6dvSiVmvtZ+oDjd6h1RVO2SpudOuiGkXNLto5V9eq35GcxqvRw7nUcxLt8aptlma4Xp0Pi9pOpLvC53kY/djapKpFnJ7Ve+oBWitUVV2m7QnLiRcwJhhizXmhOY12Tof8ipHGtiGNP/m6inqJYXPnkWYh6O3Il45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=brNrM1Tq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf1288097aso64960981fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690509; x=1707295309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtbdQ2QcmkuWepYwSxBRl7Waeuw6uF2b5jWIwkLXEcg=;
        b=brNrM1TqmhZd+X92HtVahUWkw6XkVsdYAI1vesF5iseVga9UT/jECzuxqM5dmcQ8K2
         jUOn+Tm3527cp3XDgLgDCtse1bACdErB6CM30fnuiUJW0KyToOkgRFE5bQ0Ku6bBUNob
         HlPYpkWA7g8f1uzV8mmgOJDMvVQAnBrsB3T4+CIKbuXo2yU6bXX6YfKswgUVmvp20gCb
         vXXQ89hOx4Wmjzl39df1Y5nOIEkjETS6hNrsfRSltqjHIuNWDSLkPRUOwwB+UrRCVBhb
         SCOv2DTTOz4tPJSMifSM4CqGEjyhJQyXvhX3wZzWEc8MRo1ON+2/lKzko/oa48BtdEed
         GuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690509; x=1707295309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtbdQ2QcmkuWepYwSxBRl7Waeuw6uF2b5jWIwkLXEcg=;
        b=EWqaCe+5shclcNahoPY7VGGQU6RTFu/hvVwKmpaylYcZIJSIL6WokWILKIEGeWuPMa
         9pVOfPtqvHUBknJC8B58GruLuKPDqWn5B9yaI+P58yro5hp1USlqqOdQB8npEp54Yw2+
         9mnrPydWH3XdH240ZCGhljgE1B7uGjh3S4vZyfkwhk7Ke7A1M4ObMnAKfEVERZHXs1y9
         mNVmFHMhdyEfiQ977GEx66B+zAcSC7ssKOlBEXa/lMLGGVcTmJTvzppetMK2szv6AX/V
         FM2CtYgvXw+GPIzfYQeFLQGO48DW//cAp2VnF9DNVIKLE/klxbrDATI7aFT9jC+JcUC0
         LhgQ==
X-Gm-Message-State: AOJu0YzVJM8AW7CXwUaEwu9l9RqMuVkzXp9YXYM4ihcWKesA9EORmIUD
	MhhWi/BWKhrAXvMmqJF7KAQ/iIIKjKqmtkeJjH+FTfIBh1DYydReK7SY+NCQPEw=
X-Google-Smtp-Source: AGHT+IF631H2evJImQvgomOYIAMNfTZ0qBP18fEMZ47JUk4ieaXoq+jOyqoV+GhKTJREzPbu4yFULg==
X-Received: by 2002:a2e:2a85:0:b0:2ce:e49:5b38 with SMTP id q127-20020a2e2a85000000b002ce0e495b38mr636065ljq.29.1706690508728;
        Wed, 31 Jan 2024 00:41:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpIxpMV+B0SVPGEP4wtDINumQMK/LLVB2GFLs5sHROUSelIkRUpOwm8+jxO9yqMDu1rhdUKFZOIWEHHxTrWLhjZIIkux5q92ZWuuby5tfAk44UcB98B3+mZ41q+E/NWih0qsB6r1MLRfqlEDglg1HlImJsB/XZ3v4rupSLl1M0Fwf5y8ZN7lilFRxYQTFF4pZC3XtRGOKlFYyy7dhawBhMtLI3vPmq/C53VFSKZA+xFnq7SfAPsxVgphz93s3jw+N626IaTWgqIjBB1iL9TWICrNFPRJxi5hxIBC9HG0bFdF4+grLD6Xsc3vp1VQ8nJgLZW4e//A3C+OgqHCVHaJqGYeXGUJrDHFvIF6JHFPNE5E7HdZbKJZP1bCnWQSaXlybhtyY+WFMBlug0oJS5jJ6zOGwP7hSJgTueTDOUJcaUlECaV74=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v5 02/15] net: ravb: Rely on PM domain to enable gptp_clk
Date: Wed, 31 Jan 2024 10:41:20 +0200
Message-Id: <20240131084133.1671440-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


