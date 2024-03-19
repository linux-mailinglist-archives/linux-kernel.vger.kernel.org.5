Return-Path: <linux-kernel+bounces-108199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E1880764
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFD91C22548
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA604F885;
	Tue, 19 Mar 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qC24ItmC"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6254364D4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888701; cv=none; b=Y9JDafqnmzQhGCEdHPMPK2HHFY9uhXI5uRqnkjiGKI2Tmfs6+vGeBchbErUG2DM4NcO1J2DEQ3yWc/s7Uan3c1nNYquh6sIQCl0/ssKgQts7tQYyRDUgy/kBpB38RN1cnvcFpISwuzoZJA5+hyL18PSQ0eMWQZrAxVF3g9ry2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888701; c=relaxed/simple;
	bh=3XFBPid9R0JCqt0fTgacbRotaAtE8OIG1lMDUtvpRyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXWqahfBuFHZsU8XsbD00kCxKLdVcv5RZwsCn1pDXr1rG/jX3zKGYhuI3f67SL8bW0N6SC50p1n043bsadHUmDYI4m1wTmBsrF3suceDlDdRYjl0n4xt8JXNyCazXxdA0meTpjh79p6u+wl/lFAoSuL1KTz7cI+xH4QrdU1RuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qC24ItmC; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S9/a7zZ7K+tzZcY0ZjcWN73TQAR+qMuQ1J4ijtfKAJ4=;
	b=qC24ItmCdcMeli2r0BvFALbREJppQpq2xZ8hq0cobqTPHl04AqCVy89u8A2Wpw1VBMh33S
	oMyUcNYcrR4O7E4LFmAt0Pldik8LMLStopcKkZ4MFEDHSklREBUpCsHs7mNUSK1OJ4SLQ9
	6qC/S1K+g3mlLsQ8cnAKltw2q2Biqb8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 0/8] drm: zynqmp_dp: Misc. patches and debugfs support
Date: Tue, 19 Mar 2024 18:51:13 -0400
Message-Id: <20240319225122.3048400-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds debugfs support for the zynqmp_dp driver. The intent is
to enable compliance testing or to help debug signal-integrity issues.

The first four patches are general improvements (and could be applied
independently), while the last four add debugfs support.

Changes in v2:
- Fix kerneldoc
- Rearrange zynqmp_dp for better padding
- Document hpd_irq_work
- Split off the HPD IRQ work into another commit
- Expand the commit message
- Document debugfs files
- Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
  implicit functionality
- Attempt to fix unreproducable, spurious build warning
- Drop "Optionally ignore DPCD errors" in favor of a debugfs file
  directly affecting zynqmp_dp_aux_transfer.

Sean Anderson (8):
  drm: xlnx: Fix kerneldoc
  drm: zynqmp_dp: Downgrade log level for aux retries message
  drm: zynqmp_dp: Adjust training values per-lane
  drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
  drm: zynqmp_dp: Don't retrain the link in our IRQ
  drm: zynqmp_dp: Add locking
  drm: zynqmp_dp: Split off several helper functions
  drm: zynqmp_dp: Add debugfs interface for compliance testing

 Documentation/gpu/drivers.rst       |   1 +
 Documentation/gpu/zynqmp.rst        | 149 +++++
 MAINTAINERS                         |   1 +
 drivers/gpu/drm/xlnx/zynqmp_disp.c  |   6 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c    | 836 +++++++++++++++++++++++++---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h |   1 +
 drivers/gpu/drm/xlnx/zynqmp_kms.h   |   4 +-
 7 files changed, 931 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/gpu/zynqmp.rst

-- 
2.35.1.1320.gc452695387.dirty


