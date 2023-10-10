Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA52D7BFB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJJMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjJJMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:19:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90EBAF;
        Tue, 10 Oct 2023 05:19:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06E3366072E7;
        Tue, 10 Oct 2023 13:19:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696940384;
        bh=YFh6qAUpCGl4Tk3sMb7K34FQqqhAH7T1fXGALRzD3k0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZtH63OGKpty6eflEjW+Hc+DyiqtTtvDe+vaHEwIHH9UvKBXF2u9qRo1u7LVGPvm+4
         okBCkmXNPGkAylmlpTOjydnze7Cmncqoo6unKdlJk70vJt9BTiKP9weIGJagqXlBBU
         7QQjO5KhICVGQkRls9zJ/cx8pTmibuDPCm+GoQ7zBZ0NnnXNpa5SHocOnDMQSOxO3B
         x5kW8VF+I0jJxII5gEC2UqLHMHerhzI8RkGxsbb8+sagZwHgfdJMuuzhpSOoVSJtpL
         pSMavBFtR23l6Mxk5EyOfVT4JtAzCRQxg7aR/+eFEdTVRPsnuZ8+V40oKjF83C/irp
         CC/I9CVrEZhsQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, ruanjinjie@huawei.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH] iio: adc: mt6577_auxadc: Fix kernel panic on suspend
Date:   Tue, 10 Oct 2023 14:19:40 +0200
Message-ID: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
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

Commit a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
simplified the driver with devm hooks, but wrongly states that the
platform_set_drvdata(), platform_get_drvdata() are unused after the
simplification: the driver data is infact used in .suspend() and
.resume() PM callbacks, currently producing a kernel panic.

Reintroduce the call to platform_set_drvdata() in the probe function

Fixes: a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 370b84c2d0ba..3343b54e8e44 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -293,6 +293,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
 			      MT6577_AUXADC_PDN_EN, 0);
 	mdelay(MT6577_AUXADC_POWER_READY_MS);
+	platform_set_drvdata(pdev, indio_dev);
 
 	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
 	if (ret)
-- 
2.42.0

