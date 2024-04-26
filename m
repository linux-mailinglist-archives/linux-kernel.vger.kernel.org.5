Return-Path: <linux-kernel+bounces-160147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F78B39DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080D31F22D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68C149001;
	Fri, 26 Apr 2024 14:25:37 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C7148854;
	Fri, 26 Apr 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141536; cv=none; b=u9gFo48rUBpB7ltHPNFoNn4RNGpUl3bmEZK5CScKQ+1dPyj1TEHCEM6ruiSk5cjxhkDgCFIEsUyDeMlA/5fZSJX0SgKStRcndaaGWLcxKvEnzzie2B1jCcM2LdX65ONEiCa7rIiYhbPFqOqV4ZTCLhaZeYJHmMyLPg63S+WDva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141536; c=relaxed/simple;
	bh=6KcDOU9+CwjO+b4+9EEBY0zyGxUPO/qtrcLQO/4Qd1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyk8yMlx28ZYy7LdC36e/L5AccvYuKX5dcWfx75F5AsEOOAMWq66Liu60orvHl+0uGCfrGYJQifJHgOvsagUY0rTBgsEOguNM7ruw2V2qyIYw47xDVvJ7g+uKjXRufYCyzgAbH3NRpMztii42ep/T3k3KzGAg6Djup/Y7LyekhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.. (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 5072742E82;
	Fri, 26 Apr 2024 16:16:26 +0200 (CEST)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v5 0/4] media: mgb4: YUV and variable framerate support
Date: Fri, 26 Apr 2024 16:16:15 +0200
Message-ID: <20240426141619.8866-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Recent mgb4 FW update added support for the YUV image format and variable
framerates independent of the signal framerate. The following patches extend
the mgb4 driver with support for both features.

Changes in V5:
- Removed surplus v4l2_format.type checks.
- Improved the patch descriptions.
- Splitted the frame rate limit patch into separate code/documentation parts.

Changes in V4:
- Splitted the output frame_rate handling fix from the variable frame rate
  addition patch.

Changes in V3:
- Use div_u64() for 64b division (fixes build error on ARM32)

Changes in V2:
- Added missing stride limit

Martin Tůma (4):
  media: mgb4: Add support for YUV image formats
  media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME
  media: mgb4: Fixed signal frame rate limit handling
  media: admin-guide: mgb4: Outputs DV timings documentation update

 Documentation/admin-guide/media/mgb4.rst |  23 +-
 drivers/media/pci/mgb4/mgb4_core.c       |   2 +-
 drivers/media/pci/mgb4/mgb4_core.h       |   2 +
 drivers/media/pci/mgb4/mgb4_io.h         |  29 ++-
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  |   9 +-
 drivers/media/pci/mgb4/mgb4_vin.c        | 193 +++++++++++---
 drivers/media/pci/mgb4/mgb4_vin.h        |   3 +-
 drivers/media/pci/mgb4/mgb4_vout.c       | 309 ++++++++++++++++++++---
 drivers/media/pci/mgb4/mgb4_vout.h       |   5 +-
 9 files changed, 483 insertions(+), 92 deletions(-)


base-commit: 8a718752f5c339137c5b05e54f116cd26d5a4143
-- 
2.44.0


