Return-Path: <linux-kernel+bounces-99167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E8878462
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17CFB21B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7347F63;
	Mon, 11 Mar 2024 16:00:47 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7674122D;
	Mon, 11 Mar 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172847; cv=none; b=EVsSe0uvmj59U5pgZVGIABBLhqjDxeN0HrZbiQsee7cMxVubCKMa6wXK6p++tERH+UGH/V2dfJerzoSU8i8dJ7f8w0MiTv7E4tKhvpjYEytrwZ/Vu+jFggQ9K4SnHDCtQFKQz32PsK6InhbJJj83nTtFTuzFjvYF9xZ7ahJu2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172847; c=relaxed/simple;
	bh=rthV/O6G7MwZ6Q8s5DePKnoii7JT0Cy2tYaw0zWWqyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7E3ZlJKpozYoZcXRHhr03wT7MlIoTRqLZUz5h3LlMaqiH0LMj6faa3+ssD7M5/p/gpbGYQBYrvjFGC+bV8qQ1Lhi1919gyXEu8+YPXsPxdP1a/fm/ZYMCDrWoJ9Tq7iTyZUX6lCliL9OXdmVhvea7eT5XNmT5BNBLlj0nJ90Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 5BC9E657AA;
	Mon, 11 Mar 2024 17:00:37 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v3 0/2] media: mgb4: YUV and variable framerate support
Date: Mon, 11 Mar 2024 18:00:27 +0100
Message-ID: <20240311170029.2725-1-tumic@gpxsee.org>
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

Changes in V3:
- use div_u64() for 64b division (fixes build error on ARM32)

Changes in V2:
- Added missing stride limit

Martin Tůma (2):
  media: mgb4: Add support for YUV image formats
  media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME

 Documentation/admin-guide/media/mgb4.rst |   8 +-
 drivers/media/pci/mgb4/mgb4_core.c       |   2 +-
 drivers/media/pci/mgb4/mgb4_core.h       |   2 +
 drivers/media/pci/mgb4/mgb4_io.h         |  29 +-
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  |   9 +-
 drivers/media/pci/mgb4/mgb4_vin.c        | 205 ++++++++++++---
 drivers/media/pci/mgb4/mgb4_vin.h        |   3 +-
 drivers/media/pci/mgb4/mgb4_vout.c       | 322 ++++++++++++++++++++---
 drivers/media/pci/mgb4/mgb4_vout.h       |   5 +-
 9 files changed, 505 insertions(+), 80 deletions(-)


base-commit: 65e6a2773d655172143cc0b927cdc89549842895
-- 
2.44.0


