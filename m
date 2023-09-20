Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD277A8081
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjITMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjITMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA3AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
        b=MPqOrPinGAIlwW9zbKvBuoiC5cUV1gkN9gmQA/exWlTN3jYn5voTpXGWX50+v3+2UakWPH
        RAhVQyvCZ70g+yio6sYh/ZF1CKNQYkUX5BZoo6teuHlJD+ANZwJXEI2yGFmWrizNkPLEjX
        H4MHQGW4rXc6KBMy9JJ/y1Xx1c5FsK0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-7ALJkzjOOQaSZyuL75OXHQ-1; Wed, 20 Sep 2023 08:36:43 -0400
X-MC-Unique: 7ALJkzjOOQaSZyuL75OXHQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ade76f4a44so68123466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213402; x=1695818202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
        b=eGJEunD4eC44MgMBDdPo9SX3vq60+aio33NM2PcqDKD/Iz6gvVGB3+jbVX/kJOmt1B
         dDR88DgCLX8lAu/PU3pDPY/p9r0vJ8/fCYgdxSuaKZQ8Mrl3XNymxgxDQWQb9S7vRyrP
         WOEVLpeLo7RpGtZPciO7EhysSxYe/O/mnkT/7Qz1SiXP3t+nAm7+Ox21EZ9Slvu30ZG6
         Wj1S/OCM7v2MS5nHqDr0YnD9QORpJAkP3Q5+pq8hUxanhC5cMTCWlrMCW2FDCujNbhTQ
         y+RxZ5qUCoriFTJutMKjWre6nHnyvWsGHqzq3fVd+cnNDbrCcyH1llPd92hHoi7eKYV7
         CGnw==
X-Gm-Message-State: AOJu0Yxnq/lwdfrEBb+ZtaBqdXtxI7JgbnGjWDJYrrTGp2Dtnkn7jwNh
        DfiRLB9w3jkfqleVVFuzwvPxbDV1cKQE0aqhhViN73mmC0d8w3QoOEsHvb+nG83ANOi1lO/0fiD
        KwuhwyO9DdwK+/SHuXoSBdegU
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815595ejb.3.1695213401728;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERwQ2SjAJQSsC9ZRe6AiF2nzMLomaRThlvgCuHfKcv/TAIMXpcfLWGpl0wj1aEZwFhaqVjcw==
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815563ejb.3.1695213401348;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm9348305eje.176.2023.09.20.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:37 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Wed, 20 Sep 2023 14:36:09 +0200
Message-ID: <20230920123612.16914-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..debf4ef1098f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,7 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0

