Return-Path: <linux-kernel+bounces-88354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D639B86E065
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496E71F209AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4470CAF;
	Fri,  1 Mar 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYKV9D0h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9C6F523
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292635; cv=none; b=jpu2yMaTsGhxqDPF8pNmQ+ZcvHKNGRE1NnQ6BcDSwEQKp+qF9b4rph7Uk6x6/l9AVFLUhsHXj+PMLXxyavlIWsdsFIwJ8aY2IwYjSAFjCOsK6RZ4zbcRI/RK/PR9fsTZuHjFO99dqPB5voFFiiu11ApLAOq5YBEe4lWGlLz+YQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292635; c=relaxed/simple;
	bh=DqC1146Gw+gtEXd1U6evjshsYPG+7+z9wKN5tAwt5no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSNZgLjeM6HicHVZTT26crHfrKHDBnzSYdvm00J7UhA+UrdLAadtQhZ6ruYDVKVBsh8g2m6a/GKhJyQjKX35GHvXyiEACdeb113Q1spu5X/LmwT6ZrRhmJ+s3OIp3DrcAdgwg9F/zU8Z4HPwkfCE6fzfDxaz31902s6fo21ViRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYKV9D0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
	b=ZYKV9D0hvVvacwx8yiJs+UW+XgeQ5ae1YFfaOl+yD+doMUTyju39GTB7OrCbMebSgTU8yQ
	UO1XjeKM5FI/nheGuk2DuVJ+yid/6aQ6YmtLuCC005RTmXi3HNb6ljcmMUFHmPJLFqAHE5
	xL9O6t2vRpISMt3y711MYsTiOxwMRv0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-qJXskIQsMqWSlqIKA682ag-1; Fri, 01 Mar 2024 06:30:32 -0500
X-MC-Unique: qJXskIQsMqWSlqIKA682ag-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5a10aecb064so3640eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292631; x=1709897431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
        b=SEOCqit+sTdjxDod1Ga+r1iu4ZrZvLbptKgBsmGE1bHcDLDENwfIuX5hspZ0GjXax7
         di8i+dDLP32YgXEq25wNjupMe9eFxDvC3H8uyN3C7HRhyzCzYAdOCMnpYnm8DaJeEn2F
         WXI+UqQtlmLTWhObTv6CNJu0CPFYfskoUdXR4fxEKIycgglNCd8rmcxxCYXWDeTcY5Da
         WEvvWk4HnuIsY0l9FuIkBT3WTVr6MyY65AlP+yIFpQwDxNR7QgfeO/61904oLt69hG9K
         Pv56NVawbh4tylYo4PqphIA3hwaIu4uG075ClX+vovwPJmuJcwR1U6jHmiCnm9mH62b0
         Cw8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyMP8HYFRx4Rxw632mBCGCbiE8qGBjZf23SnIZlHvMWuYXToJQ0/awlITE8PDaBDH6tszVuSxOzgIOjWupWFQ92VU9tPsB+3SOp98Q
X-Gm-Message-State: AOJu0YytOidQdsMcCQ1Yf1L/akzUbXAnWBe58MkRVgjYJNNUlh8IVYSt
	CKK+6NTGb7rKjsdhHV+6Oal9M7cvpstHiE8G/Ug3yaLaxJ8E8T318HMH2P96NIU6urB7ZWetAXs
	FD5vj9ZDYNg8MgcB3vPEJlSAhTBvMj1wKPMlg8oD2FlPIC1aeNDdA3L4AL76rVbukXpnVQw==
X-Received: by 2002:a05:6358:5923:b0:178:9f1d:65e4 with SMTP id g35-20020a056358592300b001789f1d65e4mr1147489rwf.3.1709292631170;
        Fri, 01 Mar 2024 03:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/dYBpHA/2LZIcNaPDDpZ49F70JHds10e81JbU90eBR8pmO8IjXPGhx9tXuvUpPM6IQ4Mw1Q==
X-Received: by 2002:a05:6358:5923:b0:178:9f1d:65e4 with SMTP id g35-20020a056358592300b001789f1d65e4mr1147459rwf.3.1709292630853;
        Fri, 01 Mar 2024 03:30:30 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:30 -0800 (PST)
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
	Philipp Stanner <pstanner@redhat.com>,
	stable@kernel.vger.org
Subject: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
Date: Fri,  1 Mar 2024 12:29:58 +0100
Message-ID: <20240301112959.21947-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
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

CC: <stable@kernel.vger.org> # v5.10+
Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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
2.43.0


