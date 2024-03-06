Return-Path: <linux-kernel+bounces-93218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DD872C74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23711F24BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A7D518;
	Wed,  6 Mar 2024 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xWcUMi01"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38379E4;
	Wed,  6 Mar 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690310; cv=none; b=c7d7ifOZewCwT7hA3aFFwvTOGkd+NzReUhAORDZ8HqNwadqSmf9tNiQVjTAgI6haSsTOgPizDq8RLr9Lo2NtCPDmAJfr+/JedwEkDRJV8Tdru8GZ1Gg54Q5/1D+tqFOdJHZJq3V3DaLolAqyA4KsvfEyocu/CaCur5EA5qUKzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690310; c=relaxed/simple;
	bh=NDJHWMFByDMvSMmiIQpuUnrq3/RJFevyjBzAN9KgNjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLD9+abJN/0thQ7olz+/RpcHmSYugtz7BL87fPQVb4shizLWp9yLHK0jh4deQhNRctXsyb2A1cs8RAJtHIIOcPswYzeVg7Bz0DRwm9fI/IO3AxhDATQwclOvzZeOAykOdeZZ0COlutShCcESfy6bRLO564/huycE1pN18r5UPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xWcUMi01; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709690306;
	bh=NDJHWMFByDMvSMmiIQpuUnrq3/RJFevyjBzAN9KgNjc=;
	h=From:To:Cc:Subject:Date:From;
	b=xWcUMi01dIt7Gnw8Ju2UlKoh3JVJ82I8z55YVnaiYg92ZprRNQIeVQmUz77VlU03c
	 qv3y3B3q6hj9x+IoXGWnXMHfQExM5C8IlRxPKxOdVzP4LRtcqn+TpAez88hXamTEKj
	 0rnj3llG0amZ+nBpS6fM7/goOCJFQOhsRrM4d8I/d4wdqBWpytgpOYThImqB8N+Iwf
	 xfTTX2h3Txfd2J11i1yvoag3ia9iAivAxZGo7i4cIl35XDZPKqTrumtp5/AJdsdXIZ
	 cyY6jI9OZTmceQutPhlHWMeAyR9f/Gm2wxeGDTxW846Fyri0p/cTRb2/YQfZkfEo/p
	 SadjSk9IE1jgw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE8A63780B5F;
	Wed,  6 Mar 2024 01:58:25 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net
Cc: kernel@collabora.com,
	adrian.larumbe@collabora.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/1] drm/panfrost: Replace fdinfo's profiling debugfs knob
Date: Wed,  6 Mar 2024 01:56:35 +0000
Message-ID: <20240306015819.822128-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of the patch already discussed in [2] and [1]

Changelog:
 v3:
 - Replaced manual kobj initialisation with a device attribute
 - Handle user input with kstrtobool instead of treating it as an uint
 v2:
 - Turned the profile mode atomic variable into a boolean
 - Rewrote the sysfs file's uAPI documentation to make it more generic
 - Improved the casting of the profiling variable inside the Panfrost device structure

[2]https://lore.kernel.org/dri-devel/20240302154845.3223223-2-adrian.larumbe@collabora.com/
[1]https://lore.kernel.org/dri-devel/20240221161237.2478193-1-adrian.larumbe@collabora.com/


Adrián Larumbe (1):
  drm/panfrost: Replace fdinfo's profiling debugfs knob with sysfs

 .../testing/sysfs-driver-panfrost-profiling   | 10 +++++
 Documentation/gpu/panfrost.rst                |  9 ++++
 drivers/gpu/drm/panfrost/Makefile             |  2 -
 drivers/gpu/drm/panfrost/panfrost_debugfs.c   | 21 ----------
 drivers/gpu/drm/panfrost/panfrost_debugfs.h   | 14 -------
 drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       | 41 ++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
 8 files changed, 57 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panfrost-profiling
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h


base-commit: e635b7eb7062b464bbd9795308b1a80eac0b01f5
-- 
2.43.0


