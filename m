Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D887A16E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjIOHGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjIOHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:06:46 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 00:06:39 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31585E6;
        Fri, 15 Sep 2023 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=REgnb
        YsNP87q+IDgfamZH5y9dcDqs2/HXwkY1MoJems=; b=c2/w8N/2crOMnfY8K9kei
        Ie3VTwaALPEQtdPmiQWNI12Zs358PaAcD9/Gpe7wrWtkKxxFil8G2k5E6NMDZDZ+
        EfDNpASERckjbsALx2FHo4v+YT2CWzfwnPC+sdLXaI2EyqTZImhCgyoFtW1jZ9E4
        zTy8UWDK2/DXFcdIPfOeLM=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wCHjlLF_gNlQF1GAQ--.58113S4;
        Fri, 15 Sep 2023 14:50:56 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] media: verisilicon: fix use after free bug in hantro_remove due to race condition
Date:   Fri, 15 Sep 2023 14:50:43 +0800
Message-Id: <20230915065043.3401840-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHjlLF_gNlQF1GAQ--.58113S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF17Zr48Kr48GFWkCF1DGFg_yoWDAFX_ur
        97WF1xWryqkFn5t3Z8trsa9ryIvFs0kFs5WF1ftr1UZa4DX3WrXFsFvrZFv34UWay7uF9x
        Cr45GFWakFnxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMo7KDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyBHrC1p7Lwsm3gAAsE
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hantro_probe, vpu->watchdog_work is bound with hantro_watchdog function. In
hantro_end_prepare_run, it will started by schedule_delayed_work. If there is an
unfinished work in hantro_remove, there may be a race condition and trigger UAF
bug.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 423fc85d79ee..1a5b3a85c520 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1187,6 +1187,7 @@ static void hantro_remove(struct platform_device *pdev)
 
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
+	cancel_delayed_work_sync(&vpu->watchdog_work);
 	media_device_unregister(&vpu->mdev);
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
-- 
2.37.2

