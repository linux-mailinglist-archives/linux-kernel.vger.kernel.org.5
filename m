Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E047645B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjG0Fh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjG0FhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:37:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706513C3B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bba48b0bd2so3392105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436124; x=1691040924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiPKeEp/OnJVAeiXOlEa57rkvX7TbeABjU0rqvFwffg=;
        b=Gv96cxC9tN5YDqs7yjb8N7ef2X97pLKH1U6k0a/M+7tHu8ixpB52+7qb1oORhVB0D9
         QkghtXksO+DJ6mH9Ou167j/oqRrieRoLajl4KNITe73qT9k0D8MdIjABMwEyBCEnKcm6
         5pKAoy2HnAHJeBxmcMndj6w+lRwA7MQgCfWd+dKLXwByYc3pk/Avu9Mq/RWtIptpTATY
         MhAfL+v0oAo3OUyfTBIk9DZhrtBBPowoCsTF0Pb35LvC4Ay7OqTgUOgPg6Mvob8Fo6UU
         1GwTxynTvs7fGBrhezkxYimDWOz9A+a7XXUqAz7hes8x014htOJF3wjy3WLVQmvEJ61w
         vycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436124; x=1691040924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiPKeEp/OnJVAeiXOlEa57rkvX7TbeABjU0rqvFwffg=;
        b=RISIE2C5FqFC1zjr2AmkonO3ZvCcCJ15JlX2vKb+stUKhvuU7ESJX0E/TBgONLlb7K
         5ZTANvClhvnDREwCLO1qPB6g4f2hAIx2l5hOZzga2ljaNkNRyjfTdc8hRcRP0gNrFKMu
         xMxF3yScwrRHCUbHbpCIFzZIu9F9zvR3ydZF3+OO0xX/Ej30e6nlne8PaNCBhHvq4PuV
         b79qikD8Wn0AxaSkzyM2YoUx9VyS8RdnlrWtaXdtnSTvwJX+/6tiZvUIVduoF8GPqyzH
         UZ4sayp6jx2XqsNxsLzPob98cNXffsLGP3tPAP2hJNTEigBMXcMmO0E+rNJHa3af3bHJ
         9xlQ==
X-Gm-Message-State: ABy/qLbrQ4sbufVEtJjj0qw//h0lfW5ofqmWjARHffoSSMNRBxb5p+IE
        y9L/5jRJPPORZsme1S8sbNVv2w==
X-Google-Smtp-Source: APBJJlFINJit9i5ARlN+Vsj+y55YmXolkqEqxQH3HTSxW35zdaX+DZVXitsrxj1AE1PQfpnc9plraw==
X-Received: by 2002:a17:902:c1d4:b0:1bb:98e8:5db2 with SMTP id c20-20020a170902c1d400b001bb98e85db2mr3420427plc.26.1690436123881;
        Wed, 26 Jul 2023 22:35:23 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:23 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 24/42] clk: at91: at91sam9n12: remove checkpatch.pl checks
Date:   Thu, 27 Jul 2023 08:31:38 +0300
Message-Id: <20230727053156.13587-25-claudiu.beznea@tuxon.dev>
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

Remove the following checkpatch.pl checks:
drivers/clk/at91/at91sam9n12.c:135: CHECK: Alignment should match open parenthesis
drivers/clk/at91/at91sam9n12.c:264: CHECK: Please use a blank line after function/struct/union/enum declarations

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9n12.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index d8dcff9ffaaa..01d943ebb680 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -141,7 +141,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		return;
 
 	at91sam9n12_pmc = pmc_data_allocate(PMC_PLLBCK + 1,
-					   nck(at91sam9n12_systemck), 31, 0, 2);
+					    nck(at91sam9n12_systemck), 31, 0, 2);
 	if (!at91sam9n12_pmc)
 		return;
 
@@ -271,6 +271,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 err_free:
 	kfree(at91sam9n12_pmc);
 }
+
 /*
  * The TCB is used as the clocksource so its clock is needed early. This means
  * this can't be a platform driver.
-- 
2.39.2

