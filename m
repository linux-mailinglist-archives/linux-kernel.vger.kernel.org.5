Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2564D812DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443840AbjLNKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443781AbjLNKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFC19F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso7643625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551178; x=1703155978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuS+45h2ga3aQkPKsayipRVsQ8w0E+s5uDXU4i8VrWg=;
        b=aZRo+UjPXLgFt4whs/qPqciVYMVoliRW4Ld94w6FwAIl5U/zh+prH9DxSNaOFSObpT
         6FgjPxNweVjcZGfdu+ZIkTlwIy2Z4vny/Ql26kDImvpbZ+KRbmPeQxiCegb47jiwhgBN
         GIM9CJ3fQQJxExHDhQ3J0l/jhHL42At48M8NcS4ecRLSmOz+V0eQPEbnIs4QLg/EDZh3
         4kv3L73CdLiVst6TdY3T2cy900PYSiJrfQsRvKcoqcyGlaA8L2bXo4Ksmd3vGvnQLH4h
         W8diypSWW0UUSZrfaCQKOoACVJpPNP+To1KYsms5iTW3kzfcxnJ+IsTFNspsV5fSrD/9
         6VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551178; x=1703155978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuS+45h2ga3aQkPKsayipRVsQ8w0E+s5uDXU4i8VrWg=;
        b=fCoDgg8VxJYASfvsNEWTXKU+V635N8fhA+qFSeqW22X7/Wr2UoSJOuH/3VgFLHBj96
         egNI2INnZneOyIESQUBG/ZsgXOauWVOgWCKK+orbveyj9RbqjmRtDFG7TylXWQl14GU8
         dstmp3y5UF9dNvv75FNCU+9ZRpmeAb0pjaIbMcFpa4ia+AZqG4rtvRi04aGoWDZZFfIL
         HlM1aHto1Ceq/4pShwlz4RWp8JxKWEZJFU+DEFQWEqaj6PIBBDVIn0WN14iQ2sH3pIcP
         KxHEkZOGcyZ8KvzSCqSy3Gldr+6YJYc+rbxXw8YHdhjywBEepOzxuH6PeaFmuqTjJebu
         3YAw==
X-Gm-Message-State: AOJu0YwqL3FlorywPVJE0KcvlzCZS8a2c5JQVfv0QdosMNd6TwIXnYVr
        FVWzN9L+GO3vTWqdURQ9QVfvpA==
X-Google-Smtp-Source: AGHT+IHAGC45+JA4KfBfVBo5MvsdcmfG4HWD//LZLINpHkMirvEDnQf0FMXjRjvFzd5QesYIFv2g5g==
X-Received: by 2002:a05:600c:2113:b0:40b:4520:45a6 with SMTP id u19-20020a05600c211300b0040b452045a6mr4416373wml.8.1702551178174;
        Thu, 14 Dec 2023 02:52:58 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:57 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock as critical
Date:   Thu, 14 Dec 2023 10:52:37 +0000
Message-ID: <20231214105243.3707730-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
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

Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clock
is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement,
which then makes the system hang. To prevent this, mark
CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
accordingly when tested.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 3d194520b05e..08d80fca9cd6 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top_gate_clks[] __initconst = {
 	     "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_BUS,
 	     21, 0, 0),
 	GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu_peric0_ip",
-	     CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
+	     CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_CMU_PERIC1_BUS, "gout_cmu_peric1_bus",
 	     "mout_cmu_peric1_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC1_BUS,
 	     21, 0, 0),
-- 
2.43.0.472.g3155946c3a-goog

