Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9D812F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444113AbjLNLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444114AbjLNLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9312C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso3483636a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554383; x=1703159183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YimeFaEHAC3lIu4QGMGIH0XFkFOK3pB7g8Rtk8OXULw=;
        b=NVaV6MdFFn44vQOJ+T5Ea3KVQg2gyfSQXRtVBG80811Bw1y0QPFHPnbE4xxMd+RmZU
         ShxVe3PU8hmFyrjsBHGkZGl9MSKMm69RyYy0apLcy6a1d/bTymZGSqOPk3xjWv4vCduE
         2NPAi35pRpgZu49R0TkEIcgE7u29CEj/sDijwTHMbMBU47gGANB4NDekfWi5fh2jGKPr
         EpamgjlewSiqBb/ttqQUdgoB8sX4bze6b7gj0qOWzI4wR7bAat6hkDyZQQm4OhNspXFz
         cRIF11Ide+Z/p0WaZ4taEohoG8LPWitYv3Xd9k/BJyE5RYsmKykNZkZJIKQPtTdJnM3I
         mu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554383; x=1703159183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YimeFaEHAC3lIu4QGMGIH0XFkFOK3pB7g8Rtk8OXULw=;
        b=VpCBNerHOqgXlpp+0PM4LmnKizI11RdCLVm00z6RZpGhF8b/0KYYs0ULLqB6IvMkZ8
         IdbaH1OiJrt9kXeAUBMQ3Hy1EYXATBCMT2fQm4d1nGsCT81Q3eYJaqDnX+ALHdsgQDhb
         EQu0c+PfOWOnhIvh/h7LTkqurFUVfE3RVE4TlZoFqk2Si/Rebe7ZRR02sjSzDxAerQL1
         REqE9EcnGul1Droi2lp+CV7kUC7wn/IuP4q9yC7IcD9e4NJqiMlcTl8pH/uRN5Vh1Pad
         sPbuXwL8vN+kovGzbDFTh5EEvXKfyAOa5/EDGreqdjBdn9OrRCSqMicETIeuk46IEbdg
         5j3g==
X-Gm-Message-State: AOJu0YzYdbASuD/2wSfCSIJk/8VXW44PyJoVSV3NVp7XpkAO+RuiEHMM
        HztpNsgpL6CFe7TDLgmemi6I3A==
X-Google-Smtp-Source: AGHT+IGCn2/UbIdGnznzhJ0TGCQKSt7Gts2t4IoBzSpbr36Rkj3nYjorrXYeBtJoiUGaYtkZs1R4kQ==
X-Received: by 2002:a17:907:2955:b0:a02:8b23:895d with SMTP id et21-20020a170907295500b00a028b23895dmr3746075ejc.35.1702554383237;
        Thu, 14 Dec 2023 03:46:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:22 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 03/21] net: ravb: Make reset controller support mandatory
Date:   Thu, 14 Dec 2023 13:45:42 +0200
Message-Id: <20231214114600.2451162-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index aa5e9b27ed31..b4d5a14ac4e5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2

