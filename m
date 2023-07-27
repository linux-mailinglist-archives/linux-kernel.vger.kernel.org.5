Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE20C76597C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjG0REh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjG0REf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:04:35 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75ED52D75
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sbcgdPd7//5eQ2jdrq
        nCNHQO+6z0ts+727955oICVbA=; b=ffE4gZ1mCC8ezIx91G59KavYQcd9/fejqp
        LLXv7V71YIKTYrraooyMUheXmLU5OVNpCUYZvTm8cBc4srp2vg8PCLUpK/hwGCTH
        KT0voO/8hh7PdktVxHq/hpvgWYdev9SMwZ3FhnnEsuV+tCf2rvRFFD46AxFDb25p
        5ebg/x0mw=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wAXXCF+o8JkAvnRBQ--.3132S4;
        Fri, 28 Jul 2023 01:04:06 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] gpu: drm: aspeed: fix value check in aspeed_gfx_load()
Date:   Fri, 28 Jul 2023 01:03:42 +0800
Message-Id: <20230727170342.18506-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAXXCF+o8JkAvnRBQ--.3132S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFWfKw4UArb_yoWDCFgE9r
        WxursxXFsrurWDGa45Zws3Jr92kF97uFWxWF18t34YyFy7ZryDXrWUWa4DZ343Ja1IyF98
        tF1UZw43CFnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNdgAUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQe55WDESc5Q-gAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in aspeed_gfx_load(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index c8c7f8215155..3bfa39bc4f7e 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -199,7 +199,11 @@ static int aspeed_gfx_load(struct drm_device *drm)
 			"missing or invalid clk device tree entry");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable clock\n");
+		return ret;
+	}
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);
-- 
2.17.1

