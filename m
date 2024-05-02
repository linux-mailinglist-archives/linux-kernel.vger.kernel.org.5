Return-Path: <linux-kernel+bounces-166601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EB8B9CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA4D28AB5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E0153BCF;
	Thu,  2 May 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1eQ9ouS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE356BB47
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661548; cv=none; b=Rr+mPfyANzKJ8NqYViqtIovsOXwVLYeQt5KHYw0+MWKNuox1yCCVCDQ+2/nd+R/ila19X2ur3nVusgdM+AQYXb2DMuNS+VmrKeF//0/HkKQiV05+O/xmsSclMI5WTf1o5Zq0sS4o7Os4pTLw4YXvXOd296CVIly9ZPzXS2w2OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661548; c=relaxed/simple;
	bh=zLbS8ODF0z137yrUyr8Axq4iaxcWoLKgEWh3WjjWlz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L+GSeLO7vW4ZmINHMsa1+PaI7H7WGPHz2ITcZEZ41a7yRSkGswKQqtK9yODed3GE6kBhoT8P8WtiCtNQceL/Viv2NE5swMkE7FeGdnMnhIx+fmCV0Vsu+fpgzDqWnikTSB/XRHKyfwsuhnwDtDhqAbDuDYi55tlEoet1pP6ho7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B1eQ9ouS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4f341330fso74012215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661545; x=1715266345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWweKXFrFEkCsPdE7nP0/G3wcxDTmjAB5LxHWc+P9DU=;
        b=B1eQ9ouSJZoiX54Yb8DKJg9j4EINyOuFmSltlE3wm5g8iQnx9tamU0vTl9AawdGPcz
         xhpEA54DsVFsqxWSLi+7YgQTWqS3ZJXgJ8juDU3wrQ70OiyKt2m/FWlXxFOenj7RoHrC
         GU+ni0ZbNC+oTVIeA7brSl6lJejW9cMwMd7LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661545; x=1715266345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWweKXFrFEkCsPdE7nP0/G3wcxDTmjAB5LxHWc+P9DU=;
        b=gt3sedN/IvPFcSs43Wrp3C7sbAsoa3NodWS8zDcoiCDljkRBtrJmvbuAQ+8jIOSr6z
         5qBSJ0/EMkDXkDWfVLwAPDlYNlMI7PgXBHSU8E7LVE1PEpCFVwQSjB2ZwVxLw65+SJtg
         QmsRn5xt2QSdSzDNlDLxq5nNCFehwFvYBoIr/dWGh6TrathPQGgeS7iB77frs9TtJea9
         XBVQCJKWfMx4VfRvoJzWnT0LqroLyArrwdwOsErbK4hFh/UPwb9VHkoBLiw4GbisEajB
         zaHqcbI+pUWXsUlK4ufR/HCghO2faTTTbDaahDKtUMOFujXrmAua8B/2YhD3k3HXc97b
         jPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlSsoNSIT31ZzVBPREPFcxp34iPS9VwZP2nW9r+d8doFNOeta79pRL4Uih/zL/DSmQZlpdthjOYF0zfzPUTbva2f7jQ4b+ljO2Cj1e
X-Gm-Message-State: AOJu0Yxp0jFaNLaqnqUTHBfe+V+5SLPdpglJLRS+WYpKK2THjJHsOgsC
	NXYbH0QGpBxci1BjXIPw2dMSqOu/tLsuVVErbMn2N5Zm2OXv6dfkXQq3BFo5ww==
X-Google-Smtp-Source: AGHT+IHVPNhcIilbYRycs9H+6Ov6JMpElqWXMVCfNskH2RvhYuYMOEilYAa/5fUncOtEioHR1Q6A+Q==
X-Received: by 2002:a17:902:d3d3:b0:1ea:9596:11df with SMTP id w19-20020a170902d3d300b001ea959611dfmr6029699plb.32.1714661545446;
        Thu, 02 May 2024 07:52:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qc3-20020a17090b288300b002a46aca870asm3255359pjb.33.2024.05.02.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:52:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] string: Add additional __realloc_size() annotations for "dup" helpers
