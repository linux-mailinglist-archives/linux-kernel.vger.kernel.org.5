Return-Path: <linux-kernel+bounces-165695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D998B8FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AFC1F23DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383141607AF;
	Wed,  1 May 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RRVqkC8P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0337E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589457; cv=none; b=ZQqp9A/fe+xIG6JUFY67moNvGpWox50pNW/0GpMZRo6tctn4sf/52I3ZBzDT85MvduLox4usbHiNHLQwoQa9caatmeaeUJN1hrQItOZA80hh9PToyIaQy9Y3qrbROvNOBxc/zoxZquiyACpbd8Wl2Fur0lrHRSdQpw7U6ONSc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589457; c=relaxed/simple;
	bh=iXioOwjNVyjF8VZrGx4GWEFnxOxL2Al4w5WomiTPGIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y33kTh/nkglcQi218Aav99NsydjPztN1e8QTn6iiBwVi/wYumFnwuVels1tkHwG2aojPUzoctwyqKayi6Fi96LYyrbV1WccfOZks7bOexhxto5HRcn5d1HPYCXuYAIj3689DfW5MaeZxAfD/BiWEFEOVh/+UzAipCd6LIiSUBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RRVqkC8P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714589454;
	bh=iXioOwjNVyjF8VZrGx4GWEFnxOxL2Al4w5WomiTPGIU=;
	h=From:To:Cc:Subject:Date:From;
	b=RRVqkC8P/rsb+dbc/R1mwGtLHmaiilP1yUkEgAO6/m65eyY8/7Ub7SZcFe+wbIzKb
	 OE62C0EToDkoFZPP3RZJvjwVuoyXVIpsGm8+nB+Zt0sCufo/964bgtDOKQZvOINHn0
	 LRBwpF7ZcM6+48vlC2tXxACeEbBXDqFfsfHiSE1fqZKYUzkN9tPbAoNR5mi+ylEjAW
	 T6iPuJWBZTQeiYPaCofwbiHE1g7KeUIU2q5OtCv8j1BuML0Bm2mvfQEObIuXmTQ3ub
	 C1rFgjp+u5n1kstG8kaPcsWeceSoJjLbP9+tDA+IzX12vccxS9V0skRoVNtfNvZ2SK
	 T5kf3N0zmQlnA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1D793781F9A;
	Wed,  1 May 2024 18:50:53 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] drm: Add ioctl for querying a DRM device's list of open client PIDs
Date: Wed,  1 May 2024 19:50:42 +0100
Message-ID: <20240501185047.3126832-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the patch being discussed at
https://lore.kernel.org/dri-devel/20240403182951.724488-1-adrian.larumbe@collabora.com/

In the original patch, a DRM device sysfs attribute file was chosen as the
interface for fetching the list of active client PIDs.

That came with a hosts of problems:
 - Normal device attributes can only send back up to a page worth of data, which might
 be not enough if many clients are opening the DRM device.
 - The binary attribute interface is meant for immutable virtual files, but the list of
 active PIDs can grow and shrink between successive calls of show().

This led me to believe sysfs is not the right tool for the job, so switched over
to a custom DRM ioctl that does the same thing.

In order to test this patch, one can use WIP branches for both libdrm and igt at:

https://gitlab.freedesktop.org/larumbe/igt-gpu-tools/-/tree/drm-clients-ioctl?ref_type=heads
https://gitlab.freedesktop.org/larumbe/drm/-/tree/drm-clients-ioctl?ref_type=heads

I've only tested it with gputop, but intel-gputop should work also.

Adrián Larumbe (1):
  drm: Add ioctl for querying a DRM device's list of open client PIDs

 drivers/gpu/drm/drm_internal.h |  1 +
 drivers/gpu/drm/drm_ioctl.c    | 89 ++++++++++++++++++++++++++++++++++
 include/uapi/drm/drm.h         |  7 +++
 3 files changed, 97 insertions(+)

-- 
2.44.0


