Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E16765977
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjG0RDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG0RDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:03:51 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2E6C2D4B;
        Thu, 27 Jul 2023 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=vgyp+xm3eViuAvTy14
        qqI/Yrv8JsrnJvRDQENmS56Os=; b=GsSUtodMkjXciWPwpP4UPsh19VZpfD5ZNY
        zYY5ysDgHDYT7uVl5+xDXAan/kHDPIWuYqULXVbSZO2LVC4+MOcMSmnDM4f+Tl7m
        GukOovOr3WdvANUy+XTrMJpGk0hYkX2iaO5VdHP6reU4S/aOKTjgb8Iv9MmH+XNx
        XecFlooM8=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wAnHKVYo8Jk7dXYBQ--.57110S4;
        Fri, 28 Jul 2023 01:03:32 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Helge Deller <deller@gmx.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lisa Du <cldu@marvell.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] fbdev: mmp: fix value check in mmphw_probe()
Date:   Fri, 28 Jul 2023 01:03:18 +0800
Message-Id: <20230727170318.18412-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAnHKVYo8Jk7dXYBQ--.57110S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFW7uF45Jrb_yoWfurbEka
        y3Zr93Wr9avr4kKrnYywsrArZakFW8XF12gFs7K34FyFy7GFySqr40van8u3yUCryDtFyk
        tF1DXw47ZF1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNHq2JUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJwW55V5vE8WMUQAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in mmphw_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: d63028c38905 ("video: mmp display controller support")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 51fbf02a0343..76b50b6c98ad 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -519,7 +519,9 @@ static int mmphw_probe(struct platform_device *pdev)
 			      "unable to get clk %s\n", mi->clk_name);
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);
-- 
2.17.1

