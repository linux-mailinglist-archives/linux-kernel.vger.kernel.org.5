Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E308F75A348
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGTAQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGTAQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC02108
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689812120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=C2J8692IAAq18gcx/iQIfsXA15//o4IWFVQl2MXgyKAco43s0b9FcTH4lqUFEWVcE2xbvH
        rAqr78wEDzu6ITTIQFmht0vGMHRDdYto5uGr47WV4by0aOhirweLrX43XwwOthODCMYU/r
        kXD8inZjOaaSwF8YrdMc6/cb4v6HCk8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-dB5nx_DzPEWfyspaQCHVaw-1; Wed, 19 Jul 2023 20:15:19 -0400
X-MC-Unique: dB5nx_DzPEWfyspaQCHVaw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993831c639aso14553066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812118; x=1692404118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=Ea/mh/3IHrFK2MDLRqVuxG9Ud+GwFKPCbgP3ulop7Bg5JlfVe8lfCiblXxbhU6IN+Q
         2iw4E1a1dtp1t9Romt2wv4ET/nEtWqFUcOm9d2mGth/tsh7XIL5Ftd6C8fchvPXCN4EY
         BnVknfQIuoqlo1B4ZBjze/EcJBI/NSBC9cnuhNiEpefQAZRuip+n/xYH6LT0XNPW+fZO
         EwyXYgBVqrheZ6JXD2O6W9YjodNLE9ZUfSus31n4ewQhcDZeJF38UtIH+Tm592clYztM
         c6HDJ1pMWHs92MKYppi+mwh/N31cXGlHpmEnbg6t+y/pclkRG+Xd1e25ovMZfgTMJHvW
         3Bdg==
X-Gm-Message-State: ABy/qLZPmqWk6UU9ohuwNyWFbw6Osh8tuvoWD8XBQHbCnCsFDzX/NZTo
        Gj5ceqqLJVCFl5e14Z0eCqxJujwQ+czoLGJ9G+MXv6/c7ra84+VVInkbVlHQz9l0WFhQSHWase7
        3kZai4nOgw27TmuLGIQRi4w9E
X-Received: by 2002:a17:907:da6:b0:992:b928:adb3 with SMTP id go38-20020a1709070da600b00992b928adb3mr901051ejc.54.1689812118003;
        Wed, 19 Jul 2023 17:15:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHa8q78eRCT9mzZQfSzXoKE/kSwuJuwQ3ITBz9WxHl26tCWAX/ns/AgxlMnhDJjuuJMUh0tUQ==
X-Received: by 2002:a17:907:da6:b0:992:b928:adb3 with SMTP id go38-20020a1709070da600b00992b928adb3mr901023ejc.54.1689812117799;
        Wed, 19 Jul 2023 17:15:17 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id gz5-20020a170906f2c500b0099b48ad487asm718119ejb.93.2023.07.19.17.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:15:17 -0700 (PDT)
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
Subject: [PATCH drm-misc-next v8 05/12] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Thu, 20 Jul 2023 02:14:26 +0200
Message-ID: <20230720001443.2380-6-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720001443.2380-1-dakr@redhat.com>
References: <20230720001443.2380-1-dakr@redhat.com>
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

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7724fe63067d..057bc995f19b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -215,11 +215,14 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	nvbo = kzalloc(sizeof(struct nouveau_bo), GFP_KERNEL);
 	if (!nvbo)
 		return ERR_PTR(-ENOMEM);
+
 	INIT_LIST_HEAD(&nvbo->head);
 	INIT_LIST_HEAD(&nvbo->entry);
 	INIT_LIST_HEAD(&nvbo->vma_list);
 	nvbo->bo.bdev = &drm->ttm.bdev;
 
+	drm_gem_gpuva_init(&nvbo->bo.base);
+
 	/* This is confusing, and doesn't actually mean we want an uncached
 	 * mapping, but is what NOUVEAU_GEM_DOMAIN_COHERENT gets translated
 	 * into in nouveau_gem_new().
-- 
2.41.0

