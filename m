Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157AC7707EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjHDS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHDSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA334C04
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwdeGZqElHaeNok5koZwxqm81zQwPAs60eGGyV3zg50=;
        b=cqrCIuN9WrqKmQzuqf8/N+1GCEgNJWvPj1CF3QOWTcHlv9G5LIL8BL6Ux+yyK5lN4jTsk+
        7MmSWIcg4IBJcORNIrZiSjawKuINVNG7qo9hOGAGMXT6HvGwDl6+gHTEqVUMJzCfMDZhbB
        T7xW/y1gSjnQ9DPz2xPkGJMQ17Ey6K8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-wcjsmUsfPhKYrhRVopyUYQ-1; Fri, 04 Aug 2023 14:24:35 -0400
X-MC-Unique: wcjsmUsfPhKYrhRVopyUYQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bd6ea0d9eso161305866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173474; x=1691778274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwdeGZqElHaeNok5koZwxqm81zQwPAs60eGGyV3zg50=;
        b=S+W5UnRJExHXjP0zps/VkGQ1ovtRn5lih+cTER2MvkuDi81pEOBsi2u3JhjEKOutYm
         AStHyeZJF3DuNyEIDTIGw0mt+1u4p7AaebYIoWI73W794zoUksXIupas2Ip261Ho69YU
         XS5jxNim2eaS3xKMTafTUYWEIQvqgXWrwv4csvKDJnqajsH/+3uCwhQDAO9Ddtsk1vC6
         tKH22SQGEEontqnwCgQo0yXMemr/E4NIKbADA/nJlyX23vl3Ou0gUOrERAscoqXcHCeT
         vvctzLsdKMm3lrZ4SmpPDw2aJOKjk8rwzNy9yGo1uxdJLgCEeqrV3g3bJFngTID1v0zh
         7ypQ==
X-Gm-Message-State: AOJu0YyMFRRq2hwUn9mh06s1kQlwdxE9JbykoCvraQNA468JAAOnq4ah
        FVot4Wb3DvCbsBdv55JOeAMUowRC5d0xftVC8URWbV2qzA3A9QSupQvoyzpaPAbE57xi5FQFT5M
        kTiKQN1ThpvEaBXBxvfAlA+5M
X-Received: by 2002:a17:906:5a5c:b0:99b:65fa:e30f with SMTP id my28-20020a1709065a5c00b0099b65fae30fmr2089714ejc.1.1691173474214;
        Fri, 04 Aug 2023 11:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEryZP9aoJVNn8MC19nvMnlJKcLY3kuJDlB/w4c0Aec7ZI6lMZWBxZ3bUEK2krqN5p5MUOQw==
X-Received: by 2002:a17:906:5a5c:b0:99b:65fa:e30f with SMTP id my28-20020a1709065a5c00b0099b65fae30fmr2089692ejc.1.1691173474066;
        Fri, 04 Aug 2023 11:24:34 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id gs2-20020a170906f18200b00992b71d8f19sm1643966ejb.133.2023.08.04.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:33 -0700 (PDT)
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
Subject: [PATCH drm-misc-next v10 05/12] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Fri,  4 Aug 2023 20:23:45 +0200
Message-ID: <20230804182406.5222-6-dakr@redhat.com>
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

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7724fe63067d..6130c99b6b2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -215,6 +215,7 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	nvbo = kzalloc(sizeof(struct nouveau_bo), GFP_KERNEL);
 	if (!nvbo)
 		return ERR_PTR(-ENOMEM);
+
 	INIT_LIST_HEAD(&nvbo->head);
 	INIT_LIST_HEAD(&nvbo->entry);
 	INIT_LIST_HEAD(&nvbo->vma_list);
@@ -339,6 +340,11 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
 	dma_resv_init(&nvbo->bo.base._resv);
 	drm_vma_node_reset(&nvbo->bo.base.vma_node);
 
+	/* This must be called before ttm_bo_init_reserved(). Subsequent
+	 * bo_move() callbacks might already iterate the GEMs GPUVA list.
+	 */
+	drm_gem_gpuva_init(&nvbo->bo.base);
+
 	ret = nouveau_bo_init(nvbo, size, align, domain, sg, robj);
 	if (ret)
 		return ret;
-- 
2.41.0

