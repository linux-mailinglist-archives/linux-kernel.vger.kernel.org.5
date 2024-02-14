Return-Path: <linux-kernel+bounces-65179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A78548FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CC71F24E52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA11B962;
	Wed, 14 Feb 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lktErl8e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB61B5AA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912903; cv=none; b=h2G+eZkMMkKKLr3UYi8tFtEGaN6kDXt/T9/mTsbkpHJcQ18b1VNYmMpf25U37AYxyzEPtkNA5kPAezXZk8wz4z5cRhLqm3NDgQNHOjyDWlnPkspkKHMLxhlBlKplAAMuzzGH7fIXLmgJvFfQJsod8kj6vUf8PP7CSV7NLhgmVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912903; c=relaxed/simple;
	bh=tfISkpmpp4nJRcfb3dG1pEk85K2saMry/h9bbcDcZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udRaSlJvdZFlOdV3/y8P/8d05YZhOQxgFlH6CC1JMN8a6NiKUfsqVC4qF+Ea5rgVCJ2/xSceW3z6F26hxSiiLnMHLFbN+It3cWNrBicYVhxCYNXkfSDd33/fPTyVtw7WNFqd08hS0sapUvwmNOvBQsp7DJllo+RWp/jWUAnJWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lktErl8e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707912899;
	bh=tfISkpmpp4nJRcfb3dG1pEk85K2saMry/h9bbcDcZVc=;
	h=From:To:Cc:Subject:Date:From;
	b=lktErl8emXZHiqOYad3nGkmzkVwF/jIOq8I9KToY++xNzSATm6o9jnxce9vzGrvej
	 WQzLzChYKMePwRsZrRIHemSHL2Z8gZAHy1lNJWuCscuy07vlIHbMFhlRU5XuSZKpYU
	 mjdIra5TFyd8KJkzRRPQ/tlP8KgOY3LiV/woOuGwEsMAfCdC4zMiig72xWF1N/yhXE
	 tklI/2hOpOhJIwjZvF4BlYHBygXGf095uI+sgKILDMIYxzeIJZIS2gEp1KMwCJjrYH
	 zWq4/TcxHKec+AufIpi4YSxvnT7iWzVs03C4IeYS1Hm4RZYYiqgDhKwXBx8upF/Dn5
	 4JWE1v1EkPDGg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1577A378045F;
	Wed, 14 Feb 2024 12:14:59 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/1] Always record job cycle and timestamp information
Date: Wed, 14 Feb 2024 12:14:26 +0000
Message-ID: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A driver user expressed interest in being able to access engine usage stats
through fdinfo when debugfs is not built into their kernel. In the current
implementation, this wasn't possible, because it was assumed even for
inflight jobs enabling the cycle counter and timestamp registers would
incur in additional power consumption, so both were kept disabled until
toggled through debugfs.

A second read of the TRM made me think otherwise, but this is something
that would be best clarified by someone from ARM's side.

Adrián Larumbe (1):
  drm/panfrost: Always record job cycle and timestamp information

 drivers/gpu/drm/panfrost/Makefile           |  2 --
 drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ------------------
 drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 ------------
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 -
 drivers/gpu/drm/panfrost/panfrost_drv.c     |  5 -----
 drivers/gpu/drm/panfrost/panfrost_job.c     | 24 ++++++++-------------
 drivers/gpu/drm/panfrost/panfrost_job.h     |  1 -
 7 files changed, 9 insertions(+), 59 deletions(-)
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h


base-commit: 6b1f93ea345947c94bf3a7a6e668a2acfd310918
-- 
2.43.0


