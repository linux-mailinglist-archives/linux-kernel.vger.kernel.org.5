Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7A7E3E57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjKGMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjKGMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:36:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7246B7;
        Tue,  7 Nov 2023 04:25:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460EFC433C9;
        Tue,  7 Nov 2023 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359933;
        bh=jzqatYmOq2buJSDJED14vbZpnhdtsSxyyg6oWwGzXzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgcE9kgXlcdc9v697GRBM3r5BtySBFjjQhZ+x77VbM7bnn1sYXk9KrvZ/M2tVZ8II
         xxkh/Hbea/Y/T293h0IslWAkkF7Xm4xxIrOakMI+6I9r6tGjioAeJG1FAqCfpnNXO2
         7NLzIepLwrIlT3O3/9Y3EMcR9M2Aes0QMAKXwg76B5bkK8MwfnBgkOpRsTa7+Ou0ZJ
         ky0cTmt2O8WDSy6LX7L1ONfqyHfSw4wnB4oKy2h8ebC/22hqq+/M7FdVGJUn6qLn9g
         nKhXKM/Ejf7FUsmfqlTFb04sawXtF+Q1pgP5KhKkTqk/J+X7Pdf0gEZJOV4ko6j8Fg
         KFjfWzvDkeKmQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 13/37] string.h: add array-wrappers for (v)memdup_user()
Date:   Tue,  7 Nov 2023 07:21:24 -0500
Message-ID: <20231107122407.3760584-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 313ebe47d75558511aa1237b6e35c663b5c0ec6f ]

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
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-3-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050f..debf4ef1098f6 100644
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
2.42.0

