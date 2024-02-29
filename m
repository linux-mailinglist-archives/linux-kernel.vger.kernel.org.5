Return-Path: <linux-kernel+bounces-86321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F586C3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E5F1C21AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0754BD4;
	Thu, 29 Feb 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l2oLY7Kh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032453E03;
	Thu, 29 Feb 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196021; cv=none; b=K9xiZVWqb0QmFQTYOkv78xr/h8+LzOQWsz/bKZzMpFIxXuU65knhLdJrPMz1nvfrciiemhzXFCV/lR5AoWin5MD66f5Qa0pY6kROciQvkHAU/5mfOmweq7aSYuImLntVUvh2aZ196mj3QrCRN9b3F71j81NiYsKah22Wl1jaLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196021; c=relaxed/simple;
	bh=eZ+3OozPUeVZO7B2Jgh/4l/sUFJFV2V8r9Stbd/Q98w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBksNkiv8rvKeRZ6qLJ5kGtX7bDqBYZD42iMdEFSgHg42l+SRdAwCCE86v0JYp1Yr5DVK7np5JYoXnX3fjT4U2m2UXOLOQe42oHQSkBcxlwH2FvMVfA2ixdCitjK7fPWAhSsJWhVXVTe2k4fzy3FmOoDWLv1y8atLpwVp3wcWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l2oLY7Kh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 982711C0009;
	Thu, 29 Feb 2024 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709196017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozxKQ6D3jHBM/on0ol6MGQhxLS8ky/f1F93FXUmH/nw=;
	b=l2oLY7KhBSujnww8zmyejXrx8ZpLCCLpDL6nrgIXUkHNqlk5fBaZtUEFh+4YeePiUiWdLp
	jx5Khz01X1b0Vz9+eOc/FnL5OQtH48aAW30pgX1burqxQBPlhvCawih217ZwT0to+n4qZ6
	W15UhTcBzH8YQ8yK12AHznTnCATZ6MLi174q8pJA27EewvYgYh7hh/n3YkfTlV32MQ/5kX
	VuYRz091lv+UA0WyiE9d9WE/gM5i/I0FDDgDrFJ8bEl0vnJaY+i7YGgHhkXGrt8vNpN34M
	AlIKFDVPFmS0EADxqfJ9h9UJ1zQDNc9d0mQ2aqTNKS98o78Pxo5eooy0vYopiQ==
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
Subject: [PATCH v2 2/2] of: overlay: Synchronize of_overlay_remove() with the devlink removals
Date: Thu, 29 Feb 2024 09:39:42 +0100
Message-ID: <20240229083953.607569-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229083953.607569-1-herve.codina@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
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
 drivers/of/overlay.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 2ae7e9d24a64..99659ae9fb28 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -853,6 +853,14 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
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
 
@@ -862,7 +870,6 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 		ovcs->id = 0;
 	}
 
-
 	for (i = 0; i < ovcs->count; i++) {
 		of_node_put(ovcs->fragments[i].target);
 		of_node_put(ovcs->fragments[i].overlay);
-- 
2.43.0


