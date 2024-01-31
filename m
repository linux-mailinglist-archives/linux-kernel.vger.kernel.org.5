Return-Path: <linux-kernel+bounces-45789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D89843643
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0612C1F28201
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE63F8FE;
	Wed, 31 Jan 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mREkTbXH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4123F8F7;
	Wed, 31 Jan 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680346; cv=none; b=RWRfeohsljrHQa780Sht9KESGGjSzcSTymG8qkvGcm98hC6+EYOnplXEtA9F0lC9BhIEcbXTM9HZLZqfIxlHYS5VQd5n8FKJmkGjsOgDa1YPw2SYnGf4ZKi9Dc0vFp57VvOAYKYsqikUyew6ufxNcLJWzr1xj8YV77lbHGQDdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680346; c=relaxed/simple;
	bh=oLIoHkCq7oxroT661WmG3ewiFL1pCsYktfj18SCPxK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiKt9a0revLgkdcDtiEXJlrHbTf/vlee+IPnn7U47u7QyD2Pn9sNdYcwRz3lZHLx4zGyI0PcZh/XT8IZJPgOkxjOjbtPQWlYPnfBkLToS0FlglaLQ8vHI+510fNw2UB9y+do+hKJ1NZKfxuHfnbBOj6MUgcW+yQs6piT6yGyY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mREkTbXH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C661F3D9;
	Wed, 31 Jan 2024 06:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680257;
	bh=oLIoHkCq7oxroT661WmG3ewiFL1pCsYktfj18SCPxK0=;
	h=From:To:Cc:Subject:Date:From;
	b=mREkTbXHguI7h4qA9e846aeJY3aBYevjyG4kgFlQBeUg0z74K8aAwkXrWAC7XqSI3
	 euV4oEjxiIekIKQbNLyIxfa1Ztzlx45Sb9XtV9+ZweBuAaujwJ0dnJxI1VqVQvRsM3
	 kGusMaeUgNpOEgmAPQa7yboZXp7rq64VgCa3mCvk=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/5] imx335: Support additional link-freq and TPG
Date: Wed, 31 Jan 2024 11:22:03 +0530
Message-ID: <20240131055208.170934-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for additional link frequency and
test pattern generator on IMX335.

Patch 1/5 is a drive-by patch which drops setting of a reserved
register. This register has no effect in operation/streaming of the
sensor.

Patch 2/5 adds usage of v4l2_link_freq_to_bitmap V4L2 helper.

Patch 3/4 supports for additional link-frequency supported by IMX335

Patch 4/5 is also a prep-up patch for TPG introduction(in 5/5), as the test
pattern needs sensor to be powered up to apply the test pattern.

Patch 5/5 adds the TPG.

Changes in v2:
- add new patch 2/5 to use v4l2_link_freq_to_bitmap
- fixup a return; in 4/5

Matthias Fend (1):
  media: i2c: imx335: Add support for test pattern generator

Umang Jain (4):
  media: i2c: imx335: Drop setting of 0x3a00 register
  media: imx335: Use v4l2_link_freq_to_bitmap helper
  media: i2c: imx335: Support multiple link frequency
  media: i2c: imx335: Refactor power sequence to set controls

 drivers/media/i2c/imx335.c | 250 ++++++++++++++++++++++++++++++-------
 1 file changed, 205 insertions(+), 45 deletions(-)


base-commit: d7cb6098f1d4866ae864cccdbb3fdcea1176a7f6
-- 
2.41.0


