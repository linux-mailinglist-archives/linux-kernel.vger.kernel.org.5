Return-Path: <linux-kernel+bounces-96756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FD87610F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFC81F24516
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27064535B7;
	Fri,  8 Mar 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hcmLJXI"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAE22F0F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890796; cv=none; b=WCQlYt2zC4iNDehonT1fqo/1xsW4I8tYNKV4PFN/BTGQRf2PAdf9fwirU3dLIG44IjfOS7Q10c4fpyFv/ogzWs1JT/tsRPdJw2CloBtp9rALILGZs6MRQTWEOPDxAHWgki8SyVh9Cq7rmFCE+5F8G/F4mk3t3MvA970eKbfB+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890796; c=relaxed/simple;
	bh=vtX7LPhamSxcbWntEzmJsAiMyPj5+b2SPq2jCfp7lnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raJoy8WKFM9yR8dmcrz5xkP0GZV19k5/XaDmyHr25FierkWNjaddyegHOMmOA5vihCkzeK0PJ06+WRjVqX1PrCGcl8pua3zNEoG4rhwQZ2rPeP89lWJwFspnuwGPm9SKxq7MnWStWl3SMfYPPk3llNsxsOzTA6yWXmLUa8YDnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hcmLJXI; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7db26980225so296935241.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709890793; x=1710495593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkn/lM2x4sb3JsolgYFeL1UFRJfnKJyId5+RqBqRGmc=;
        b=0hcmLJXIrfoPhbKyXlsTI0eKqMuBgCZQ58F621PJn+4o5EOwrTdFpCE2wdzvk3fbW1
         PdEMenEhfEB97f9FBcd+ng0K/ip3zKTIb1wTWCl4/WH9EdBosnyiLXGLLvXQdLWCM7uD
         ll2vCKKV3J0QicFdWmjkVD0oLr41k4wR1+NSOprdRpCOfnVgjcAE5GjNprwcfumpNXwJ
         rCz+YRH8AsR6nk342CyN13r2DMeX3SwJjMU6b6r6IaQPiBmlUMw3yPuaOXAVd7MTWh7I
         IOMOwcQEmSd3xIfXEjBZd4XvUAFzeo1ljhLSBSlsYGdzzwpjhM23X996zmwYGq/3IIl+
         R/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890793; x=1710495593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkn/lM2x4sb3JsolgYFeL1UFRJfnKJyId5+RqBqRGmc=;
        b=C8pOV4qu6iib4xs+nhL3Hzk1eU5fgeNhUflb69gQyANCdZRuBfZq8OOTG7j7s2Jhkr
         tN2FxAPYxGWqAFmaPt1X0QhjSr6NcDwiETZ8GVFkbM8ZdRSxQSYi9cMXEcungtEZ4ZK7
         3ZPghyUTDtlIMYFYOBlqGZvvRbW9MURAtp1lXd7Y85X+52QMungqR7IwMAz25zEdipC/
         uegmsfNoRu4PuCPS4SD9UmSUr+qIVNDaiDKV+4U8AU2rKCWgD6IHaTTIRIQH246p6fMg
         f8FmoVfkhh8kymfaHDcIgSH8MVWhgJnr8noKVWpBl+wzvz1mlHI+oaxaLXwaYsfqH/Sz
         oiFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHSvFwd3DYh8RrB0zdJbenjHZ5FWkTl1KQqRjjYsIMi4rafhh57EiASS30IcrtkCr+Xb9a/0B95pW3ziZTecfk6flWIiBGtZrROiS
X-Gm-Message-State: AOJu0YyRiJxThCwTV2UHLLdGgGjO3u6b5N/jwSJExp6zIh/rwMt79EDx
	7uOJvJSeMFwz4c/sCZfrj44a6s67Uwllg3sBaArIm2UMdZOS7ysOKdzLI853N54ZMSYPKPN+SZX
	N9g8Ac2M7ZOlkRndaDz/qd5K372EF5m6e/zfv
X-Google-Smtp-Source: AGHT+IE98fk08xTbrq+mTAdTYKrnDf67OwO4kqP1lpmve9KoyN/iaSJCDm9ZXsgnS4dUvfiGh7TmfKawzn8GENgGIYc=
X-Received: by 2002:a05:6122:2703:b0:4d1:34a1:c892 with SMTP id
 ej3-20020a056122270300b004d134a1c892mr11242267vkb.13.1709890793488; Fri, 08
 Mar 2024 01:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308043448.masllzeqwht45d4j@M910t>
In-Reply-To: <20240308043448.masllzeqwht45d4j@M910t>
From: Marco Elver <elver@google.com>
Date: Fri, 8 Mar 2024 10:39:15 +0100
Message-ID: <CANpmjNOc4Z6Qy_L3pjuW84BOxoiqXgLC1tWbJuZwRUZqs2ioMA@mail.gmail.com>
Subject: Re: [BUG] kmsan: instrumentation recursion problems
To: Changbin Du <changbin.du@huawei.com>
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 05:36, 'Changbin Du' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Hey, folks,
> I found two instrumentation recursion issues on mainline kernel.
>
> 1. recur on preempt count.
> __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> preempt_disable() -> __msan_metadata_ptr_for_load_4()
>
> 2. recur in lockdep and rcu
> __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> pfn_valid() -> rcu_read_lock_sched() -> lock_acquire() -> rcu_is_watching() -> __msan_metadata_ptr_for_load_8()
>
>
> Here is an unofficial fix, I don't know if it will generate false reports.
>
> $ git show
> commit 7f0120b621c1cbb667822b0f7eb89f3c25868509 (HEAD -> master)
> Author: Changbin Du <changbin.du@huawei.com>
> Date:   Fri Mar 8 20:21:48 2024 +0800
>
>     kmsan: fix instrumentation recursions
>
>     Signed-off-by: Changbin Du <changbin.du@huawei.com>
>
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 0db4093d17b8..ea925731fa40 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -7,6 +7,7 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>
>  # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
>  KCSAN_SANITIZE_lockdep.o := n
> +KMSAN_SANITIZE_lockdep.o := n

This does not result in false positives?

Does
KMSAN_ENABLE_CHECKS_lockdep.o := n
work as well? If it does, that is preferred because it makes sure
there are no false positives if the lockdep code unpoisons data that
is passed and used outside lockdep.

lockdep has a serious impact on performance, and not sanitizing it
with KMSAN is probably a reasonable performance trade-off.

>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2bccfd37c38..8935cc866e2d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -692,7 +692,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>   * Make notrace because it can be called by the internal functions of
>   * ftrace, and making this notrace removes unnecessary recursion calls.
>   */
> -notrace bool rcu_is_watching(void)
> +notrace __no_sanitize_memory bool rcu_is_watching(void)

For all of these, does __no_kmsan_checks instead of __no_sanitize_memory work?
Again, __no_kmsan_checks (function-only counterpart to
KMSAN_ENABLE_CHECKS_.... := n) is preferred if it works as it avoids
any potential false positives that would be introduced by not
instrumenting.

>  {
>         bool ret;
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..33aa4df8fd82 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
>         }
>  }
>
> -void preempt_count_add(int val)
> +void __no_sanitize_memory preempt_count_add(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>         /*
> @@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
>                 trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
>  }
>
> -void preempt_count_sub(int val)
> +void __no_sanitize_memory preempt_count_sub(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>
>
> --
> Cheers,
> Changbin Du

