Return-Path: <linux-kernel+bounces-110031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABD885916
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90335B22BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA0762C6;
	Thu, 21 Mar 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKjafP6i"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC159B68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024159; cv=none; b=h1K3CKZvWvJrMRLp9kdZsUjyEC2vCnioxMaxTfAV/LnBQkIPUJDix46iulofXb2sii6rxAD7oMf3ply5DsBiNFW1SHeG8Wnidpvrk9GXyQM3APRCyCRzo+gljRrbwIuVLbByWe58jXDPiqJ6U3VWaJStvZm68MiXwXU1T1rjDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024159; c=relaxed/simple;
	bh=tm8N3cZUwdmeZ/y7o8pF1D0pqpba9EI0Pn+Pq+OavWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8mH9TVrLrQRRiL8DUtvGlU9ApZIZGTS7QNK7+W2n5m5gy3eEH7K4txFO+ECjw2Cc8lYp5xLm7if9GlRuGKHZsd72u11M5hhAOXqT7eZ5nQYOdnSmsDK/N5dlVurjpPCWFuIbiymBvjxxbbSVmoFzhN6LQdRerqQpzpedLKgHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKjafP6i; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d46c4e1578so374320e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711024157; x=1711628957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7kkkaXKbTgy3PIzx4XPScnI5vGtNWw818zYmBGpfIzA=;
        b=RKjafP6ipkbctf42LLuZrvTjkfLVOupK6Zf30KSSLHTKVyH5EC3+alpw6oIyAOX0WW
         wI9mlF2IILKNEntxus+kYrNSoPM4bfXZb9QO86QPu4uMwkzVAjxWBIB0KhfOrjGPlkY1
         OBShuvzZ5tOLLO2dYg4nkw+7Tf5wh/SnaRlcm+/FB05fRreYa5QjrtZeaOl5GGkSXQUJ
         LmTzPcD9vulXe0ZaaUPsBQa9tnq16Luw9ssz21pM8kVluwBVHBpEWhH1Iv5AZeAj8qcu
         12e2bCJhdOvrRUVu7EWjIX6VPTp/ITmfRAX+F7zOH8Z49lxygnOxyHC/PptH1ReApkkP
         J8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024157; x=1711628957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kkkaXKbTgy3PIzx4XPScnI5vGtNWw818zYmBGpfIzA=;
        b=KXFRcZdf22QOlVPQy1/KlKRv+EJzov1phlj1lk+UYMtiFOpxfDLWixi9+S/ys4j7fn
         PomIQ48EvjGLdAbbzDdwrzUB6snIUTYeW/Y22+9mFhlbpNJWjF46924ffOLOSEvnB9Uv
         r+1mC6WCtR35qbEM6wMsPzPe1LhFzIWD+4isVmqgyPklk9Lq0NeEb9bTEWgqQH7yGPpS
         wCcqNtdU8XqrVuvQ5pgUiO8UBdhnf3A1rV0mr97vl8HkS18TB7DEAu0FVfopyeaA5ZZ0
         mQ+1iyMpRV7kU2umkv/H5b+xAT9Hm6MSJ0j2wSRl5hN6CpJ1xks7bi6FImLa6DDaZp14
         o7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXnvqgCN2ifZyHvFpOBqIOa36hWGx7usiRYslyoRPKa+zty4Vg8XxuvUQT29u90QzrYOogkm4pdjqIMRJ2jPWLQ4Q6Zkv7an06RoxRc
X-Gm-Message-State: AOJu0YwreJe39Hdwq2CJPmWMxknmb87yk58FIjcijJR0lGSQWmTEDyjR
	9KZTzhQLfhLfEn1pkbLgvgX21p6Uhr8Fr/NAARxjtmHqHj2WGmccglVNu1l/RWDM4/o/HBV+ttW
	rD7rCmfUBWaasDONbAoLOe8Di/Ppj7Y3jRzN6
X-Google-Smtp-Source: AGHT+IGHqywZSKo+5VSGjYfmZhZLouPqTvJxBCmehmTcKTLq2hB1p1f8gtpU2MJUyeQVZHqxz5nugn/4T1IgLrMVz7k=
X-Received: by 2002:a05:6122:3626:b0:4d4:3621:b245 with SMTP id
 du6-20020a056122362600b004d43621b245mr12680826vkb.16.1711024156532; Thu, 21
 Mar 2024 05:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com> <20240320101851.2589698-2-glider@google.com>
In-Reply-To: <20240320101851.2589698-2-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Mar 2024 13:28:40 +0100
Message-ID: <CANpmjNPA9h_OgizevqkiEkGS34nSPnQrqWF0FMazwVfjR3w0uQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] instrumented.h: add instrument_memcpy_before, instrument_memcpy_after
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 11:19, Alexander Potapenko <glider@google.com> wrote:
>
> Bug detection tools based on compiler instrumentation may miss memory
> accesses in custom memcpy implementations (such as copy_mc_to_kernel).
> Provide instrumentation hooks that tell KASAN, KCSAN, and KMSAN about
> such accesses.
>
> Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  v2: fix a copypasto in a comment spotted by Linus
> ---
>  include/linux/instrumented.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 1b608e00290aa..711a1f0d1a735 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -147,6 +147,41 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
>         kmsan_unpoison_memory(to, n - left);
>  }
>
> +/**
> + * instrument_memcpy_before - add instrumentation before non-instrumented memcpy
> + * @to: destination address
> + * @from: source address
> + * @n: number of bytes to copy
> + *
> + * Instrument memory accesses that happen in custom memcpy implementations. The
> + * instrumentation should be inserted before the memcpy call.
> + */
> +static __always_inline void instrument_memcpy_before(void *to, const void *from,
> +                                                    unsigned long n)
> +{
> +       kasan_check_write(to, n);
> +       kasan_check_read(from, n);
> +       kcsan_check_write(to, n);
> +       kcsan_check_read(from, n);
> +}
> +
> +/**
> + * instrument_memcpy_after - add instrumentation after non-instrumented memcpy
> + * @to: destination address
> + * @from: source address
> + * @n: number of bytes to copy
> + * @left: number of bytes not copied (if known)
> + *
> + * Instrument memory accesses that happen in custom memcpy implementations. The
> + * instrumentation should be inserted after the memcpy call.
> + */
> +static __always_inline void instrument_memcpy_after(void *to, const void *from,
> +                                                   unsigned long n,
> +                                                   unsigned long left)
> +{
> +       kmsan_memmove(to, from, n - left);
> +}
> +
>  /**
>   * instrument_get_user() - add instrumentation to get_user()-like macros
>   * @to: destination variable, may not be address-taken
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

