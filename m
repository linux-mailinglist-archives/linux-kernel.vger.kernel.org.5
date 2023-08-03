Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD276F01B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjHCQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjHCQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF243C1E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691081593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLzavWF6HUG+3GGQgH2DTq7sDOog3ykOR8e7MsGbNA4=;
        b=iOzUTQVQfawBYLlyvNVHHGIs7bxIv6Gk+twELaKFRRM0SCzecp3LWDwsbPd0myhl/ZuKZy
        zuYprgh/mmNVSeYctxBKoZYCHOTanpfgU43WsjdMcw4FrDw5Kc8zfFbFATbszsxfEVitOE
        BPeuKnuJajBinBWPL1fqMHtOzTwjfGg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-6u1ABCoCPKiQeLKJXTV2EQ-1; Thu, 03 Aug 2023 12:53:12 -0400
X-MC-Unique: 6u1ABCoCPKiQeLKJXTV2EQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993d41cbc31so78314766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081591; x=1691686391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLzavWF6HUG+3GGQgH2DTq7sDOog3ykOR8e7MsGbNA4=;
        b=dSUtDxWpSIUfdQJYrXlSGrG+E3/2MsJ4Phdj7cfVha5zcl/3nVNpqT8467kWGX7ul4
         BYpQiE7I7E3Si3HR06iT8qz3D59JCsqjiaLPxI8eDEIRxsYjL+Ei/7oUkZ3zwb3MqZI0
         i1GO2anR2l5anGwJJY24JLiSIqWlZctNTOs3w6REaOc5+Z2hPI3YV1jd/ragfQE3VDaL
         HBA1jt1lVpqkMk5K6oPzHuDokjN7IEJMalE73WqNyCpqymkeSsCRQuYsPyCr776Ddp4x
         I9XBM5EG31X1PBiZBpcppnzsFbGv7NUxYFwBPqgQ/NfO8bw+B/JQ1/pwEI4CvWHRneFP
         R9fA==
X-Gm-Message-State: ABy/qLbBx7CJVueBq1qRnFLkgiBnNhFTNvdU+la0stWIYSQiRR71tz2Y
        9m8mlEjVpIqPFRFKqg3+jlKWYp3fAiuoLVsL1hAfsvDYfp14FWYeJVEPpHjhINhAI0GgzWhsRxs
        MtdjQ+Tuebpi+ax+Fl+TOb7VD
X-Received: by 2002:a17:906:73d8:b0:99b:de2a:d9a6 with SMTP id n24-20020a17090673d800b0099bde2ad9a6mr8157548ejl.41.1691081591074;
        Thu, 03 Aug 2023 09:53:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH88VVUyeljJh/RTuLjx6dMZVKmwPisfXTau5q9VkuIQhzKoeDHKmSMdudiTm0zRh3+A0gk6w==
X-Received: by 2002:a17:906:73d8:b0:99b:de2a:d9a6 with SMTP id n24-20020a17090673d800b0099bde2ad9a6mr8157534ejl.41.1691081590887;
        Thu, 03 Aug 2023 09:53:10 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090612c700b009937dbabbdasm61145ejb.217.2023.08.03.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:53:10 -0700 (PDT)
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
Subject: [PATCH drm-misc-next v9 05/11] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Thu,  3 Aug 2023 18:52:24 +0200
Message-ID: <20230803165238.8798-6-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803165238.8798-1-dakr@redhat.com>
References: <20230803165238.8798-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

