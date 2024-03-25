Return-Path: <linux-kernel+bounces-117354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492888AA63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1FF1C38AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C613A40E;
	Mon, 25 Mar 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fv4hX1dM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E818C08;
	Mon, 25 Mar 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380119; cv=none; b=Di2D9pSZRzVFrwEyvsEh5nVXESKzcmm24JYouchH6MuhMbF4sJopnvuOx2dFvCOeIMb5hMDwyNOHwZ879Ez5QyrnOnfEFEoJrQk5NWRp0BXWEmfkUwnsBxvtSkxqYrrMNauqUjChXpVr4vg95NA2UPc1+9p5PKB1GKJwEgvKp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380119; c=relaxed/simple;
	bh=Z7ZRXeLKdWuIY/i4KBUBO0qa0OtkvNi41/wthDRv3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U23Ei0L54TLzRgSjB9HUC8pLt3X7RpkI+QaewFcG6A+2o+gF1q0g3qgYylT0yPMsz6VPljwvF3BBCt1WLXWTg6cIKwGgPWRtq0TRXho2rhQyRJgzT7askhpTldCflLTiRgG1if8q5nf5grUfCvJ4THjNK0TdJfRIxO1TrtOe9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fv4hX1dM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8A71EFF809;
	Mon, 25 Mar 2024 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711380114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yrwq/MwRkPr6XM5PqLQGjO/LfIdYiz0l6AT8j8PAEYs=;
	b=fv4hX1dMW+whUxlXO6PgrPO5FtqLEOtD+3oSMlR0Lpw0faFS4WnQfo0Q9MHRSo0H2cXV8A
	roGJGgheYN+BFl2m+adPgf35EfnWlrD7eDSeYq+CccTGbYUTcKWkFmegq/gfPQl/O/Sckj
	8b6u2YAhUFu+nvSVhVwBKWPqlMHktQe5wjMsl61/03ZPvlKIdzDKL/7pWvAMVjvR0bcIzN
	WrG70/iCB7tIHCjz9MWqozwi1f3xHAt88zaIVyYam29pONMIEfV377vfJOULAycBDjdK6k
	P7Lae/bOF4LRlA6YkTQ/R6aOf0/b25cVf8Jc/PQrfbi/ybybtohR0GIppFzBNA==
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
Subject: [PATCH v6 0/2] Synchronize DT overlay removal with devlink removals
Date: Mon, 25 Mar 2024 16:21:24 +0100
Message-ID: <20240325152140.198219-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
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
  https://lore.kernel.org/linux-kernel/20240307111036.225007-1-herve.codina@bootlin.com/
this v6 series:
- Add Saravana's 'Reviewed-by' tag

This series handles cases reported by Luca [1] and Nuno [2].
  [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
  [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/

Best regards,
Hervé

Changes v5 -> v6
  - Patch 1
    Add 'Reviewed-by: Saravana Kannan <saravanak@google.com>'

  - Patch 2
    No changes

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
2.44.0


