Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727776E80E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjHCMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjHCMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:16:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1511C1716;
        Thu,  3 Aug 2023 05:16:23 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 996E7C67;
        Thu,  3 Aug 2023 14:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691064917;
        bh=FUF1g+cBUsdEqKfbNzez2Hokd0GxCCbEB2o0a2KNDys=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kHNnALG85T2UZ9jsxoPBGsCRJi8ddcr/Id9vLH7RjLzbukpEAryOpBqYfR6YF9fXO
         Undu76W6QJLqayq/vpNOAMFhF78Nep7yb9+U/CLZuWW5tCk0ODZbbIQffsicwZenem
         pHncreFTgP9wIKUIe5cJC/3yDlK7Qu6HiJUS+W1U=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 03 Aug 2023 15:15:45 +0300
Subject: [PATCH v2 1/3] media: i2c: ds90ub913: Fix use of uninitialized
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-ub9xx-uninit-vars-v2-1-512570ecb798@ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
In-Reply-To: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=FUF1g+cBUsdEqKfbNzez2Hokd0GxCCbEB2o0a2KNDys=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky5qSirgPH9zPThBDC93DQo5bx72emrcDGxbpv
 ac30JTkfx+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMuakgAKCRD6PaqMvJYe
 9RopEACtjE3K40xcWVdMWnD6/aLAj3cGmLF6yGhjC6N2i/GcuHm1WFBIT4zM76hgJdHt0eL/GF7
 0hGtPuKBgB11Q9nP5/H0VGZwZE7Q9d+lBOsYPogkQhhz/AUFBoBXrvJ0+Sc0XZH76pR8hHF/3QS
 nF5fOVIs86jL5vPzbrSgpqBEEm/abJTJNX4RHv/0aZbWsNZSLIiIqWIEWzEUkwlOOSC97pd2wSh
 JKXgnCwaeGpbcsFn26Vx5NTS3tSV2GA7XrnK7u/cUZNjp1LBtZfGGcyxAmT9OfLlHv4wXghRuVA
 hmHRRxe9nU94njr+L08gjP2c47k0YjZevaJPBqUGjp3ZS4mm6Pc9kLe5DR2fjiht2SyDofK8Elm
 TerHWe/07ft2/eAg0swQ7C3cRVnX/jr10w5K5wGGrfVQwVI6yhSo3abgIt76cKbA/ThKlv9pIgB
 aS0E5XIlVXfL+lFhwcfjvS7qitY5TuBVTNWuoMMGgkz9AEyo6mIeH698fa76RLz42ak6HUBgd3L
 5nz4FurbhtbB7lYzAJrbPGr7VW8PYE4x89aeBogxLq65YGsM2CpY4UdyUf5bpw9yEkpN5pbrsdq
 ffZkeGnOzw/XY0J4H1Qxc7UtGOmPoB7sB/7NopIkmcUp6QQS1qencSSyMPzy8X7xz3FsnMWr3iU
 y7BgeQ0Ihbqkq9g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports some uninitialized variables:

drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.

These are used only for printing debug information, and the use of an
uninitialized variable only happens if an i2c transaction has failed,
which will print an error. Thus, fix the errors just by initializing the
variables to 0.

Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub913.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 80d9cf6dd945..b2115e3519e2 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -469,7 +469,7 @@ static int ub913_log_status(struct v4l2_subdev *sd)
 {
 	struct ub913_data *priv = sd_to_ub913(sd);
 	struct device *dev = &priv->client->dev;
-	u8 v = 0, v1, v2;
+	u8 v = 0, v1 = 0, v2 = 0;
 
 	ub913_read(priv, UB913_REG_MODE_SEL, &v);
 	dev_info(dev, "MODE_SEL %#02x\n", v);

-- 
2.34.1

