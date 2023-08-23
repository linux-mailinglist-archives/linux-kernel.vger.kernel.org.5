Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3578549E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjHWJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjHWJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54411F;
        Wed, 23 Aug 2023 02:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE9265E41;
        Wed, 23 Aug 2023 09:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D6EFC433C8;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692784058;
        bh=CUB+u6bVCnkeuFktM5zQ93AxsKZq6KM0HrW/RWf5h5E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Sn9hcYf2m+u8sS5L4KsABJsUeCIA2r4WDsh3+r3uYeRRxINaqcc47iSep2j6GsyG2
         PSOEPSWWNP9slVJAtwTH7AsZ/Z9C26RC9ljN9le4XGE0VpmuJEikQNjiSFuCETgDRC
         ur0Ct08XF2gwW6i/NC3A2897dRibjHnAYzTlNSiA8Odt4lUineFl8gSrKe6HGsii1j
         xqIPhY01/lML8JDeCtYQEdXwRVvyF77u5W9ByYQJI6Pex/rlo22F10gBKaTzk/v3QG
         6vlcceaGecuRZohcKahhnWdjSbnNeGqPhEwGgWSm2/TfcvUht8qfGq/jDMNa6PHlO5
         +ppa7yUUnwiPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2EEE49B4;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 23 Aug 2023 12:47:27 +0300
Subject: [PATCH 1/2] ata: pata_ep93xx: fix error return code in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
In-Reply-To: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692784059; l=900;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=jYEaemYd1aErVDz1ZLCTtX58S5YLSNWId6yDIFw7HVw=; =?utf-8?q?b=3DiV4woMczzqwW?=
 =?utf-8?q?fAyaeeBpmYNnvFmAVzLgmavJtQvOa677LWj7OjdgnBPGOjXOyvkq1IvHu2gJVkwf?=
 NhAV/ZimBI22z6M/kXCSrq4TsrBRgHlpdUKT5w+AmYCLfN+B2KFO
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Return -ENOMEM from ep93xx_pata_probe() if devm_kzalloc() or
ata_host_alloc() fails.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/ata/pata_ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c6e043e05d43..4ce0f37c7a89 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -939,7 +939,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
-		err = -ENXIO;
+		err = -ENOMEM;
 		goto err_rel_gpio;
 	}
 
@@ -952,7 +952,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
-		err = -ENXIO;
+		err = -ENOMEM;
 		goto err_rel_dma;
 	}
 

-- 
2.39.2

