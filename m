Return-Path: <linux-kernel+bounces-89484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D386F0F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5101F21EEE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D318E37;
	Sat,  2 Mar 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kH023/Uv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BF1802E;
	Sat,  2 Mar 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394574; cv=none; b=HMaTMn1ChClw/Z8c7R/snRqWjXhHBYNWngTaP6kCfd05MX5IsjTXH0PCberUXXoCyaq3Ynm2PG4/KqIUf86mZc5/K1B2hF2p509CwaNue4BK9sz/odHuMdhUd3xH3P8ob8CU+xLim9kPQDEi4pnLASw4yXy8vWelGlxXWg75H8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394574; c=relaxed/simple;
	bh=HynQocuJOxjcyWAXFyZaIokqOOlqZOfq1ChkQP5+nVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=czle15ES6DwqeS6+NEWRjtc1oJv3DOMrK/R4gVD9hvPieOPuhjL2EhPAzf/6Enlg+I23oLIKPhuA8SZ8mUOFYyXZ7rxqu6pSMLkXyl1rSaiCYfOU6uSNmZfZc/V607z+/sM8/wSxpbRoDAJh6jORJDo7vcnwIy4MteLE41Lp2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kH023/Uv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709394570;
	bh=HynQocuJOxjcyWAXFyZaIokqOOlqZOfq1ChkQP5+nVw=;
	h=From:To:Cc:Subject:Date:From;
	b=kH023/UvRJljNhpLdKB/Nn8WM/o540hNs2gVrI9jRtYaqRvJsMvrzXWRTc8Y5gceE
	 Q/tTR3gK2LW9EbzxDQMtpxi2MfDk/mm1d+lkkbKFtj4mVUmhYDLGboojXXPk7ekw89
	 VZbs8AFM6DQO8xU503UXz6+Yeuj2Acw+yZ/lZpryw1nQpWqRDB8xGY+ELa8XvyTifA
	 lXQRLHz/4Qc/cXSs9pNHf28cO5CZqQYT/5LmBazHGkuNxP6nRarASFWMOdikBS7OkU
	 eDU+3qB/qYLvXOkDW6LK1fxHu2DiX1ueAchyvpq0AEp19pB6c8qsBnQjN4L9LK7+/M
	 2G1gATNL95o+w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 18DA637813CA;
	Sat,  2 Mar 2024 15:49:30 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/1] drm/panfrost: Replace fdinfo's profiling debugfs knob
Date: Sat,  2 Mar 2024 15:48:40 +0000
Message-ID: <20240302154845.3223223-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the patch already discussed in [1]

Changelog:
 - Turned the profile mode atomic variable into a boolean
 - Rewrote the sysfs file's uAPI documentation to make it more generic
 - Improved the casting of the profiling variable inside the Panfrost device structure

[1]https://lore.kernel.org/dri-devel/20240221161237.2478193-1-adrian.larumbe@collabora.com/

Adrián Larumbe (1):
  drm/panfrost: Replace fdinfo's profiling debugfs knob with sysfs

 .../testing/sysfs-driver-panfrost-profiling   | 10 +++
 Documentation/gpu/panfrost.rst                |  9 +++
 drivers/gpu/drm/panfrost/Makefile             |  5 +-
 drivers/gpu/drm/panfrost/panfrost_debugfs.c   | 21 ------
 drivers/gpu/drm/panfrost/panfrost_debugfs.h   | 14 ----
 drivers/gpu/drm/panfrost/panfrost_device.h    |  5 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       | 14 ++--
 drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
 drivers/gpu/drm/panfrost/panfrost_sysfs.c     | 70 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_sysfs.h     | 15 ++++
 10 files changed, 120 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panfrost-profiling
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_sysfs.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_sysfs.h


base-commit: 216c1282dde38ca87ebdf1ccacee5a0682901574
-- 
2.43.0


