Return-Path: <linux-kernel+bounces-110033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52288591C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E785282E08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D427A70D;
	Thu, 21 Mar 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsVMEQhI"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78757A156
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024281; cv=none; b=N7jnjHIMl1UJwkMfWY237goieStPA3ngSgJfk0CuFfRfPeCu3biROCqb+R4yqsgNXpVAZIzWDtf3qpaGxylxqLBperoBdSzFFc4a2wN1aFpDgsezGE7iTzQZDaQqxpPr9PpjTac95lkRiAqyudb2vwV0x4fsyzVkJwJA1r2m8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024281; c=relaxed/simple;
	bh=BTg+EWmvJZoLYmT0vdJuRMK/JhaMzRSaXUqmDlG1W64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9w6/rr/M8X2dTRkKwWp88ECfCYOv8fyGrcC8B4103giRav2XbLFjGyvzoAkpcNa5/qbkmXIyhgrsoUSVYSHxX97J+hcObl69rmPdr0AIobDqX/CQVUl3SQDabCp6rRabj5zsOmCIf+Y3USXjEE+Fh2EzGvEpzzGldGdjR5VyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsVMEQhI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d4404fbdf5so411241e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711024279; x=1711629079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4nWxDL2LITioaRby7yvh7M2SRX3O9JMXDxwR9Igm8M=;
        b=QsVMEQhIMDqg+hqu3F7BBINDNHAvoP2nr4uGzi17WsB7q96S+C6xx5XqJOsUXGGQ8u
         a5bt7qUxWFvZzsOZzMSFbGeL+1/fMTdDIlFy/xZfw+snqQMyECQ34qbuKcmwRFiCZvP1
         wBPkEy9AJnG7Moc4DTi3euuJ3pm2o9u3IC+yoO73fQZlxF/1DaqImjS1dyoPq0xmqgG0
         viMgIK2VAzYgE4ZVdw3+K1jsNNAaM02phv+fWFG4aIrXGahLDW/SIci0bmxKHZVDUAYN
         yUwpioHoIRHf9dijVSYL3h6DJ2a/6q3zfXb8yv0CBhWjoblYvudy9HCpjbEJtLFXjXFL
         6xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024279; x=1711629079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4nWxDL2LITioaRby7yvh7M2SRX3O9JMXDxwR9Igm8M=;
        b=Ysw0EwfEN+BiiYBi2BnG3+Z2hm3sb4qj1Bc2izqJYfe/CPYPbINcc67Ip/54xM1077
         jqjtY7pTE5CqLN2UXGlrLQUfD6IDVktsUF7HPPqAghUoJQPgVZXYrhSDRvOPZU3+k1I1
         mQCoinXCZ8FdjYrnXnzoYC3bVkDH53SVznPzdIPP6C3gVjgMcNJ59eIAfS8gOascTpVp
         P21jgXcJ40gzVMSoQ5ATugCEkHq5QoHXvcw1mLEVhItOjLxuuNMuLDBosKKRDgqjYUU2
         887IORwIxMi+dkjksvJirsdirXVhnR/1ot2eeWzQinpj4sWi59TpvB2lCYsotGpRZFBt
         PQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1A7p3/Q/eYsdv3qoAaeSRoXVgeSkqIxLBzU70BIC40h+GQyGAPKcRjFwsSVjrXsQMibqKjL8x7bNqrn/RzthtXFKDIW7yyfVw99Yj
X-Gm-Message-State: AOJu0YzeTby0JMu5OHwAg14xphY+OluA/Qa/YlIVNIE2ueDlvKj3D/6d
	Rjbik+GmGZcmsgp/Az8bHiGPVTxMmxGzu9BYDYpXp9tqIBisYJkg2PPmGQpgGTeBLa0sRcbGPVu
	EPH0rXfll7SUA6TW3GlhbU/FDhIxdp2s5GnTM
X-Google-Smtp-Source: AGHT+IHGrB6CuyBs53WYzdX+XII3yZ/LVaQAkjkHQL8Oy5rSxBEdZcjAaQ131inYEQj+EUaVDhZew04yYPkWm/wJHTM=
X-Received: by 2002:a05:6122:c85:b0:4c9:f704:38c with SMTP id
 ba5-20020a0561220c8500b004c9f704038cmr19496827vkb.11.1711024278613; Thu, 21
 Mar 2024 05:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com> <20240320101851.2589698-3-glider@google.com>
In-Reply-To: <20240320101851.2589698-3-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Mar 2024 13:30:42 +0100
Message-ID: <CANpmjNOetpgqju_ujuEauY7HZ_BbFUz9ZeBHc6M6aWe=hYu7=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86: call instrumentation hooks from copy_mc.c
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 11:19, Alexander Potapenko <glider@google.com> wrote:
>
> Memory accesses in copy_mc_to_kernel() and copy_mc_to_user() are performed
> by assembly routines and are invisible to KASAN, KCSAN, and KMSAN.
> Add hooks from instrumentation.h to tell the tools these functions have
> memcpy/copy_from_user semantics.
>
> The call to copy_mc_fragile() in copy_mc_fragile_handle_tail() is left
> intact, because the latter is only called from the assembly implementation
> of copy_mc_fragile(), so the memory accesses in it are covered by the
> instrumentation in copy_mc_to_kernel() and copy_mc_to_user().
>
> Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v2:
>  - as requested by Linus Torvalds, move the instrumentation outside the
>    uaccess section
> ---
>  arch/x86/lib/copy_mc.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
> index 6e8b7e600def5..97e88e58567bf 100644
> --- a/arch/x86/lib/copy_mc.c
> +++ b/arch/x86/lib/copy_mc.c
> @@ -4,6 +4,7 @@
>  #include <linux/jump_label.h>
>  #include <linux/uaccess.h>
>  #include <linux/export.h>
> +#include <linux/instrumented.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>
> @@ -61,10 +62,20 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
>   */
>  unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
>  {
> -       if (copy_mc_fragile_enabled)
> -               return copy_mc_fragile(dst, src, len);
> -       if (static_cpu_has(X86_FEATURE_ERMS))
> -               return copy_mc_enhanced_fast_string(dst, src, len);
> +       unsigned long ret;
> +
> +       if (copy_mc_fragile_enabled) {
> +               instrument_memcpy_before(dst, src, len);
> +               ret = copy_mc_fragile(dst, src, len);
> +               instrument_memcpy_after(dst, src, len, ret);
> +               return ret;
> +       }
> +       if (static_cpu_has(X86_FEATURE_ERMS)) {
> +               instrument_memcpy_before(dst, src, len);
> +               ret = copy_mc_enhanced_fast_string(dst, src, len);
> +               instrument_memcpy_after(dst, src, len, ret);
> +               return ret;
> +       }
>         memcpy(dst, src, len);
>         return 0;
>  }
> @@ -75,6 +86,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
>         unsigned long ret;
>
>         if (copy_mc_fragile_enabled) {
> +               instrument_copy_to_user(dst, src, len);
>                 __uaccess_begin();
>                 ret = copy_mc_fragile((__force void *)dst, src, len);
>                 __uaccess_end();
> @@ -82,6 +94,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
>         }
>
>         if (static_cpu_has(X86_FEATURE_ERMS)) {
> +               instrument_copy_to_user(dst, src, len);
>                 __uaccess_begin();
>                 ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
>                 __uaccess_end();
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

