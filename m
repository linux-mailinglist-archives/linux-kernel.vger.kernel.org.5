Return-Path: <linux-kernel+bounces-94529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F16874115
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2AC1C221DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301F143C5B;
	Wed,  6 Mar 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDqSro8N"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8A142906
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755440; cv=none; b=NtZ06Z9teJK6DEu+XUZwi/ChZXsJpGKgF88o8j3K4qinnjTJ+8QBuo1N+Hc9BbVedpYAblB5zIcAqoQoH7h78GixRk5wn7KJzVMES8YRh7NWs8Kk5fUBiq7Bnw3BHkEmxBVSA8tVvhsvLJ4U7DdAZel0YKBwjWlAaEeimiDZ9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755440; c=relaxed/simple;
	bh=Q+pRA35gd4K0k7v6qKItUMaetKmHyCKrGSHriuKb4Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwLeKyjdKUhtXi04cMZZLN0Qc1g1tygrNjTq/pBLP5/RQmpRl/0q+TLC+8AoFVLZ887LgL0AGFe8IQXQryM795LXeImk7SV+dPZrZxgUeShjgtJjTqUZ3boT1z4+wzHtZAHHrYmOk8D6XrKFSVeOjaae4yrEz5yVX8l2JEtSi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cDqSro8N; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so97292b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755438; x=1710360238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JCkj6GVRUNO967KT3bkL0DjQ/CoTjKrWRf8htMUslg=;
        b=cDqSro8NR+5yvJjCoAEa+JB9s4T/aGRkP9eKi9Ar7R00wheR5BzeFQZ73bPpTSTJnJ
         mNFwsq2fwC5yx/ljsvpuAVC7eMr5gv7jcCNWMGXywZPvrJAEmO4bflJy/6qcA7Ut+pd3
         IzdB1aDeOAXtECN0laSqBNENQbi42hOEPWZhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755438; x=1710360238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JCkj6GVRUNO967KT3bkL0DjQ/CoTjKrWRf8htMUslg=;
        b=EuBljqHuv1tYAl+MLQE/F+NggM6Rs0MpUV2AQfxvZDUAXPYlnJmskmELTD66mnmyGC
         x6nC09flhwFi6Y5qDgFo5pIAMSrtswzBn75jSGsU0tLOBX//7+jge2wzZLqk0Bw+1ZUh
         zVRqxkpTko4AuptnaCefnV54a24dvlvJklN0bg3BQkmV+ISMM8wzVRbZlxpU1zNu0LuC
         ZzmIVq7jiZZ3VLWWy3Zp3K6ermfrLxU/NcUL5l7De6wpJcXJx2B/XHnLA6vXDaU0xkSy
         kcpMvcwrc1TPjetQGKAMbxigu9adPcYzyb6uAErdarzyPYTOcNbmqTHS4e14Z1dVhd5x
         YX2g==
X-Forwarded-Encrypted: i=1; AJvYcCUT+Ewayz5aU21FRf7UdivR3G7XZH3W3PllSC1e5xDgcjUoqAMeKxKJnVf4GxsEtCVy6MO8TEihZlNdapf97lySPLGyG83SO/p2mhhO
X-Gm-Message-State: AOJu0YxaHEn8jwfpmygEv8woCxKrjVyzGT0Ilr1irCARWFJCmuCw6Glq
	+iG5r5zxflz5rH0g/NLHfh8U0+flDb5joRIjU3JmMQer/mt2h3agdUbFfXeVhQ==
X-Google-Smtp-Source: AGHT+IHUlhDXpMflxQ7aiaCnsIh19pRSvBvh8iAGRXwrLu9WFPh0MIGQKicT8WXJgg+viWcZikJTdQ==
X-Received: by 2002:a05:6a00:4f8d:b0:6e6:16b5:2eac with SMTP id ld13-20020a056a004f8d00b006e616b52eacmr13189150pfb.29.1709755437897;
        Wed, 06 Mar 2024 12:03:57 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:03:57 -0800 (PST)
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
Subject: [PATCH v5 2/6] drm/edid: Clean up drm_edid_get_panel_id()
Date: Wed,  6 Mar 2024 11:55:52 -0800
Message-ID: <20240306200353.1436198-3-hsinyi@chromium.org>
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

drm_edid_get_panel_id() now just directly call edid_extract_panel_id().

Merge them into one function.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v4->v5: new
---
 drivers/gpu/drm/drm_edid.c | 39 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 8c7e871eff58..febe374fa969 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2743,8 +2743,24 @@ const struct drm_edid *drm_edid_read(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_edid_read);
 
-static u32 edid_extract_panel_id(const struct edid *edid)
+/**
+ * drm_edid_get_panel_id - Get a panel's ID from EDID
+ * @drm_edid: EDID that contains panel ID.
+ *
+ * This function uses the first block of the EDID of a panel and (assuming
+ * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit value
+ * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that's
+ * supposed to be different for each different modem of panel.
+ *
+ * Return: A 32-bit ID that should be different for each make/model of panel.
+ *         See the functions drm_edid_encode_panel_id() and
+ *         drm_edid_decode_panel_id() for some details on the structure of this
+ *         ID.
+ */
+u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
 {
+	const struct edid *edid = drm_edid->edid;
+
 	/*
 	 * We represent the ID as a 32-bit number so it can easily be compared
 	 * with "==".
@@ -2762,25 +2778,6 @@ static u32 edid_extract_panel_id(const struct edid *edid)
 	       (u32)edid->mfg_id[1] << 16   |
 	       (u32)EDID_PRODUCT_ID(edid);
 }
-
-/**
- * drm_edid_get_panel_id - Get a panel's ID from EDID
- * @drm_edid: EDID that contains panel ID.
- *
- * This function uses the first block of the EDID of a panel and (assuming
- * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit value
- * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that's
- * supposed to be different for each different modem of panel.
- *
- * Return: A 32-bit ID that should be different for each make/model of panel.
- *         See the functions drm_edid_encode_panel_id() and
- *         drm_edid_decode_panel_id() for some details on the structure of this
- *         ID.
- */
-u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
-{
-	return edid_extract_panel_id(drm_edid->edid);
-}
 EXPORT_SYMBOL(drm_edid_get_panel_id);
 
 /**
@@ -2881,7 +2878,7 @@ EXPORT_SYMBOL(drm_edid_duplicate);
  */
 static u32 edid_get_quirks(const struct drm_edid *drm_edid)
 {
-	u32 panel_id = edid_extract_panel_id(drm_edid->edid);
+	u32 panel_id = drm_edid_get_panel_id(drm_edid);
 	const struct edid_quirk *quirk;
 	int i;
 
-- 
2.44.0.278.ge034bb2e1d-goog


