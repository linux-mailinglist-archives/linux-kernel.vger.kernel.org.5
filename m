Return-Path: <linux-kernel+bounces-93543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63A873134
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF451F21345
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D735D8E7;
	Wed,  6 Mar 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IKId+XNt"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201565F57A;
	Wed,  6 Mar 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715091; cv=none; b=RA7+eZauX3PEhMS7MPqCoWUzvELZWsa3nefnqolOLCZIsMsG7xx3878kuwWpgW0aGdYgNQPgucU2AtXO5w5TJuakJde2ITl4b+/TaHyk8utT10J0M/iOBpJcbnFvJCmOXoyUz7KTFHjPDdjtOFeIQcETGcLMWK0H2Ucttpa2whQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715091; c=relaxed/simple;
	bh=wzT7UhMTi5fgGYNzyYXCwdvm1pnKZUabXN24TffNYU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTI3P3dGNNw54pZbsysOtqyEZlFlNHTnSRlzE0YjJ+OqE1FWeZMzNYKhLN4+wDIppl2hvrqqPnc+DYow+KYMDcYTHLuea65TEp4IGPBnHmNY+2LfecMS6F/81S5A96qVTOhIGxbfNo+WBQgROc+KJvEI/x4i4hJ0P0MGPqcKQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IKId+XNt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5D105C000E;
	Wed,  6 Mar 2024 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709715087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsaNdjrSmF9njVQ3P2uiU1SWMrwODHyriD/FQt22xJA=;
	b=IKId+XNtwfMc9maul8rDek2w6giZktzfLy7TYFnWymsvRHGxatxduZdlZyFiAyZ4eyoN1N
	89sVlm3zLG88SKO1emmcJCxSzevEs0XyVOVre/s5b4uQWqoKGwl2N3gaaS6HO6UoPLFy/5
	Eo/Gw4CAjc6em+XGmRMkpV4I0z0Mty6FHDgbz1t/fEzAxA8JM4JR0He4K1d17zq0plLqr9
	IiekxPe4aoxjw6E1sKJGS/SjdqH2+L1LrSLepzOqU2W3kEVMXdnRt5rGlPZNPCKEbpKPTw
	XnNefiYjlp9N/qL10vMEk825zf+qhhKkxJhGYHdp4nNzkVdYfkJ0PEiRczNlDw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Saravana Kannan <saravanak@google.com>
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
Subject: [PATCH v4 2/2] of: dynamic: Synchronize of_changeset_destroy() with the devlink removals
Date: Wed,  6 Mar 2024 09:50:03 +0100
Message-ID: <20240306085007.169771-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306085007.169771-1-herve.codina@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
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
the of_node destruction, synchronize the of_changeset_destroy() with the
devlink removals.

Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/dynamic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3bf27052832f..169e2a9ae22f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -667,6 +668,12 @@ void of_changeset_destroy(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce, *cen;
 
+	/*
+	 * Wait for any ongoing device link removals before destroying some of
+	 * nodes.
+	 */
+	device_link_wait_removal();
+
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
-- 
2.43.0


