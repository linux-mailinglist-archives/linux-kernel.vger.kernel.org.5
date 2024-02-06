Return-Path: <linux-kernel+bounces-55039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BE84B6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B7BB2796D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D76133412;
	Tue,  6 Feb 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQd0HvdN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AD1332BD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226863; cv=none; b=kaEnnh/GbXwf2psgt54cTVOqTtYRA3xmpvXNIA/ACIo5MQ4yK3dlnVI5Pj5DNa3GQG+CuRTUcYlXk/2rrzCcDDT6zAW9keZrnxXsZl77ikG5x/vhsl2Ts9yQ+iKG7Rczfj1bJYjjJM0CcE2mgo+7sl3kQ4cCOZ72TXguZvBggpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226863; c=relaxed/simple;
	bh=DqC1146Gw+gtEXd1U6evjshsYPG+7+z9wKN5tAwt5no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htyTi0wr2OES2WKPunx0H1CxW33x45Yf+ok93mkM3VK/luoB/Yinz/iaWRgdD+PYad+Qnebqq0C7eM9QpBtgD00iE3W2djizCQaAFJUNOa1MYuLxzjAxuOhvn78LqC1ja505B4XO3J6Z6EfgAb5Pu+zlupoomw/T6jiPA+4tiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQd0HvdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
	b=MQd0HvdNzAzjr6Wwhz5+1MFypwBgPEOci7c6lpO1CFFwKfrUXMP9XBMGlV76cr+5l0aaB9
	qwh/DVOe1WtdOCK0MBdbcMTs3SXYgvZws+kfYcF2CU0yfx/dmp7mFnCoMdleH7gaCurlPJ
	ioQZPcxPu2+WskD066OlJmry4axj/y0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-VBqYc4A8MManfjrazG0Y7w-1; Tue, 06 Feb 2024 08:40:59 -0500
X-MC-Unique: VBqYc4A8MManfjrazG0Y7w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78543d8dfd6so47980685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226859; x=1707831659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
        b=wa5q1PrV8pCZL0V7/ZzD0n+s1rTz8hUAhlck3RSRChBrwX7+CwMWxC22Ai6muA2ZJk
         Xll4FAH8mnVii1uAUAbp5FUeXbcjd92SUcVYRk8+j400aqDxWwcEJ0OLBaxJJwR5wfei
         3FPFsdxm9s7gMUN2R6+cK1qrs+8gXZoW/HSzoW5Kj9ND7eX8EsdeblRgMLJqPejip2AI
         7beoWI2ZRZHJ81fALJVFQo/x+fBkdvznFiRHmFah4hurJ+7tr/AUOoHQ6dg5tRdHFavl
         4yjSHH4z+4O1sDT67uDf6jraiVvD5ZnYrgrKwtrDTMe6RWB+h3tiOC8fn/1CTOfaFytV
         DcxA==
X-Gm-Message-State: AOJu0YwEtzwCDtggPdhpacocUwXGrGDkUrrYghkqoqq03llITF9XmWQM
	PJcIiaXXplzRyCUKfCLP3KJqGOFv7yFr1G8KJPfp8gI5Oy7xXUmrndXG7/DgXaiJOkLf7ovzFLg
	g0IFdppF4ltgIr+pJSWHUgb24a+gJ16jF46cWTFWQj2J59KiRvsREKUhA7NoBqg==
X-Received: by 2002:a05:620a:458f:b0:785:8aed:219c with SMTP id bp15-20020a05620a458f00b007858aed219cmr2740652qkb.4.1707226858855;
        Tue, 06 Feb 2024 05:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbUFe8rAmzdQwiOUkDOWaSU2uG39vl/g+XyIl4fyr/XwVyPG/ryyPI2bU0DdbSQp1oH7bwGw==
X-Received: by 2002:a05:620a:458f:b0:785:8aed:219c with SMTP id bp15-20020a05620a458f00b007858aed219cmr2740622qkb.4.1707226858478;
        Tue, 06 Feb 2024 05:40:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVeDR5b9c7g/LX4DSP+QZjXTjR4mD9i/Uh3Ezjtj2GW3JtLorKY5AblA+CjtJql2aLlNALxzV0bl4U41u/GhhZLatfz9z0bPdBgozM5EYqgeElngR5qR0Txp3/2qm26N1Ys4+/8hSBu6u0aVRfjpHdO1etZE2hVCPT0KXoSUUzd617dh59feMZZeAjbZhdv8EnSQMoiuo89rEq+BvdPIr9sAN3QLOVlkylgY3mNTLjiVFjIdPDcpIFzQC9jWFF/j85Y4fRB2DTkj/Y3sTRuTE4bDbGsJR7R5v8GBdTiU3fm3/tDc7ma55apc9cEjsouFx/iBcEiQmJasZt4DHn09OqYIwb+Wn3YbkFIprccJT/mkYLQbiwHpsE+JR6Ql4TqRJ4ZFLdqlLKi8ArBJYgqbXk+HpyMNjYOPlQc7SM
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:57 -0800 (PST)
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
Subject: [PATCH v3 10/10] drm/vboxvideo: fix mapping leaks
Date: Tue,  6 Feb 2024 14:39:56 +0100
Message-ID: <20240206134000.23561-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
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


