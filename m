Return-Path: <linux-kernel+bounces-49822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4584700E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33301F250D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28E141997;
	Fri,  2 Feb 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz7xU9rj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDB13F01B;
	Fri,  2 Feb 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876302; cv=none; b=S7hEAf5v1bYA3gmzAOHm0jkU0bTaVW1CMTcvAh0P7Oh1Aqd+4gipg/eXlqBLgelG+UzFpzr2Bn/Ym7rXvtUMJmp3sgNKA/XtjLJmmpwIzIhjCRddzMnMxCfc2z6DqjlImYWCk4gw3gpo0FNdd/p9dOKfoBQt4/O6cUT6ayQTTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876302; c=relaxed/simple;
	bh=qaZRRanp9ZLnLiYxNViu6c8e7LEdLYpVq+TyVdfsOAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XQSm6yiLTM9kuXE/nDqxVQutbdGtDPOauQS9HMK3vSiD2o7KLBbt5RoiV8pyKHMWeyNIcrZDh7j44IlPQ6h2J7wkN2Z+BHZKU3k4adtYmTk0NxrWLbVL2oHXQoSrIvBYocKHmTDJurlck5wVdzepngHBR+ThGFTdSjuijruc/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz7xU9rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D27E4C433C7;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876301;
	bh=qaZRRanp9ZLnLiYxNViu6c8e7LEdLYpVq+TyVdfsOAc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Sz7xU9rjroP6ZEAh5LrlNan9JvTaMDY6mest18yANrItXNekEwbgjA1X0AxzKNX3R
	 k5xxG9KiXrBu3JXTlHqC5+aaa7gxPXbcU47z3CgG/2Ie4j6O8uZ3+QkRUJUCCwwSQF
	 ygRgvk2RSbo0K8CyutQq+S+Zm9K12n/2b8MUBzgW4wuJVlJUsqdKCjG/+qqc68xWtz
	 nmFkU76t0vBZLE0TTXeyM3t873a4nIyw4FdxowlRIFmuzN5+n2n536Exww3HPyavUd
	 5B12/sbY/0T2kg2PnOZf7ojXtpLGcC6nL7pmloj+Gb2ogSpS7bEzd4wHGVuSkNhWn/
	 qjiICRquqolcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C176CC4828E;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] fix DT overlays when device links are released
Date: Fri, 02 Feb 2024 13:18:15 +0100
Message-Id: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIfdvGUC/42NQQ6CMBBFr0Jm7Zi2IAmuvIdhMZQBJmJrWtNIS
 O9u5QQu38//7+8QOQhHuFY7BE4SxbsC+lSBXcjNjDIWBqNMo7SpcZIPjqVoGVdxj4g+cVhpi3h
 pjGFV16S6Acr+FbiUD/e9L7xIfPuwHVdJ/9J/rEmjxo6bqSVLNLT2Ro5WP5+tf0Kfc/4CNYu1E
 cMAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706876300; l=1394;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qaZRRanp9ZLnLiYxNViu6c8e7LEdLYpVq+TyVdfsOAc=;
 b=lX31h/u07E3I6PjCqxD/6Q1IoZFzkQvco9yw5skg5t6FgawTdPYE3Bogp/xhHn/ZUmz2IzLRS
 WyTeA9lP/pfAxNLs/sQJKmuG7cI2P5gfIxzD0gA2Lw1SdjpUjE0XLwO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Link to RFC:
 * https://lore.kernel.org/lkml/20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com/

Changes since RFC:
 * Use a dedicated workqueue to remove devlinks;
 * Flush the devlink workqueue before checking the of_node refcount
   value.

The following series is the result of the discussion I had with Rafael.
To sum up the fundamental issue, device links drop their refcounts
asynchronously and that means that the of_node refcount associated with
the device will also be dropped asynchronously. Now, in
__of_changeset_entry_destroy(), the assumption is that the node refcount
must be 1 and that cannot be guaranteed given the above.

I'm pasting again the link of the first time I exposed the issue where
one can see the resulps (big splat) of failing DT assumption:

https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.sa@analog.com/

---
Nuno Sa (2):
      driver: core: add dedicated workqueue for devlink removal
      of: dynamic: flush devlinks workqueue before destroying the changeset

 drivers/base/core.c    | 33 +++++++++++++++++++++++++++++----
 drivers/of/dynamic.c   |  8 ++++++++
 include/linux/fwnode.h |  1 +
 3 files changed, 38 insertions(+), 4 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-fix-device-links-overlays-5422e033a09b
--

Thanks!
- Nuno Sá


