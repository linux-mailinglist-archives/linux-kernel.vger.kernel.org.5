Return-Path: <linux-kernel+bounces-154893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F278AE2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A127282C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E87E78E;
	Tue, 23 Apr 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDsW3ZW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2D612EB;
	Tue, 23 Apr 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869152; cv=none; b=gDOSCRkxirhCWPAYCQYZF+3ZhbIn5CLB5e/4vrUTHfICQZ4Klvue2MHgNUUlNL4oP0eggcGXDmKHLvkneSm5Q0ZNix4yVpzeAptw44K+PIUoblHTEYnshiRbCiP8RcG17GdkNj+/4YsilOHz8AlMzZkr6aZaAEAiNlqTe7PL5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869152; c=relaxed/simple;
	bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik4qbsrNRO/syYxZbwee7A1iuoDNh6CG4K1TdCm7fEGUFs551HwbLJB07ittVTYY8mtXwg7HqH6nG68HWZnvHq2TY7EV8eeIqVpTEuLscVzN+IlxeVTlLPYiIBn/ZaHn1Y8M8NBojduk+1/qk3gFFCoQ4pPm/mNa4Xbo47Qa3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDsW3ZW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC45C4AF07;
	Tue, 23 Apr 2024 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713869152;
	bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rDsW3ZW84snUYVaIDg/CIDZZuOWPCLi/XsXzkkoHlYAli9XrlY0I/hg4vVaAmjWbI
	 TSTgmhJco50fUGDtCLaAxFoFwn17SeQPMkOSFNg3rA5fhKlVUaWEGH+848sXI8l57J
	 Io/Tooivr5a6c8bIcpM7l6nJyVMRLeivBxLTvByJwfXncB/bwRKaA7P6QhvTp9PWhq
	 0U7zUqK+5lMQHOGr2RvFBLzHD3ohz5WPPo3dfX/negfccHjDW/QnVJ8uEAGrr7ff0A
	 pHeWZpX8xztj5i/1PN4cB56Zz9rCLd+ZylDu43PmXDm2RVfPIACgTVPFXeq12FrPhi
	 O0YGHnuXKlLDQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 23 Apr 2024 12:45:31 +0200
Subject: [PATCH v12 02/28] drm/mode_object: Export
 drm_mode_obj_find_prop_id for tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-kms-hdmi-connector-state-v12-2-3338e4c0b189@kernel.org>
References: <20240423-kms-hdmi-connector-state-v12-0-3338e4c0b189@kernel.org>
In-Reply-To: <20240423-kms-hdmi-connector-state-v12-0-3338e4c0b189@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGnqE71nJhYLv1rX9s18+qI71qx57l6zb3Tene/owG18y
 KHi1R+9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARoW+MdQpprxdsXLb+QnbT
 rOkpX+yeuZsvOKmZn2T+5PifW9MTbc7tFr3Yzs/us+T+nrb9amWXPBnrA7O/Hvb22vKDkydz05Z
 H51pPOBmcPJ272YvRed5CGbb/6TqXrjI3rDAP5f08/aqpbaYMAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We'll need to use drm_mode_obj_find_prop_id() for kunit tests to make
sure a given property has been properly created. Let's export it for
tests only.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 0e8355063eee..df4cc0e8e263 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -476,10 +476,11 @@ struct drm_property *drm_mode_obj_find_prop_id(struct drm_mode_object *obj,
 		if (obj->properties->properties[i]->base.id == prop_id)
 			return obj->properties->properties[i];
 
 	return NULL;
 }
+EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_mode_obj_find_prop_id);
 
 static int set_property_legacy(struct drm_mode_object *obj,
 			       struct drm_property *prop,
 			       uint64_t prop_value)
 {

-- 
2.44.0


