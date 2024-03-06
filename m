Return-Path: <linux-kernel+bounces-93961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD187378A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA38B22D38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E8130AEB;
	Wed,  6 Mar 2024 13:14:42 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5A86647
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730881; cv=none; b=Iuxor8avHkO7MXnj9/RKikoamx2QjhlP3xwMzqwEuqpY6CEszOr8ooPGGIUgi3Tuh8R4diuuUh5s5ryq07sROucYLoit98BNev4gOlzxXYb3LLqRD1nkYxnTw8pT/+yIcVhFFmKjpeC0EW/r5NO3lspbazaDC0ovh3svaD/qhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730881; c=relaxed/simple;
	bh=NBkN7yQfAa7PLCdKB8AWp3JIJxP/gKGV/xcc0W35Ujw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YA+n20VPE3hmHrergnuzvtfoMtbGh+5Tmh25TZBB+vNfng1XeTqxtl6m87e8CjE/Hgpk9zT1eC8nnnewV5jyLNY2KaQI/ul4R8qtOkcskvtvKMEezV3Qzd5sNCSdyYE4tpSPDrb9BUWae/cpbYgFY+q76R2N8xTjkMrkoWwA/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c84939e5a4so291379439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730879; x=1710335679;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5M20glDBiQnz053hv9P0J8VDogdHXOJ11z3E6yWqJI=;
        b=FN1m/R3E5Cj2D98Z124MAEWvCMtjfnvcFBM8/PfIPq81fJy1oE8cSXKrSbBQZu5ZX7
         oF9xSvat6xLr0P7gEPYted9sc0wx7DZE9c0ZRsfE36ugoN/WuppWyO9wWa7sy5DtWEcv
         DF8oazMTgkLPMh2e0HzzHenC7ZlB+XsNw3yLIG3vPuHf2hKlqLlbARzSYCiD7HiHcgUc
         FNG2peRbKh0d84FWKCoTLlfNkGspMC4YV8jLQ26uZ0JuaIF/J/s5TEuM/0Rzg+V05RjD
         b0YHzhTLA2YBTV4rUdpWt1lzbuxmRkxAAq0vI2/hNkrbbZIQVHLk0v+ITutmkMrwGX6a
         jvLg==
X-Gm-Message-State: AOJu0YzUUUbqfjWJ4smEnl3EMT1pG6cEu8PMzlO9XAF/fcHLWD6jcI14
	j3GizIs/mkpHBf6ZwAyNQbsUDqyknTOssM/esdwhGnJikfhtefvMuj6ZIMccM4i1LBhbI7M/zap
	irWnHU2HAj/BLZNPxZhYqRavtnFL3DAJ0o7KUQ5Oqv3V5gLpkgVx4Jkzlig==
X-Google-Smtp-Source: AGHT+IFkIdlj3Vh+Dr0JneBvr/lbEYMK9+EY5Kx/huO52Th9Lh+ScMAWiyOkddlzR2PS7JknLqj4vKkS/2yM4Y+Qq+1y5UPJC/sY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:365:177f:6db6 with SMTP id
 i1-20020a056e021d0100b00365177f6db6mr1109462ila.3.1709730879216; Wed, 06 Mar
 2024 05:14:39 -0800 (PST)
Date: Wed, 06 Mar 2024 05:14:39 -0800
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7b41d0612fdbdb5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [virtualization?] KMSAN: uninit-value in
 virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Author: penguin-kernel@i-love.sakura.ne.jp

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def..6858f80fc9a2 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -61,12 +61,18 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
  */
 unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
 {
-	if (copy_mc_fragile_enabled)
-		return copy_mc_fragile(dst, src, len);
-	if (static_cpu_has(X86_FEATURE_ERMS))
-		return copy_mc_enhanced_fast_string(dst, src, len);
-	memcpy(dst, src, len);
-	return 0;
+	unsigned long ret;
+
+	if (copy_mc_fragile_enabled) {
+		ret = copy_mc_fragile(dst, src, len);
+	} else if (static_cpu_has(X86_FEATURE_ERMS)) {
+		ret = copy_mc_enhanced_fast_string(dst, src, len);
+	} else {
+		memcpy(dst, src, len);
+		ret = 0;
+	}
+	kmsan_memmove(dst, src, len - ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
@@ -78,15 +84,13 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 		__uaccess_begin();
 		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
-		return ret;
-	}
-
-	if (static_cpu_has(X86_FEATURE_ERMS)) {
+	} else if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
 		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
-		return ret;
+	} else {
+		ret = copy_user_generic((__force void *)dst, src, len);
 	}
-
-	return copy_user_generic((__force void *)dst, src, len);
+	kmsan_copy_to_user(dst, src, len, ret);
+	return ret;
 }
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index c4cae333deec..4c2a614dab2d 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -61,6 +61,17 @@ void kmsan_check_memory(const void *address, size_t size);
 void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 			size_t left);
 
+/**
+ * kmsan_memmove() - Notify KMSAN about a data copy within kernel.
+ * @to:   destination address in the kernel.
+ * @from: source address in the kernel.
+ * @size: number of bytes to copy.
+ *
+ * Invoked after non-instrumented version (e.g. implemented using assembly
+ * code) of memmove()/memcpy() is called, in order to copy KMSAN's metadata.
+ */
+void kmsan_memmove(void *to, const void *from, size_t size);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -77,6 +88,9 @@ static inline void kmsan_copy_to_user(void __user *to, const void *from,
 				      size_t to_copy, size_t left)
 {
 }
+static inline void kmsan_memmove(void *to, const void *from, size_t size)
+{
+}
 
 #endif
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692..364f778ee226 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -285,6 +285,17 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 }
 EXPORT_SYMBOL(kmsan_copy_to_user);
 
+void kmsan_memmove(void *to, const void *from, size_t size)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	kmsan_enter_runtime();
+	kmsan_internal_memmove_metadata(to, (void *)from, size);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_memmove);
+
 /* Helper function to check an URB. */
 void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {


