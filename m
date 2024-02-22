Return-Path: <linux-kernel+bounces-77064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F48600C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD04283C12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403115AAC6;
	Thu, 22 Feb 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+M5ANkB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9915AAAA;
	Thu, 22 Feb 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625674; cv=none; b=gVnzCdmi/8vKkA9DdZBtPfThwOUIlqgUi+iw8+lrgmVClZSUZN/Cvsy0uTCsRcJ/xxtF0tUO0fvY0Ve8/U+r9sI9f/0CZ42QvcFnvtytH+mnosetnBeeSJtEnlQuBQwWAx8mHY/isx0oAozfOUvv+tzr5MfMSqI7dUCkK4do+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625674; c=relaxed/simple;
	bh=TPv8mjAc7k5WixCBRXHynM6H/AaB/bUbe1H5MJSrFTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6qHN3zItMNj5J8LKUF/Cz6KMRCc5jUj7qLKst4l0Y9tRjkZIrZmDmls1MrbbqWqWqZ8dcu55CY9TonOXWji3WkdAdrONJDmUSL3D5CQOZEsOardBz4JcXlES5rOCdF3kQnKZMP0YcwQYndNXvy/H4mYNHoKDINY0+UGjoHZpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+M5ANkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CADC43399;
	Thu, 22 Feb 2024 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625673;
	bh=TPv8mjAc7k5WixCBRXHynM6H/AaB/bUbe1H5MJSrFTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X+M5ANkB1G/XImwHDpav6Puqp1tOivphrSFKAYvmOdJchFlHyCPJYfTXMrxPNi+Wo
	 Xi5p2qC9Q92a0AH97//XjY6qjSMO0pzcsMplhKKuHRAp1/CqdU62EflPbnWwI1NHpL
	 iMgRNV2C3AoV7bcRuCBbhihhYOGTyP9b/j9oB/of4n8ncIufeKXgVJXY+fOJF67P7T
	 SP3Ecy3Hpc1uA2/A7mPcdN+szfNbAFddDScakVfzxdnXN0yizutE9sfcQP5w1UuOfO
	 y/MM1ie2l+ekMhxnRguIo1l6hd2rWld2YAFHsP5Yg2I5vyTn100oEuAB6E6Q3s5smY
	 DT1CAmYDF8+JQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:13:48 +0100
Subject: [PATCH v7 02/36] drm/tests: helpers: Add atomic helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-2-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TPv8mjAc7k5WixCBRXHynM6H/AaB/bUbe1H5MJSrFTQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnX+17F6uVucBPQ2WjBInZLQdLzjvr37ZceBBx8Ei6y/
 9tibRnRjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkpyAjw7GvS26/03vapBp3
 bfr1pd/XHs1av5C7ZnvFwfhDn96/aFrIyPBO/Z2sBptBi2LkPzHmdT0fdRIXNsttmvNX64XIVPa
 zbpwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The mock device we were creating was missing any of the driver-wide
helpers. That was fine before since we weren't testing the atomic state
path, but we're going to start, so let's use the default
implementations.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index ca4f8e4c5d5d..4fb11b938bc1 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -14,6 +15,8 @@
 #define KUNIT_DEVICE_NAME	"drm-kunit-mock-device"
 
 static const struct drm_mode_config_funcs drm_mode_config_funcs = {
+	.atomic_check	= drm_atomic_helper_check,
+	.atomic_commit	= drm_atomic_helper_commit,
 };
 
 /**

-- 
2.43.2


