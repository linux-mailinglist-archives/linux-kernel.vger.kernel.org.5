Return-Path: <linux-kernel+bounces-155926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE98AF8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4D6B29DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12D143C6B;
	Tue, 23 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rDyiKo2t"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21004143C48
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908014; cv=none; b=Dr5LW2P4JNZwvP/GEVO85cdbC5q/kUL/1Tj38HgsGdWcWxcrO6FNVfU3wf2uRhyTVpy8jhDlrDosYrK//fiN9s5NAXX/O4hCVLGhfGPkTZ17bexnNeOzKM5tvL8gJev+6QuVFuXL/pMzHgJaK8GPpaxcufcl80Vu3WrG/2ovrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908014; c=relaxed/simple;
	bh=ermidCzXptS9UpEY1BtR56mVa1oOYmwIe1YcgjJZ+ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3EBnZigTOmtJFDIIddOZu4erjrSTd5sOK7zgtpAjT3/Bq/81FFcoCog+LqkYIOxwRHDzRXajuDgMhl+bBfHItHwjybbT38/FaIkx2EI9Uv7hXAfPFu4fWykeq8x+Gj5bCDy9YofQlXKPN3gQcZl65zEKjLQYRr06cgfc7D69m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rDyiKo2t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713908008;
	bh=ermidCzXptS9UpEY1BtR56mVa1oOYmwIe1YcgjJZ+ew=;
	h=From:To:Cc:Subject:Date:From;
	b=rDyiKo2tV9d6QgusK0/h56uoM+CxgLeCuxOzEcKEkn1fVg3dc/vpv7F5SBhby8Y1A
	 Gd/m/a/4n+AfOmLdEafPOX2Uf2oLzvK6lb/PX4rgEza31wB/3fAAA6IM8OE1dSPX/G
	 l+24U4hihjxOvrc2UziSiag/buW92ZCNog3sHmqsGcAjVMHWdGh+5/1BwbKk7xv06C
	 vD4fev0a/7HpyTzq96An4oN1c/2ywirsN6pmGrhUkXdR6szLG4aHlZ4CncmB67GoQY
	 zerF1eHdPmFaA/grMuowHqjn/tJIxI70mMl3DcTjVpBC+FuX5ifdUjc0FRrdDw+hgX
	 OkeKLITLc4R5g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3E7E37811D1;
	Tue, 23 Apr 2024 21:33:27 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Support fdinfo runtime and memory stats on Panthor
Date: Tue, 23 Apr 2024 22:32:33 +0100
Message-ID: <20240423213240.91412-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series enables userspace utilities like gputop and nvtop to
query a render context's fdinfo file and figure out rates of engine
and memory utilisation.

Changelog:
v2:
 - Split original first patch in two, one for FW CS cycle and timestamp
 calculations and job accounting memory management, and a second one
 that enables fdinfo.
 - Moved NUM_INSTRS_PER_SLOT to the file prelude
 - Removed nelem variable from the group's struct definition.
 - Precompute size of group's syncobj BO to avoid code duplication.
 - Some minor nits.

Adrián Larumbe (3):
  drm/panthor: introduce job cycle and timestamp accounting
  drm/panthor: Add DRM fdinfo support
  drm/panthor: Enable fdinfo for memory stats

 drivers/gpu/drm/panthor/panthor_devfreq.c |  10 ++
 drivers/gpu/drm/panthor/panthor_device.h  |  11 ++
 drivers/gpu/drm/panthor/panthor_drv.c     |  31 ++++
 drivers/gpu/drm/panthor/panthor_gem.c     |  12 ++
 drivers/gpu/drm/panthor/panthor_sched.c   | 204 +++++++++++++++++++---
 5 files changed, 244 insertions(+), 24 deletions(-)


base-commit: a6325ad47bc808aeb4c69ae36e0236c2c6d400b5
-- 
2.44.0


