Return-Path: <linux-kernel+bounces-91102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E48709A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C8A1C20999
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1378B4F;
	Mon,  4 Mar 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va/ua3gL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1278694
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577153; cv=none; b=IOlalaj7cyxsuVE36uNf4TzvDaJ2WAEML4iTBzGIEVTFF4QntWsE5jvNV+8bZbDpRVj4VVC9WH0A84pgkr/hXzyI8palhltb53zII80AE3JyfiyXVs8Vw6dHtjc1e351uRTI/HIoPaGHwdPilSuqP5XLunwtsFWuutHH+HNbTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577153; c=relaxed/simple;
	bh=QgKNOuRt/oJXimE9KMGkOFs9TLGMO52vwLhgONFKhig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+YgrQXYPSDFPAsY2SP2i7wQ4axJ5qFOUMOjqnsqBJKnYyaAcSkccI3c2csCn+qQ9qvQgOYzBk1QPczqm1ayToPQAMYVBWZ8lRM1z4NOcgp9Hxnqwk9kxpNIGoC/UaEPyKeRVO+3UVj38BSY9HEQnYD2OpOy5cgTYRf6ZBFg6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va/ua3gL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709577150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HIrnHCNtl6Z247/wJhmk+Seyt/6rCNU1N0P0o1q0xY=;
	b=Va/ua3gLYES3x9wOu5QGKfLP2nTo16Pfq19nybiybnI6au0gCPga6JZeXOwhS4KFoGPD5h
	UsfhHOk5AhL6/4qUH8TSuQuBDKON8WeV4w7DLW5NRxNGhpv0v1Vdnc6ENdMN5XuSmZKsXF
	/D6Pzoj+OjgWL+EstBQDcrFyKg2vww0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-zxXx5DG1O1OD1msDahO3SQ-1; Mon, 04 Mar 2024 13:32:28 -0500
X-MC-Unique: zxXx5DG1O1OD1msDahO3SQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ee9c08720so52100666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577147; x=1710181947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HIrnHCNtl6Z247/wJhmk+Seyt/6rCNU1N0P0o1q0xY=;
        b=c2ti8i2jDzhspEJmcb9fToRSPo/yeq5kVG804t1UKbcyVYBboAV+hUemupME3fUrcN
         4R2wv1L+8cXcHz7BMbq7PjPpx8lED15wkLm/lL7XTdPImFkASTTudV5xyFD3sshfp5op
         nA67O5PU6pTPa+LOCVItzhE7pWB9Jjoce4mN9ho74xL5yEva13kh89G8Ire7cOAkUA3l
         66mbpNp7zUVIOa5Amxjx0EjwhjEmkATsju3pe4hjqgOORBtDUm7i+v6/vNcrxvs8GKr3
         tan3bc96M8490/a4mHI0EDhWJ/CTbRuAtucDNeUmvGhk1FEvrUteRM3UgwRAZf2olpWO
         yigQ==
X-Gm-Message-State: AOJu0YyAb2Sjxjuvwzp9s53PB/x+OxqfA3J8WwcK00wgRrbfpwr6UymN
	g6dWTHYY/tSiSNLHzdbC7u7aMgwM+1zlyqNnqnoYJQrSPMcf/7dbWrCTPSNayRHDjMn08YPWu0J
	+cMp5BVbDXkNJAaMWjz9A4e7tpOgOGdMy6Bz+ZWOlHzZbQN3a94slg+pXv+aTxNUxko6mhUiUYe
	2lvJI2nMH1xPKb6u7JsCjD94c8Pnk7FTa/RSopVPQcZje+
X-Received: by 2002:a17:907:8e8b:b0:a44:1bcf:4e8d with SMTP id tx11-20020a1709078e8b00b00a441bcf4e8dmr8867307ejc.5.1709577146906;
        Mon, 04 Mar 2024 10:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC/9uJQ7FdpOhZejxBiANmYZJHF+aXDDDzFon+9rcbVgig5VWeAqsBGKNqjOSPCQAW/3TuvQ==
