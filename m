Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAB7E4DE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKHAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjKHAOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229D10EB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699402393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ctUbNYpz6tzYpOeogS+HZIyW2krgJWmH5IZy1f/TTs=;
        b=UTVAWsKTyd0S0AIS1Cq/2T7F1Cmfyc5iF7g/+LLdp5G9dRAqMIgBoNq7qKY7lNeRmuxwU1
        wLXLkBded5aK2R5G18SwcmJaHLzzeZPPRCEeRrId1bRUO72g6T8UO+dX/EigYy/FE79yEy
        E639w81uHOiUuQCGN4CaW1hHh6e08fY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-2Tf6Qnt2MXuqVd9lX8z8hg-1; Tue, 07 Nov 2023 19:13:12 -0500
X-MC-Unique: 2Tf6Qnt2MXuqVd9lX8z8hg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9de267de2a0so273019766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402391; x=1700007191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ctUbNYpz6tzYpOeogS+HZIyW2krgJWmH5IZy1f/TTs=;
        b=GAtzfDl4OBcfYBdNdPOViR8UnPRfyE65H4Gbwk9HyT1lccyymqFLMkQpkQPxQGTHi5
         m44TNLGWs71kucV1MX0AnjIyjg9JRLpnAmbeLQdh9uFZqByloGUJH/DkShHPd8IqEKm2
         k31Z10XR367cVAFXM6nrxtszbF0iPGIznRsHM1fx6okwuAioTsSL2wSMle7UUyT6hrfb
         dJCOjpvCamcKp0eIqHionxMbKix8AtAgtq75UeDqqBLjKIaWam20T4WDzewAg/+WZNcM
         bsSd917jXBZ9OHM7X86f2ecL/r5j6bOW6RhZlhI+WKiYozGngXDk2lUwcuIUCXtuI7jo
         9EaA==
X-Gm-Message-State: AOJu0Yx4TAB97yC6fg5MDG6KLMQJUOAxnkGgFkyeTXnmSNaqIE7nEoyl
        l6mXqZRjfEF/gr/+qTMP72tQhm5IqDeYw1h8TXAW39qoakVsMYnd2wm9xOu+P3nqbJ2ssw+ZSO0
        EybU8BLwmdHwDvfcJpQUfQU9r
X-Received: by 2002:a17:907:72c2:b0:9b2:6d09:847c with SMTP id du2-20020a17090772c200b009b26d09847cmr128991ejc.10.1699402391141;
        Tue, 07 Nov 2023 16:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5mZIJaXlXK5+6Ct9x6+zYmd4wQssrYGMVAP+petiYpgw5Audt1XmkpV1U3GDZmm9qpuS4MA==
X-Received: by 2002:a17:907:72c2:b0:9b2:6d09:847c with SMTP id du2-20020a17090772c200b009b26d09847cmr128975ejc.10.1699402390838;
        Tue, 07 Nov 2023 16:13:10 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906048400b00988e953a586sm177311eja.61.2023.11.07.16.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:13:10 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v9 02/12] drm/gpuvm: don't always WARN in drm_gpuvm_check_overflow()
Date:   Wed,  8 Nov 2023 01:12:32 +0100
Message-ID: <20231108001259.15123-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108001259.15123-1-dakr@redhat.com>
References: <20231108001259.15123-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't always WARN in drm_gpuvm_check_overflow() and separate it into a
drm_gpuvm_check_overflow() and a dedicated
drm_gpuvm_warn_check_overflow() variant.

This avoids printing warnings due to invalid userspace requests.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d7367a202fee..445767f8fbc4 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -614,12 +614,18 @@ static int __drm_gpuva_insert(struct drm_gpuvm *gpuvm,
 static void __drm_gpuva_remove(struct drm_gpuva *va);
 
 static bool
-drm_gpuvm_check_overflow(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
+drm_gpuvm_check_overflow(u64 addr, u64 range)
 {
 	u64 end;
 
-	return drm_WARN(gpuvm->drm, check_add_overflow(addr, range, &end),
-			"GPUVA address limited to %zu bytes.\n", sizeof(end));
+	return check_add_overflow(addr, range, &end);
+}
+
+static bool
+drm_gpuvm_warn_check_overflow(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
+{
+	return drm_WARN(gpuvm->drm, drm_gpuvm_check_overflow(addr, range),
+			"GPUVA address limited to %zu bytes.\n", sizeof(addr));
 }
 
 static bool
@@ -647,7 +653,7 @@ static bool
 drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 		      u64 addr, u64 range)
 {
-	return !drm_gpuvm_check_overflow(gpuvm, addr, range) &&
+	return !drm_gpuvm_check_overflow(addr, range) &&
 	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }
@@ -682,7 +688,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	gpuvm->ops = ops;
 	gpuvm->drm = drm;
 
-	drm_gpuvm_check_overflow(gpuvm, start_offset, range);
+	drm_gpuvm_warn_check_overflow(gpuvm, start_offset, range);
 	gpuvm->mm_start = start_offset;
 	gpuvm->mm_range = range;
 
@@ -691,8 +697,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 		gpuvm->kernel_alloc_node.va.addr = reserve_offset;
 		gpuvm->kernel_alloc_node.va.range = reserve_range;
 
-		if (likely(!drm_gpuvm_check_overflow(gpuvm, reserve_offset,
-						     reserve_range)))
+		if (likely(!drm_gpuvm_warn_check_overflow(gpuvm, reserve_offset,
+							  reserve_range)))
 			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
 	}
 }
-- 
2.41.0

