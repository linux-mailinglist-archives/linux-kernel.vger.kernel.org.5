Return-Path: <linux-kernel+bounces-96349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C14875ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37F91C21079
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749148CC6;
	Thu,  7 Mar 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HwlcahBI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238B3E480
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852822; cv=none; b=cSfW6ZPCkODEpq3vEfi1Yh5+icfhpvMnHpaEHuM28Fe9d5f8Zx8W4wYQxKPgaxfYrZZYHdA0tWWSxy09aGpmf/OBPEG4wM86usATaCkQoe0+EmzF4bIqgiuFuHahPOQJrM2UdIPQJSfdEW2rTNaplZSBLLd4sLbIk77coRKETs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852822; c=relaxed/simple;
	bh=IOqtw8i65TliM1M9qhk2LNGe7LbBpuKoQAi1rapUIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIhXX5erN41AZg+BqpnzgMdgMIDrvThZdd70E+68JuSRd1yvc39sF7FuIiimpACZZCM43hN3vMLViCuv6Ey6OOo0iHCediWtQoB6DLE2wymRMQr/zKt0GJRFHSwxmxg9AeKIuAJ9p+Un8VOmMt+8Dwm918hqXWrIRBSP27h2Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HwlcahBI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd2dca2007so1429225ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709852820; x=1710457620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhMzn7mAql0qeAQCBndfDWvU8yMf9cLlH/SFDDXTa5Q=;
        b=HwlcahBIRcj8hNMTmEJQ0J4q9gcD2laz69uuArWYkgdRTisDdKnCQWoiCypbTczC+d
         bCW86WP5CXuyRyw0EPt9gdWMxlG0clyZ0wpm1PLHN3EFkOx1ZYk7VTw+zcgQpZ1YJ/q2
         QSfF9Y1m8hMKBlL9gGbYYrCmDTJypS6r525eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852820; x=1710457620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhMzn7mAql0qeAQCBndfDWvU8yMf9cLlH/SFDDXTa5Q=;
        b=oWCPPqBa72LVGsftZDmT1KhCsjMLqI5MwBka5GZHDhVXAAX8XubiS6t6Obf9Ser0lL
         XGU9MfqRb+KzAHuyPPmRVjZb3l3rqvIO64Nq0QoJ6t0r2Wcsbnx5JaE1wftDhCWAXX54
         ety3zm9tXX0yjSXbNPfQ+KvDQlVAvfeIWrihdrmUi+KU1/r443DjYNeLj306DjHu/gyQ
         arteYqOc7Hr9o+6d1UHS7Oe9cCvOvQTfon1/bG61HWAKiR94HEIeHoytuyfQSsy7sCDV
         Vd2UzJAsWNbCiWdPBC8qvUEQvgf0nzFw6y2BzR+VWLfJbzWEzYWfP8vERiArNcIbDTUw
         KCWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+m/ycCrJzVEHdvrN7hfwUXTMNkjahZUwGM00nTgwI5GgyClN8sWVoS8xNmad/YV5Fs9YUsqvaTRpY4wM1R/zuXwyeS51avgeJz00W
X-Gm-Message-State: AOJu0Yziwo2IJc87PB/jQXBpYvj3O++CNj0LPjO9sZDpN2ow/uCoZzsp
	yquvRTWRkIbf6ksVcNQnbbvM+iiMeOSBBTgSGP4bCfuSvs8Xqf7qUfCehEMWOA==
X-Google-Smtp-Source: AGHT+IGM8Dqm/6+6/lxZ8pSJg338UR6F0X81KWVG5uRhl9oNBtnBdU4y50jzsgc9NatZRGXMVzuApQ==
X-Received: by 2002:a17:902:e806:b0:1dc:b063:34ac with SMTP id u6-20020a170902e80600b001dcb06334acmr11901220plg.21.1709852820139;
        Thu, 07 Mar 2024 15:07:00 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bf8f:10d4:f877:bee3])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001db63cfe07dsm15196654plc.283.2024.03.07.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:06:59 -0800 (PST)
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
Subject: [PATCH v6 3/5] drm/edid: Match edid quirks with identity
Date: Thu,  7 Mar 2024 14:57:43 -0800
Message-ID: <20240307230653.1807557-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240307230653.1807557-1-hsinyi@chromium.org>
References: <20240307230653.1807557-1-hsinyi@chromium.org>
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

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/drm_edid.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 58fe35058181..4abc50516cda 100644
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
@@ -2883,16 +2885,17 @@ EXPORT_SYMBOL(drm_edid_duplicate);
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


