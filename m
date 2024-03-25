Return-Path: <linux-kernel+bounces-117485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028C88ABE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EBA1C3EB62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BE13CFAC;
	Mon, 25 Mar 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IJhRTwMa"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3513D51C;
	Mon, 25 Mar 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384765; cv=none; b=lbjAmg4a4+LCr1oDoCRvMIKjSmAucxtjyPiOodajosj8/8LqqDrT9c5fzu7/xMv8X23QUQ0TeM/Q+rZP9h1r432e6fd5yWCrjFHUthqJMdoXTuzVYu8qtkZA6w4Spd+PNY4EOqPDhey7hT/HpzLy+7eL5xjJK9u5z0SftXR7CsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384765; c=relaxed/simple;
	bh=14gtqtCVNayAqIK5rueXTjgkgP8gMseCMqMHcCd2L6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpMaT86gojdAuYUPqr0D+xOHQ9OVCHJhRzpSlbt9T5zYTcwKpdgRBfUH28AQVCXVUfyitJoQR1Lh/0JVMPjHUa9dYZNpZuQeIybveBseBCRVD1IFfM1tam1PG1oRp4M7xV86wMxbxvp7PTrjHanSwrFu3TTAeI1RcxHff19LIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IJhRTwMa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C44512000A;
	Mon, 25 Mar 2024 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711384761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8iMLGnKdVyyeBqn6RGrsFcqXN0O2cTjmwyktnHMM9S4=;
	b=IJhRTwMaxBoudK2YoL02Ka+EhnIeHvQTaqyJnEHzsRO8t5qtDGwb3Zpr9s5WBEBtq+1m0y
	/5Skpb7f1VgtmdupzC+DfCj+FN0L2OYYHWIPMXaXS79c12hIqdkpX1dr77xDcwGd3yjXNH
	DfMy3xY6cFXP5nAvuoTimDOoGzB6/SYSz8TFIbt4S80dSkoY5AL1Rp7+sxd1aOpM9jKQkm
	ZGc86rXNQJ6jUmC06dER5ZnWpNn4DZ0QHcukwnS1nule5nlkizowmYh7MPx6t90bm5gR/S
	dxQHNTJsGLrc3MJfui7YYEd4dWKGmELp92Z6ggtnGaA1g6gYDbGcq/+A4p0sFQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 RESEND] driver core: Keep the supplier fwnode consistent with the device
Date: Mon, 25 Mar 2024 17:38:31 +0100
Message-ID: <20240325163831.203014-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

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
index b93f3c5716ae..0d335b0dc396 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2163,7 +2163,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
-- 
2.44.0


