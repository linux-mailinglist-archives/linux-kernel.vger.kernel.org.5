Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F276D1BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjHBPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjHBPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC37729C;
        Wed,  2 Aug 2023 08:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A2361A10;
        Wed,  2 Aug 2023 15:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD5C433C8;
        Wed,  2 Aug 2023 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989452;
        bh=7g0cOtIPkTfpyTVkaC+imOD6lb85coVQ5pyYai7ah8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+GTk+ZiTqrD50iO1u+Je+SWZGXJ8Ykl+Kd2uDp2GWXfLqyxNMBGGoKLq47yWby6/
         Grucz//CFkdABFja9oavh7p0hIl+v8DkAzPsThD7LrkPk/4MWmVJxVSsE9wzX8/FZJ
         CstVqxfxeHocIXHyfPrUsn3nZ4t0JO8dtNmEldKeMb0nhMfFkO7N/pGEpgFGV7Atd6
         AhLtDUvem4RlppYeFSpP1CwRYzz93yhezO89tL4c6Pj0vV8hJVLLzYjsa5UcVLpArx
         hfynAGhFjQQfJcuEOqtYF6ZDPcgHYqa9M0ap3SEnoIwG/oU406YjcI80x5hWsAIbti
         YOH3EVR0d30gQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250_dw: fall back to poll if there's no interrupt
Date:   Wed,  2 Aug 2023 23:05:45 +0800
Message-Id: <20230802150545.3742-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802150545.3742-1-jszhang@kernel.org>
References: <20230802150545.3742-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's no irq(this can be due to various reasons, for example,
no irq from HW support, or we just want to use poll solution, and so
on), falling back to poll is still better than no support at all.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7db51781289e..39db768517eb 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -524,8 +524,12 @@ static int dw8250_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		if (irq != -ENXIO)
+			return irq;
+		/* no interrupt -> fall back to polling */
+		irq = 0;
+	}
 
 	spin_lock_init(&p->lock);
 	p->mapbase	= regs->start;
-- 
2.40.1

