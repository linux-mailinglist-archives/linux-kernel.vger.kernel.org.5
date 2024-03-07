Return-Path: <linux-kernel+bounces-95384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D27874D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C14A1F2437C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0140128811;
	Thu,  7 Mar 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S9a7Gm/J"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6286AC5;
	Thu,  7 Mar 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809849; cv=none; b=X0zG84WvY4fEe0eCsoa1I/M7HQ8JjO8ktS6+Svpo/R21O/JTMYa0z43JA3bTuOVXbSUXy1qiseDpwn0n8ofmooe34Sh+mDCDKHySpxLvIxqjjhgC6aknIBjKAQFJhn6Lx2NAKOnyE3Vly7JJGUhK18sFc5JBhay9IS/PmZPww8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809849; c=relaxed/simple;
	bh=mL1RpzLe5fJQgf3VMMyC6C4MdlJwKXj2lEJv87d7j64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNmsg3IwLs7qBxyHFHYmDgsgf2f9P6jpRoGPX2do0ZzmwPzC3EN8aBedeh/A7+CwidLs7atOnV1WOwwxDpRI1R/KprENJehbNWJCHvyPx9afnkhn+Pk/V1N5lYzpdZ33UnjFG3Trm9yAkIRc1sTdaIMxNe78GeC9/PCrZLq9Zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S9a7Gm/J; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4F67760008;
	Thu,  7 Mar 2024 11:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709809843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G8/x7h1kZGZnjE94su9ktfwZ0ZklqZmWmS475eXxFoE=;
	b=S9a7Gm/JR4t/c0NVhCIrAiNUihDayU/hAAYikBulVKS2OMlghRI7t/UxtPXW2f+bejv2MF
	6hQ0H6TPtRoHkeTLHPeXf9Tf6/waba/5yoC8PiJNpJbeWqHPqHfk4bKOd/1LrJvg4Ls1RA
	8liW9bOC1mFA0Ns/NKhlpBIILVLDNstjvleQBcDlWt6EZO0MIhtPEbjacDjrXrP+T4ehcu
	dlQdAV3Vh3zCzC8CHJQsTRf0a8apKdPCGbqOEeFzp35ketXpI5A43C1yRwPF9C2t1ulnrM
	wMnZ4xJn0cQqtiKe4/4HP7ZbcjNHYhSC+bzfOxd60jNeddM0LAkU5ttG8eiFaA==
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
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v5 0/2] Synchronize DT overlay removal with devlink removals
Date: Thu,  7 Mar 2024 12:09:59 +0100
Message-ID: <20240307111036.225007-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

In the following sequence:
  of_platform_depopulate(); /* Remove devices from a DT overlay node */
  of_overlay_remove(); /* Remove the DT overlay node itself */

Some warnings are raised by __of_changeset_entry_destroy() which  was
called from of_overlay_remove():
  ERROR: memory leak, expected refcount 1 instead of 2 ...

The issue is that, during the device devlink removals triggered from the
of_platform_depopulate(), jobs are put in a workqueue.
These jobs drop the reference to the devices. When a device is no more
referenced (refcount == 0), it is released and the reference to its
of_node is dropped by a call to of_node_put().
These operations are fully correct except that, because of the
workqueue, they are done asynchronously with respect to function calls.

In the sequence provided, the jobs are run too late, after the call to
__of_changeset_entry_destroy() and so a missing of_node_put() call is
detected by __of_changeset_entry_destroy().

This series fixes this issue introducing device_link_wait_removal() in
order to wait for the end of jobs execution (patch 1) and using this
function to synchronize the overlay removal with the end of jobs
execution (patch 2).

Compared to the previous iteration:
  https://lore.kernel.org/linux-kernel/20240306085007.169771-1-herve.codina@bootlin.com/
this v5 series:
- Remove a 'Fixes' tag
- Update a comment
- Add 'Tested-by' and ''Reviewed-by' tags

This series handles cases reported by Luca [1] and Nuno [2].
  [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
  [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/

Best regards,
Hervé

Changes v4 -> v5
  - Patch 1
    Remove the 'Fixes' tag
    Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
    Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'

  - Patch 2
    Update comment as suggested
    Add 'Reviewed-by: Saravana Kannan <saravanak@google.com>'
    Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
    Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'

Changes v3 -> v4
  - Patch 1
    Uses flush_workqueue() instead of drain_workqueue().

  - Patch 2
    Remove unlock/re-lock when calling device_link_wait_removal()
    Move device_link_wait_removal() call to of_changeset_destroy()
    Update commit log

Changes v2 -> v3
  - Patch 1
    No changes

  - Patch 2
    Add missing device.h

Changes v1 -> v2
  - Patch 1
    Rename the workqueue to 'device_link_wq'
    Add 'Fixes' tag and Cc stable

  - Patch 2
    Add device.h inclusion.
    Call device_link_wait_removal() later in the overlay removal
    sequence (i.e. in free_overlay_changeset() function).
    Drop of_mutex lock while calling device_link_wait_removal().
    Add	'Fixes'	tag and Cc stable

Herve Codina (2):
  driver core: Introduce device_link_wait_removal()
  of: dynamic: Synchronize of_changeset_destroy() with the devlink
    removals

 drivers/base/core.c    | 26 +++++++++++++++++++++++---
 drivers/of/dynamic.c   | 12 ++++++++++++
 include/linux/device.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.43.0


