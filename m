Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48A7F9C50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjK0JFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjK0JEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794D1BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so5234813a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701075888; x=1701680688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlwN1qAsHWca5scAvNLuwE5lxsRTiu67SGgg4R0r8Q0=;
        b=mK2+XRTfjLkVysJyfdFGzgvus2pb0IBOCv6sWeT19Po0xmWmXeF1fnURbwfgrXTZoh
         mXUzckH4CPLdA0SPT3d33BmXpCTqPx9tEeE4V3hKbwncMAmSCzd5N7dackSvibWFhtBU
         777w/QINmqmeNPb0gMNzogDgRQjo3sxsyO0t8jic6+uJquqkoiy+eYw5MkEC/V3NO0fE
         S1PFx7PVKkA9FRhyof+DNq38cie0OWM1J7Iej1lxVWIBephtRBsUJebF+99rBkzDtCMh
         X8O/Nlib/4jFfj18+lHStyX2BDPEF14M6Zqaxh1LvA/8Icm2yUR0d+EFLahRGIidh9EF
         B/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075888; x=1701680688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlwN1qAsHWca5scAvNLuwE5lxsRTiu67SGgg4R0r8Q0=;
        b=TDBMNYckULDttP8g6Um0e8EnWS41DyF7X0h/TjCWO6n6KdeMu8FpulkKHv1AGQBoyx
         YVzJEaHjS8PqeCTBeAOZaYIKblM5WQS3qR/1kRy5ixCiJa8ZllpdRGVwSRD2PkwKQTbO
         bul+slCm1RWZ3ax4bqi9hqSviyY5i4c/gSDTqqPC9c80fg0tKCFSWR6qK+/CXap5DXxO
         OOvQV3stVh6x2rTnorne4k+Wx6zfy5bvJLb5v717kd0EXG06nzCx5vjDKSqQBzdBroKH
         dcR/kG2hfM6COheWZLZgmgW+4urX6WO3lvRn7clxbBc5TkqVmEIyWMcSDLrrnt2au26m
         K8ag==
X-Gm-Message-State: AOJu0YyM1fd0/DK96RD+8ONYyGVXILj0tDmlycftPoDdzowPJL2nIPcw
        Tdp5QiB0FCPgJc6Ow4o1gotuaQ==
X-Google-Smtp-Source: AGHT+IHDt74vApXNuokupSF97i72AROOdDfRVSFnhGnDr0hpPadcCYRP9B7Fma+bCxtiohowOhGS1Q==
X-Received: by 2002:a17:906:5817:b0:a00:aa23:34d0 with SMTP id m23-20020a170906581700b00a00aa2334d0mr7398772ejq.68.1701075888425;
        Mon, 27 Nov 2023 01:04:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm5456539ejb.153.2023.11.27.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:48 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        robh@kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5/6] net: ravb: Stop DMA in case of failures on ravb_open()
Date:   Mon, 27 Nov 2023 11:04:25 +0200
Message-Id: <20231127090426.3761729-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes since [1]:
- s/ravb_dma_init/ravb_dmac_init in commit description
- collected Rb tag

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f7e62e6c9df9..805720166ef3 100644
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

