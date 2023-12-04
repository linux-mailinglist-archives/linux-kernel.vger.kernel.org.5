Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C9803BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbjLDRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjLDRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664583
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:19 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d852e06b07so1659058a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711319; x=1702316119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LzfPXnoh+csBX7vLMU59nOns526pWVt603zQVilgL4=;
        b=TfhmGU6lO6fg/noNszpMohBn1SHLq59i6u/ummWQ9YrTwimiP+vc11WmP1anJ7tAKl
         qS8q6JCAZhryqSnIeyd1+N/GKeoiEfbF1Stb8xx/uB0jBYAlGBOccjkd1KTDYDr3ibav
         EcN62nikiWeRCwHlfUHJE3U4xwCEx3sRGVB1ppY3bLDwifCegn0largtt0wtlPGBzd8e
         G20CFh4bwcg9/svlVG8O1q/lR2Ep7qhKEC9wCQ8swK6vZ7pamEXy9Cv3v/z3yxhF34I+
         yJli6EJ+o2JDeABeuiQzYxDJ6JQ4nmRpYHBVGxtdiXh9A/SMYeDkBPBG8Dezq1mZ+vZr
         k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711319; x=1702316119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LzfPXnoh+csBX7vLMU59nOns526pWVt603zQVilgL4=;
        b=DFAEhpK5QpFNLqFi4v29cH6FXsLRSR1Jo4cTPIZ510pTOVM159NkEFq6Kay+j6Kbr0
         axWmi5Lh1Vcswzy3lWPjvSP51WER7MOK6GFOjIOC9IysXkLE6p5/Q2ru3dqJyFQUcUkv
         odDffhoAunRQIEHivpXRHjnTMddYbnCayqclHxSc6MadyEiM2FS/BxPwnKbnM+H9hsfh
         6LZH2o0lZhoqD8NJUl1pk6k48fIWErnPmBi1PBBNe12kpY/oeCoztZkRcikA1a7iD/jG
         gYMJrUt/2RnsWWFBCIJHCTX7sOjyO8lQticu0KKQHQu2CsYPd2koNb3ppc0tr8vztbPB
         y9aw==
X-Gm-Message-State: AOJu0YyflhOo11lTfssfhNP3HCmb9Lx/S1QXQrU/x2P15IxVmdYhbNjU
        frQFVD/EjuENFTuCRTYq5BJ79w==
X-Google-Smtp-Source: AGHT+IGtOaPvxIOHnyH/580dDNDubjZltu2MPm85XIWMx0R7RIPtoorikJI9IsraRZQp8KMwdoeMMA==
X-Received: by 2002:a9d:6e0f:0:b0:6d9:aac1:228 with SMTP id e15-20020a9d6e0f000000b006d9aac10228mr767736otr.40.1701711319036;
        Mon, 04 Dec 2023 09:35:19 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:18 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] spi: axi-spi-engine: remove delay from CS assertion
Date:   Mon,  4 Dec 2023 11:33:34 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-8-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the AXI SPI Engine driver has support for the various CS delays
requested through struct spi_message, we don't need to add a separate
delay to the CS assertion instruction. Otherwise, we end up with longer
than requested delays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3798f96da586..78221715ba81 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -194,7 +194,7 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 	if (assert)
 		mask ^= BIT(spi_get_chipselect(spi, 0));
 
-	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(1, mask));
+	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
 
 /*

-- 
2.43.0

