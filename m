Return-Path: <linux-kernel+bounces-41963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CB83FA11
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2751C21880
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0273C486;
	Sun, 28 Jan 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Tj4qXk8M"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B11DFD9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477137; cv=none; b=TqzLjTDmWNZskOPjchLa24y2oZ+ai6u2vt6H8tK80qDNiEsHr59qv0SC8emzpPFRgI+RNLhU9j3vq0lpaWBeMWQMk6r4ZqWopY7WYZKlnYz1E0+870gMpIDqwk0pZkoaYYgibbKPjEMZEF4YZNmGeGp2TdaCZVsmxVId2oPVdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477137; c=relaxed/simple;
	bh=qZP50DNmV6i1En0HHhsG+38vD8v/gyaGde7BMOi1FMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T9mImumcL8T8WpmPhZHitVr0S7ZEmGApmJBrZQG3EM8qYjk6AVlwH1BqrqTECcbDn1/qDtaYMjickVuK/Pue3NhIwIjE7NzqzwWl9qIBX9PpnqIMj1pdARYQkTezV1azhbR8XPlsO0QLboE3hjxF1nWt8i15zzcGDmcmTyxh2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Tj4qXk8M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MNiq0HNP4Q9Rqomb+cMUTJBSTivA7YPuGDdGMrmslc0=; b=Tj4qXk8M5MGR2/SV09cUxgKkji
	PdCr4hKuDhjJIBXLeGZ/XFYbFKr+eTPPK71e2cF0+DKbH30y7ZWmikT9C8ApW69kHrtrDWoMopApS
	By4xFIiOnrLlI/MLfMyG+bzobIb4X6zdVpJ8Gisb4ye3EYAagSF6Vw5fZOSwO5fPHhOetySdfLJym
	w/aEkWAYhlWIKU0wJ2n2gvYT5yqN4NQrbTlFqKh35Sa6rv18BOvZ0hBCCL2icXCDyvEYPDlLUFOdL
	junGRoQIvRmdXe5glxcAWtxj3HGDGMtPWxScL03NwkSu0fzoFDehFZ61X/yoGlemuN3QN8nJ8TuP3
	ZtYygtSA==;
Received: from 201-42-129-61.dsl.telesp.net.br ([201.42.129.61] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rUCeY-00B1M8-Gj; Sun, 28 Jan 2024 22:25:22 +0100
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
Subject: [PATCH v3 0/3] drm/atomic: Allow drivers to write their own plane check for async
Date: Sun, 28 Jan 2024 18:25:12 -0300
Message-ID: <20240128212515.630345-1-andrealmeid@igalia.com>
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

AMD hardware can do more on the async flip path than just the primary plane, so
to lift up the current restrictions, this patchset allows drivers to write their
own check for planes for async flips.

This patchset allows for async commits with IN_FENCE_ID in any driver and
overlay planes on AMD. Userspace can query if a driver supports this with
TEST_ONLY commits.

Changes from v2:
 - Allow IN_FENCE_ID for any driver
 - Allow overlay planes again
v2: https://lore.kernel.org/lkml/20240119181235.255060-1-andrealmeid@igalia.com/

Changes from v1:
 - Drop overlay planes option for now
v1: https://lore.kernel.org/dri-devel/20240116045159.1015510-1-andrealmeid@igalia.com/

André Almeida (3):
  drm/atomic: Allow drivers to write their own plane check for async
    flips
  drm/atomic: Allow userspace to use explicit sync with atomic async
    flips
  drm/amdgpu: Implement check_async_props for planes

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++
 drivers/gpu/drm/drm_atomic_uapi.c             | 63 ++++++++++++++-----
 include/drm/drm_atomic_uapi.h                 | 12 ++++
 include/drm/drm_plane.h                       |  5 ++
 4 files changed, 92 insertions(+), 17 deletions(-)

-- 
2.43.0


