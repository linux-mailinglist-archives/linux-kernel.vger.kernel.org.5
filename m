Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F875AC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGTKcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGTKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015910FC;
        Thu, 20 Jul 2023 03:31:44 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F1DD373D;
        Thu, 20 Jul 2023 12:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849046;
        bh=bS5i5doTbSucq0ar42mZOd1EPRTamwE8j3ah3qy/e4s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=wUd28V0pe4O9hotnFlHCiz8pzFKU6I0ugnmryeXgX29mhIi+EDjjtTfbMv5YuCOTO
         rk3Yf9Fm7Y35rHcJZEGtbIzFl2glcuRF9A86x1mdrknhUsq3JJYfMEqJZa6YRtpn0d
         CoOVA2qIANLZ3XAGHzBqq/L2fRxNa1RuRV0fU+so=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:36 +0300
Subject: [PATCH v2 5/8] media: i2c: ds90ub960: Allow FPD-Link async mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-5-b91b1eca2ad3@ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bS5i5doTbSucq0ar42mZOd1EPRTamwE8j3ah3qy/e4s=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0GYZsPUbzsSK2JECdTPkcdIHBDIEvrJu359
 Mm270T0WJOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBgAKCRD6PaqMvJYe
 9QnJD/4s8UeNqGmWQPr9OW3S/znmoLR5DpkmyTgwNiUNCqKqM3a/6v52+j0Muf+J67a80e6Dkhq
 ybnCQ8k6Uy+YWBGOYy0cAjRYBoKazSyzlfASNhduK6EWjDWsbLF7hhuKtloVGUjsLrTAGIL3Gso
 OMWS+vKPSo8DFiHAvi4Hxaljlt5bfDl3+M3X3/VvyVNdHeO5d6//NH3j6fcVIIg9Man94zq9uGa
 /oFJoeiDTXc1RAyC9PqD5lQ8kOD38E9H6WcvuXv/sbAvBr3CEMZesA1N01vsRGxej3b98hQSKDz
 dHNwyUPyhyCp8gtI6hCvTiDFnwLqQJXYAkS24Ui1aDEkV4meIL1qHWt2nec+Ay9use1A3PvFPy/
 Bh0gMywGhqRp+8sgMF7K2/wC75nZRfOpt10GlXBhGcXpTmXwH9GA3Jhzu7z32SHPVfK0aMM02Gq
 qTMXKabRHskOnN3HUNGmyAfoN4a8J7a32oIzLihMLWE83w10lmjQbFDe2hPhaezsCQM0S52PlNH
 6p4s03CJlxFNg6C6cdWuKpMEL9099sFca4TMHeZveldqIMT6reV7sgQF/HuV2WEOqjLAHBJKjVp
 WdGMfmFrRzk6nSUxXqB6BiDl/XTmgPWr9xOgSHO6kgcKpIrjazB0PRGOh4OdSlho0pmKHhoXR61
 sTS0DtF6TenI4PQ==
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

Allow using FPD-Link in async mode. The driver handles it correctly, but
the mode was blocked at probe time as there wasn't HW to test this with.
Now the mode has been tested, and it works.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub960.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index a83091f47140..ea819fb6e99b 100644
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

