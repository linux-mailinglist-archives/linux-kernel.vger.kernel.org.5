Return-Path: <linux-kernel+bounces-164977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D98B85C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191B8B2250B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028E4CE1F;
	Wed,  1 May 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yuTqdv0+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1537F;
	Wed,  1 May 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546620; cv=none; b=QPEQo6xlkp431QQR6Ip2jTJV4o8A8dbwM6vkM4uzqbJRvM5Pb6zr99q/zAASuSzplk8t/vfcel2658AokRUII3IqqqhWoFQTm9sQ88wdQfRKF9MB/BVvsl/oQiZ8aycuhoTIHBz7m7kVRT+7CV4tjRpM0idR6eUd5KAKgLl7T+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546620; c=relaxed/simple;
	bh=+gpJXoDEqYzBuZulQbczBn4Pg+8UdQjqkKQDhtgftuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=danZ7ljiAYcWRqJRBx/cU2t/56ekWpX/eOMDN+S/ckCUcd53UZQOO9cNakhpZ2Ct1Fgk10/pItMkUjKkZgJ0/TTzYt+vba8fmFekaoFZgQtcd36PbgRoWkFoaAja7kVHE9K9LXQX1SvgjfEst/vePYqILwXQ7rrWAzfcuOijqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yuTqdv0+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714546617;
	bh=+gpJXoDEqYzBuZulQbczBn4Pg+8UdQjqkKQDhtgftuY=;
	h=From:To:Cc:Subject:Date:From;
	b=yuTqdv0+509GARpdGOcAmrDFIxTdHACNuq70OZV/uZkrBBYLeXnkdHQppBi+f1K0w
	 XhJvjKC4KJhIUNFstpRB1834LTcx959ulNuv/8zpD3sObav68v7HSdZkBmjxd8IrjM
	 nfcPLv0yYiZ0ols0ubim7uB8TGHHVgiI3WE3mgo4yf3fHxVt8nRznYThiPm5yoG4HC
	 dtO83IN9gN+qkr8cVynrVFxUpn4clCfMkbP6Pe1ap7foEK93Uw64rV/LIrE1qPO+YN
	 nRSNJ2xO/fsIrFzjtP3oc2PicaCDckOy3HyqIGRYot5U0iNqVKczLMLrs1tPHQTnsm
	 Twy98Bk3lgeKg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 43E7E3782087;
	Wed,  1 May 2024 06:56:56 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Qiang Yu <yuq825@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Koenig= <christian.koenig@amd.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 0/2] drm: Fix dma_resv deadlock at drm object pin time
Date: Wed,  1 May 2024 07:55:58 +0100
Message-ID: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of https://lore.kernel.org/dri-devel/20240424090429.57de7d1c@collabora.com/

The goal of this patch series is fixing a deadlock upon locking the dma reservation
of a DRM gem object when pinning it, at a prime import operation.

Changes from v2:
 - Removed comment explaining reason why an already-locked
pin function replaced the locked variant inside Panfrost's
object pin callback.
 - Moved already-assigned attachment warning into generic
already-locked gem object pin function

Adrián Larumbe (2):
  drm/panfrost: Fix dma_resv deadlock at drm object pin time
  drm/gem-shmem: Add import attachment warning to locked pin function

 drivers/gpu/drm/drm_gem_shmem_helper.c  | 2 ++
 drivers/gpu/drm/lima/lima_gem.c         | 2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)


base-commit: 75b68f22e39aafb22f3d8e3071e1aba73560788c
-- 
2.44.0


