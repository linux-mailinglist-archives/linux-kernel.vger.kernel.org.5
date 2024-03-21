Return-Path: <linux-kernel+bounces-110024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E26885903
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D151F22212
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525676036;
	Thu, 21 Mar 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3XLhYx4"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F2224F2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023749; cv=none; b=SwUBf6nBKfaXiuGOTXKqEgzn1foCIPO0keNkK5ZcKiMreFnHyXx040SFEpYWF+JP+1DYOz516R23hTiX801yZMaas8LRVNuUtn+bCVXmH5DgoQEcc4ySrqcwvCOU/xa39lizrRsDne9hWVOBGy4hQrYcFeHjsK+hm+rELqh2IMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023749; c=relaxed/simple;
	bh=v3Nq2GqirEEJ6VTPoP4neja2FAVeVekFR2Tb5rF8Abk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLxJI5F8yVwSSnEZXoAYf0hiroQINsV+Yc4BcLkPXtzR7qVBdpWWdvVoDMSCY0ppaDauQPMwB/EZ+rseNXycKaVyZwDR6/2TEGdUJ9xmaaaaSY5MMqYNEZ0d7X+z+76IdghtJ8xvRdwqdKhlV9aUcUvlZImRE2eon7GV5cf9RpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3XLhYx4; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d44e2e9f13so360387e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711023747; x=1711628547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BJtjyUU93UByaqE7DctDE27rbESuDSaozbO+roW89C8=;
        b=B3XLhYx4rgPZxeqUsH8h3RpnJxham7K+2i48b2/jiPLoztucidk1JiK0HGaKh/dSD+
         AXkIB07sWYG4AVFD+I0Zd0gx5i6N2t/hO/ChOsETY0XEaAsfREtyA5vyWDWBuSUYYcZK
         IqyTz0jQYmqtk1OQFS5/G//0Tsg3erx8Y92IkfiCuaLxhGi/EPFML8fGFglaC9VDdJrj
         ARgPozWnppT++Auu/HK1sLXXD3aCtM0yM78pcnyIaqkTeDMkP+Kh71Ixcd7WrTdy6oik
         hmDDg4KxuVlonKBP126or60r+y65Z/8ZuAFZjpBvOMIbsIPEvNPXUJPfYeU3RCHUilao
         fbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023747; x=1711628547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJtjyUU93UByaqE7DctDE27rbESuDSaozbO+roW89C8=;
        b=Q0rlZRFiYcE1ZztB4hYQBEX+A6i+wzsrroc7nycy3zp+OAIR45STLR1C8Dd9I4UWN1
         Vjmf1L+jsoXOuPc88ObWKPq2BUkLJuQL8Kj8FSlRiNssYontyOs8kDIUFiKfjcJA6Qa2
         /W8rcVz55vMw8Hnc54bj7qeCkivZ+uNdp2o8BD6jfw5UwLphnopKFtKP01cs+7KEr7tv
         64Ie1zOxtNNfeA4Vyi52e3UrRbe0euefA2iPYxj+VuXh/qVpK9Usu2CMI+a+5+2HEWbp
         kyHF44ljx8Oho8bkkPsANs2nYLk2vgqtTF8IQ3aZEUJiet+PR1Y3loW72MF1JjUdD+6W
         nA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdGt4b3yL4Ztfoi94MC3hh5WA+JsIMi/GsAOPXINnWw7wqWjvdhXLkZ+336I4FkouZZTgtPrVzQYjTyydOdVfVLr7LmxD96erDpCsQ
X-Gm-Message-State: AOJu0YwF2kV/AFV6CIWMi4H9TOBFAbNF/1b7JUSJSDOlb+VZSFUQCCTm
	bcQZTyg75fuPKK1M/rHJfomEH9uybym+ZlLis+mYQD+jJyETQbZJiyYfDeRf5kNpxJnWZdHialV
	ekWWGdb8rd1H4yAoakf2Pa8iiKx+hrJpY2C6Q
X-Google-Smtp-Source: AGHT+IH2D8QrIZ0C+AbDylyT5s9WD+GesvP+2mcUDbCJiXNIQ/C51SuKQRl9uBoE041q1vP3W14+xs9e5cGFhMUCtaU=
X-Received: by 2002:a05:6122:3659:b0:4c0:2d32:612f with SMTP id
 dv25-20020a056122365900b004c02d32612fmr5775412vkb.15.1711023746707; Thu, 21
 Mar 2024 05:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com>
In-Reply-To: <20240320101851.2589698-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Mar 2024 13:21:48 +0100
Message-ID: <CANpmjNMNL9At6Ow41TxQUhg_HK7ctxk6XAG1=Ndh0nxit+K8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: kmsan: implement kmsan_memmove()
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Dmitry Vyukov <dvyukov@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 11:18, Alexander Potapenko <glider@google.com> wrote:
>
> Provide a hook that can be used by custom memcpy implementations to tell
> KMSAN that the metadata needs to be copied. Without that, false positive
> reports are possible in the cases where KMSAN fails to intercept memory
> initialization.
>
> Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kmsan-checks.h | 15 +++++++++++++++
>  mm/kmsan/hooks.c             | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
> index c4cae333deec5..e1082dc40abc2 100644
> --- a/include/linux/kmsan-checks.h
> +++ b/include/linux/kmsan-checks.h
> @@ -61,6 +61,17 @@ void kmsan_check_memory(const void *address, size_t size);
>  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
>                         size_t left);
>
> +/**
> + * kmsan_memmove() - Notify KMSAN about a data copy within kernel.
> + * @to:   destination address in the kernel.
> + * @from: source address in the kernel.
> + * @size: number of bytes to copy.
> + *
> + * Invoked after non-instrumented version (e.g. implemented using assembly
> + * code) of memmove()/memcpy() is called, in order to copy KMSAN's metadata.
> + */
> +void kmsan_memmove(void *to, const void *from, size_t to_copy);
> +
>  #else
>
>  static inline void kmsan_poison_memory(const void *address, size_t size,
> @@ -78,6 +89,10 @@ static inline void kmsan_copy_to_user(void __user *to, const void *from,
>  {
>  }
>
> +static inline void kmsan_memmove(void *to, const void *from, size_t to_copy)
> +{
> +}
> +
>  #endif
>
>  #endif /* _LINUX_KMSAN_CHECKS_H */
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 5d6e2dee5692a..364f778ee226d 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -285,6 +285,17 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
>  }
>  EXPORT_SYMBOL(kmsan_copy_to_user);
>
> +void kmsan_memmove(void *to, const void *from, size_t size)
> +{
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       kmsan_enter_runtime();
> +       kmsan_internal_memmove_metadata(to, (void *)from, size);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_memmove);
> +
>  /* Helper function to check an URB. */
>  void kmsan_handle_urb(const struct urb *urb, bool is_out)
>  {
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

