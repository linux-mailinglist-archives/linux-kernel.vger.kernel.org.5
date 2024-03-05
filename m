Return-Path: <linux-kernel+bounces-92995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8C87292A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221C81C2309A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627A12AAF5;
	Tue,  5 Mar 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="endf5MQ4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185151B809
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673082; cv=none; b=Xm1WjZmE7AiS8+2o5AJ5O//AO7IgWw0zkOmKD3225K91KjS5W+GZFgXqe3f+z4iYhLz641oyPD8TgXcmYO61zg+x2QR33Zye9rVk0eTbzDluEkHIRzC7DxwPhXoEtVylP0d/qOaqG3xmx0L42cDFidu5s87kSdR1cH8mGZJ0deU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673082; c=relaxed/simple;
	bh=OKwLmlwHaVM9YDm02QY7BaQXKQlATiOtDVXMPFzNoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzAM1aSe2YW9LMrn+DvdJ0BF19+Vkv1mN/IlxLp4/Ro7kI0tvpAK+vH8+5HvfKErumMmms7G3ScbGgT+euIPElrGYZHSNkZWtY6YiiBUg7VLCKWcoI5ScD17phc1xJhVxtAhd6rFshyvng7ycZWgpvmxwpLhvR9kKMiOW1d7S6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=endf5MQ4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709673079;
	bh=OKwLmlwHaVM9YDm02QY7BaQXKQlATiOtDVXMPFzNoF8=;
	h=From:To:Cc:Subject:Date:From;
	b=endf5MQ4Js1GWRWnOg9eYVceof+qnDPQd9vjpPl2lb7brl2Zb1u9q52UXgNOVC7c/
	 WcxuQO+i6VGwX6XlON4J4lF9kFK++q4eOycYsNU7LXi1Tj1RPGPaAPNpmWSq2PXmPv
	 CQO1cqJFXHzVaCju3q3WmTk+M6dPf+WKm6+u4CtH/SLRcSyhR7LEkhsj7+1ohtyRD7
	 ZfhZc2hs5Tz4kUaGIKJ8ELkj9Ld/PbLAtmt5HwRCunJwg/T/fOCgNtTs9eIRXdwO7e
	 lZguXX9MEhYQWltncKNDIAmFIbXWkecfTIj9eeuNqzGwaMk6+i4kO+le8WQxhnLv+R
	 4kOHJOdE4oUwg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B5663781FDF;
	Tue,  5 Mar 2024 21:11:18 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: boris.brezillon@collabora.com,
	steven.price@arm.com,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: adrian.larumbe@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/2] Support fdinfo runtime and memory stats on Panthor
Date: Tue,  5 Mar 2024 21:05:48 +0000
Message-ID: <20240305211000.659103-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
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

Adrián Larumbe (2):
  drm/panthor: Enable fdinfo for cycle and time measurements
  drm/panthor: Enable fdinfo for memory stats

 drivers/gpu/drm/panthor/panthor_devfreq.c |  10 +
 drivers/gpu/drm/panthor/panthor_device.h  |  11 ++
 drivers/gpu/drm/panthor/panthor_drv.c     |  32 ++++
 drivers/gpu/drm/panthor/panthor_gem.c     |  12 ++
 drivers/gpu/drm/panthor/panthor_sched.c   | 217 +++++++++++++++++++---
 5 files changed, 254 insertions(+), 28 deletions(-)


base-commit: e635b7eb7062b464bbd9795308b1a80eac0b01f5
-- 
2.43.0


