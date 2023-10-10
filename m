Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119F7BFD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJJN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjJJN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:27:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB2B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:27:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so9590124a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696944431; x=1697549231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iig9ag63aVzgMKeY4TwjyQYW3SBdv2Ym+GOOusSElI8=;
        b=RjmFxK0khafMxqzsB4Od0FtHja4eGFDM6JsRgpnvl3TEMkm9CYaCd6klRgAK0F0z0O
         KcBsgWVuvi3dsu+VLecVUhQmioVnToYNx+WwnVOYginzbKByZlu4uAOZimeNitYYy60k
         QVATuuZKuySqjYqruwS+KjsjxH1SMnrvv3bIL1uQMPPV8Ho/3tci5S1uVU2gLIHn2uQL
         G49Qv9qbLjK9b9SRSu+VMFb6vsWOevBnoJzDZkDcWs4apduC1vP/pHNSGpB/v3ZsmPdG
         5YmrQTOZsEXz05sJ8Tv4X4+sl7kO5SQbKd0i+Q/tHcC5RrjPpP3G8JleUXc5SPqn5R1d
         BAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944431; x=1697549231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iig9ag63aVzgMKeY4TwjyQYW3SBdv2Ym+GOOusSElI8=;
        b=cx0QzZez1UYkXNG04IRwYRWlzbI8GLQOU2X5IYhQSZIK2sOrzLAzgK12F1Ns4NAfGx
         Bv1w27nLmZQWuEk0iz1uRSy3+99/CYAB+WzJqOvBRoheM2YgSQ8Hx/dc11qAN+uirgOp
         3cUnRkbVugYXDGvzKRPr6Y2EthCXaCVtzeYrfhgnLPaWFsirWdqgguzOvwL3oMAjYKyj
         vZJxCD/O3cigQbbVdDk7KQInO0NLGe+aHB+Z0PvrqhL4Dpi9Kx6Fl709syHpbBdDTCFl
         tgFf/pJDCT3P8KY+AcR7pO51FenrHo8oZozj0T84d6dDvZrEmacPBtS/UpI+uc5YgMGk
         gy3w==
X-Gm-Message-State: AOJu0Yy44vLFf59XgFI7RuSP6yA4xhlzbEeyGFfFC+f36k1AbBCpWZG+
        OfLtsUNEKRm8tAZ9bY4qG7nZMA==
X-Google-Smtp-Source: AGHT+IH/4VgcQTIb7nq7GquauPcHOWu6jQZTwpKEVREMKXrZskqhEh3KwuV8ijbjiN+arTCLWWjT0Q==
X-Received: by 2002:a17:906:8a59:b0:9b2:e26f:3636 with SMTP id gx25-20020a1709068a5900b009b2e26f3636mr15771125ejc.13.1696944430759;
        Tue, 10 Oct 2023 06:27:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.152])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709064ed000b0099bd0b5a2bcsm8526578ejv.101.2023.10.10.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:27:10 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/6] clk: renesas: rzg2l: Use %x format specifier to print CLK_ON_R()
Date:   Tue, 10 Oct 2023 16:26:56 +0300
Message-Id: <20231010132701.1658737-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use %x format specifier to print CLK_ON_R(). This is easier when
debugging as the value printed will be hexadecimal like in the hardware
manual. Along with it "0x" has been added in front of the printed value.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d62f1bc1f60e..764bd72cf059 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1213,7 +1213,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 		return 0;
 	}
 
-	dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
+	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", CLK_ON_R(reg), hw->clk,
 		enable ? "ON" : "OFF");
 
 	value = bitmask << 16;
-- 
2.39.2

