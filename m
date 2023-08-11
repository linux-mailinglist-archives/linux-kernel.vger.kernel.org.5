Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E695778E29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjHKLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjHKLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:47:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8CFB;
        Fri, 11 Aug 2023 04:47:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so29399791fa.3;
        Fri, 11 Aug 2023 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691754471; x=1692359271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=sF/A45rdhEiX+eIwSp80Sg2yJ80z8xF5WeQ7Nw3N8LHVIHcCoImy6xn+6kN23fwiwz
         D/fLLoMzJPc7VbwY4s1TnZsSNua6fdBlpFKe9ow7O/65HT+Y8IE2xStyjZD0sgr7krSM
         UxI/FFRQKbFxVKH+WpJrDl0fTad4z8we4E9t61TaeuEQ+dwMOQXW/VLAFJmWjfv73O/Q
         ZhXQr1Id4IHd9Do73AqTg1nUlw9rjvw5pw7vU8L4hPZMcx10CazHKMT48wwHbhkr0nem
         pVxmBprjCyD5t8PnEgXPo3FYNbZmx5hdxzWAfKv+Z0xrXYv1bwKxjIJAL8FWajJzTBm/
         gtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754471; x=1692359271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=ZU+DSeJsfp9+eBpbmLivBXXM2gocfZdAvp7KMUhY5fSitSnoN5J1rn0kv8PLefxYFO
         UdPsBWmkqWn8mjlc4pOrc02M954TWDZt6ZroGYinto/KTPhrQNyR1YzvbyU2xaukLf0T
         qcYGuHxSJYNRDVKFel4xQgHwD+29Z1EtTLtuEtHaYzMkay4/uob+yGnKh8K3xgGfid3o
         wA5QbtJMCwB+TP+mATtVVTVuPymeiFfpDNxA23JXAJHpQQlkH8xZVezYxjif37kxgkpy
         dGFVkUtDwHWo6eUJ6hBYbnhbnERK+TyeRUmJ34q1d9da7UCOoWh3EWf3p7g+/NEvMapr
         kopQ==
X-Gm-Message-State: AOJu0YysJrcPgdBJ1BaSxXF/DOVbFLGJUqI2ZPjrl6rUBQ5WqiB2KU5k
        0lq6eDNHnuA2vyylfMs3RfBpMctwVX+bzQ==
X-Google-Smtp-Source: AGHT+IEPAS8YE0dO3E+UIuVv8R9jOiunOJsM9J49JulkWNIoFiBtjoPVmPqE8jQXHBtLWVwY9r58rg==
X-Received: by 2002:a2e:9916:0:b0:2b9:e230:25d0 with SMTP id v22-20020a2e9916000000b002b9e23025d0mr1479557lji.14.1691754470545;
        Fri, 11 Aug 2023 04:47:50 -0700 (PDT)
Received: from gba-Precision-5530.kat.ac.za ([196.24.39.242])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm7836898wmc.24.2023.08.11.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:47:50 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: Fix tps65217-charger vs vbus irq conflict
Date:   Fri, 11 Aug 2023 13:47:20 +0200
Message-Id: <20230811114721.35418-1-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index a4bc9f2a10bc..6f68becdbfd0 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
-						IRQF_ONESHOT, "tps65217-charger",
+						IRQF_SHARED, "tps65217-charger",
 						charger);
 		if (ret) {
 			dev_err(charger->dev,
-- 
2.34.1

