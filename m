Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7D79C54C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjILEya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjILExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:53:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F95710C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50078eba7afso8945101e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494361; x=1695099161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoBHke4urpozyZDHr5ucE6zOtD1XFhakU9jA2sy8fAs=;
        b=LcRpHldFUeTT2alLv3t90dqC+PKSe8sWlaiN3S68IMeQCDAB9fp/5GfpH9Xi6BUX+M
         e/i51vklWFGYGZ/zrkS0PKGKgokt2hu8PGyiaIE5r16VUV3EwQ6vq2kDSimiOzeBGgTb
         t4tGGZZBdmvxw38zDYPuyrf9/ttIO/e7tWhgzw2TVIxTSn2gA8kt1wwolodAq7K2Vo4g
         PO18+jfk6Cyh5luemVwy3qBQTVw6BxPvKYLEma8aSBVyXJ5ZE5V5PzsNtPfeqMAbp5Y/
         sFBOmB6Ag8VSpkHxtU4DcumtxVH28YGpAafc05Cpl1OOM1xG8Pv++ViD9YFJjPftWIYO
         wnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494361; x=1695099161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoBHke4urpozyZDHr5ucE6zOtD1XFhakU9jA2sy8fAs=;
        b=IDIDJGwNoGp6DLb+9y5FtfCMU7tSGPAsdpRtiC5rFNMrEAM4FegaN9YaJC/Qa5h4Yh
         f7GN3rdxGwABpZtwNdGcRpULlx9ecwicwzQrL+sYAUd0HAQXkkN1RlplC8LObJ9PLtLi
         MFNTksefoBRLTglfprXyfxgDjuzJm6DstEFCuU9QmobYSnomSyoUNur3g6nVxhdBGqhW
         /gYPe4SbMfJkAjLylrjLkdcvGrZPOlxtBsaOR0HknHejIio/bTU4PdQ6WzpG28aL2v+r
         g24VCYJPokcCN54LOyleqJ56ElHrz69azkqJ5up0nEDVQZMt3Z2xR1CdwSRmpKqx9o4U
         tJ/g==
X-Gm-Message-State: AOJu0YyXQ+R070JA46AJdHT2VGOp7yK5mZZTVTGoGJwdtsBdIASrhTWl
        NimPoAkWHYTqGXzFU6H+mEyL/w==
X-Google-Smtp-Source: AGHT+IFBjLYuyqtfvAjQ/GMEhL7UmycvXELpCVQziRGEXwb15gSWM7vl3v1Q/q/qmVWFzr8rmtSkTA==
X-Received: by 2002:a19:4f02:0:b0:500:bbd4:970f with SMTP id d2-20020a194f02000000b00500bbd4970fmr8992708lfb.5.1694494361475;
        Mon, 11 Sep 2023 21:52:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:41 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 12/37] clk: renesas: rzg2l: reduce the critical area
Date:   Tue, 12 Sep 2023 07:51:32 +0300
Message-Id: <20230912045157.177966-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
to hardware register. There is no need to protect the instructions that set
temporary variable which will be then written to register. Thus limit the
spinlock only to the hardware register access.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 6c289223a4e2..d8801f88df8e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -912,13 +912,13 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 	dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
 		enable ? "ON" : "OFF");
-	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	value = bitmask << 16;
 	if (enable)
 		value |= bitmask;
-	writel(value, priv->base + CLK_ON_R(reg));
 
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	writel(value, priv->base + CLK_ON_R(reg));
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (!enable)
-- 
2.39.2

