Return-Path: <linux-kernel+bounces-58695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4084EA12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA351C24B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE84F1E5;
	Thu,  8 Feb 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bPVMvjuN"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105C4C3BC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426371; cv=none; b=ekszSFrq8vFSUAco4t9yHw0cWMDRgMWHMh2bgS7aOF2tzMtS2IHXk4ehj1DjMpfYVaxkVsx2Mpc4PCLm8VO3NtV1XH31IPQJu+nrOz84PafC1VzjngHHcf87wc1dZauOW74PAZ02a4Dnz0lnJVV/z6giOz+LhEfbmFBok8STuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426371; c=relaxed/simple;
	bh=aFKaEtHT7WyXEPskslqxQKDMgPIVsPSsjkX6+5U4kdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKyNTQf9WjjWqc/I2tqt0rYvsuaEfAPgOJ/D8R1RCI3Xoj138xtxGqOOsMpy3tfKRrBDNh2JwYPl6f2IGOhSMliaFw7ZgoUv3WkPnS/UapZirUD0/nC8oZarftqo43mXwjGACBLbX5PTyth1BrciW3lh7W//OK+XfkumUVspauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bPVMvjuN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kyFdaFZn5fxDlyBsRXk/mw238QRIyiO/3fj7J8kHjNw=; b=bPVMvjuN+0OiIcqtRCnCv2qXcQ
	VAxWA+DDjI9bpmt4CiVU4Ac8fEHRJSjJFrdbIdDiYNwvw3H0o8Pv4f1pKTXV7UjoGj0G4YjG1TqmJ
	dqqi1KNO7NkfPdDq0hmQYpsxDu5JNv9W4LALJCRJMzH836YDGu8j6wyOoOBjNeYP/09BEt+zJf/+o
	zA6fEfVqC41T22xFVkfqooE1CTg0k6fdXh6YaNTzuL/iyFFh6u6fVbQPo1+9PFSO+pQA4ToHWVLos
	nUvIIGaTBPedsneHdQjkWIa52dooBitg3MwbIqvEdV80ymjRMl/83Aas/Nb6sApw1MhbCajY44/qn
	hffwKQhA==;
Received: from [177.45.63.184] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rYBak-00FMBk-IJ; Thu, 08 Feb 2024 22:05:54 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/3] drm/atomic: Allow drivers to write their own plane check for async
Date: Thu,  8 Feb 2024 18:05:39 -0300
Message-ID: <20240208210542.550626-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

AMD hardware can do async flips with overlay planes, so this patchset does a
small redesign to allow drivers to choose per plane type if they can or cannot
do async flips.

It also allows async commits with IN_FENCE_ID in any driver.

Changes from v3:
- Major patchset redesign 
v3: https://lore.kernel.org/lkml/20240128212515.630345-1-andrealmeid@igalia.com/

Changes from v2:
 - Allow IN_FENCE_ID for any driver
 - Allow overlay planes again
v2: https://lore.kernel.org/lkml/20240119181235.255060-1-andrealmeid@igalia.com/

Changes from v1:
 - Drop overlay planes option for now
v1: https://lore.kernel.org/dri-devel/20240116045159.1015510-1-andrealmeid@igalia.com/

André Almeida (3):
  drm/atomic: Allow userspace to use explicit sync with atomic async
    flips
  drm: Allow drivers to choose plane types to async flip
  drm/amdgpu: Make it possible to async flip overlay planes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 drivers/gpu/drm/drm_atomic_uapi.c                       | 8 +++++---
 drivers/gpu/drm/drm_plane.c                             | 3 +++
 include/drm/drm_plane.h                                 | 5 +++++
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0


