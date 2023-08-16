Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385B77DE96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjHPKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbjHPKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:25:39 -0400
Received: from mx4.sionneau.net (mx4.sionneau.net [51.15.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61C19A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sionneau.net;
        s=selectormx4; t=1692181536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u3x517jXD17JEc1IgHDvl6xnCwSrZAX7MMReTifJSfw=;
        b=UVzGLarGqRkh17fKKZQH8qckmwDTrRwfa46nemDSBLdCY97gzVKw0udskfs3bQwy5/fxN5
        0JJiYwMo64MsvWrL/1e2KuxojSgkv8qUzULjcUaa+mGqamX+G5XtexE5cSToyecOcgP2Ip
        SWntxQAgrQQ6rhcI0XvSQ8rQIK3i0KU=
Received: from fallen-ThinkPad-X260.home (<unknown> [109.190.253.11])
        by mx4.sionneau.net (OpenSMTPD) with ESMTPSA id e3db66ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Aug 2023 10:25:36 +0000 (UTC)
From:   Yann Sionneau <yann@sionneau.net>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yann Sionneau <yann@sionneau.net>
Subject: [PATCH] bus: bt1-apb: Change from u32 to unsigned int for regmap_read() calls
Date:   Wed, 16 Aug 2023 12:25:30 +0200
Message-Id: <20230816102530.31605-1-yann@sionneau.net>
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
Also shuffle the variable declaration lines around to respect
reverse christmas tree order.

Signed-off-by: Yann Sionneau <yann@sionneau.net>
---
 drivers/bus/bt1-apb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index e97c1d1c7578..becc92572bea 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -92,7 +92,7 @@ static inline unsigned long bt1_apb_timeout_to_n_us(struct bt1_apb *apb,
 static irqreturn_t bt1_apb_isr(int irq, void *data)
 {
 	struct bt1_apb *apb = data;
-	u32 addr = 0;
+	unsigned int addr = 0;
 
 	regmap_read(apb->regs, APB_EHB_ADDR, &addr);
 
@@ -274,8 +274,8 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 {
 	struct bt1_apb *apb = dev_get_drvdata(dev);
 	unsigned long timeout;
+	unsigned int n;
 	int ret;
-	u32 n;
 
 	ret = regmap_read(apb->regs, APB_EHB_TIMEOUT, &n);
 	if (ret)

base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.34.1

