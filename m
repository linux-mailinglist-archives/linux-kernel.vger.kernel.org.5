Return-Path: <linux-kernel+bounces-104976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38C87D72A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64121F21CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554515A102;
	Fri, 15 Mar 2024 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GdPBPgVK"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F359B7A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544169; cv=none; b=NuJGk2V82Bnvx41iLRFGNelOI4xmEAPlfxTPvMlvg8jGT8c3rV+G8R7vH4D6komVcx0+8oIM+S3ajVQi4+8Pabb0bUTuAjXmR24xGRYjDNm6rNQZG5ZXW0GHwgck/IS+50ZwEMxwzcnElR/ISsaOCKMd2+QIlHmsL+kx/oYkSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544169; c=relaxed/simple;
	bh=PRqwLBezQ2b8JpfWeetQRqh/Pok6FXAsKQ9uDwWaj3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGZ7EThheNcFMY86leuUMlZl3xVewsv18qi6qXy2dh70/ADpEYl+e2zsuRMn3bEAAtS+UbAF8tfr5uOCFeJt7nTTlxHX6SIRxiDGPm2/3O8JTBbsy8ZS6SW9QSD8clQKb9fPdb8RYC/QGYpB5nrtcfY5VoIdsY/ds9v0JQUikzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GdPBPgVK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710544164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g0CAM95i80n59VZGkwHqlea1rQUP9k4U2WVriSCIsYE=;
	b=GdPBPgVKp+x3BhgDmR3jO4bwbIRmvCGlyyZr3/ONV9Yk16p2IrhiTrrEcEQjyZno0rr1Es
	MM3yszbKjMYbzVV9T6Yx74OenfVDXqMlAKUkFiKIZMVk0QKT88zOxpWA6y5c0Mw6/zU4Vw
	TFFQeQp++/hYVeO110XQY1B3TYLav/c=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/6] drm: zynqmp_dp: Misc. patches and debugfs support
Date: Fri, 15 Mar 2024 19:09:10 -0400
Message-Id: <20240315230916.1759060-1-sean.anderson@linux.dev>
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

The first three patches are general improvements (and could be applied
independently), while the last three add debugfs support.


Sean Anderson (6):
  drm: zynqmp_dp: Downgrade log level for aux retries message
  drm: zynqmp_dp: Adjust training values per-lane
  drm: zynqmp_dp: Add locking
  drm: zynqmp_dp: Split off several helper functions
  drm: zynqmp_dp: Optionally ignore DPCD errors
  drm: zynqmp_dp: Add debugfs interface for compliance testing

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 749 ++++++++++++++++++++++++++++---
 1 file changed, 691 insertions(+), 58 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


