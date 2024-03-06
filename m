Return-Path: <linux-kernel+bounces-94636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473AC874274
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE91C20DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CED1B968;
	Wed,  6 Mar 2024 22:09:13 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799421B81B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762953; cv=none; b=Jh7LyuXaC6qqEV7dBcRMbEjG37SJ2FxTU7O2NuMelMWEgEDFd93bz08Do4Z/YxAZr17VIIhLg66Iaprj+edB/OHneSwBO5y/1oKjIeTspvNCa7n95VykFciangymGu37unxmTlUGf+L5TzD2LPGgHB74kOPjOUQDSHAGp74BO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762953; c=relaxed/simple;
	bh=OpHLrbf/wbZWGKlWzHZkTRSdUAQZaURp4dx3plJlmz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnxTFTS/lZJDo80OAdzB2y2YaG+8kCuz8IELpR7FlJ/RnLXKQG7gceDDJZtnQW6/fmKDz3d9uwVzt1d0VA6yotf4DntOtOY3iO/jWXZbcEoBFMIr+5iIyJHCdP/RmsP8I36Bd4ige6monOxzQC/cExfOkGhoR9PIWG8/BHHlTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 426M8EaB071013;
	Thu, 7 Mar 2024 07:08:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 07 Mar 2024 07:08:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 426M8DcQ071009
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 7 Mar 2024 07:08:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9692c93d-1482-4750-a8fc-0ff060028675@I-love.SAKURA.ne.jp>
Date: Thu, 7 Mar 2024 07:08:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
 <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for explanation.

On 2024/03/06 2:57, Linus Torvalds wrote:
> I think the KMSAN people need to tell us how to tell kmsan that it's a
> memcpy (and about the "I'm going to touch this part of memory", needed
> for the "copy_mv_to_user" side).
> 
> So somebody needs to abstract out that
> 
>         depot_stack_handle_t origin;
> 
>         if (!kmsan_enabled || kmsan_in_runtime())
>                 return;
> 
>         kmsan_enter_runtime();
>         /* Using memmove instead of memcpy doesn't affect correctness. */
>         kmsan_internal_memmove_metadata(dst, (void *)src, n);
>         kmsan_leave_runtime();
> 
>         set_retval_metadata(shadow, origin);
> 
> kind of thing, and expose it as a helper function for "I did something
> that looks like a memory copy", the same way that we currently have
> kmsan_copy_page_meta()

Something like below one? Can we assume that 0 <= ret <= len is always true?

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


