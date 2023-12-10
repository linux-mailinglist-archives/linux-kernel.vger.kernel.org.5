Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53880BC4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjLJQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 11:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 11:50:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738CFA;
        Sun, 10 Dec 2023 08:50:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2886d445d8dso1009275a91.1;
        Sun, 10 Dec 2023 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702227046; x=1702831846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cx83+ClTbz5lUz2UC/9mxXOF3CM87EbKd6ZcjX3rjAI=;
        b=bpgfOHtVXinUsbpKkASsksV0uyjqgpJFty9QpCwftGrsPe3OlLghtvzF5nvz7vI0yA
         8/HFg0n3x/gKvdD4BLVZm1QJL7n2S572Dx/+xgwVH/UynACUtodZ5SHyJtbbJToxav12
         X7xwoW6U2QvRcr/243HmGaufgeOf7KLYbWTlX6YeeOXiymu5ok1x36lICYUDVdUeVGso
         fXQqzgWruPxRwlX+jcHrBkns4HpkfgIMEoO2Gms9a3odxBgyFyPz7I5BKmu4vSWsByS4
         jejJ/rLChTg/5brPbntGvMO79VeeXcsqk2kG7Xy57fTCjzE+CWOJDG57h8YJZtPDAFIz
         a4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702227046; x=1702831846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cx83+ClTbz5lUz2UC/9mxXOF3CM87EbKd6ZcjX3rjAI=;
        b=PQQxbgrd9IlSbjNTPxbFf7TRe+wVFlc6Z9H9U0K0ebPcfF/VMFUdzg/xRejfK9iZQc
         /AhsYjQvAxVY6cZWFnNnddU4wLCAqM1NYyCRqCFu/k8FDK57GhUS0zOeWWdMh1QMRyLy
         +7FKPaBrtGLgZn1mqgb48R3Hq6A3ZvZz78iqrPV+H0soNlK93z67fo3ATlac8V8VqX6f
         60SRwTJXvYLRD8mJ1+OHcjCRAyiKjeK0VLX7NYhZsnu6TJ31kj1U3+bjlRpBS8M6ScL+
         YPe5OAiQyLFGq2GO3fKm/q/3Ll3BkKZHnYIGN0xU9VAeb8HzVwk738lCBztcH10Bn2mu
         B8mg==
X-Gm-Message-State: AOJu0Yz0IFksKccnK1tUoVHVpNyIaZv91VZ09WrieQjty3MgWl9k6q/Z
        xY/Ll9KO2K532Z2OLiydds0=
X-Google-Smtp-Source: AGHT+IEfbTLarMP63qUNtsd6a3QqVptoby0FIdULnNzGnoM7p8yeSo8LcHvXt+o76mrdpYycJjKDmA==
X-Received: by 2002:a05:6a20:3d29:b0:18b:c9cf:4521 with SMTP id y41-20020a056a203d2900b0018bc9cf4521mr7940567pzi.2.1702227045917;
        Sun, 10 Dec 2023 08:50:45 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b00286bd821426sm6758938pjb.26.2023.12.10.08.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 08:50:45 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     robh@kernel.org, abel.vesa@linaro.org, dinguyen@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date:   Mon, 11 Dec 2023 00:50:40 +0800
Message-Id: <20231210165040.3407545-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where kcalloc() fails for the 'clk_data->clks' allocation, the
code path does not handle the failure gracefully, potentially leading
to a memory leak. This fix ensures proper cleanup by freeing the
allocated memory for 'clk_data' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3620.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 2d7186905abd..5d0226530fdb 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -466,8 +466,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-- 
2.25.1

