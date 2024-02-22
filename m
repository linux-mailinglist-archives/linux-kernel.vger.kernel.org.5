Return-Path: <linux-kernel+bounces-77061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E28600B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637F12847BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6115A480;
	Thu, 22 Feb 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3zBTaDI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC515957D;
	Thu, 22 Feb 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625671; cv=none; b=hSFiFrP7TCblD6x4f6rD5Ju8ZXKtZmzdB7K0AKTPsWMaFCtteLVdSMczn6s5iiVzHDaQodxEW/xQk6/Fey+UGLNdJ83qt3iBy2JVSYv9Pibu3ruf5uwTbV+Ym2V0DgfH1qA5BQoEv/iArp+BYQx4kH77nTRVYFYVk9nrcl704Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625671; c=relaxed/simple;
	bh=kHekB7+ds8HZQmTIIDcT/8myymC9mYLsud01YExrJOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kT51Pu4wmSwkiZThDmk/AsOdqES+RYOGlNG3VBhRRmD01RPqjZ8tw+fP4ueGDXaLaD3YidfZFci4q7Osq83d/5oF66wPxyhJKnU2BMBdSXpVN8NDwzi8qh2Sg5UW7sLS2iEySLB8dElWfUv4oAjO9DTBRYHsTQV+Ekkw2yn0OX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3zBTaDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C23AC433C7;
	Thu, 22 Feb 2024 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625670;
	bh=kHekB7+ds8HZQmTIIDcT/8myymC9mYLsud01YExrJOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3zBTaDItjm2XsKVKjxzwnBiuzy4wNXnVf4UYigdnUHlIBqP105EyAoYw1osMwpJM
	 aMnUJvo0HCmK4cFpqouGt7Y8kLbOsY+EGzHu4rJO1W69bpA3nVT7ZPJkW8p/2DmLEP
	 I6uBgaVc+ZJ3RwKSHbHsp3LLzfj1dyhWKUphOwiMb+//cxELWiEKcQ/n44G14DmEKb
	 8fyx883D8W1OmsOof61Lda6qUjkPeQf2KnnvgI+LX2E0WcZLCc4RhaRu1uqsRBwiEn
	 iSsaRJjCa7Bv2QUUN1U5erKp4Ara5IzUddvlwcvwior7wpnawQYD5kN0+oaQIwnPSi
	 MDoICaAnAGe+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:13:47 +0100
Subject: [PATCH v7 01/36] drm/tests: helpers: Include missing drm_drv
 header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-1-8f4af575fce2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kHekB7+ds8HZQmTIIDcT/8myymC9mYLsud01YExrJOg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnX+14+OPGD65yaVsrXhVmJuUeYFHZas6m/kLWwjn/uM
 e2Q+QW2jlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzE6Cojw8dX7G+ZpRLPTvky
 72jM/sy/Xqt2bxLjSFZ5zHvgq6fpOROGf3bOQpurI/9sPsWz6HlQz6qaOm62E3fYiyTfejJ9UOr
 2YQAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We have a few functions declared in our kunit helpers header, some of
them dereferencing the struct drm_driver.

However, we don't include the drm_drv.h header file defining that
structure, leading to compilation errors if we don't include both
headers.

Fixes: d98780310719 ("drm/tests: helpers: Allow to pass a custom drm_driver")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_kunit_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ba483c87f0e7..3ae19892229d 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -3,6 +3,8 @@
 #ifndef DRM_KUNIT_HELPERS_H_
 #define DRM_KUNIT_HELPERS_H_
 
+#include <drm/drm_drv.h>
+
 #include <linux/device.h>
 
 #include <kunit/test.h>

-- 
2.43.2


