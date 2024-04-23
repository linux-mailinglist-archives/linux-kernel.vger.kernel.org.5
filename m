Return-Path: <linux-kernel+bounces-155649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E68AF532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796771C2223F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E913DB98;
	Tue, 23 Apr 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EWRJ0KOa"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172313DB88
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892756; cv=none; b=DS+SNiqS+LLtdC6IGpjTiQAqy/ttw9wBNMqhip8uaKCIJQdHDYQHIbR0Q6AAtvDDPhPJVWIi2r6jmo0c+bpW9FIJTj3Q0pm8TvVqlsDOoER1gVfg9wSa0ecQO/pL1RuZk1aLeId6kQT836B1gGhsoFno/jCzmwmYgEhI4piFgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892756; c=relaxed/simple;
	bh=qiDfDJgwBeYt8TDus+l5rjMhbZN/EiJh0k4vS8yBzbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DLEbkN4ZPPEwcAHHThv+4f3Q7DyD12f49DIdJRzcv5QYwINjwtL35wtunCFR5kJVilmberqOn2Q5FeefW4aY9loBlJumQMwC8tPDWzX4ZjH/XGwIf2m+o/bpKrjy3u0pc05vzczs66+3qvYDJ68Ms3UVReM63nYQOWwB541po1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EWRJ0KOa; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GkDOBRS3bMMlmPWhkPDc7Z2NwYGzHPLznmeKWSenCK0=;
	b=EWRJ0KOakByqTr3nmR6CXByfwD7AlAMDfbf1tqiKsGrDWPpo3JJ0voXLhWi03MpyiN1OXb
	91VScwtFKwPGkoiu3YhqPkME9aDfChv4y+i1NDu75NwPAc7ogOLUpJ9GRgkT+15fTSibR1
	JYfRtOW3ayf4xVL/3E9LpN0ONa5+ngQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 00/13] drm: zynqmp_dp: IRQ cleanups and debugfs support
Date: Tue, 23 Apr 2024 13:18:46 -0400
Message-Id: <20240423171859.3953024-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series cleans up the zyqnmp_dp IRQ and locking situation. Once
that's done, it adds debugfs support. The intent is to enable compliance
testing or to help debug signal-integrity issues.

Last time I discussed converting the HPD work(s) to a threaded IRQ. I
did not end up doing that for this series since the steps would be

- Add locking
- Move link retraining to a work function
- Harden the IRQ
- Merge the works into a threaded IRQ (omitted)

Which with the exception of the final step is the same as leaving those
works as-is. Conversion to a threaded IRQ can be done as a follow-up.

Changes in v4:
- Rebase onto drm/drm-next

Changes in v3:
- Store base pointers in zynqmp_disp directly
- Don't delay work
- Convert to a hard IRQ
- Use AUX IRQs instead of polling
- Take dp->lock in zynqmp_dp_hpd_work_func

Changes in v2:
- Fix kerneldoc
- Rearrange zynqmp_dp for better padding
- Split off the HPD IRQ work into another commit
- Expand the commit message
- Document hpd_irq_work
- Document debugfs files
- Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
  implicit functionality
- Attempt to fix unreproducable, spurious build warning
- Drop "Optionally ignore DPCD errors" in favor of a debugfs file
  directly affecting zynqmp_dp_aux_transfer.

Sean Anderson (13):
  drm: xlnx: Store base pointers in zynqmp_disp directly
  drm: xlnx: Fix kerneldoc
  drm: zynqmp_dp: Downgrade log level for aux retries message
  drm: zynqmp_dp: Adjust training values per-lane
  drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
  drm: zynqmp_dp: Don't delay work
  drm: zynqmp_dp: Add locking
  drm: zynqmp_dp: Don't retrain the link in our IRQ
  drm: zynqmp_dp: Convert to a hard IRQ
  drm: zynqmp_dp: Use AUX IRQs instead of polling
  drm: zynqmp_dp: Split off several helper functions
  drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
  drm: zynqmp_dp: Add debugfs interface for compliance testing

 Documentation/gpu/drivers.rst       |   1 +
 Documentation/gpu/zynqmp.rst        | 149 +++++
 MAINTAINERS                         |   1 +
 drivers/gpu/drm/xlnx/zynqmp_disp.c  |  44 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c    | 908 +++++++++++++++++++++++++---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h |   1 +
 drivers/gpu/drm/xlnx/zynqmp_kms.h   |   4 +-
 7 files changed, 999 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/gpu/zynqmp.rst

-- 
2.35.1.1320.gc452695387.dirty


