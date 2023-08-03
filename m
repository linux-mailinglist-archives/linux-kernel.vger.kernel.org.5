Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8289476E80C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjHCMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjHCMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:16:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B3B1;
        Thu,  3 Aug 2023 05:16:23 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5113ED4A;
        Thu,  3 Aug 2023 14:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691064917;
        bh=Vr87S8JB3GTlOm1impkDXZI+XrjWqCD9MJquwKbXKLc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TJKAY4NRrA5qtAxkCyK0XLonSqh7V81KFI8rmQmyy5ezMTNCVm5DJNYjM/7hSlePu
         zlxCAnmucZZCahVxgsSoPg90ccEVG68dvkBEg7rRoX9ayH9SDp0CoPJ4y66LnN8rFK
         OA5HoDLnZ6JtwaPimi9SlaRPl4QzmN31ktRM5pGQ=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 03 Aug 2023 15:15:46 +0300
Subject: [PATCH v2 2/3] media: i2c: ds90ub953: Fix use of uninitialized
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-ub9xx-uninit-vars-v2-2-512570ecb798@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Vr87S8JB3GTlOm1impkDXZI+XrjWqCD9MJquwKbXKLc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky5qTSyBs2s9Dctr6+/nKcJU5IQoL5DB0EJmC0
 xXjV9NpT3WJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMuakwAKCRD6PaqMvJYe
 9ZSWD/9Lrr6SSSG7H8TH6Sw1fcd4/h1X4OmH+sSAXf1uOJW9TIqixpJl5LL1bj/4OkY423QQU8f
 kB9aQDc2c8CTRaKjlbF8S9QQ0rgMgYAOwz3Ii6laafVPDUjHYgrgV99JMdoORxWczxVrEO5zM9V
 YYdPUDAPlizw+PJXlUZguTwBaaZfzD6YcMVWU9GR9tGThr253Klte5LJYOIkNO4zIhuPouAEybH
 2KhBbLC4hfHujSOivsUBBH0ot/kjySgbOKlE3D/B772YVQle9WYHMahyIhvh/tWg1uf74eoWv10
 hwRYPgea1djdRSMvJEIejUOv4KFwEI+9bpbBErf/g2EJAx14boDbyUuokGIEXPp9Hu602AGwuUm
 J02npHgFiLqkgZtkRDvy1IHqQN7F3XLaV2/sJ+vwOd3x+l3He8Dxy8GSI0ITaSP/r95QvB623NW
 P9rlY4SNjEvRkblENntRdgAb7L5zemNL+UKj1BQ3kUkcMgRiUbU9uNA52cGzXGmb2rGLFZRXN6x
 mDOMO/YS5WftUYJ4egA0gkUGdmCV1R31mbvdh17eE7cfiNmeW2H+F2QLnbE5xfNjzGL+yJtsIK/
 B4exbEtj6tTjuGowXL0HAIV2dsFs6/SblC7QBD4ZD6InF07vBcPqo2eRCSSARntalLayvJAZIgS
 yx/8HxXQNYRsGaA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports some uninitialized variables:

drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.

These are used only for printing debug information, and the use of an
uninitialized variable only happens if an i2c transaction has failed,
which will print an error. Thus, fix the errors just by initializing the
variables to 0.

Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub953.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index cadf75eb0773..27471249a62a 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -593,9 +593,9 @@ static int ub953_log_status(struct v4l2_subdev *sd)
 	u8 v = 0, v1 = 0, v2 = 0;
 	unsigned int i;
 	char id[UB953_REG_FPD3_RX_ID_LEN];
-	u8 gpio_local_data;
-	u8 gpio_input_ctrl;
-	u8 gpio_pin_sts;
+	u8 gpio_local_data = 0;
+	u8 gpio_input_ctrl = 0;
+	u8 gpio_pin_sts = 0;
 
 	for (i = 0; i < sizeof(id); i++)
 		ub953_read(priv, UB953_REG_FPD3_RX_ID(i), &id[i]);

-- 
2.34.1

