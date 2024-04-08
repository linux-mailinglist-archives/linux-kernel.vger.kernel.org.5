Return-Path: <linux-kernel+bounces-135071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035DA89BAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35663B231E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0F3B7A0;
	Mon,  8 Apr 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4CxYqMZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7A4F208
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565895; cv=none; b=tOaneb3FWiEQ+9NywKTP5OGwhYla7AWHOO8bFsMyS8ZyCRMFen+e4uvsZuZYP8gBpgIQRZcjHA2s12RVJfK0jeqQkEIwLN2w1OIoF9baxQLpbBiepzVDNwNNoTlbRV0TZI1ENGY8q8MZQNMp7Pnq8Mkxqg03s0GzcbhhSgyJtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565895; c=relaxed/simple;
	bh=seKAVIenEEwbzM3Iic5g38ri/d9lXst00U0PHR2Zy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci5iBrLnsG/px1vFnbEfDF95/Jlv8LY3QWbAdooWwmswA9rM/Ks4YE83tl8MDORIFXDlkqea23oBbLMFzrbgv3EeTpV+U++vkjjH6rbyk3gh8DalCNjVwcpRRAxFkac0db7qT+NdGx5tLEng2kUHD0ml54Zql/+UHvtzKlCtBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4CxYqMZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnmS+ZQ70OmsHKGyqstMbXO2wKO+H5ag8eg75yEHt7A=;
	b=H4CxYqMZBMw5yYeMYh6f1zpNx/ZgBz5gceGCNMXbBcdNSFGdZmPVLgSMGeCKNaSVClBsTU
	J8N5wed0HM82E2dMm9m13JOsPV4NOSeKkbAqmbmjY3L8rPlLMDmV4TH1S8EYJcht2XcS9W
	KP770ZvaNc4kkzEjLsb9mhwQk2wKjuw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516--C0vef43NF-9Kyx5Mpd4qA-1; Mon, 08 Apr 2024 04:44:51 -0400
X-MC-Unique: -C0vef43NF-9Kyx5Mpd4qA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78a5e62931cso55282285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565891; x=1713170691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnmS+ZQ70OmsHKGyqstMbXO2wKO+H5ag8eg75yEHt7A=;
        b=uzOKt1CKvl3ycEdRrGXP4xDlA17H0Lm2eSAyz+NIklZDeQ9jhB0x3HRP9fFyRJBKJq
         hk+zp6CvZiflf3ukg+8L3RU3rQsP8SRw3QMXIcjaOjB36eB+WkIBVkEfjdSnGIDHVN9/
         vXlEVS+so7XZWMfPxhFKrdATBpZYeV+RWhAMmLo/PfsRvE2wHFJitUaJ5m3KJ/mwklu1
         yDLAXjSF9F4BU9z46YtsGads4NlPGTpkpmOXG7q85mL7zPA6NO9KHr4pvPngNiNUJ0CC
         PwAO6amUdqor39CoGlfvExnGDtRwH4+RbOugOY98HUjzCiMw9meocOaSg8onc1hTXsnT
         N3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMSxyNUd7opqJJBMcuQBLFR9juf/RYYuDKyO2NGxjAiffPpLJ1t8P2u7U6/ETWK7g9oewrnEsqxpHkSpSNjTNgCYYTk9/8CMJMpri7
X-Gm-Message-State: AOJu0Yz07j3zuASwqoYwTxNhTSqPRzoym7oZJYpsAwYKvnBfEYJW2osr
	OPU68m3SE/iqPHinngbzD1ZzjbfHtYTIMjMX5veZqLnOMYxLYpR9YRywIqY827bu9OZQHH3MXsV
	q2zctbLlQ6H1YQkvHFJalAoPy/mwBpVXtaGx73FXNyZIKYVq90JyQd9hLmzNiDA==
X-Received: by 2002:a05:620a:319e:b0:78d:5fd5:9254 with SMTP id bi30-20020a05620a319e00b0078d5fd59254mr5644004qkb.5.1712565890759;
        Mon, 08 Apr 2024 01:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsVOxGIi2Iuj/AVIRSbBNaD6COng8+R3PpINEdp5/DQW+HcEotDsruGHbTospw6yxnsP+ZjA==
X-Received: by 2002:a05:620a:319e:b0:78d:5fd5:9254 with SMTP id bi30-20020a05620a319e00b0078d5fd59254mr5643989qkb.5.1712565890518;
        Mon, 08 Apr 2024 01:44:50 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:50 -0700 (PDT)
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
Subject: [PATCH v6 10/10] drm/vboxvideo: fix mapping leaks
Date: Mon,  8 Apr 2024 10:44:22 +0200
Message-ID: <20240408084423.6697-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
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


