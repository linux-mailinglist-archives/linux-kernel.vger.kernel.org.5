Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022378DD84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbjH3SvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbjH3NrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95E12F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
        b=X44ubrSmM1rpfeLXq0Y+RPjPBUlu/VHdmKaLrO2s6ZBMvJX5HIQlbcUpz78OsJeysXuFeF
        unuHQ3N7O0xrMiE2+KmBnwpNritORGA+piM7NtCBp5sgZAbdaVE+wP7STBeOWy2tme1zL4
        kmYeUJLNN5ykFDGUk9Gcjq1OZSgkx0o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-xV2FbFoOOL2HsszY-NhH7Q-1; Wed, 30 Aug 2023 09:46:28 -0400
X-MC-Unique: xV2FbFoOOL2HsszY-NhH7Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a5c5f0364dso53522066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403185; x=1694007985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
        b=kaK9/tdMaDDIN42lMK69os1QSma9Y2NHfTmjVA2XAyHrCnRvRsey+Zv6F9eGLmZpSp
         nm5J23LVCPd174kBynSk93QQYuMVxBcbeKgHMQU9hb3iOE0MqmZ743gXa+76qx617ysj
         UbNS5WOur4dMGT/c468OYeGRo12EzkqU/xqaJQ9lbDfLPgvP5HZX+vZLK1+favvVCXZP
         rZx/JUMwFQmkMLT2bpj988V8dJ2CajlK0wEUrf0aQHXocwFRXWaHN6RF1XAWLpK6hcKp
         X7QNjzJ9OqvD4g+8CMTLdPJjRj4LM268PPagepPjYnXXUr+y9nx2Rt1ferJPbdcPsRWm
         aWkQ==
X-Gm-Message-State: AOJu0Ywe38dXc08XDTX7rKEH932gBFdYaVJf+ct+0wp0wgFGPD5UbS3u
        6b1/6LrxAcohYs95fTtn5cMGqdIFo+e+DD4Ei7dtYb49EXRU1vCFebbaKzKfFChECvwyDAwKnwE
        7Q+Z5GeJ8hPub0isuljI9jcsP
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497355ejl.4.1693403185528;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs3XWD3GCd0nxchFLVqW0usUrIz+VOttxkboYOB/XHHWAwTxGY9Rlu6B7+6AhH9DbE4wdw7w==
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497324ejl.4.1693403185198;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174419eji.111.2023.08.30.06.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:24 -0700 (PDT)
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
        David Airlie <airlied@redhat.com>
Subject: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Wed, 30 Aug 2023 15:45:52 +0200
Message-ID: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
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
---
 include/linux/string.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..0e8e7a40bae7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,46 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0

