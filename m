Return-Path: <linux-kernel+bounces-153856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E368AD43F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0BE2833EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA251552E0;
	Mon, 22 Apr 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xGEpfK+3"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D1154453
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811561; cv=none; b=M1GbbS1uuGgIVJ3A61I60nK2YsizuiymEEkkwlBRhd7iM/ThY3LVxnrM4aZBZNoxbN9vWT+EIT73wSivL5GLeHW/drF95FziaLooB1o7+NrTKi76G0IP74vI1OsLHxTIwZYVYZWedZjL4W7J2BM8Cr7i1duoMZorERsYt8rRxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811561; c=relaxed/simple;
	bh=i0JhnsemiBLqt5TUhdprRNPojGuuNhckUaFzNwqob7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnRtaxpqhkML4QQZhCP5Mc90/JMvvyuPz0lZbLbPBiW9zW+BnJOs3QN2EKLDDVZXoaLGTOTON0RnuHBoLBvmveV/quXYQVRHJtyAIXYo7+MvcQFGujTViS9RHcd1CoRvatmkvYpqj5ZPah5BaSZ7Fgp6F/z53UkbuFw7mhb4Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xGEpfK+3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=amqB6+ngfAeMK7LFbICEVIOkozkmR392D+egwlKyyE8=;
	b=xGEpfK+3vqXV26cx1iQXhOPoewDDeufjuKlIDsyF2JNrn1F4qSdEufgjrLTCpF5uXsuD+X
	aOzx2lBRTJv0nM+5UxTbuqEbB2w0tWkBBdzrVcBNnTajfwnbXYxkOlcxgPZj3URSYPskYu
	YRnWH2Xn6QBGdQ0apXLNlnH7yQLD7es=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 00/13] drm: zynqmp_dp: IRQ cleanups and debugfs support
Date: Mon, 22 Apr 2024 14:45:40 -0400
Message-Id: <20240422184553.3573009-1-sean.anderson@linux.dev>
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
 drivers/gpu/drm/xlnx/zynqmp_dp.c    | 909 +++++++++++++++++++++++++---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h |   1 +
 drivers/gpu/drm/xlnx/zynqmp_kms.h   |   4 +-
 7 files changed, 1000 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/gpu/zynqmp.rst

-- 
2.35.1.1320.gc452695387.dirty