X-Received: by 2002:a17:907:8e8b:b0:a44:1bcf:4e8d with SMTP id tx11-20020a1709078e8b00b00a441bcf4e8dmr8867288ejc.5.1709577146532;
        Mon, 04 Mar 2024 10:32:26 -0800 (PST)
Received: from kherbst.pingu ([77.20.15.65])
        by smtp.gmail.com with ESMTPSA id me25-20020a170906aed900b00a44efa48c24sm2705672ejb.117.2024.03.04.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:32:26 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 2/2] drm/nouveau: move more missing UAPI bits
Date: Mon,  4 Mar 2024 19:31:57 +0100
Message-ID: <20240304183157.1587152-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304183157.1587152-1-kherbst@redhat.com>
References: <20240304183157.1587152-1-kherbst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those are already de-facto UAPI, so let's just move it into the uapi
header.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 20 +++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_abi16.h | 12 ------------
 include/uapi/drm/nouveau_drm.h          | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index cd14f993bdd1b..92f9127b284ac 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -312,11 +312,21 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 	if (device->info.family >= NV_DEVICE_INFO_V0_KEPLER) {
 		if (init->fb_ctxdma_handle == ~0) {
 			switch (init->tt_ctxdma_handle) {
-			case 0x01: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_GR    ; break;
-			case 0x02: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC; break;
-			case 0x04: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP ; break;
-			case 0x08: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD ; break;
-			case 0x30: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_CE    ; break;
+			case NOUVEAU_FIFO_ENGINE_GR:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_GR;
+				break;
+			case NOUVEAU_FIFO_ENGINE_VP:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC;
+				break;
+			case NOUVEAU_FIFO_ENGINE_PPP:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP;
+				break;
+			case NOUVEAU_FIFO_ENGINE_BSP:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD;
+				break;
+			case NOUVEAU_FIFO_ENGINE_CE:
+				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_CE;
+				break;
 			default:
 				return nouveau_abi16_put(abi16, -ENOSYS);
 			}
diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.h b/drivers/gpu/drm/nouveau/nouveau_abi16.h
index 11c8c4a80079b..661b901d8ecc9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.h
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.h
@@ -50,18 +50,6 @@ struct drm_nouveau_grobj_alloc {
 	int      class;
 };
 
-struct drm_nouveau_notifierobj_alloc {
-	uint32_t channel;
-	uint32_t handle;
-	uint32_t size;
-	uint32_t offset;
-};
-
-struct drm_nouveau_gpuobj_free {
-	int      channel;
-	uint32_t handle;
-};
-
 struct drm_nouveau_setparam {
 	uint64_t param;
 	uint64_t value;
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 77d7ff0d5b110..5404d4cfff4c2 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -73,6 +73,16 @@ struct drm_nouveau_getparam {
 	__u64 value;
 };
 
+/*
+ * Those are used to support selecting the main engine used on Kepler.
+ * This goes into drm_nouveau_channel_alloc::tt_ctxdma_handle
+ */
+#define NOUVEAU_FIFO_ENGINE_GR  0x01
+#define NOUVEAU_FIFO_ENGINE_VP  0x02
+#define NOUVEAU_FIFO_ENGINE_PPP 0x04
+#define NOUVEAU_FIFO_ENGINE_BSP 0x08
+#define NOUVEAU_FIFO_ENGINE_CE  0x30
+
 struct drm_nouveau_channel_alloc {
 	__u32     fb_ctxdma_handle;
 	__u32     tt_ctxdma_handle;
@@ -95,6 +105,18 @@ struct drm_nouveau_channel_free {
 	__s32 channel;
 };
 
+struct drm_nouveau_notifierobj_alloc {
+	__u32 channel;
+	__u32 handle;
+	__u32 size;
+	__u32 offset;
+};
+
+struct drm_nouveau_gpuobj_free {
+	__s32 channel;
+	__u32 handle;
+};
+
 #define NOUVEAU_GEM_DOMAIN_CPU       (1 << 0)
 #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
 #define NOUVEAU_GEM_DOMAIN_GART      (1 << 2)
-- 
2.43.2


