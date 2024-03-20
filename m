Return-Path: <linux-kernel+bounces-108795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF545881010
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188BB1C22EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10703A1D3;
	Wed, 20 Mar 2024 10:39:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E039FED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931195; cv=none; b=BZvIvC04wuZLvpQlmw5lqNywToOs+tZl8BjjdnuyVJF9oZu9wVdH5CdgZHwWRWAgmGp8vZBuZxMQmDeoCrvEzvRWKaFKy749yT4dUwQuGfyu+4vQAbqE15UhFh4xtu9Xt7OhT5JN8lLdmcFmNFlyvWqlTaUHAIuVtpdwVuwA4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931195; c=relaxed/simple;
	bh=/YnmHjebPsYji+772rQDw2SVKaxnY04yaSAvNkDGeak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHMYOFr1T//EZn83oDWMKNXGYo6rGM/xtomiDvXi3UzikacIL5FCnWe1PEzMJM2vIJrOaiQX1Chby4+SnCX4J42iEXdYo+DuATghSbZ8KXA00yNQcLMWvAinqXxifLk4nYU2RKyd+v731FPJpJWWmzEWWzufYRkBCzxzRnV6Zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42KAdo0k048716;
	Wed, 20 Mar 2024 19:39:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Wed, 20 Mar 2024 19:39:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42KAdoUV048713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 19:39:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dce41a35-aa2a-4e34-944b-7a6879f07448@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 19:39:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
Content-Language: en-US
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
References: <20240319163656.2100766-1-glider@google.com>
 <20240319163656.2100766-3-glider@google.com>
 <f9a8a442-0ff2-4da9-af4d-3d0e2805c4a7@I-love.SAKURA.ne.jp>
 <CAG_fn=UAsTnuZb+p17X+_LN+wY7Anh3OzjHxMEw9Z-A=sJV0UQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAG_fn=UAsTnuZb+p17X+_LN+wY7Anh3OzjHxMEw9Z-A=sJV0UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/20 18:29, Alexander Potapenko wrote:
> But for KASAN/KCSAN we can afford more aggressive checks.
> First, if we postpone them after the actual memory accesses happen,
> the kernel may panic on the invalid access without a decent error
> report.
> Second, even if in a particular case only `len-ret` bytes were copied,
> the caller probably expected both `src` and `dst` to have `len`
> addressable bytes.
> Checking for the whole length in this case is more likely to detect a
> real error than produce a false positive.

KASAN/KCSAN care about whether the requested address range is accessible but
do not care about whether the requested address range was actually accessed?

By the way, we have the same problem for copy_page() and I was thinking about
https://lkml.kernel.org/r/1a817eb5-7cd8-44d6-b409-b3bc3f377cb9@I-love.SAKURA.ne.jp .
But given that instrument_memcpy_{before,after} are added,
how do we want to use instrument_memcpy_{before,after} for copy_page() ?
Should we rename assembly version of copy_page() so that we don't need to use
tricky wrapping like below?

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..b9b794656880 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -9,6 +9,7 @@
 #include <asm/alternative.h>
 
 #include <linux/kmsan-checks.h>
+#include <linux/instrumented.h>
 
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
@@ -59,6 +60,13 @@ static inline void clear_page(void *page)
 }
 
 void copy_page(void *to, void *from);
+#define copy_page(to, from) do {				\
+	void *_to = (to);					\
+	void *_from = (from);					\
+	instrument_memcpy_before(_to, _from, PAGE_SIZE);	\
+	copy_page(_to, _from);					\
+	instrument_memcpy_after(_to, _from, PAGE_SIZE, 0);	\
+} while (0)
 
 #ifdef CONFIG_X86_5LEVEL
 /*



