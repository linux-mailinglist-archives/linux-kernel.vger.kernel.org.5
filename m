Return-Path: <linux-kernel+bounces-45207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0017842CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4172C1F23B74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F337B3C4;
	Tue, 30 Jan 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS+1nSpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E967B3F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643385; cv=none; b=W3H7uKJQ2RN4uYT8VdOle7oGrgH8+dxROq6P8hbVufvRH63fhXbcNd+7G+Bqf7DFCxcgIZIyJvw0zXSWzcJ8eSMDbecFcFEfjVVMDaD6aFY/UNi0HfN73H6CijMoXl+bfqH8aRB4ZnTeptU1ePWc+mtszdDtGKap3ymXlwJOe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643385; c=relaxed/simple;
	bh=GCBfd5mLJbvPUMTeQRHRUkl80taoMNksfKJ3w5SuiY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpM6qMuEK74ufPyAT1xtBbDRecSxFSgX6rEux6uxiSZZyKoNZXemyM8OuLG2R2N+I1XrCYtdEpzEOUJGbVJ3vJ7JBA0LlWFd2j8MTJYGkFM0ESeCCbHPuwgKPkMRglPkieQNc6sQjpvDXP1eSWkHAbvjuAxhcD6rhrk5HPbwGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS+1nSpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eO2tfSCg4jg2tkHiP+PqLw0E0D3ueaSVlWmZEShgPks=;
	b=DS+1nSpOat1PlN1e/csUiGxwgfxe3hGn+7uJdLP0gXVMJ5/QpxgntL3ZhChhBaojLMDzT3
	npNn+XTdPD6oxkPyt3+KjC2ntRrd8HSi8sYKBa3Hp0mfxNDhWi6XU2XztRp8CB0mRqxTWY
	5a5YnaHGNnBVQ6jAWi6dEe0N5M6kWJA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-70N-30K7M7yV1PvzLejtKg-1; Tue, 30 Jan 2024 14:36:21 -0500
X-MC-Unique: 70N-30K7M7yV1PvzLejtKg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7833761135dso771321485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643380; x=1707248180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO2tfSCg4jg2tkHiP+PqLw0E0D3ueaSVlWmZEShgPks=;
        b=rbnO90op1xQRI6uB1pKvg/e1fNXV7XUVXk1KBeIvI3fCP/262OwktAZmMp9lmmewtI
         MLgaibKNGgVnXcRAlSqTLjwKMcNVT7Dh73xrwoSLhRnOh8T2wFJBplXIlelwNsh1OMk+
         WY3oG3tTc+VZB34BPsGw3a6XPHNiUFptmlgr0Os06vyjUSjTHfgtGAAao3HoIyn10qpo
         bUepY9otgZjcavDWeE/6xPSE2Mw2c8u+XpjzunerAt/laKVLxwcz6q83MxjDHk9DezeL
         YXJROhtoAZMZNA0bVhzJa7kEoF7hmQMOL2UvuGCI+tYzHEMKyJ1pCdHzbEmk5PMGNuzL
         uCSg==
X-Gm-Message-State: AOJu0YwiOskFh8ENW9Uj/Zj1X6TM79PsfDbR/gnOh9AMWJtixWsDdHGC
	Y5I9AjBVD9bO+g/e2EmexXVJ3Wl+SeYO5MbsAm6wf8L14fpDjtJNJwF3wY5oCDhVEm71BHmuKpj
	T1wU6K4f5N1qShWmfcnirNlxUr0txh1VJWpzwhIyjSmmrlfWCfr9hRbLYCEIP
X-Received: by 2002:a05:620a:4002:b0:783:fa44:b578 with SMTP id h2-20020a05620a400200b00783fa44b578mr6559166qko.34.1706643380412;
        Tue, 30 Jan 2024 11:36:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYC19g5MZRZIgIwfdR143MC6lyXsC0CINs2FqXf6m+Mluo9eI+lN2USg0Jt3opdf0Zny4U4Q==
X-Received: by 2002:a05:620a:4002:b0:783:fa44:b578 with SMTP id h2-20020a05620a400200b00783fa44b578mr6559153qko.34.1706643380114;
        Tue, 30 Jan 2024 11:36:20 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a164900b00783e32eefeasm3253128qko.93.2024.01.30.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:36:19 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kernel/module: add a safer implementation of try_module_get()
Date: Tue, 30 Jan 2024 20:36:14 +0100
Message-ID: <20240130193614.49772-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of try_module_get() requires the module to
exist and be live as a precondition. While this may seem intuitive at
first glance, enforcing the precondition can be tricky, considering that
modules can be unloaded at any time if not previously taken. For
instance, the caller could be preempted just before calling
try_module_get(), and while preempted, the module could be unloaded and
freed. More subtly, the module could also be unloaded at any point while
executing try_module_get() before incrementing the refount with
atomic_inc_not_zero().

Neglecting the precondition that the module must exist and be live can
cause unexpected race conditions that can lead to crashes. However,
ensuring that the precondition is met may require additional locking
that increases the complexity of the code and can make it more
error-prone.

This patch adds a slower yet safer implementation of try_module_get()
that checks if the module is valid by looking into the mod_tree before
taking the module's refcount. This new function can be safely called on
stale and invalid module pointers, relieving developers from the burden
of ensuring that the module exists and is live before attempting to take
it.

The tree lookup and refcount increment are executed after taking the
module_mutex to prevent the module from being unloaded after looking up
the tree.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 include/linux/module.h | 15 +++++++++++++++
 kernel/module/main.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 08364d5cbc07..86b6ea43d204 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -695,6 +695,19 @@ extern void __module_get(struct module *module);
  */
 extern bool try_module_get(struct module *module);
 
+/**
+ * try_module_get_safe() - safely take the refcount of a module.
+ * @module: address of the module to be taken.
+ *
+ * Safer version of try_module_get(). Check first if the module exists and is alive,
+ * and then take its reference count.
+ *
+ * Return:
+ * * %true - module exists and its refcount has been incremented or module is NULL.
+ * * %false - module does not exist.
+ */
+extern bool try_module_get_safe(struct module *module);
+
 /**
  * module_put() - release a reference count to a module
  * @module: the module we should release a reference count for
@@ -815,6 +828,8 @@ static inline bool try_module_get(struct module *module)
 	return true;
 }
 
+#define try_module_get_safe(module) try_module_get(module)
+
 static inline void module_put(struct module *module)
 {
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..22376b69778c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -842,6 +842,33 @@ bool try_module_get(struct module *module)
 }
 EXPORT_SYMBOL(try_module_get);
 
+bool try_module_get_safe(struct module *module)
+{
+	struct module *mod;
+	bool ret = true;
+
+	if (!module)
+		goto out;
+
+	mutex_lock(&module_mutex);
+
+	/*
+	 * Check if the address points to a valid live module and take
+	 * the refcount only if it points to the module struct.
+	 */
+	mod = __module_address((unsigned long)module);
+	if (mod && mod == module && module_is_live(mod))
+		__module_get(mod);
+	else
+		ret = false;
+
+	mutex_unlock(&module_mutex);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL(try_module_get_safe);
+
 void module_put(struct module *module)
 {
 	int ret;

base-commit: 4515d08a742c76612b65d2f47a87d12860519842
-- 
2.43.0


