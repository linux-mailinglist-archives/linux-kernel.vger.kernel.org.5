Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9427645AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjG0FgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjG0Ffo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:35:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13112D5D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8c81e36c0so3583685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436079; x=1691040879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRCZH4GGM1E14D8FGmRam/hRPth71ctX83uTK0gxaqc=;
        b=AdlbqsjbBdcn/EdEJb2LCLEioo8YFANuQmf67SxKzZPYqENGC4s6ucFjuztzOJpoCc
         JM2FxjqtAvMkz9Szl++ADE8A9hw5jIZS3jl1XCByzdIPVfulumg8/lwE/xIHNZU+06Li
         r/k7QyUkbC0k2nVSbXbZJWJ7KXRPTA76hqcbmgoOM7c7yYMf6wBtRsNH8EO93Z8hiPkB
         AEQNGuqMxSL+CnWsw9SH5Y3CWij+9RRW5M3WSuT1ULKAVnYjpnLhJfeRQ8Foco/0SxdR
         VexKYCKFFwTcZj2Y2plyxp+M0SXbDvG4HCGrDNBcncCAAV3rsymp2jAr8Y3cigaAOcU/
         XEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436079; x=1691040879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRCZH4GGM1E14D8FGmRam/hRPth71ctX83uTK0gxaqc=;
        b=Y7ODr3Vg2M2ie4LGEgKTDfWKRuKFZDmQT3V1nki/hDzTTzcG5MoxoociJFAGYh+lht
         TSl4S4hYVybcIfJ3dgwYYPcIO/p0bRK6EoAf7AXsWy4sZ3RvT0t87ePAKEpAycbJixyW
         QSwIwfWChtoFDn8D+rCCFkb9QHNzrOyKOB5+RaypZjAgpSplIYaucRpZpJwAycDgmpwY
         KRmZOglOHIF1voP5GLhE4lDakx+GvaPsB/b5KxofsvKg+GVcktRlEE11TIxNEpzhp6uD
         ucIG5JVT2a19Jo8MekvJBbCFdrgvFabWS/JDITHENVYIJaxFIGy0u+7X66kvt/zpPT08
         DSgw==
X-Gm-Message-State: ABy/qLZDf9AMiAX8aqTo9u3RObt4lb8MBGe8R7YlVZEFzPWGXbdV9W/s
        28SWxtz1gOQ4W/4yBFXmlQhC2DibMsf45+xfAHU3Hqp8
X-Google-Smtp-Source: APBJJlExUH0L/WX/KUv9vnLUnpAxPAgjWkHqBlJL7WFDFDhavzVhK7nkGWSMpRtLiPS6S6yphRc6RQ==
X-Received: by 2002:a17:902:7047:b0:1b3:9d13:34b3 with SMTP id h7-20020a170902704700b001b39d1334b3mr3348176plt.37.1690436079762;
        Wed, 26 Jul 2023 22:34:39 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:39 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 18/42] clk: at91: at91rm9200: fix checkpatch.pl check
Date:   Thu, 27 Jul 2023 08:31:32 +0300
Message-Id: <20230727053156.13587-19-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
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

Fix the following checkpatch.pl check:
drivers/clk/at91/at91rm9200.c:216: CHECK: Please use a blank line after function/struct/union/enum declarations

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index a862a0a18972..e0418ab5d65c 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -222,6 +222,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 err_free:
 	kfree(at91rm9200_pmc);
 }
+
 /*
  * While the TCB can be used as the clocksource, the system timer is most likely
  * to be used instead. However, the pinctrl driver doesn't support probe
-- 
2.39.2

