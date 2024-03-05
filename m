Return-Path: <linux-kernel+bounces-92458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8087206B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1601F25885
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0178613E;
	Tue,  5 Mar 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrD8rO5V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253055E77
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645941; cv=none; b=Bh9Akb/vIz1wM/ogBebf/arKPD1I1E3UfkRnods3pnymPbUZeZeiPv/3RISkeNYiNkH5RWrjeYL3tnfVcuecGs/eIcq4I+RusBP1FzMfdHcbMhjH2wMhhDwy2UEAJgC6gyRImhsavC5G8usfiFIhY+iR5jZRo8E5H2NE/C/RKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645941; c=relaxed/simple;
	bh=ka/sHqtSSUL5w12UZDQHXFz+zGlrhqj/313XLMpnIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjuJHAsavBubr3U8HVxCon9pUNpUamUx+C5llA0mJuIETlva9Eypfwy4yZA3o1shCycWYVc/HUZv1/ruyIu73aDQL2pHLmi7GA3y5icIoDTwEY4h64SzEwxWMjI43xB+65m3cOx5ZnP4kRYRq1+DlpPBrSHdElqYeen6pmu3zUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrD8rO5V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11CPXNNF150pfEUFPWGbUJ1IKwl89RXoTZySYxmoYV8=;
	b=IrD8rO5VKqHo3j03gJmZ8zIaPnbDi01UW5cZ2rLH/eNAh/mbvSlAbnp+YmVMZ06/APbdqr
	iucEVykAHBNoADJioM9HK1TwIw7kDXf2zZMjb6+GqHdqtAbanaOKCzE/JCeYyVcCzp54Tj
	B6+/nNmvr4hsvXpfWc8tf5hX6OmuTy8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-cP5C9PVEOBezvZTpeXa6Jg-1; Tue, 05 Mar 2024 08:38:57 -0500
X-MC-Unique: cP5C9PVEOBezvZTpeXa6Jg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a436a38bf5bso68387866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645935; x=1710250735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11CPXNNF150pfEUFPWGbUJ1IKwl89RXoTZySYxmoYV8=;
        b=g1FySn8gAA7GOud0mOIj1wKjmLJ8T5i41OEXJBILLQOiPh1d1gPX2308bdjQkJvUhN
         HALNLIpdDO4jFojuypH9as07wGzOxRqCDk7dY2+sebLQWxcUbbJ7fyGKDopByejYJzqw
         ziSNpYdDsIjfliHDTfkVu8xXNLoVI5wrJqIBSveOI5zjXwgHMI9PiL6d4hWl20V2+0zx
         Ie2AyOVhSK8lMMc1R9+6I0JddY97g4cAfpk4IvQ2du9nYXzUo//VNlvCoL2xM23LYR7H
         nzgwcFtvz89c+uu4rN2vU+LnG5CtqZDyFaRm0vPwHOb2y8WqRKp3skgTlkBoRiongWWg
         EuZQ==
X-Gm-Message-State: AOJu0YwMw9lyh50mp3U0uIEazHGV9AVwxP5IHQ1dCFPWFsR8IgpT9A85
	GPvLim/aBfBkyGVc0mRP/f5UU7GEXQwPvVlwWXb0XBXgieIdIi4PmD9+d0OrqGQH8OCjO1HYhe8
	1yjwDNAAHYBx+E6HVZC1qzuMfgrBqnyxMZfWJkzyq7JcXjlzz/Vlx3fkFi+Tog41Enz5zVAauOj
	bet6bOSdUaWPhRfnMxI7H7DrmxuTXhpBnF+QZKOCS99TA2
X-Received: by 2002:a17:907:a68b:b0:a3f:161b:cc13 with SMTP id vv11-20020a170907a68b00b00a3f161bcc13mr402057ejc.7.1709645935587;
        Tue, 05 Mar 2024 05:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGf3/3KYPfk68CgY/nW360g4A9tp+KNIVj9PFBRcH+lHdipruHA8YbSsz9ZbASe2wCJh5jOw==
X-Received: by 2002:a17:907:a68b:b0:a3f:161b:cc13 with SMTP id vv11-20020a170907a68b00b00a3f161bcc13mr402031ejc.7.1709645935129;
        Tue, 05 Mar 2024 05:38:55 -0800 (PST)
Received: from kherbst.pingu ([77.20.15.65])
        by smtp.gmail.com with ESMTPSA id wk16-20020a170907055000b00a4532d289edsm2641326ejb.116.2024.03.05.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 2/2] drm/nouveau: move more missing UAPI bits
Date: Tue,  5 Mar 2024 14:38:53 +0100
Message-ID: <20240305133853.2214268-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305133853.2214268-1-kherbst@redhat.com>
References: <20240305133853.2214268-1-kherbst@redhat.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240304183157.1587152-2-kherbst@redhat.com
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
2.44.0


