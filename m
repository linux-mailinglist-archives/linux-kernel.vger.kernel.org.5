Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92376752986
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGMRGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjGMRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5AE2D55
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689267915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=WrgNLcj13nbg0a83aC0/Zdhx39gFCA1yb1VsT8rlFJWlEXoSGqK5yOnCJv2+YRwn6hHweZ
        sLFAG2POBKT99LyzndWZv5YZqco6LMTt4YQ50/orv9tdgycZFnqKIwlhmBdwK9fVdHjI32
        SI/MlPyhdKD6myYbsqgoby3gUidlFjs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-4m4TI2sJN9utn4hkupoFGA-1; Thu, 13 Jul 2023 13:05:13 -0400
X-MC-Unique: 4m4TI2sJN9utn4hkupoFGA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a356c74e0so58769866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267912; x=1691859912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=X9plT7qQmODCmUW0CxqW5AJ6wbQ7qYacaMr3oOHJ32JqM8tWmLlM7nTkpFsiVAwJoG
         oDWha5c7K1CrNv1dc06DlgXgkEZrBgN4ZIBnHmGz55/wgXnfE2mXxkETOBBNqztuNgSS
         3i+aBodw+RdeAFhGrIe11VZKr0RBecfydZktim33XMKdrGizgliDBCLqoyzSRWL331yr
         u22Avgi98IcvCnqkABkEgZvTYdXLi1ly4NPUcmS4KG6pW0aJanqAXBebMB3QBKOWDLDu
         nyTlyYOYE8F8H6lx0tCsp3LaNLEzGBPCtl9j/TMIcaPlMJqA31GLD7Xj3yuAS9Q1xF+D
         4YoQ==
X-Gm-Message-State: ABy/qLYfz2p6mym1rUShnNPDzqgEj7dqPE0hWKfpsO/ZEcgaek1u1ZOh
        UUs/+idSGaIRbR+/fMiepz3hp4hLmM97tdGyf9PbZsOXVPQBl6VL9JRf7dPPPQLYXMAU6T3ziTS
        bKg9sN+WRBvODjcs0ufLNKzgj
X-Received: by 2002:a17:906:739e:b0:993:e752:1a71 with SMTP id f30-20020a170906739e00b00993e7521a71mr2073324ejl.9.1689267912643;
        Thu, 13 Jul 2023 10:05:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHckHbTyjMCGJSB33a1xuyToxA5Lv9jbmRxtayiMatm6oRwXfd/mPMU4d/wU1zEIEwWQbE5w==
X-Received: by 2002:a17:906:739e:b0:993:e752:1a71 with SMTP id f30-20020a170906739e00b00993e7521a71mr2073306ejl.9.1689267912463;
        Thu, 13 Jul 2023 10:05:12 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090616ce00b0094e7d196aa4sm4179835ejd.160.2023.07.13.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:05:12 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v7 09/13] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Thu, 13 Jul 2023 19:04:04 +0200
Message-ID: <20230713170429.2964-10-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713170429.2964-1-dakr@redhat.com>
References: <20230713170429.2964-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting
fences.

If a fence context is killed, e.g. due to a channel fault, jobs which
are already queued for execution might still emit new fences. In such a
case a job would hang forever.

To fix that, fail to emit a new fence on a killed fence context with
-ENODEV to unblock the job.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 7 +++++++
 drivers/gpu/drm/nouveau/nouveau_fence.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index e946408f945b..77c739a55b19 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,6 +96,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 		if (nouveau_fence_signal(fence))
 			nvif_event_block(&fctx->event);
 	}
+	fctx->killed = 1;
 	spin_unlock_irqrestore(&fctx->lock, flags);
 }
 
@@ -229,6 +230,12 @@ nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel *chan)
 		dma_fence_get(&fence->base);
 		spin_lock_irq(&fctx->lock);
 
+		if (unlikely(fctx->killed)) {
+			spin_unlock_irq(&fctx->lock);
+			dma_fence_put(&fence->base);
+			return -ENODEV;
+		}
+
 		if (nouveau_fence_update(chan, fctx))
 			nvif_event_block(&fctx->event);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
index 7c73c7c9834a..2c72d96ef17d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
@@ -44,7 +44,7 @@ struct nouveau_fence_chan {
 	char name[32];
 
 	struct nvif_event event;
-	int notify_ref, dead;
+	int notify_ref, dead, killed;
 };
 
 struct nouveau_fence_priv {
-- 
2.41.0

