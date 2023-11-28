Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422BD7FB397
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjK1IFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbjK1IEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:04:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b399a6529so21770705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158689; x=1701763489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UUIFtQDzSDtAn0+xL/a4rToHREO/z6KIZ1fp0e9QBw=;
        b=NTru99EYPWeI2IZS/ZDXNx/2q9s804lRjP4j4Kgs3Bj9vAiCsUpHBQhvORI30Xg+F/
         nlpuAp8hrQb3tncaeBk8Xf6FIBlipXk0hoFAywPHFlEVZvh600BeBxoO0/Pp2XWIvAHK
         r2hw0yBpBcf3dubMAOqG1p2h2wcR8RV5fnSvcBP/vGp2Hfuq55Yq8+I1D+a5rusT9qCJ
         XdF/ti3gINrjlH+OJoEw7sNR7NgFL2d5oPIMm2jxZMaR/zB98G0u2w3Vm2IAtZrzB//S
         IdvtiSnp1J9qJV2B6NOf0IhajygZT/dq4GdIV4k6+B1gJ/BxNg+k8JWQNPV1QTK2WzeT
         AHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158689; x=1701763489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UUIFtQDzSDtAn0+xL/a4rToHREO/z6KIZ1fp0e9QBw=;
        b=pSlf9VfZOvG+kEPRBwuhnZGywy0DZrA5VF4SPE0dJ6owyyW4BJrKRGX+6x9UiNd6Tc
         HXKBACQiTzilYN41h2XX1cfDiV7v3MVrEFBmeJu2kSoUrSrar9kEvVgG23v+G20N39lM
         FRlXLIOmMqa0N2+iQz28g6Eilitp+usitKAEU7fayoGluTD81IbkjVvvvNuUxR+X2mYv
         Sz6S6sddsUEG7MUF475X7oxHUhddKmV0lvWj60cPdIAyFLTsgRYHDpJOqH/Fu0DAGnMq
         7Db/d2FJr5+fOc2YL3coMFwXJ1BuevT7UgqBQOiYcpHpqhVzjmN25vWT/rwfE6NcXsxX
         ZRaw==
X-Gm-Message-State: AOJu0YzfkeIMB8aeVLrgfx123zfwdyOHZ2prBBeZ78zwd5tGwtRoM00s
        cV03DxqbzLz2rL7+YC3Xn2LYMJwU134JIXP/TSM=
X-Google-Smtp-Source: AGHT+IEObelGQNl9tI+LG1sQsyG2i2yFcxb2Q6riQzEbIjU+MG5AYRIubmmNG6CsXxUcxblwvRfk8w==
X-Received: by 2002:a05:600c:35c7:b0:40b:3322:2af6 with SMTP id r7-20020a05600c35c700b0040b33222af6mr12528814wmq.5.1701158689281;
        Tue, 28 Nov 2023 00:04:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:48 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        renesas@sang-engineering.com, robh@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] net: ravb: Stop DMA in case of failures on ravb_open()
Date:   Tue, 28 Nov 2023 10:04:38 +0200
Message-Id: <20231128080439.852467-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
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

In case ravb_phy_start() returns with error the settings applied in
ravb_dmac_init() are not reverted (e.g. config mode). For this call
ravb_stop_dma() on failure path of ravb_open().

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

Changes since [1]:
- s/ravb_dma_init/ravb_dmac_init in commit description
- collected Rb tag

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2ef46c71f2bb..2396fab3f608 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1825,6 +1825,7 @@ static int ravb_open(struct net_device *ndev)
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
+	ravb_stop_dma(ndev);
 out_free_irq_mgmta:
 	if (!info->multi_irqs)
 		goto out_free_irq;
-- 
2.39.2

