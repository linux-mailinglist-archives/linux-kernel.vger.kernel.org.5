Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E00764599
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjG0FfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjG0Fei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE7C271B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad8383faso4782515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436043; x=1691040843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj/zrL8WwstmXnH1Iv4DJ7LsdbSE0/SZKmUpfuJWIbY=;
        b=SkwKPnpOR8Z5XGlFbjS/UMoDRkdlP11vGl2TiPxlx6nUE8ssAcqu22tL8udwSA4B8r
         V5g9pDV1XNvMVDbrfzyxJM2GEtIVDLYBD05OkibLfrzFGYKf5f00cEcLI78gzljDn5h5
         t0ozMF4W91aI52nesrSWZNuYtNBLqkZ2A7oU3nvNqbBzCRsyp5LfQl0O7BlX5SneCa1A
         TiRyc8d89yPv9/geLCZXvT48uuNX6KnXlu4F4ij9awAkQqWoVSBtqb+DS/nduw8+oQwR
         k2FhahE3AyOji7/roqQXLCW0wFqHjEGXPHiSC+Vc4XrPJuSJdp1wh+cQ3R6XHn2jobQz
         01Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436043; x=1691040843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj/zrL8WwstmXnH1Iv4DJ7LsdbSE0/SZKmUpfuJWIbY=;
        b=GHAS7VTNmPgs1D8yZwLfS+j4DPZTSc3ttF5k5MgyIkOcrSbPxqnd0qSnKxMm/xA5rD
         VOokBRRqCJSuv75AgrAW89tKltkoZZv0JRfUf0WCIFueq08FPMDvVFuy/5DhH2vAAo+V
         nrcJMZrIUT4WgPVzHM/MGE6JFPjm5WMuIcqA4z1m7boUAY+cM+Aa2luUcjeBfODq77Mi
         c1CygBXXy7HhbVO+GSW2sHDDn+amPa14NUYDqjx3AjUZ6KNV7awS9VGQ2kxB765dh9E+
         YI1LpPiMjlCCDQYFEkuDZfHOKID27u6NphqnHjMiCR+iS7JNdW3Vh8+pLq3TDX0jiz5N
         oerg==
X-Gm-Message-State: ABy/qLYl0Czp7j4Kq0f9MG1E7BOio5alFlErd5gHS88vNbyCz1fzIdHE
        8h7+vfQLeJmie5ChQmOfSne3SQ==
X-Google-Smtp-Source: APBJJlH6VVHpmUq+5fWHet5chIXLNq550gkLg6fJI38OQMt+EeCcLhBG1OmgTl2N6iN3wLb63nplDQ==
X-Received: by 2002:a17:902:c941:b0:1b8:a4e5:1735 with SMTP id i1-20020a170902c94100b001b8a4e51735mr5146515pla.61.1690436043560;
        Wed, 26 Jul 2023 22:34:03 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:03 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 13/42] clk: at91: sama5d3: make checkpatch.pl happy
Date:   Thu, 27 Jul 2023 08:31:27 +0300
Message-Id: <20230727053156.13587-14-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
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

Remove the following checkpatch.pl CHECK:
Please use a blank line after function/struct/union/enum declarations.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sama5d3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index db0c66e24091..e1c1ba907e3a 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -278,6 +278,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 err_free:
 	kfree(sama5d3_pmc);
 }
+
 /*
  * The TCB is used as the clocksource so its clock is needed early. This means
  * this can't be a platform driver.
-- 
2.39.2

