Return-Path: <linux-kernel+bounces-162761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731A8B6035
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15691F2120C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBF86AE3;
	Mon, 29 Apr 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u0N6tblE"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706F8614C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412132; cv=none; b=gZ5M/9o2You5M7QhIOktDp7T57A0h3GwrZGmDbsb0y39nJopKwwm65CX9t56iJJmVS/WtAPAjkA4vdLPuYxeBUPcfzsFcB6D9pgH3Gu/LBEBiBYfWMl1cipzdZxLRtooUIFKnM04wKq97cbojSw5hfgpl8L7695kqS2pJVsIchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412132; c=relaxed/simple;
	bh=dOUe2WWZzlqk8YBktPP4n23wAwUymxMP3IYBUIaW6XE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMAIFvg5iWoZAb2MKLrCElG8onQtyresXURjy6YbY2YM23yhYQjqLCUj9w/isOPxCrBHjNhnWmVSLrHdgoLTd+AHC3RqGMvcP3VqeZUEmIUAJGgljV3lYrclniBL1buNPJDjrAhS68/X9XikfYO0ZnSMZEyICpCv+1JDP6KWyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u0N6tblE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714412128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n0mr83jQFnbS/LkT/ppLN9l+vhlOUacudDF+vKeopdw=;
	b=u0N6tblEIt128FzOUGXN46EKaYoLHh9F+OyQOHRxcnKwKywR5h/zwb27HJAQ0TaS0TWucL
	AnBthNT9fyVV73vfCeLLLEWAjbt2+PD8kpQ9hEBbfXIVIPVUCfCh9e4aWxRzrmXGPaBX8A
	A+k7Gcnbf+i3tQtBP4G8KomY946lgLc=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm: drm_of.c: Using EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
Date: Tue, 30 Apr 2024 01:35:21 +0800
Message-Id: <20240429173521.709719-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Linux kernel puts strict limits on which functions and data structures
are available to loadable kernel modules; only those that have been
explicitly exported with EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() are
accessible. In the case of EXPORT_SYMBOL_GPL(), only modules that declare
a GPL-compatible license will be able to see the symbol.

Since the whole drm_of.c file is declared with GPL-2.0-only license, so
let us keep functions in that source file consistently.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 177b600895d3..1ca36d654e61 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -44,7 +44,7 @@ uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_of_crtc_port_mask);
+EXPORT_SYMBOL_GPL(drm_of_crtc_port_mask);
 
 /**
  * drm_of_find_possible_crtcs - find the possible CRTCs for an encoder port
@@ -77,7 +77,7 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 
 	return possible_crtcs;
 }
-EXPORT_SYMBOL(drm_of_find_possible_crtcs);
+EXPORT_SYMBOL_GPL(drm_of_find_possible_crtcs);
 
 /**
  * drm_of_component_match_add - Add a component helper OF node match rule
@@ -181,7 +181,7 @@ int drm_of_component_probe(struct device *dev,
 
 	return component_master_add_with_match(dev, m_ops, match);
 }
-EXPORT_SYMBOL(drm_of_component_probe);
+EXPORT_SYMBOL_GPL(drm_of_component_probe);
 
 /*
  * drm_of_encoder_active_endpoint - return the active encoder endpoint
-- 
2.34.1


