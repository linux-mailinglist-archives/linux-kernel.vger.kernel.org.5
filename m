Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951747EAB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjKNHq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:46:57 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740401A3;
        Mon, 13 Nov 2023 23:46:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id B9A7824000A;
        Tue, 14 Nov 2023 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699948013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WSqWkMKT4hlIo0Hft0JXkPwNJp2PZekuBZnXLftRgw4=;
        b=OuRD1zr1JHlFhd/s9EKNWu1YgcODmlldoi8th8WmxXzC253V98Yxh3AguSHjJruVVZYzny
        Nvdyl+hxOQtnqcjJnXIV79evSLByXrnpHRnD1kQPLBI/wSaiG55j1VNODZ9xaTwhqjZg8a
        BgZmDSVD71zK/zPt+xfBd9XFOBtZeNXgtm/t2iVfvKbp9OgdHuPWcI13pXTY4d0ShrBYMM
        b6LpCKb/Pi1DCVeYpCMZ7eDor0HMEib3tSFOCQSJagJ25amfJuXfZG9ygOO/jiCkWkls98
        4J2JYU9A1TApE9/imXNWDu1Hjvy9eTxDBooyLIG9ei6syummlWk0q7lzkeRurA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/1] driver core: Keep the supplier fwnode consistent with the device
Date:   Tue, 14 Nov 2023 08:46:32 +0100
Message-ID: <20231114074632.192858-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
fwnode's consumer links") introduces the possibility to use the
supplier's parent device instead of the supplier itself.
In that case the supplier fwnode used is not updated and is no more
consistent with the supplier device used.

Use the fwnode consistent with the supplier device when checking flags.

Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v2 -> v3:
  Do not update the supplier handle in order to keep the original handle
  for debug traces.

Changes v1 -> v2:
  Remove sup_handle check and related pr_debug() call as sup_handle cannot be
  invalid if sup_dev is valid.

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..440b52ec027f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2082,7 +2082,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
-- 
2.41.0

