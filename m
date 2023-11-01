Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E77DE8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjKAXcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346400AbjKAXcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5C9109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698881496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToQKAQ1y1PRH/3OVIpCvIaQCyxCqcVrO+cdPlLKjGls=;
        b=Szn9XfuBnsI3zxMWEH2JNsL3xe24aj98uRZM1aMM+2epIdBWiRTPmAzp/4ofyHCJliqZFz
        ML7cifI+mxvmizkjg4mGYl/kE7zTqof7k29fVq84TGartk2H2xQW6aGQhln5FrjmIqqUGx
        uMxuDApq7DWbxx4dCRVGPPsMqj2OS4Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-PLtTCct9PKS5gl5S9hxTGw-1; Wed, 01 Nov 2023 19:31:34 -0400
X-MC-Unique: PLtTCct9PKS5gl5S9hxTGw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54356d8ea43so183909a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881493; x=1699486293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToQKAQ1y1PRH/3OVIpCvIaQCyxCqcVrO+cdPlLKjGls=;
        b=Wb+mODr3rAh7SfrEkkLUJMDalY/uM1Nx2YG9mJQ9v6uK56GehTQIHx2sgSf4+rAE7f
         S+jmPUm36ZdC3aWGbXmtfpdi6+oYFyJqN1PNcSRHm8HRyt7bqD7Naq64+R0gc4iL7gsm
         q8/yBsGrGyabzgjOJs/BV6qv4NkIVMoadk9EQL1VmT/JR9QQZvs7PCFQNUICEoxA45V5
         v4iQJUM/PkyUo4xH53i7KLzcxkoV0kcuFaf22mT+BwySTB+fJBiL9NBr3OzwNRuerk4Z
         M20Ej2NJh8W7Yj/3yUUf4iMhLA058KOARJIRsnkO/8hoPXfd7je/Zw/R78lhNejaOXmZ
         jafg==
X-Gm-Message-State: AOJu0Yyn7vdPchQ2Zv6MFiY9/tJ797svEgGQPNbWR0Jtp3zrodRAhaGe
        I5dl8fQ7nz3RepWugOlxHgXmX58JvthELS116KdnJQ3F+unW1u3kKGabmZuqAvq40+XfizX1PS+
        ERLxhyo0sxzR4ift9WtlhJgb5
X-Received: by 2002:a17:907:2d88:b0:9bf:60f9:9b7f with SMTP id gt8-20020a1709072d8800b009bf60f99b7fmr3588030ejc.4.1698881493763;
        Wed, 01 Nov 2023 16:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8VXTjVmx2ScEY9zyfvtwm9s6xZPaZj87Oi885o90gLsjCTQH8aVAE6ZRQgz+nv+ASvdFvfQ==
X-Received: by 2002:a17:907:2d88:b0:9bf:60f9:9b7f with SMTP id gt8-20020a1709072d8800b009bf60f99b7fmr3588018ejc.4.1698881493503;
        Wed, 01 Nov 2023 16:31:33 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709063a0a00b009ad778a68c5sm465904eje.60.2023.11.01.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:31:33 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v8 04/12] drm/nouveau: make use of drm_gpuvm_range_valid()
Date:   Thu,  2 Nov 2023 00:30:56 +0100
Message-ID: <20231101233113.8059-5-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101233113.8059-1-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gpuvm_range_valid() in order to validate userspace requests.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 17 +----------------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h |  3 ---
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index aaf5d28bd587..641a911528db 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -929,25 +929,13 @@ nouveau_uvmm_sm_unmap_cleanup(struct nouveau_uvmm *uvmm,
 static int
 nouveau_uvmm_validate_range(struct nouveau_uvmm *uvmm, u64 addr, u64 range)
 {
-	u64 end = addr + range;
-	u64 kernel_managed_end = uvmm->kernel_managed_addr +
-				 uvmm->kernel_managed_size;
-
 	if (addr & ~PAGE_MASK)
 		return -EINVAL;
 
 	if (range & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (end <= addr)
-		return -EINVAL;
-
-	if (addr < NOUVEAU_VA_SPACE_START ||
-	    end > NOUVEAU_VA_SPACE_END)
-		return -EINVAL;
-
-	if (addr < kernel_managed_end &&
-	    end > uvmm->kernel_managed_addr)
+	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))
 		return -EINVAL;
 
 	return 0;
@@ -1834,9 +1822,6 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		goto out_unlock;
 	}
 
-	uvmm->kernel_managed_addr = kernel_managed_addr;
-	uvmm->kernel_managed_size = kernel_managed_size;
-
 	drm_gpuvm_init(&uvmm->base, cli->name, drm,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index a308c59760a5..06a0c36de392 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -14,9 +14,6 @@ struct nouveau_uvmm {
 	struct mutex mutex;
 	struct dma_resv resv;
 
-	u64 kernel_managed_addr;
-	u64 kernel_managed_size;
-
 	bool disabled;
 };
 
-- 
2.41.0

