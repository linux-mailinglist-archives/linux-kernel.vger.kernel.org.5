Return-Path: <linux-kernel+bounces-72881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAD85BA08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5271C24791
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D467C71;
	Tue, 20 Feb 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RKYZaPEJ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E467C45;
	Tue, 20 Feb 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427461; cv=none; b=jZOee6QQzxXvjw9g4IByYkP0fZOagQIi83ddoHhwyhsWIJeUJxX7ljR/dny9LtAIUSDB2flUZoLr10mFdgcDH+zmvLjqcB8AAlkTP8XR+6vFtYsDkMPwTQYkK+G6ijCLyTZZ1lwhDS1AE8/zPs27XcN2rkytfdq4DClvL1Vwf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427461; c=relaxed/simple;
	bh=SORknAyK89FTpPMUYDIygldtRacLzHgxp/VDNZfKqJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq3pI8mV6JOKKi8JE4jnvuWrEAox7oCPbV2dIUHEqhaarbl665BPh1++dRzH06xNGBdky1Lzeno1su7g2H7xlJWZLvLA+WuXkf+/MBrTmpHb2syIMKyzK9VtcPEzluCQugaVxx+pViJ4sF7tnGlZfRMIPfxgUbui68JmEgk/g/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RKYZaPEJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4906C1BF209;
	Tue, 20 Feb 2024 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFeqAc0viLZubDduFEQRtTQhhOqlv7YIdJ9vqQOHsWs=;
	b=RKYZaPEJC+YwyWaq+Vd6q3jwz1J1O+djnucz/L2Nc/pCdc+LpnnqKGweCyYqqab0hxw/zo
	llSi0TCWhhLFGQUF7veRhkz1jHCHvkbEdeFIk6M2w8FDQnn45TApkJifS/7WcX729LnMM4
	RmQnIqzu+OARccUzXZasSo8HtO5/z5roV8ztrMgx1HneWTrD3kRc+8NJd9bABDhLwochuR
	+H3HG11tkb74Ei4sWNoxk+sxr0WeVyBecQim9ytbovIkEeYXqXwwjJdb8J85gmfnSo9YIF
	OoUGO+0QjNoKtbzy10C7CpDmQfPdQQWLk3zFktun/qPy2Ast6p9au2TwSEcEXw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when created from phandles
Date: Tue, 20 Feb 2024 12:10:37 +0100
Message-ID: <20240220111044.133776-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220111044.133776-1-herve.codina@bootlin.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVICE
is set on each overlay nodes. This flag is cleared when a struct device
is actually created for the DT node.
Also, when a device is created, the device DT node is parsed for known
phandle and devlinks consumer/supplier links are created between the
device (consumer) and the devices referenced by phandles (suppliers).
As these supplier device can have a struct device not already created,
the FWNODE_FLAG_NOT_DEVICE can be set for suppliers and leads the
devlink supplier point to the device's parent instead of the device
itself.

Avoid this situation clearing the supplier FWNODE_FLAG_NOT_DEVICE just
before the devlink creation if a device is supposed to be created and
handled later in the process.

Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/property.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 641a40cf5cf3..ff5cac477dbe 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1097,6 +1097,7 @@ static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np)
 {
 	struct device_node *tmp_np = of_node_get(sup_np);
+	struct fwnode_handle *sup_fwnode;
 
 	/* Check that sup_np and its ancestors are available. */
 	while (tmp_np) {
@@ -1113,7 +1114,20 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
+	/*
+	 * In case of overlays, the fwnode are added with FWNODE_FLAG_NOT_DEVICE
+	 * flag set. A node can have a phandle that references an other node
+	 * added by the overlay.
+	 * Clear the supplier's FWNODE_FLAG_NOT_DEVICE so that fw_devlink links
+	 * to this supplier instead of linking to its parent.
+	 */
+	sup_fwnode = of_fwnode_handle(sup_np);
+	if (sup_fwnode->flags & FWNODE_FLAG_NOT_DEVICE) {
+		if (of_property_present(sup_np, "compatible") &&
+		    of_device_is_available(sup_np))
+			sup_fwnode->flags &= ~FWNODE_FLAG_NOT_DEVICE;
+	}
+	fwnode_link_add(of_fwnode_handle(con_np), sup_fwnode);
 }
 
 /**
-- 
2.43.0


