Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6F7F0DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjKTIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjKTIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855B10C2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084095722aso15794415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469998; x=1701074798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnubXRxqwunb9d9wAijOwoMF4ml5sMiS99lc6deFk3g=;
        b=kDjgvOwsGrktkE6c+4SJ7VsHqDJ5DFCbTuJwiiMqs/PQWj6VgIf2NTgz1Ma+IsMVdo
         qkIqBM95A7M3eSW+/NB4dfMErnpCwuK5OU3/cEUIQQk4blNSArVLAFA/0fyu2ky1O5hh
         RTVgN+x0nthlUWB5nkH+eB5JDaGCVBeVgV5GebEH15NWuxywUfrTpkcplCf+X+mKWpvG
         s16cV5JgkUkrw3qO1nr5fMNRkg1ILPzRyPzxzLLnYUz5JgOwLCOpIZZKmhALcSUG2AmJ
         acJV7Y42jlCY8Om8VsxoTZmSr4zHkIduE9W/hqABNxUZOFU0sr3vHvv1n9gLx0tiYO04
         P8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469998; x=1701074798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnubXRxqwunb9d9wAijOwoMF4ml5sMiS99lc6deFk3g=;
        b=tcJClvIp78YIh45umwHHyYRdtFgI4FMU1rWtRelMpgEoIe/AWVvvKXRHeGpY09hHOO
         B24hH2x2oLJfDtaHiauQIGN7HslxxDa7pVnr4OIQw3oSs68l9JaYHHQrp3/tfU186gaW
         1hj9+YSmDFIu0uC6kTyTtcnVtXRP0aNFxSKlPyMb5oYmhzguOr/8shZ8yXGjtdImvYaM
         5lzbDyxI8WQxfBRcwTEe5ObXu2F3pKt6bXnbwLh4O/o/ioo7stjl5/ca2gjVOOS8gnNk
         M1RzxevY4YTLGVPWgQC/tyQmcT6gouNXL5zpw2QCWk0wMzPL+1SqT8WKQNoYoaPK7zJ6
         IKnA==
X-Gm-Message-State: AOJu0YzPCaRi6IhzopKEsXA8h9FtoXy+5jAi4HxLTBrbJ7ljNgHjLnpX
        9sninAGAa3BwBlFLMSvFI6NFeg==
X-Google-Smtp-Source: AGHT+IEMct7WxOL7CEruxo5dhNLNWOxO//4tc7G+NL8rWLz5AtDQvNUkk8+27zWIFX2LTYBR/EnH+A==
X-Received: by 2002:a5d:64c6:0:b0:332:c527:66e8 with SMTP id f6-20020a5d64c6000000b00332c52766e8mr1784413wri.7.1700469998154;
        Mon, 20 Nov 2023 00:46:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:37 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 09/13] net: ravb: Make reset controller support mandatory
Date:   Mon, 20 Nov 2023 10:46:02 +0200
Message-Id: <20231120084606.4083194-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for ravb driver specifies that the
resets are mandatory. Based on this make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ddd8cd2c0f89..8874c48604c0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2627,7 +2627,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2

