Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82678E587
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbjHaEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjHaEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:44:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8BC2;
        Wed, 30 Aug 2023 21:44:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79266c8617eso17419639f.3;
        Wed, 30 Aug 2023 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693457085; x=1694061885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO/87gbQyeD3r5BfAmLIA18C/d6yldzKh/4viMrN7iE=;
        b=mHySLFr0ss8pY95+HrhoiGN+7dwxLzjLdA3agIdpDretyKrP+Q4SNU50fj6Me8DZbd
         vZavFFDOkd9Tm1EUKW0w9FvPKTL9dYWTNsJ8CPEvnJjkCJG3lQ3mb4uixFofvqQXL85s
         avlcWr4ExMObMxyFmndcHJEb+840weeIuKB/1TnYvftBQ8oYlw25Z9NiQafEVGXF4anm
         3ujcW+btmAkiAj6iEK4Q9c9iu7auDuZxd9iT4e+Zl6NCABHWKCOBtgLSSSi3XHjLDCrU
         aiUw6vSqQ2NGeN8SeOiY2RmD31n2ExDIz61vNKKm/xLiwkfl1BSHtX9Cv1MRZiAOzUX6
         1S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693457085; x=1694061885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO/87gbQyeD3r5BfAmLIA18C/d6yldzKh/4viMrN7iE=;
        b=KVwVt30g8NnzkvinN3oCwJMMYdwoQrS85+nq8fzMDN+RPOQ+zf2j/XEdHJ9Cgpt2cV
         hhNDDx+O+UmONn2bYO5wzCRgy76FShJOvmWD4t6jvThDR75smQhpxS1TobBPpttLECXs
         VIDkmJmsl8cy35MHJdNazRQXlH3cFACMZkvxW6SpOumn63aO0BPqJvUSnp8bPnb8PXqo
         JqScl2tBaYC4ThsTOYIbkIAYOFY1ounuKs4gFo6j8hW0X7i66E6VHQp5wUPr4xMcllCe
         C4jTwYsNJN1Lc+AQag9EqKpJj1rNwzIbxFew/WXWLVzKCwQBY2xiDGTl6N2T+08k0x/f
         kLJA==
X-Gm-Message-State: AOJu0YzXmtijjIIpIZ1w8X9YEhGlYLe+Acc7SY6Taq0MJ2SkSBwdT6ll
        NWEtewqbvCWGuteBvh0m8yI=
X-Google-Smtp-Source: AGHT+IGkarME/wE2/xF7fz2L+6by6g+X2BL81KcUMeKD+bK+C2N1nmf8y0ZjmtNA8CAWWuKnLZytYw==
X-Received: by 2002:a6b:d90c:0:b0:791:60c:4b60 with SMTP id r12-20020a6bd90c000000b00791060c4b60mr4527425ioc.15.1693457085608;
        Wed, 30 Aug 2023 21:44:45 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:d40b:6175:6beb:6448])
        by smtp.gmail.com with ESMTPSA id x6-20020a5e8306000000b0077a1d1029fcsm215006iom.28.2023.08.30.21.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 21:44:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH V3 3/3] clk: imx8mp: Remove non-existent IMX8MP_CLK_AUDIOMIX_PDM_ROOT
Date:   Wed, 30 Aug 2023 23:44:31 -0500
Message-Id: <20230831044431.250338-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831044431.250338-1-aford173@gmail.com>
References: <20230831044431.250338-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRM shows there is only one AUDIOMIX PDM Root Clock Select
register, and it's called IMX8MP_CLK_AUDIOMIX_PDM_SEL.  That
selector doesn't appear to have any more children and the
MICFIL driver can reference IMX8MP_CLK_AUDIOMIX_PDM_SEL
directly without the need for any other.  Remove this
errant clock, since it doesn't really exist.

Signed-off-by: Adam Ford <aford173@gmail.com>
---

V3:  New to series
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 11cb0a4fe999..7da4243984b2 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -376,7 +376,6 @@
 #define IMX8MP_CLK_AUDIOMIX_MU2_ROOT		36
 #define IMX8MP_CLK_AUDIOMIX_MU3_ROOT		37
 #define IMX8MP_CLK_AUDIOMIX_EARC_PHY		38
-#define IMX8MP_CLK_AUDIOMIX_PDM_ROOT		39
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1_SEL	40
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2_SEL	41
 #define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1_SEL	42
-- 
2.39.2

