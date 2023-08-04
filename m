Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF57707F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHDS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjHDSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD84C05
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GC244PIhZZVEaEMVp/i0uN0Dlx9b0oRSDCpI7qyebQM=;
        b=WYJ6uujKgJSlNu3ZFnWwL0dkn6Mu1X29VMhOEy5kN+us/TeEth//4c9fc7G2PwtEiqehmx
        kJuusYmq9iXcFYAhuOHC1Lr/mVopV3oAjrGP7+u1INcc3RNQnygm+uJqe7T6f/8FpxGOjC
        85ILiHeecM00X1YdT0Wem/IqOVkFJHY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-KHT26yE3PzOC74qHErVe-A-1; Fri, 04 Aug 2023 14:24:49 -0400
X-MC-Unique: KHT26yE3PzOC74qHErVe-A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a356c74e0so150976366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173488; x=1691778288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC244PIhZZVEaEMVp/i0uN0Dlx9b0oRSDCpI7qyebQM=;
        b=fxm/nR5gdzcu4Ahq9uHko7gTl7+IvotrQDTM0O3U1VOc+sm709n+kqnKjpE7HN0imt
         c1ncfcEZNTKcMFVUANuy5X2VHLJBr/VNRb5waHpGnLahTzJO5JdAi0ipa3olhhjr2QD7
         JnaUG6ixuH/umShsgv6nwAWEq4RJxIcwVFZ58g2lUoZIFbaF3nYr3RRoJC3sr4vh70D9
         D8AVmjvZWIRwucmagizYIjvK8sSvcs7biEGvBwpqTnj5ga0BpACYvyQQz3miIGUjOVkp
         rW2kp+JNOwyO0Z1QNE/cmtdjvssyasUEDDDyhvz263LvZ/d2KwP6Z8Qj8BbxZKpDiEQP
         ZHsw==
X-Gm-Message-State: AOJu0YzgZbk9OBFVNrRbNoamdGizB1qizD0Y0YM6gIRC3G9VIhdwAj+a
        xZLikzZ2YjgHCwW3Bomcii78KdwOIQatLKsA0RUHJnEjTqouEYiEt87/uMXKwv2bx5EcUjlo2rx
        lu29Kn2oN6OhaqZJjgLHtmIyH
X-Received: by 2002:a17:906:31cd:b0:994:2fa9:7446 with SMTP id f13-20020a17090631cd00b009942fa97446mr1890096ejf.46.1691173488304;
        Fri, 04 Aug 2023 11:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNm88b5/GKa7FD6Aqs6b0cTELulEnpK8lpJSfesvb7pgDI0RFk7OgObhebiBKeVpSn286rFg==
X-Received: by 2002:a17:906:31cd:b0:994:2fa9:7446 with SMTP id f13-20020a17090631cd00b009942fa97446mr1890079ejf.46.1691173487983;
        Fri, 04 Aug 2023 11:24:47 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bw4-20020a170906c1c400b009829d2e892csm1674052ejb.15.2023.08.04.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:47 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH drm-misc-next v10 08/12] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Fri,  4 Aug 2023 20:23:48 +0200
Message-ID: <20230804182406.5222-9-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804182406.5222-1-dakr@redhat.com>
References: <20230804182406.5222-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Dave Airlie <airlied@redhat.com>
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

