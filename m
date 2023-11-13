Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9327E93B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjKMAwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKMAw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:52:29 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420991FE5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=EzZ1VatqfWxQhDUcF9TinY3eHHdZUFg/2GJwAA3DgHY=; b=lssJOr
        V5zSCoLdklIpXZWXwZ/QOafV4vonzgf+MLfzqzEiJwV+MN8DKruO5DHyq7R9Q5YF
        /8RDWLWV9MQvwqtG+xv2abqUKYH9StEFG6SWLMddiYnZZccoq72G2wx1ZB/ArU8r
        vX01/0oV0w3XppLRQG2A+W5n9mCNPkFzgvFuZbGlRkV8Gw7DMlhW5zhfF8LCD23P
        4n+MnufLWa7ZhqEejG707kTzST/8uoqZUqsG5tTlwt4ssUQSjzXHQTHR2iYp/Zzi
        eZBp64D6wPExVXdDTXQkncXf7Oj9lmxOsYxyiyA0G/Sv4aE6YXRIuRrJFV7dolxv
        RH69LKgxyneanKhg==
Received: (qmail 4084423 invoked from network); 13 Nov 2023 01:52:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2023 01:52:24 +0100
X-UD-Smtp-Session: l3s3148p1@3s43Ff4J88AMv8XD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] gnss: ubx: use new helper to remove open coded regulator handling
Date:   Sun, 12 Nov 2023 19:51:49 -0500
Message-Id: <20231113005152.10656-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v_bckp shall always be enabled as long as the device exists. We now have
a regulator helper for that, use it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gnss/ubx.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c951be202ca2..9b76b101ba5e 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -17,7 +17,6 @@
 #include "serial.h"
 
 struct ubx_data {
-	struct regulator *v_bckp;
 	struct regulator *vcc;
 };
 
@@ -87,30 +86,16 @@ static int ubx_probe(struct serdev_device *serdev)
 		goto err_free_gserial;
 	}
 
-	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
-	if (IS_ERR(data->v_bckp)) {
-		ret = PTR_ERR(data->v_bckp);
-		if (ret == -ENODEV)
-			data->v_bckp = NULL;
-		else
-			goto err_free_gserial;
-	}
-
-	if (data->v_bckp) {
-		ret = regulator_enable(data->v_bckp);
-		if (ret)
-			goto err_free_gserial;
-	}
+	ret = devm_regulator_get_enable_optional(&serdev->dev, "v-bckp");
+	if (ret < 0 && ret != -ENODEV)
+		goto err_free_gserial;
 
 	ret = gnss_serial_register(gserial);
 	if (ret)
-		goto err_disable_v_bckp;
+		goto err_free_gserial;
 
 	return 0;
 
-err_disable_v_bckp:
-	if (data->v_bckp)
-		regulator_disable(data->v_bckp);
 err_free_gserial:
 	gnss_serial_free(gserial);
 
@@ -120,11 +105,8 @@ static int ubx_probe(struct serdev_device *serdev)
 static void ubx_remove(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
-	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
 
 	gnss_serial_deregister(gserial);
-	if (data->v_bckp)
-		regulator_disable(data->v_bckp);
 	gnss_serial_free(gserial);
 }
 
-- 
2.35.1

