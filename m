Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145767E4DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbjKHAOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjKHAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:14:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443FB10F1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699402402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6qqEPqKINJozX4kiVm6oeIhikVcMg+GmtiPQ0sRpWA=;
        b=Wc97O2eqaBihmI38/4glVdf1I3kMr/+2+vrDXNNx6Ph6zmrv+2yDI8ZQimi3K8nP8mCctr
        loD9SAtRnGnRivDFwseMAoD7CFKN2mxq+qo+kwBOWbUQStHFLRiKn+NawePssCkXVu6K97
        SNMxTUb+7gQcPQIrTeXtdHvwQtiP8ok=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ZS7Cl2dJMeiLYZx82wsOhA-1; Tue, 07 Nov 2023 19:13:19 -0500
X-MC-Unique: ZS7Cl2dJMeiLYZx82wsOhA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5161838d8so63107361fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402398; x=1700007198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6qqEPqKINJozX4kiVm6oeIhikVcMg+GmtiPQ0sRpWA=;
        b=iLnamZOzFglYpvY4i8dkilpRVCSg55GGjbvdwWbywO2qIrpr54Y4u0UsH5sTOU2kZ0
         QcpIr/z651S+PeouCmO/OVqksbMFMT/W7AQOFgDduEs/pAeWPR6d+RuFxFEYqIjNnfZq
         JpuJSlGiwuIJRYy7OBO00zrevAH+F/PBODTEqPA75aw0ycAfqFgAEJD3Sw7U/XlUutu7
         U81OF0ocF/s5ix3cFX/kdIrrRQIABESoTTkPOA9egtRMzeH4+HM7qPMS/4xn0b+1TBi7
         Ny4oIbwJyobTX16yFQjwD/FKXIk0+uDbHGcIT8pzF5oFTauYOESmphJDd9Ky0FFNWCEq
         18Rw==
X-Gm-Message-State: AOJu0Yy631rYvXnVc64kxALjheKQJ0RbKSw/gep7FQ213164sawI+NR2
        B2sBTY+EVQfj0cwbd+L0yzQRG7Zkiet+iymqeqwZywcTm4SeAWiapgno+u/xjXzREMpRc7possJ
        XsQEqcYzDavc4w4XPgx0kUds4
X-Received: by 2002:ac2:5104:0:b0:507:a58f:79ad with SMTP id q4-20020ac25104000000b00507a58f79admr97839lfb.61.1699402398210;
        Tue, 07 Nov 2023 16:13:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD+Xkq0u6oAI8m3oyiBP2SEe6J/IOUMaiSjmHPhK06TZq3qINW3kr5HPMHObx1V1vCSwDkRQ==
X-Received: by 2002:ac2:5104:0:b0:507:a58f:79ad with SMTP id q4-20020ac25104000000b00507a58f79admr97816lfb.61.1699402397864;
        Tue, 07 Nov 2023 16:13:17 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id m9-20020a1709060d8900b0099cd1c0cb21sm168299eji.129.2023.11.07.16.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:13:17 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH drm-misc-next v9 04/12] drm/nouveau: make use of drm_gpuvm_range_valid()
Date:   Wed,  8 Nov 2023 01:12:34 +0100
Message-ID: <20231108001259.15123-5-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108001259.15123-1-dakr@redhat.com>
References: <20231108001259.15123-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gpuvm_range_valid() in order to validate userspace requests.

Reviewed-by: Dave Airlie <airlied@redhat.com>
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

