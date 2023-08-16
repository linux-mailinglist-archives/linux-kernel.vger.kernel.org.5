Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5577DE60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjHPKSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbjHPKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:17:38 -0400
Received: from mx4.sionneau.net (mx4.sionneau.net [51.15.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E84198E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sionneau.net;
        s=selectormx4; t=1692181054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6M9tt3zpTWSYp9oRydSxYUo11ncDPEHNocW6qHm2Gzw=;
        b=GeGniOG6jIL7MQg0TsqD7uy7QJwhXDdsAssMt33SQ1aO+6HdqyuEwqdxM3CsUtqym8Q9bt
        5P6GA8ZqKLNGUyulRQf4h39hfVGbr6HKwEIR3MoJoehl0MBrK+TKaQ6b+kx3Av3NAZWnF3
        Wa6TKHdxpMGs2pQp5U8U5YwujSeXX1I=
Received: from fallen-ThinkPad-X260.home (<unknown> [109.190.253.11])
        by mx4.sionneau.net (OpenSMTPD) with ESMTPSA id 0417cac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Aug 2023 10:17:34 +0000 (UTC)
From:   Yann Sionneau <yann@sionneau.net>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yann Sionneau <yann@sionneau.net>
Subject: [PATCH] bus: bt1-axi: Change from u32 to unsigned int for regmap_read() calls
Date:   Wed, 16 Aug 2023 12:17:29 +0200
Message-Id: <20230816101729.30229-1-yann@sionneau.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_read() API signature expects the caller to send "unsigned int"
type to return back the read value.
Change the two calls to match the regmap_read() signature.

Signed-off-by: Yann Sionneau <yann@sionneau.net>
---
 drivers/bus/bt1-axi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 4007e7322cf2..80a76f26b4c3 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -58,7 +58,7 @@ struct bt1_axi {
 static irqreturn_t bt1_axi_isr(int irq, void *data)
 {
 	struct bt1_axi *axi = data;
-	u32 low = 0, high = 0;
+	unsigned int low = 0, high = 0;
 
 	regmap_read(axi->sys_regs, BT1_AXI_WERRL, &low);
 	regmap_read(axi->sys_regs, BT1_AXI_WERRH, &high);

base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.34.1

