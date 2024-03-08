Return-Path: <linux-kernel+bounces-97197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED38766C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABDEB211DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041E1CD20;
	Fri,  8 Mar 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EzhGPudl"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480F20314
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909784; cv=none; b=rvZFBeWK1c8wINrSEOAlMM58Y4fBO6nOZuNt61/p8bPOviVqL2hw+jjDAkjgA+ZQUaawRanE+rrDI6pCBJA/KgUxy2vgHQKcE5I+YxYLztzsQQ/5c3GklcF3Q46g4qqe9Ps+/gmcP1ZF7C4PkUPIIZrGMH3Af1OWFm+7hsFckxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909784; c=relaxed/simple;
	bh=y80heCwbhAQqqtJAfYk/nrQDwtR1qybFYBcIOVhCOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhpYWj6F74CzwDUYPS0F4fnBGABBja4JasSRZNj4JdspfSBrT3ImmkRhNZuIODSS9wwoDW0++yBvrA0Y/Uw2KFo7ut6uDeXPu5cv6GYAVlLRa0cl9vIwthH/ueC7hjz42+senFQaxpXmNxfJE21FuTS4557EUTH/TP+61fWhWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EzhGPudl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yRF44PAwuObJjETXmhstoHPr/yI6S4jcqxgx+14ydL0=; b=EzhGPudlVcIyYE0mO/lcVrqegM
	F8nFLKO3qO83O6C/zNC/BB2q4TzqXb5kf+kNT+CdO5/fRtyxL6sfEg2XCz21VVJUnquqldXqqiJb9
	EnXVU12DNjwcv8jlFotFRw+IZLh7RPOW1nKl8ROwBGT4pHtjeRYzcp7UmimWfRD6CIIM1CjgfYiT1
	4xWSIKCJfKsF3gucCVzoIq6JV8DoO7Jr2+6ww0RGsGJ/qZF3O5TwD/3v+AEZMS9lga4BjM0v5Du/q
	OUeigFkntJ9NPX82nexlacVgHWbeuldHjWKCI3dIHA750BEtePOAOLdtu/VNjxcCs+SfuKob8eyY0
	0Kf/oeng==;
Received: from [152.249.135.210] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ribdz-007p93-2D; Fri, 08 Mar 2024 15:56:19 +0100
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
Subject: [RESEND PATCH v4 3/3] drm/amdgpu: Make it possible to async flip overlay planes
Date: Fri,  8 Mar 2024 11:55:53 -0300
Message-ID: <20240308145553.194165-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308145553.194165-1-andrealmeid@igalia.com>
References: <20240308145553.194165-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu can handle async flips on overlay planes, so mark it as true
during the plane initialization.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..dc5392c08a87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1708,6 +1708,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 		unsigned int zpos = 1 + drm_plane_index(plane);
 		drm_plane_create_zpos_property(plane, zpos, 1, 254);
+		plane->async_flip = true;
 	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
-- 
2.43.0


