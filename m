Return-Path: <linux-kernel+bounces-93177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5F872BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E628A6C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7EDDD2;
	Wed,  6 Mar 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S43xP0dm"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994C6FD0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685835; cv=none; b=mtlDG3JDevBZC9SgPI+RYdTXRTmXa717KezPhQS2VmDtRBG9WkDXHhVweULlvqKKlq4vi3JxGBUBTEhseQBHaP9/RHgPw9UjpYSA+MmDAwn7AppQPYdYf7oPOOR8RbG5m3u10NWesCTP5nhv+vnVzPfxz7OwfNuTrE4oz74ZpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685835; c=relaxed/simple;
	bh=dIL9j9slboWzHrUIW8e3XcVKVmlUcIC6yHxtLGAdPFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgEaKIZB7UgNZJEqk8GUam6ZqD+0l15I9VKn7GsDOBzxSBwEiYwzlNqPLMxx6f6Rdq3aankM3JuEDKoEROnnRT2D4KFYkqp1BcJ4rOUFbTvk6IbS//utZHnrKH2oSUr0Ig4sIyl2KD9Lol6UXkFtvHGAXFiTZGiPc5bCHS1OjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S43xP0dm; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1e992f060so1829158b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709685833; x=1710290633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmN32yDBtw8o7MT20mOBDUzK3nXP1eK8tU0sZE85v7Q=;
        b=S43xP0dmGWUvhMJ4tj/gXST/Ga0wu3MLXatmFLz3yXkYq6P7ASkfkxrosyrRS8TLNe
         FuPB/1Rfxdtj6lYKZZs1AQeFF2mmU/smlQ81/0MCA6e3Khlo6mLWHgoDEJA6GU1c9aYJ
         oh3rBFDj5zll47bYWPHn1RMq8jsfhTwjQ1S7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685833; x=1710290633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmN32yDBtw8o7MT20mOBDUzK3nXP1eK8tU0sZE85v7Q=;
        b=kwAFZWrJWS3nHZyKpn6ZmiBvWXagz5BVRJjcP7Q6G63Yw4kioiainLHfEArNcqvkjy
         JxXLgnPFvxQo0xtQz+dBOuCARG2HGRchdp9HYfoRse0UIgE4Rpw+adZcK6bdOOpBEqnD
         MeSwZ/d7+9yp+voeNtf8Hz2tqkoVQE8+kYCtqBpAyOvLijdQ/ytvsqPYxAiTbu4CYf70
         70eX288OG/6OU4woEQv+kxOX7DaRViQdTVuF4JTowHYEHiCVl4j1WebHfLSpn850MNgR
         XLDJVZwq4/Y6oiOgg38xLLi6jwWyireqoDT3FaD4H6SCicE6UiASao93mb6DGYSHNrXz
         ew8w==
X-Forwarded-Encrypted: i=1; AJvYcCV+IhaJXlGz/zvMPy8qXShXvapo1lrtZz2RXzpSqYtGkMvQ3eN+NA7gIRm3OtVTjlU03Hp8DaWw3EVJ5qx3/sf0Rq/L+WzC/Ia4XEFl
X-Gm-Message-State: AOJu0Yym/GpiUj0Pnn5i0w0pYlvfiEh6qaI4gL7qURYYzCvv1wwVhv0Z
	X2giCDkpv08lksFELU8prv6ztl2eNpqyecy1+3Ku9HvTIAujumKwsIAK6LWBhA==
X-Google-Smtp-Source: AGHT+IF9JDWMnbkfo7qAITIq4vU3d+C8vqidkBtNkEVN4h5JsUh1v6Vd9HjSE/5hv0doQQPhuxukSg==
X-Received: by 2002:a05:6808:610:b0:3c2:1ab4:3323 with SMTP id y16-20020a056808061000b003c21ab43323mr472567oih.51.1709685833369;
        Tue, 05 Mar 2024 16:43:53 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:29bc:b3d:1ba8:cf52])
        by smtp.gmail.com with ESMTPSA id x37-20020a631725000000b005dc48e56191sm8512885pgl.11.2024.03.05.16.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:43:53 -0800 (PST)
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
Subject: [PATCH v4 3/5] drm/edid: Match edid quirks with identity
Date: Tue,  5 Mar 2024 16:34:03 -0800
Message-ID: <20240306004347.974304-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306004347.974304-1-hsinyi@chromium.org>
References: <20240306004347.974304-1-hsinyi@chromium.org>
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
---
v4: new
Per discussion https://lore.kernel.org/lkml/87a5nd4tsg.fsf@intel.com/
---
 drivers/gpu/drm/drm_edid.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 5e7e69e0e345..93a49b262dbe 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -114,13 +114,15 @@ struct drm_edid_ident_closure {
 
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
@@ -2921,16 +2923,17 @@ EXPORT_SYMBOL(drm_edid_duplicate);
  * @drm_edid: EDID to process
  *
  * This tells subsequent routines what fixes they need to apply.
+ *
+ * Return: A u32 represents the quirks to apply.
  */
 static u32 edid_get_quirks(const struct drm_edid *drm_edid)
 {
-	u32 panel_id = edid_extract_panel_id(drm_edid->edid);
 	const struct edid_quirk *quirk;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(edid_quirk_list); i++) {
 		quirk = &edid_quirk_list[i];
-		if (quirk->panel_id == panel_id)
+		if (drm_edid_match_identity(drm_edid, &quirk->ident))
 			return quirk->quirks;
 	}
 
-- 
2.44.0.278.ge034bb2e1d-goog


