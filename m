Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD579E217
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbjIMI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjIMI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:29:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38DE10E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fe2470d81so1896919b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694593775; x=1695198575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVZVDk0nVt9xPkuQ7kA0rk+skb+IlHVfGj8ZHv+S3fY=;
        b=jKa3B/dHMq6nA0fizblnER5n4wbGN2DVUwzxpgOii3l3AF7Q6J015p2ZF8kubTr+U6
         QF6h7CGGfm3SmBCfTl5/V4j+CtF0fVlqbOhGUQTd9O+C45qQmyyXbAoQKAXLZXpIsmgm
         SAqcjJdH7RGhv5QoLHgUL9Ss8ytBHCDoSf9l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593775; x=1695198575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVZVDk0nVt9xPkuQ7kA0rk+skb+IlHVfGj8ZHv+S3fY=;
        b=ohYm1+9gHv2akA74LyqhCKipf9ExO9lcVz+Oe3y5wxbLIUQ9nrWL5n7CWvhW+OVRTT
         qNZ+PNgWaQKYE4ikrkbW2aakgyWUr0cbIv4CbzL5++YZ2k2RfGRPf4tPRJwX7cUjZwLo
         VsflEa2irhHiKB2DiZDjANYHta/tlbZSw/gUzMKdFLAIOWJFiBwJ4sJVzCa209eq1TKx
         W3amqqXSl0QEQX9hV/s++HUpzQO+JpqV+SUvCpXRSbsxFTNw5Ygu7nYzqEL/iLQf9XqC
         iFdS675pTZDc8ZNqkZ4PTVm4Nr23IrO6/D3EQ7kvjdjaEADeYVJTIiDO5EEv7lz6q+Ds
         +OUQ==
X-Gm-Message-State: AOJu0YzpWuXzUrLaXqAEe8S3YJa8hxWklRspkDCr2X6VdiOaXHanLGIV
        BbhKQCnHZrudvEDJVmitTDDStA==
X-Google-Smtp-Source: AGHT+IEF2Cbs43/GwH2qUvBaNCgggY8+SfaBpnPQY9+z0cUqRzQ1FP5ckChyMhczwlBC41km5t3GYA==
X-Received: by 2002:a05:6a20:2444:b0:134:30a8:9df5 with SMTP id t4-20020a056a20244400b0013430a89df5mr2039361pzc.43.1694593775198;
        Wed, 13 Sep 2023 01:29:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b24c:3be4:d952:d3b1])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b006901bd3a9e4sm418781pfo.104.2023.09.13.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:29:34 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/3] regulator: mt6358: Fail probe on unknown chip ID
Date:   Wed, 13 Sep 2023 16:29:16 +0800
Message-ID: <20230913082919.1631287-2-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230913082919.1631287-1-wenst@chromium.org>
References: <20230913082919.1631287-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6358 and MT6366 PMICs, and likely many others from MediaTek, have
a chip ID register, making the chip semi-discoverable.

The driver currently supports two PMICs and expects to be probed on one
or the other. It does not account for incorrect mfd driver entries or
device trees. While these should not happen, if they do, it could be
catastrophic for the device. The driver should be sure the hardware is
what it expects.

Make the driver fail to probe if the chip ID presented is not a known
one.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f0e3c6261af1 ("regulator: mt6366: Add support for MT6366 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6358-regulator.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 120c60d40ed4..935c7ad56c7e 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -682,12 +682,18 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 	const struct mt6358_regulator_info *mt6358_info;
 	int i, max_regulator, ret;
 
-	if (mt6397->chip_id == MT6366_CHIP_ID) {
-		max_regulator = MT6366_MAX_REGULATOR;
-		mt6358_info = mt6366_regulators;
-	} else {
+	switch (mt6397->chip_id) {
+	case MT6358_CHIP_ID:
 		max_regulator = MT6358_MAX_REGULATOR;
 		mt6358_info = mt6358_regulators;
+		break;
+	case MT6366_CHIP_ID:
+		max_regulator = MT6366_MAX_REGULATOR;
+		mt6358_info = mt6366_regulators;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported chip ID: %d\n", mt6397->chip_id);
+		return -EINVAL;
 	}
 
 	ret = mt6358_sync_vcn33_setting(&pdev->dev);
-- 
2.42.0.283.g2d96d420d3-goog

