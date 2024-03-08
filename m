Return-Path: <linux-kernel+bounces-97194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BEA8766C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814831C21070
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80149539C;
	Fri,  8 Mar 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H5AgBLhs"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149D139B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909771; cv=none; b=r9tHLbs+tcV/ocogVMphtIml8sfACpMnXGKq7/NLrRwX73c1QEL8edcvo/HP2CFIwmo8+YI6kz5pc88lxSMwvGDHsyZR3ZFMbJ5X0ZJ2/dtO30VL9upANqMyQqrCRK3lDILsO1bB2v711oUEtTD8ziQotRVri7cdeD6GBGhzGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909771; c=relaxed/simple;
	bh=aFKaEtHT7WyXEPskslqxQKDMgPIVsPSsjkX6+5U4kdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NimEigSuvxGMS/9T1alVVWa5MH8CxqkcIgV7e2Ef6/lxFp9yvhKff85SRZaxct+MBRdR9vQ0/O6vg0PeiwDlWzpkI9em/AGQtdLhq0N0KiUlxNCfWXYFVd39I3RJoGCMCb+CN+WJOKjii6+B8ZHr9pWDBhTnj/bQlPFgJdHn7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H5AgBLhs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kyFdaFZn5fxDlyBsRXk/mw238QRIyiO/3fj7J8kHjNw=; b=H5AgBLhsvkRfuIv80r18F6uxFH
	3mzommNNDYBDIa5KLMtTPW6A5YvjaC8R4DrshbDWekHaNBgehR+Ma49Vfw9MsFghc2n53IhMhwK04
	f1PEIbryunTIUbqr10vnICOY7r1+IjQHdqxW+jf1lI8r4MXgIZRwZeVF3dmGn6/z80cDXgmbFl7z2
	SrcRx33EVFIpCritGKEkOJQDPr7vHoQg8/O4nF0B8oMvJiR6KGsq3I4vRigdse5hlwJvYGNDjiWST
	0BPx6FGB/Imrbi4MW08qlT4ovr2DNTnYPeqMj52laQEBWBOdLndkwjh0PDDM0CE8OmomLdSUfPyZ/
	/eU+yLpQ==;
Received: from [152.249.135.210] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ribdg-007p93-HA; Fri, 08 Mar 2024 15:56:01 +0100
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
Subject: [RESEND PATCH v4 0/3] drm/atomic: Allow drivers to write their own plane check for async
Date: Fri,  8 Mar 2024 11:55:50 -0300
Message-ID: <20240308145553.194165-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.44.0
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


