Return-Path: <linux-kernel+bounces-94531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F887874118
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FF1F24EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA848144039;
	Wed,  6 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCh8Bkuz"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88178143C4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755442; cv=none; b=g4w7CDbjPEDd5PqGx0RhpN81c/dH+N+P5vL54+2lMwU9xRK9p5PI+CPh3TU+Q3hTDHefCJV/bq1YXVnV1z4jwi2Mno6dnBl6an9k58P7ntqJU/3mWKxGSDDExWbO+rNWnNkVWva2RntKkn6guLkywztyrGD7A7i6qtrmOsG7XW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755442; c=relaxed/simple;
	bh=hEpsavpaqhOCfUkMXmoZI8tqy+kyvROq31HXhJ/C6io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iyk1dbnXK/YJZILSx8sbpfnG3h8oMZH8DbGJNwd80EOEkpf/ZvDmLQkYtmeB+Vk1gkdWW4CGHmxZS9eld0My4w2/19L91AEynPFjfF+M+lkkbqiE1Qzpj0/tiaugm9uPhTn4E+MyPgtxLCmbqEDzVSoZ4dR4JPBHbaibb3kpJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fCh8Bkuz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e61851dbaeso73127b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755440; x=1710360240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcV5LiM2kdZ7H9iL9vZSs1WtOpfzFcM+Wcf+rllNpWo=;
        b=fCh8Bkuzu7bAXrp78sa6SrbHaKwHOLGLjJ8/S0y/ZPQBaXCiFsrEam2IML7+CKLHEM
         NS0oTG0ZBOsCLObei8KN2abSu4PJJXzyDVJ7tlt+P1IwAOo3Tn4Iyxoma8IyhYJ9TTs4
         v8jiR6ctl/6q60s1fRd19f0Vyr9Zfop/7/Zgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755440; x=1710360240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcV5LiM2kdZ7H9iL9vZSs1WtOpfzFcM+Wcf+rllNpWo=;
        b=MbaXMjOMDooEIyhFjBKPPwGShrj22hgIWLeGXNBjuMstNWY/5wZJLC1+qIkEb5OE+y
         Y2BJKujaUP6L+LiRBJ1/w1A7R4iB20twCdkgWbV0Z3MthDlXs6ReY3cfaIcz5pgO+6sJ
         mDwT1Sea7yJGiT+8UehTfF47ixHYKoPo00rcv06S4k8NWZdIhS1Eq8W3YZwDookDCTbO
         qwshv/SpS1Hd3S77r+lhF+G2iUB2bmiM1pQeDwXyDjaSx8YbJrX3XbP3387T0wBHBtbN
         RYjCOFWeSwWdaHwqIhpZj08YD6NbFjl0WaSouvEjmpeaop0msu2keGw0y42p7sKyCkOm
         ywSA==
X-Forwarded-Encrypted: i=1; AJvYcCVpx+TYPwkR+EmdPlL+t1tAgD7qkr4K3VWV9/zmDNWKk2qEs5URq4qRZ0QhwKIqWfEYsT079f06G90k8u7vckjYdeR6KIZ19w/O9XUN
X-Gm-Message-State: AOJu0YwflqECvyuKEGl8f3O0g96+COvn+Mc5L4tWdu51A87OrecXm5bt
	0yt7dr/uL39i6ahiH6uDiib43b5Ke5WEiZ00TUaa9XluYua1zxwklsHCtrvINA==
X-Google-Smtp-Source: AGHT+IFCgN8qo4pn/qojFIdZBRNxtgY9xf1gMLK7jbuggLu5VWKkK+6qu1VlMtZ+ebGWkZKHlSr2Cw==
X-Received: by 2002:a05:6a20:5489:b0:1a1:6d2c:45da with SMTP id i9-20020a056a20548900b001a16d2c45damr971620pzk.14.1709755439863;
        Wed, 06 Mar 2024 12:03:59 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:03:59 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] drm/edid: Match edid quirks with identity
Date: Wed,  6 Mar 2024 11:55:54 -0800
Message-ID: <20240306200353.1436198-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306200353.1436198-1-hsinyi@chromium.org>
References: <20240306200353.1436198-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently edid quirks are matched by panel id only.

Modify it to match with identity so it's easier to be extended
for more complex matching if required.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
v5: no change
---
 drivers/gpu/drm/drm_edid.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 29ef35ebee32..f9e4dacd7255 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -112,13 +112,15 @@ struct drm_edid_match_closure {
 
 #define EDID_QUIRK(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _quirks) \
 { \
-	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
-					     product_id), \
+	.ident = { \
+		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, \
+						     vend_chr_2, product_id), \
+	}, \
 	.quirks = _quirks \
 }
 
 static const struct edid_quirk {
-	u32 panel_id;
+	const struct drm_edid_ident ident;
 	u32 quirks;
 } edid_quirk_list[] = {
 	/* Acer AL1706 */
@@ -2880,16 +2882,17 @@ EXPORT_SYMBOL(drm_edid_duplicate);
  * @drm_edid: EDID to process
  *
  * This tells subsequent routines what fixes they need to apply.
+ *
+ * Return: A u32 represents the quirks to apply.
  */
 static u32 edid_get_quirks(const struct drm_edid *drm_edid)
 {
-	u32 panel_id = drm_edid_get_panel_id(drm_edid);
 	const struct edid_quirk *quirk;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(edid_quirk_list); i++) {
 		quirk = &edid_quirk_list[i];
-		if (quirk->panel_id == panel_id)
+		if (drm_edid_match(drm_edid, &quirk->ident))
 			return quirk->quirks;
 	}
 
-- 
2.44.0.278.ge034bb2e1d-goog


