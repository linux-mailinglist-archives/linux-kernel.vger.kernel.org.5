Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9277AAC9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHMTI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHMTIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:08:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDC1703
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:08:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so37268255e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953735; x=1692558535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5D0ERtpENLAoSBb0NpYZ2syoP+xoywzN9HcLRAsbn0=;
        b=scvdw0pSpfRGJCMg0BvhGqOR3OJpzgYLkmQCcCMF1now3MANkopiijpZwgiwxP4ab6
         voIIigZyiXR688hHh8eSPX3dSZ0ErOU8Bl8prTpMv+Sr5zuuguaDtSC8Gc3pNkScC/Ij
         zSucDVy1xOCma2Y1pYDarhI03AQ/1RVKP/SNLiGq/ZUhiKPJzXAnI2aw7kVMi3dyCndD
         gkSm0mIhWMHUrrKW5wNM7UiYyre7JoEGh+UkJ9DtJvoV4aWHmu/BFEM8VhA410Ylv0lt
         FKUPtJjFDwCRMAdE5eeyx2qiPAF8dDY9kp4tKxbABd0FCrLUsh65pQQaozFQwZcWo0xn
         bl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953735; x=1692558535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5D0ERtpENLAoSBb0NpYZ2syoP+xoywzN9HcLRAsbn0=;
        b=VDLudtq4rql2Q71eFEGquMSz1A7zOBKBe55BummnObUZeHXD0jITMBVtM3gCQCPIxU
         565YAO65qSSfZ/s8bxCNz9TlnMy2wLu7yT6k7j+XggTQAHsww5SnT+q4yv+D7F3A882b
         1Xsh0w/JUmGvno7hIR3pDqH7fuXcOAZ255yOfGNT4UOlYDiWxnSXeAMJuT2rP5n7mDZS
         gfwLZSkO0HU9VmW1UoMKOKnlmXVttjFMd4q9Tjrg6q0RyICjaYby/HgTapAkx1MDrUq7
         4WwCTYzch7oEmiHvGO1O+FH7fxJhx9vH7BiYONtyDteORkaOx18JJp/TC34uwzvr4gtN
         1v4g==
X-Gm-Message-State: AOJu0YyAVsNjBzsnEoHN5AgtrgI3mkoE9ABNxjRsSmuuNJh7J1NIVEbH
        HHKTEuk9TdmLaarz3HN+7YiWXQ==
X-Google-Smtp-Source: AGHT+IFKiWxS8QFsjAKe/GKVPaVjMJW81uuxW8E38kLmtsFjftnNcL+y86PpOY7I8APucHp50fc+xQ==
X-Received: by 2002:a1c:4c0e:0:b0:3fc:3f31:4233 with SMTP id z14-20020a1c4c0e000000b003fc3f314233mr6293550wmf.38.1691953735095;
        Sun, 13 Aug 2023 12:08:55 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.210])
        by smtp.gmail.com with ESMTPSA id c14-20020a05600c0ace00b003fe4548188bsm14919163wmr.48.2023.08.13.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:08:54 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, aouledameur@baylibre.com,
        daniel@makrotopia.org, void0red@hust.edu.cn,
        aboutphysycs@gmail.com, Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] thermal/drivers/mediatek: remove redundant dev_warn in probe
Date:   Sun, 13 Aug 2023 22:08:45 +0300
Message-ID: <20230813190845.49738-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to print any extra messages in the driver if
devm_thermal_add_hwmon_sysfs() fails.
If this function has any failures, they will already be printed.

While looking inside 'drivers/thermal/mediatek/auxadc_thermal.c', the
failure will be either be one of:
  'Failed to allocate device resource data'
or
  'Failed to add hwmon sysfs attributes'

Also, the failure will be reported on the 'dev' object passed to
'devm_thermal_add_hwmon_sysfs()', so it should be clear which device this
error belongs to.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index f59d36de20a0..55f7fde470e5 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1290,11 +1290,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(tzdev))
 		return PTR_ERR(tzdev);
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
-	if (ret)
-		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
-
-	return 0;
+	return devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
 }
 
 static struct platform_driver mtk_thermal_driver = {
-- 
2.41.0

