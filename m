Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5A812EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444003AbjLNLfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443988AbjLNLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:35:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19B116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:35:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a22f2a28c16so314487966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702553721; x=1703158521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKjeAY34llcGOWUq2lKYylvmKvhjwRpxdh2PzgtUzQM=;
        b=XlBkhy2XpWw9PEY6gUXcvcKOS9DJWtbpAMhBhU++2Y0Vter51xEydZEZwK/AMP09sj
         VdHjisE8wFD3q/UbyArxhR9/QojwJju5Q+hHj+g7SlUBiFUhUOb5c0tGFEyrXlN3hb5O
         n3iIeGWN/7VoDIk0E4hCqNO0AlT9LrEs7j+ILM31SqRYsx2ltVkFPdQbzX3SxFlFssXQ
         h0hfUGo8n5Y9N/xGcd1XZp3HFvE7QVHftcjiLF4f5muXccPWBqpO1IBn34r3DwjTehNE
         0a2dR8kxCN79/e0LzF5PWtKoCHH3hb/TlErmqGLj13aRDcvASBG9Mtbu92xupkYvxIe5
         U4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553721; x=1703158521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKjeAY34llcGOWUq2lKYylvmKvhjwRpxdh2PzgtUzQM=;
        b=T2Fuu/CxOqQj3xi6OFSh/sCh+xfuzMN8RXCY7TNlGeFC1+zsgXtvrfNyQn2ku1xF1M
         u6MCcwRbAXUKn5mPSL+oPQ1JH9hZ+RuZNB3TA1C7+uI0BhH4E1RI1bv5LdRRyNe9SxrT
         Tj+drUTWJ+P2ox9YXPwcB4woKKdJn/GNfejmXH/c5b0lwrBaTN4KhYsaGdak5nGHyFaR
         sfoAjousQyyzzAdLD18yEEoeLslTk92a4l/4/ed3AOqNSUnHWHJDjIZdGKEASxinuuxH
         OoZvtDPOrMyVQxmw5xWSG5diGnUqG92U9owipZkpRq+0ZT1KNpYBWNIushwsxfQ9Wa6w
         4Zdg==
X-Gm-Message-State: AOJu0Yz+xk8EABtue2uMaOGDCqVlGFzPIHAWBPYGAiSjxWVm838DpbgA
        4lrlbHH9dG89AHNpw1csklXWgQ==
X-Google-Smtp-Source: AGHT+IHVKCNMY9YBEDCrCTyqOqL3DNWn2qqH3wXx2mquhgdz/j50tlo3i1QCOR6Gnh2H4SupB1aloA==
X-Received: by 2002:a17:907:2da1:b0:a0d:39c6:1f67 with SMTP id gt33-20020a1709072da100b00a0d39c61f67mr3996296ejc.76.1702553721371;
        Thu, 14 Dec 2023 03:35:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00a1ddb5a2f7esm9290656ejc.60.2023.12.14.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:35:21 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com,
        niklas.soderlund+renesas@ragnatech.se, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: ravb: Check that GTI loading request is done
Date:   Thu, 14 Dec 2023 13:31:37 +0200
Message-Id: <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hardware manual specifies the following for GCCR.LTI bit:
0: Setting completed
1: When written: Issue a configuration request.
When read: Completion of settings is pending

Thus, check the completion status when setting 1 to GCCR.LTI.

Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ce95eb5af354..1c253403a297 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2819,6 +2819,10 @@ static int ravb_probe(struct platform_device *pdev)
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+		/* Check completion status. */
+		error = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
+		if (error)
+			goto out_disable_refclk;
 	}
 
 	if (info->internal_delay) {
@@ -3041,6 +3045,10 @@ static int __maybe_unused ravb_resume(struct device *dev)
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+		/* Check completion status. */
+		ret = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
+		if (ret)
+			return ret;
 	}
 
 	if (info->internal_delay)
-- 
2.39.2

