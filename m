Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00F752980
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGMRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGMRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993902D50
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689267906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEv7G0CEYOPGW2iDjZ4bQ7xPP+mjrUkHdLemyMCnVvw=;
        b=FJ5UULOH422tP/0ZB/UlTS08v/f5yvx8SY4OCRMZTEeg6E0Qr8f4uxLTP1bhlgXOZ9ZWVt
        IJ+spYxeLBzEAO2s7a2UNrJIP/ZfVk6ckwrSVqRQj8hnlyaqyibxbFUomCqdIFG/EXy3f9
        9zltKQlie+MbtzX0Q+WC8cXFSK/hRhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-RkPDYurGMHyFfv6kMLC3tA-1; Thu, 13 Jul 2023 13:05:05 -0400
X-MC-Unique: RkPDYurGMHyFfv6kMLC3tA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3141325af78so663378f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267904; x=1691859904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEv7G0CEYOPGW2iDjZ4bQ7xPP+mjrUkHdLemyMCnVvw=;
        b=IMH8nQlcL06us7qkXZV9mcGB0+ROoCYf3F/iT9PbQKX9s4WAbHnz4LbyAQ/gwpR8IB
         NoMvf60IgpT5Hnpf7D9z2CzPuynoGi4ahq8lH77lHisJq6ItC4ZpcncL2J6pYIsc6fbn
         +WAAJJdnwwiqVbOsifHjiHD4rFNv8LMT9V+LjjapNDhesgaNtrgoxdOA0RfjrwQ+4g1J
         8YJdJXfqE0GekKeKKBrItVw5lDmKkQMFW+C41YLOQ/NeexsgBmi/ksSFgiQ7cdcpWFrv
         I3xdo/y7rqCWZFf5/OXdb2H1WfpMC4Ld6nRG+Jskot+/dCV9RzX8i1JpNhlRXBNGhGK5
         DmWQ==
X-Gm-Message-State: ABy/qLbg6U4+xOutjMD3bITgv+K4u4qd3zmU6Dn90OevYuXl2kWgt2c9
        q6NR7T3C3pAj0x/nf+RYQSr4zmGeJMxjHUebUaEIy8N+V+jct7JYD2/xWQFI34K4dXru1UL0ANY
        GO6rJlhfPXi6unWKQi6s0GrOD
X-Received: by 2002:a5d:500f:0:b0:314:37a:4d2 with SMTP id e15-20020a5d500f000000b00314037a04d2mr1881504wrt.60.1689267904130;
        Thu, 13 Jul 2023 10:05:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF056mkLn94E+lKHndYR5EU4ydy3QCAICJDC86xIw557hHcn4RjCQJ4RaRlRWXwLJY/mxbcrA==
X-Received: by 2002:a5d:500f:0:b0:314:37a:4d2 with SMTP id e15-20020a5d500f000000b00314037a04d2mr1881473wrt.60.1689267903898;
        Thu, 13 Jul 2023 10:05:03 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709067fcb00b009929d998abcsm4194749ejs.209.2023.07.13.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:05:03 -0700 (PDT)
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
Subject: [PATCH drm-next v7 07/13] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Thu, 13 Jul 2023 19:04:02 +0200
Message-ID: <20230713170429.2964-8-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713170429.2964-1-dakr@redhat.com>
References: <20230713170429.2964-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the usercopy helpers to a common driver header file to make it
usable for the new API added in subsequent commits.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_gem.c | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 81350e685b50..20a7f31b9082 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -130,6 +130,32 @@ nouveau_cli(struct drm_file *fpriv)
 	return fpriv ? fpriv->driver_priv : NULL;
 }
 
+static inline void
+u_free(void *addr)
+{
+	kvfree(addr);
+}
+
+static inline void *
+u_memcpya(uint64_t user, unsigned nmemb, unsigned size)
+{
+	void *mem;
+	void __user *userptr = (void __force __user *)(uintptr_t)user;
+
+	size *= nmemb;
+
+	mem = kvmalloc(size, GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(mem, userptr, size)) {
+		u_free(mem);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return mem;
+}
+
 #include <nvif/object.h>
 #include <nvif/parent.h>
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 45ca4eb98f54..a48f42aaeab9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -613,32 +613,6 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
 	return 0;
 }
 
-static inline void
-u_free(void *addr)
-{
-	kvfree(addr);
-}
-
-static inline void *
-u_memcpya(uint64_t user, unsigned nmemb, unsigned size)
-{
-	void *mem;
-	void __user *userptr = (void __force __user *)(uintptr_t)user;
-
-	size *= nmemb;
-
-	mem = kvmalloc(size, GFP_KERNEL);
-	if (!mem)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(mem, userptr, size)) {
-		u_free(mem);
-		return ERR_PTR(-EFAULT);
-	}
-
-	return mem;
-}
-
 static int
 nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 				struct drm_nouveau_gem_pushbuf *req,
-- 
2.41.0

