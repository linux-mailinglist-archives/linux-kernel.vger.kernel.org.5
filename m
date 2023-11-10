Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7327E81B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjKJSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjKJSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:52 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB48852;
        Thu,  9 Nov 2023 23:56:10 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 0C9FEC0004;
        Fri, 10 Nov 2023 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699602968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=21zxqA6JvOISJe3ZnIEum9hlx3V56G+DUdHtSQWR7rs=;
        b=pQ/je16HBVbd/gOPr59KjOR7ROOIaIhTdMBkwKs3pXBk+z4UEUgknISSAGg8L5sf8C9vuE
        d+nobqWiH5Z+4s7NqxSevsfUxjuEARNQpFys1kpjyrMDfLQnFcNhIs1zccLYx80xGnT2Ik
        hrGtfcBfYBA1hf3Dnqq/KsWLY7MHmYRNGunwk6kABouSHj3cUe0KirI5PJDGHnwGIMjITV
        tXNg2xXHQNGzJBCF1Il0vAWEfhp306FiyC+nTMw8XqFERScYWcMYf0EFk+LnKdpLsQgE7B
        Ap9vHh72yAXAVKggWCt2DxQ/D1JTRceSa18oneVHpNc+2fTctiH3vE+aKtLjMQ==
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
Subject: [PATCH 1/1] driver core: Keep the supplier fwnode consistent with the device
Date:   Fri, 10 Nov 2023 08:55:49 +0100
Message-ID: <20231110075549.702374-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

Update the fwnode used to be consistent with the supplier device used.

Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..17f2568e0a79 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2076,6 +2076,18 @@ static int fw_devlink_create_devlink(struct device *con,
 		sup_dev = get_dev_from_fwnode(sup_handle);
 
 	if (sup_dev) {
+		/*
+		 * The supplier device may have changed and so, the supplier
+		 * fwnode maybe inconsistent.
+		 * Update the supplier fwnode
+		 */
+		sup_handle = sup_dev->fwnode;
+		if (!sup_handle) {
+			dev_dbg(con, "Not linking %s - fwnode NULL\n",
+				dev_name(sup_dev));
+			goto out;
+		}
+
 		/*
 		 * If it's one of those drivers that don't actually bind to
 		 * their device using driver core, then don't wait on this
-- 
2.41.0

