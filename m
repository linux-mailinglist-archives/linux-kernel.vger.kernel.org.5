Return-Path: <linux-kernel+bounces-86319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AF86C3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74CE1F2414D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44598535BF;
	Thu, 29 Feb 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fdbcXAaE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE052F7A;
	Thu, 29 Feb 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196016; cv=none; b=BDr92UaePWEz1IwrmGYnMiKaNDBdVeGHM11c9kuc76nbDmRI6e8bPxdsIdUTW9Bih8sSyreekt7gATfPUedMCZwFwtGUwNK0lDecUp18l+c/msIR1u07emw5D8qmzvT+rEQq7cnTJTHL+8MKryLSoddgEXA7mvWWluz3gVj/mMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196016; c=relaxed/simple;
	bh=BNo0yW2FLpDKUhmP2HaX0f6PbcoTDWSkMT1gkxmdvZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sg1aihYy/QGL/SFRSX2cWUBx9z5n2TEOiXlv7rSU6giXyohssBUDBbhE1jKhBwXRSWKCTWEbaTXHnPmcS8n67Cjs/5hGwvlJbSJ76LmYIUDP25q7Y6hf1b+fOln9DC6sDvUt9677wBgrKhPfgZB4OkV4Bb+UTqljvfJJSeSRPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fdbcXAaE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B5F541C000E;
	Thu, 29 Feb 2024 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709196011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=66l5nnX2XD0JkszxdbTNgnTBzOtV2bLUDTMkK3+nFE4=;
	b=fdbcXAaEGmYq4xDjfNLLpoZfYjl0yLzw91HYvMXGM0Rk7GIahIpgp/PD8MJc3XtdCCD8ft
	Dyhg2CLbB3DE0DI8tN1a8oFnq3ncDc7RYM3otb43Lx1iGdfxJ4CuAEdSi8LhLsC2grptbG
	xmgrXu97H663Qn08GdU3TNxJdkl1wzjIIQEd1UnEO6+E0eM3OOqMgaiRf2IvxBizQw5sf3
	yNYGUc11/7MAAve97/BwKm+YVKBdBuqVOite+4ChfY3A5n5Q/dgOfEhmZEA3CYnPLDL07S
	4XsnrlV07nBmPEDmyVmcI9qMU5+g3fU59+93KdCjyQj6GZsMB3BpbV/U2iyhzg==
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
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/2] Synchronize DT overlay removal with devlink removals
Date: Thu, 29 Feb 2024 09:39:40 +0100
Message-ID: <20240229083953.607569-1-herve.codina@bootlin.com>
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
  https://lore.kernel.org/linux-kernel/20231130174126.688486-1-herve.codina@bootlin.com/
this v2 series mainly:
- Renames the workqueue used.
- Calls device_link_wait_removal() a bit later to handle cases reported
  by Luca [1] and Nuno [2].
  [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
  [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/

Best regards,
Hervé

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
  of: overlay: Synchronize of_overlay_remove() with the devlink removals

 drivers/base/core.c    | 26 +++++++++++++++++++++++---
 drivers/of/overlay.c   |  9 ++++++++-
 include/linux/device.h |  1 +
 3 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.43.0


