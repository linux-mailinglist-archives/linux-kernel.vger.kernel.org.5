Return-Path: <linux-kernel+bounces-102522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD087B34A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20C31C22A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278657863;
	Wed, 13 Mar 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVVLp0ng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B45787D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364347; cv=none; b=sttEp3ZnvpEjqbaH4D03g6PREC/nEV3XAFleV3H/qNzqdtC/1GW1nXMCUTjSquzO6G2w/dCuLzdfo3385DfrxaCOG0lr5vbLHvB3Tno/Nwi0iN93gjinwBMnm0scyUnqo4pNupZ4RuQnfw7xx6qqC4radwSh5k1MKEyo89+boX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364347; c=relaxed/simple;
	bh=pn/5tZr/4USUk6Xl24wnyddCOFjB3FKvA39M4UJsywA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hR8XAopygIob16GR5RiyPMSTK5w4eSMKnl0hunYRe0y2DjPG7CXc2FbvQcFpBORsswoBskZaFgjwX6xEMm4bmRCgL47/+PzLh9zbPgwC1STUyMrD5fVfA0136R4ORaMsNi+rES7qHX/ztxiCrAlk1O1Fj/u60bScRVXMAcDDxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVVLp0ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D14B7C433C7;
	Wed, 13 Mar 2024 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710364346;
	bh=pn/5tZr/4USUk6Xl24wnyddCOFjB3FKvA39M4UJsywA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OVVLp0ngrjEYvpCQp85XBLMBGVNfeDd+jUm1srgzNoDnDyDrATHtsTaMRJjDAAz2n
	 SPeyfyN7XDvrFM+pP7Z+KpTTVBqgUNDZ7GFoWQOb2QQrA76SAEWW+KtlK2WVAzkOaW
	 Mu9v6lAeldFor/kreLZP+qeO0g4rwAibD5qiBg9RAjP1Ips659p0GcW48VRG7DiRK5
	 hD1HAC7qg6ex8Q3POGlp08U/W22rSypG+5WAqBr9HK6wf96Y+Voyqn1sopodg9ZUDk
	 4UlsgSRl8f+r0yKyJ6L5H5i3x87m2AIegX2RRgvNCwOFC5wBP7rfuwxvfRDWkJ3FQh
	 JiMVjoweSBAQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BDFC54E66;
	Wed, 13 Mar 2024 21:12:26 +0000 (UTC)
From: Douglas Anderson via B4 Relay <devnull+dianders.chromium.org@kernel.org>
Date: Wed, 13 Mar 2024 14:12:14 -0700
Subject: [PATCH] drm/panel: atna33xc20: Fix unbalanced regulator in the
 case HPD doesn't assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-homestarpanel-regulator-v1-1-b8e3a336da12@chromium.org>
X-B4-Tracking: v=1; b=H4sIAK0W8mUC/x2MywqAIBAAfyX2nKAl9PiV6GC12kJprBZB9O9Jp
 2EOMw9EZMIIffEA40WRgs+iygLm1XiHgpbsUMlKy1opsYYdYzJ8GI+bYHTnZlJgYfXUdtJmNDP
 k+mC0dP/nYXzfD1GOg+BpAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710364346; l=2015;
 i=dianders@chromium.org; s=20240311; h=from:subject:message-id;
 bh=/jgB/LgJDly6Altvbipo14aZmr/j8F+XuDmbB4fICv0=;
 b=ZSkyjZHVIxke1plTs0iVfALVXhp73xvZV1inGwLQ3nW5eOV+sfMENciF2dYF1l2+2oZFBEoiT
 vi6lBPds8GkA6mNzmas1XXWF4TafE7e2SSJw22U5dDDFyN3gdum072f
X-Developer-Key: i=dianders@chromium.org; a=ed25519;
 pk=3pyAfvsLkkkp4Xpq0XV7ZHOoA0WmPoJTE/BIAhunPKg=
X-Endpoint-Received:
 by B4 Relay for dianders@chromium.org/20240311 with auth_id=138
X-Original-From: Douglas Anderson <dianders@chromium.org>
Reply-To: <dianders@chromium.org>

From: Douglas Anderson <dianders@chromium.org>

When the atna33xc20 driver was first written the resume code never
returned an error. If there was a problem waiting for HPD it just
printed a warning and moved on. This changed in response to review
feedback [1] on a future patch but I accidentally didn't account for
rolling back the regulator enable in the error cases. Do so now.

[1] https://lore.kernel.org/all/5f3cf3a6-1cc2-63e4-f76b-4ee686764705@linaro.org/

Fixes: 3b5765df375c ("drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct drm_dp_aux")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 76c2a8f6718c..9c336c71562b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -109,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
 		if (hpd_asserted < 0)
 			ret = hpd_asserted;
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Error waiting for HPD GPIO: %d\n", ret);
-
-		return ret;
-	}
-
-	if (p->aux->wait_hpd_asserted) {
+			goto error;
+		}
+	} else if (p->aux->wait_hpd_asserted) {
 		ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Controller error waiting for HPD: %d\n", ret);
-
-		return ret;
+			goto error;
+		}
 	}
 
 	/*
@@ -133,6 +131,12 @@ static int atana33xc20_resume(struct device *dev)
 	 * right times.
 	 */
 	return 0;
+
+error:
+	drm_dp_dpcd_set_powered(p->aux, false);
+	regulator_disable(p->supply);
+
+	return ret;
 }
 
 static int atana33xc20_disable(struct drm_panel *panel)

---
base-commit: b33651a5c98dbd5a919219d8c129d0674ef74299
change-id: 20240311-homestarpanel-regulator-f4b890ff4b7c

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


