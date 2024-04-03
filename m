Return-Path: <linux-kernel+bounces-129276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A88D896825
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424902899B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6213958E;
	Wed,  3 Apr 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5FD+sLC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4013774C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131663; cv=none; b=cchuBl2dXUlOfSUBGXHVEaialotZrMu0kuxlwDD6AzqarVOHCFZzKBLEKqNHu7ZlJKzmwoU4vwpnAD8n0Lo98JFSm65dMfgwbIZphay/wNyPOJ+kf5KBRr87TELfqlVMRkr6lBt1JAS/8gvfCfd1ej/cY2Qs6t8O2bcuEojfBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131663; c=relaxed/simple;
	bh=yB67IW3EG1x6cJSxoti1WslrkvMytD90mSjXc8mIVWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3VFLD9I8IbkyBmGuuaR8cpzSUxeb/AJ/Cp4dCuxNZ/XE3mPf+h1PSSVythFVopRe546+ci+3uKzVOlce/qmsEP/4rWjA516u9UwUbFLLcMphVsXJXQswc0leFaA3ot9aAH5pF5PHiDWMD7sGgwRG/YyYHuNpomISPd5U/g36Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5FD+sLC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiRLnMbkdq0ZK3iF1Wz+eyDORzRxcdv33M/2a8lgeaY=;
	b=e5FD+sLCnsERkqNN4rC3L4vgKLV15tSwm0jFOphgr1ctiOEkeKjDUJpTaFnSJLarlofKv9
	pkfWoBRscEaAUwABW7RuQjcQF7Wrnwlf4mJEFsLIjcx7E+ktWzKPIDf7KQyt8Oac0HutYP
	XD8TpDkM9XhScSYbsUmk2GuHUWxtfUQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Xl_K6t_aMS24P5Nl6jNIJQ-1; Wed, 03 Apr 2024 04:07:38 -0400
X-MC-Unique: Xl_K6t_aMS24P5Nl6jNIJQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343740ca794so324885f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131657; x=1712736457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiRLnMbkdq0ZK3iF1Wz+eyDORzRxcdv33M/2a8lgeaY=;
        b=MNo+OMS5h7T5cA9+JFJNDGJWHyrQuBZCT77+ybjXGUf2UAGWsOczcLTnu2BpxiIb8i
         G2lAXv3Vyu2PjnvzVoIFcScPddb9TCplgFrW907NcaZRVSTNRFgaBxlsAyBEYooc4naE
         +xQaz108PHlrUcpjkEY5cuWXv3rcQFBFNLp0KQgHGiyTNismBADq+OujKMYeQ4HjK+73
         bodppg26JNnbBRgb78xiCJHx3FstdW5AX33ou/aHvH7E5u6bhrR6jLCX50sM9Z/yuTwJ
         iCdFnNZV4LMVnhqmMr2GNQ2OeEOJ3UlT8A7HEyI9Pj0PHNn/HEG6KShbm6svd5R6tixr
         c+og==
X-Forwarded-Encrypted: i=1; AJvYcCWeggsL2v9STQ1gZGtVrPgh8zeOwt2NwGF/Fomg78OvNwc4IebSQ+/iUwUKcEDD1jPLCynH49WDuByB7LvmgZMUfUcEnLoo4AfaZqfe
X-Gm-Message-State: AOJu0Yxyg+BmSY+GFeiPkPLq6Pug31/pROqymyjUveG+w5fRp+lGJiDn
	lHG4xV9waHeUhH+drFS5aoOk2GiqmWfcIHcx6XW5eepdjeE9VSK5PSzrTJVL6I4RRZl8EUX+l56
	8wJR/0HtPdyH4YIVvLd0kvUXTXnZNds8qSsn/BshvD9HbG9V1qvk8kd7C/+Yk1Q==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9b0 with SMTP id l36-20020a05600c1d2400b004156725f9b0mr5651484wms.2.1712131657601;
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSEV4CULLDHixjQ5GOzJ41zlIKQYkOtpxOte+Iv6GRLF0JbLuFFpysICEch8WGgEL0sf/Gcg==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9b0 with SMTP id l36-20020a05600c1d2400b004156725f9b0mr5651466wms.2.1712131657356;
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v5 10/10] drm/vboxvideo: fix mapping leaks
Date: Wed,  3 Apr 2024 10:07:11 +0200
Message-ID: <20240403080712.13986-13-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PCI devres API was introduced to this driver, it was wrongly
assumed that initializing the device with pcim_enable_device() instead
of pci_enable_device() will make all PCI functions managed.

This is wrong and was caused by the quite confusing PCI devres API in
which some, but not all, functions become managed that way.

The function pci_iomap_range() is never managed.

Replace pci_iomap_range() with the actually managed function
pcim_iomap_range().

Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index 42c2d8a99509..d4ade9325401 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private *vbox)
 	/* Take a command buffer for each screen from the end of usable VRAM. */
 	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
 
-	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
-					     vbox->available_vram_size,
-					     vbox->num_crtcs *
-					     VBVA_MIN_BUFFER_SIZE);
-	if (!vbox->vbva_buffers)
-		return -ENOMEM;
+	vbox->vbva_buffers = pcim_iomap_range(
+			pdev, 0, vbox->available_vram_size,
+			vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
+	if (IS_ERR(vbox->vbva_buffers))
+		return PTR_ERR(vbox->vbva_buffers);
 
 	for (i = 0; i < vbox->num_crtcs; ++i) {
 		vbva_setup_buffer_context(&vbox->vbva_info[i],
@@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
 	/* Map guest-heap at end of vram */
-	vbox->guest_heap =
-	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
-			    GUEST_HEAP_SIZE);
-	if (!vbox->guest_heap)
-		return -ENOMEM;
+	vbox->guest_heap = pcim_iomap_range(pdev, 0,
+			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
+	if (IS_ERR(vbox->guest_heap))
+		return PTR_ERR(vbox->guest_heap);
 
 	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
 	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
-- 
2.44.0


