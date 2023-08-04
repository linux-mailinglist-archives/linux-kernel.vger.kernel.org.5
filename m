Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD57707F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHDS0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjHDSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D282A4C31
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sILSYR0gnJ8A9dpqcei0GUdx0191p3j7ECPYiYKPGLY=;
        b=EfTrG7fUH0Cx+H0Mgx+2C8stlvzpU8awrgnRmY1HUu4dtSuPh4eSLUlqK+E2MYjatZwKc+
        tj55+ZwsHkeb/wLofDpJ18kBMS0DcajFoF4Br8my5rf5BA3rG3qRRJYuXG2OkFOdLZQomk
        FVSksCF/gB/h+rL0ebG+rmlTF81VE4Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-CeNdvE0_PfmMhJq2tLSHwA-1; Fri, 04 Aug 2023 14:24:39 -0400
X-MC-Unique: CeNdvE0_PfmMhJq2tLSHwA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5223d4b9da2so1574406a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173478; x=1691778278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sILSYR0gnJ8A9dpqcei0GUdx0191p3j7ECPYiYKPGLY=;
        b=I4SgxC/F7Owo4xci10aV/6lfTPXKOi3h/FQ4brB8t/kLWJTNo3a/uRKQWqE4QhFXC6
         gER3dWBlsH+w37xNBvuUhBO1HOaquwHGaj9YEet8/WUSiKqZ6ZcxSj3ncDttvkBOSpyx
         4XD3xVR/tQaZVOkK+MaWxvVl+tK4gB2wat+078j9p7htUfxtgbwIXfHp9z85Hl94ukTf
         L1rV5jZmZZ9XTulyZHQ5El7PWKMJFoVzrFqhPQNfe1RLQYeHjLMqY1UxJ4afwujodPXs
         e3IO0LdlrAhXiXt4e6l1KyYj7q69ekeY9h+njObuepwK3V2PII/r92SoBQVQy7qysbqN
         Exqg==
X-Gm-Message-State: AOJu0YyfFx28Z62tvCZO0cGznVY7Qi9zW4XmNwvX/M6pZlCXU+HthiYU
        VoKsAmsfc0W+dC2RFH4SK23WgVdgtI7wU4xnhH6FJr3mwXLjEALD6qY9+bAPQte29CNVaWpaU2D
        l46q6t/BUyEmYNMIgp5UqKZm0
X-Received: by 2002:a05:6402:448:b0:51d:d390:143f with SMTP id p8-20020a056402044800b0051dd390143fmr2168716edw.5.1691173478710;
        Fri, 04 Aug 2023 11:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdtc3GjLhkVTBVp4UpZhrnZWEfIc0NqlSy8j8ZyVB3ZFGvxmr6W4of3EQqVmArV7n8nDbEA==
X-Received: by 2002:a05:6402:448:b0:51d:d390:143f with SMTP id p8-20020a056402044800b0051dd390143fmr2168702edw.5.1691173478516;
        Fri, 04 Aug 2023 11:24:38 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7c146000000b0051e2670d599sm1570383edp.4.2023.08.04.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:38 -0700 (PDT)
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
Subject: [PATCH drm-misc-next v10 06/12] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Fri,  4 Aug 2023 20:23:46 +0200
Message-ID: <20230804182406.5222-7-dakr@redhat.com>
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

Move the usercopy helpers to a common driver header file to make it
usable for the new API added in subsequent commits.

Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_gem.c | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 81350e685b50..d28236021971 100644
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
+u_memcpya(uint64_t user, unsigned int nmemb, unsigned int size)
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