Date: Thu,  2 May 2024 07:52:21 -0700
Message-Id: <20240502145218.it.729-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zLbS8ODF0z137yrUyr8Axq4iaxcWoLKgEWh3WjjWlz4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmM6ilI5lXYV7EB9Om3uCGMQdscNOrpz9iX9JHo
 hBuJ9ziVhaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjOopQAKCRCJcvTf3G3A
 JuoZD/9xVonPh1Os8i0HOHmdDbzpC1BsWB7Sit1KHrwZQNGkNkFve9Pd+uTE5t+yry5bIhJxESA
 L30S5XBnG8azcbRX3JYx80Y5TTC5FdvtDRTF6zZbKZeZOV+Zch/dulo6/fjsD7rIbSGlcyh6ja8
 pyOKmu7Ydc75t65+xRYmNmnBdxo2UdqaQAY0YdyqYmAD6GTz68Xzezhp9jhS6rNgKIGRcJkFsqi
 C3rr22VLZqrlsin0DwU0MMxf5YHyohWGQgERA8It+DTRaRnBnsrXYqT36Ftl1w8LVQDbM/QyCFT
 /D0B6LI3XniHkh/uPU69b5hvSw+vBbUg/On5q5C5dGFlkukVIHRy8WC4jBwY/fLQSr8DO5TfGtl
 5USIDp8uMjNmTeF2UBES5NbkTLrDPHxWOzSEG0ftNpNXS+gduX5eBhQIajOeD4p/kMnCz38XBIU
 H/KbLLX1VYyOOSQ89MKVtWCDBlr1DCSKY5QwbLU6VPaoUmR6heFdu/IvDjPOme4jHrMPYl/bIqM
 +USJvManf+F8SYtWyP8Tx4rnAUwiwDr2HRzP+r5rilPY7DOrhAz57hIE5cd2zmHCQfwCaumOYcY
 2h6Q29virxplEzaTzxhB6CtZjnVa9Ym0Kg2dAky7dx2NoC/8CC0jiB1s/AVWeVAd1qMtQW4JIl0
 I1Q3e9n 84x3YA9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Several other "dup"-style interfaces could use the __realloc_size()
attribute. (As a reminder to myself and others: "realloc" is used here
instead of "alloc" because the "alloc_size" attribute implies that the
memory contents are uninitialized. Since we're copying contents into the
resulting allocation, it must use "realloc_size" to avoid confusing the
compiler's optimization passes.)

Add KUnit test coverage where possible. (KUnit still does not have the
ability to manipulate userspace memory.)

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2: change variables names to keep added line continuation lengths similar
 v1: https://lore.kernel.org/r/20240501233201.work.732-kees@kernel.org
---
 include/linux/string.h | 13 ++++++++-----
 lib/fortify_kunit.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 86aa6cd35167..10e5177bb49c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,8 +14,8 @@
 #include <uapi/linux/string.h>
 
 extern char *strndup_user(const char __user *, long);
-extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
+extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
+extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *memdup_user_nul(const void __user *, size_t);
 
 /**
@@ -27,7 +27,8 @@ extern void *memdup_user_nul(const void __user *, size_t);
  * Return: an ERR_PTR() on failure. Result is physically
  * contiguous, to be freed by kfree().
  */
-static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+static inline __realloc_size(2, 3)
+void *memdup_array_user(const void __user *src, size_t n, size_t size)
 {
 	size_t nbytes;
 
@@ -46,7 +47,8 @@ static inline void *memdup_array_user(const void __user *src, size_t n, size_t s
  * Return: an ERR_PTR() on failure. Result may be not
  * physically contiguous. Use kvfree() to free.
  */
-static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+static inline __realloc_size(2, 3)
+void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
 {
 	size_t nbytes;
 
@@ -285,7 +287,8 @@ extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp);
+extern void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp)
+		__realloc_size(2, 3);
 
 /* lib/argv_split.c */
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 306522fd0aa2..d2377e00caab 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -363,6 +363,31 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static const char * const test_strs[] = {
+	"",
+	"Hello there",
+	"A longer string, just for variety",
+};
+
+#define TEST_realloc(checker)	do {					\
+	gfp_t gfp = GFP_KERNEL;						\
+	size_t len;							\
+	int i;								\
+									\
+	for (i = 0; i < ARRAY_SIZE(test_strs); i++) {			\
+		len = strlen(test_strs[i]);				\
+		KUNIT_EXPECT_EQ(test, __builtin_constant_p(len), 0);	\
+		checker(len, kmemdup_array(test_strs[i], len, 1, gfp),	\
+			kfree(p));					\
+		checker(len, kmemdup(test_strs[i], len, gfp),		\
+			kfree(p));					\
+	}								\
+} while (0)
+static void fortify_test_realloc_size(struct kunit *test)
+{
+	TEST_realloc(check_dynamic);
+}
+
 /*
  * We can't have an array at the end of a structure or else
  * builds without -fstrict-flex-arrays=3 will report them as
@@ -1046,6 +1071,7 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(fortify_test_alloc_size_kvmalloc_dynamic),
 	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_const),
 	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_dynamic),
+	KUNIT_CASE(fortify_test_realloc_size),
 	KUNIT_CASE(fortify_test_strlen),
 	KUNIT_CASE(fortify_test_strnlen),
 	KUNIT_CASE(fortify_test_strcpy),
-- 
2.34.1


