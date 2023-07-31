Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977DB769784
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGaNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGaNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9761707;
        Mon, 31 Jul 2023 06:25:33 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35758162B;
        Mon, 31 Jul 2023 15:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809865;
        bh=f8au6qvF3OZVIkRVMXNUu/SB0ChQK+VTu7qLwWFxelY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SegS/ito9ajWM4AZfplWG/O0zEN0Kenuwr3Sr47NakELDS0bGtIdm3B7br5bdJUob
         TtXGiS4iHeQmyT6I3r8clAlxPWzmKwCySRtFmtn/oLOFURBgTd27v74ig93alBI1vz
         pPmWQ1AhKGke0psVS/GuVEwsk5XaGcUcAfqVmtPY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:40 +0300
Subject: [PATCH v3 6/9] media: i2c: ds90ub960: Allow FPD-Link async mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-6-8acfc49c215a@ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
In-Reply-To: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=974;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=f8au6qvF3OZVIkRVMXNUu/SB0ChQK+VTu7qLwWFxelY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y/UbxU7HJAcmhXe8b+jzuAoSAPcpVA31uKN
 HCUEuOVRGiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PwAKCRD6PaqMvJYe
 9b7cEAChEf3rWGXsVjID7hGB3eUqavFiFSC1AM873idJTFB9EyKYJ7EOq+iyxMIsGBRn4iOKZw6
 O8GKMUIqESsysR98OjpsI+R2M2gyvYPl1DoDSt+MYyrFUR6V/6un4OPT1lBocWRgkkj7tXYNlpn
 /Yo2/cLAzl/F0Xy2mij6lj+1mQdHiidEvSnlqfS6WBZTy4CpbflhMlGnOTyKbMwdet5NcNPSvM1
 coVwW3YsJAnbAJIzsIViFTgdjuvGXIQLMjm7oZmNY36lm7SrRk1019UkU/0dqaxGX37AwdPzUeP
 hHwfd3RIOqeD9hP01F6cC0zxKyDIi2XtPL2u7dcUX1DKPZ3DuewDhfH8JE7c3p/Du9GM4Mw09V2
 rPd4EiFckYZ7hkKrqilGPl+w/oCxozrr7sBmdEb6cEWk6c6NWolw+HADzG/NFNMo9N7FfuHBACH
 h/ZrTYooOhlzkkE+zHAFSBHEjyUwvgDgFJuSsDy6fNY7rYpY1ZLHNv5S/7tZU/LryEy0ADdwYsF
 X43f1+7NspgB9aVxKATrf/lJFgVv9RSh3tPLdK4m1Y9A6KL8MXLVVEhGn/sE+9mTZu9JPuUH28E
 jxznINddda4iipmL3RMGDqbRpdDKS4Drx4+Pl+15W5xDgQGi77VV8+g3NASX0e2vX3LGn66dfRo
 OPilql58g3+x5IA==
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

Allow using FPD-Link in async mode. The driver handles it correctly, but
the mode was blocked at probe time as there wasn't HW to test this with.
Now the mode has been tested, and it works.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ds90ub960.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index b840c9160bf2..c29db59e340b 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -3240,7 +3240,6 @@ ub960_parse_dt_rxport_link_properties(struct ub960_data *priv,
 	switch (rx_mode) {
 	case RXPORT_MODE_RAW12_HF:
 	case RXPORT_MODE_RAW12_LF:
-	case RXPORT_MODE_CSI2_ASYNC:
 		dev_err(dev, "rx%u: unsupported 'ti,rx-mode' %u\n", nport,
 			rx_mode);
 		return -EINVAL;

-- 
2.34.1

