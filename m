Return-Path: <linux-kernel+bounces-86580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2FA86C765
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909751C22041
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD77B3EF;
	Thu, 29 Feb 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A3ZE4+ob"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279007AE73;
	Thu, 29 Feb 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203941; cv=none; b=fE9ZQ0pl9P8ev6Kp0SH7dDBDKtSRsKie96Ew6OcfJxCqDWWCwD0cAWk3Tie0wPh5cp8rTXBnyLjtFo9naMhYiBWb62ObOpILepk8g+DM8SMv4cZOp33gfqZLZGN2UAA4lmmIMs5ika0tbPMbrqjJ++8BTvwffZRp/qnJ5i/079U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203941; c=relaxed/simple;
	bh=zfGeDfyRmaFp1JOEzDfUGcjVtP7tQN/s50BcDdDqvD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2RK6mIXr2WcN++WtosjSXQ4yIzRBIlaQpAGDILuuDQWk7IZmt759c9/364ZwtMpsCpMsa74xe4xSdEVYsXNJQruFhnFeOxurSOHkvv1R0ENuzs54SasiDwywTuklyTxrTXNHcJ0MhFcT8BjNqyPk6P4H9H39Dkpa4nXJDEZSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A3ZE4+ob; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 821C9C0003;
	Thu, 29 Feb 2024 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709203937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCXysWU34VdlLu8PHd2qD3CH0eUBVQ9+sisrVNEEJMU=;
	b=A3ZE4+obaUKBUYrzYYpw7/+4tzUBwLP3K+U4Z+PkVz+LyIlBL0SEinir8alS1UsUr7QYu2
	1+okgDWJFW+K4k8eZYmxcbmfl4vihNEvnKl402+rm1RWHb+4TNnm7K/RaoGmrAWj6BGSHB
	bY2bT4f+1yJj9EP1cD2ujhBJRG64iu8yzudkCRBeuNpF6+IpDoG/KBrqERFPRfmY/65nSF
	hgyuLNA5+HSCUBqQk4B2AW8m+g7TyJv2Z0uZxR9IlKhCYdtaSErIBVIh4fxWgdX5G/DciB
	hbkIcOoZF8FXonqU7Z+fYaSGqu2AZqI7YA0bwgXBnHF41MZ2jzVK1WaXb4BfeQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove() with the devlink removals
Date: Thu, 29 Feb 2024 11:52:03 +0100
Message-ID: <20240229105204.720717-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229105204.720717-1-herve.codina@bootlin.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In the following sequence:
  1) of_platform_depopulate()
  2) of_overlay_remove()

During the step 1, devices are destroyed and devlinks are removed.
During the step 2, OF nodes are destroyed but
__of_changeset_entry_destroy() can raise warnings related to missing
of_node_put():
  ERROR: memory leak, expected refcount 1 instead of 2 ...

Indeed, during the devlink removals performed at step 1, the removal
itself releasing the device (and the attached of_node) is done by a job
queued in a workqueue and so, it is done asynchronously with respect to
function calls.
When the warning is present, of_node_put() will be called but wrongly
too late from the workqueue job.

In order to be sure that any ongoing devlink removals are done before
the of_node destruction, synchronize the of_overlay_remove() with the
devlink removals.

Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/overlay.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 2ae7e9d24a64..7a010a62b9d8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"OF: overlay: " fmt
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -853,6 +854,14 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 {
 	int i;
 
+	/*
+	 * Wait for any ongoing device link removals before removing some of
+	 * nodes. Drop the global lock while waiting
+	 */
+	mutex_unlock(&of_mutex);
+	device_link_wait_removal();
+	mutex_lock(&of_mutex);
+
 	if (ovcs->cset.entries.next)
 		of_changeset_destroy(&ovcs->cset);
 
@@ -862,7 +871,6 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 		ovcs->id = 0;
 	}
 
-
 	for (i = 0; i < ovcs->count; i++) {
 		of_node_put(ovcs->fragments[i].target);
 		of_node_put(ovcs->fragments[i].overlay);
-- 
2.43.0


