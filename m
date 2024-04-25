Return-Path: <linux-kernel+bounces-158303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64828B1E11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9881928293A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA184FCD;
	Thu, 25 Apr 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJ3D6S2Z"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99B84FBF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037611; cv=none; b=FTnFdf7V1YjvsuPVoCV7g+q+CvrRqyNfAaDQlLQ2VYHcJLJdepnJgQRcHonj29v2yNKALFWazf1HZzlqX4Mzdh8AICR/ihuV6lRCEgQV5BbliIhhAgJtuLLsvLt13ZvV8tf8C/h1MMdaX5qAYzBOHwNPG+jGUG2wMz9aCuU4bqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037611; c=relaxed/simple;
	bh=jsWz/PnALIkdN9qUdDwNKDeU0qNvhFKiyrmn/dMkRhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwDfnTPF26YutEcvfqOmpB0WHI/8VBReCbb1D+as7x/A1MaMGlfseUbAj9HZcwL3c90OHYIKs8uT3aEP/aUt1J+7rja8zy1BVDK2P0l6Uoe2s4OKNTNkiaU9eOf47YoMb3ivPC3ZvGxpjh1+ichdxkgEburTanTNI7EeQJtDF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJ3D6S2Z; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e61a25900cso295784241.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714037609; x=1714642409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0g8AoNgNK5FpEulQUEfO2DSIFwhKhldAuDagIIonV0I=;
        b=lJ3D6S2ZVjfVPfaSPDybSMArh7WEVgVxmJsLNyrZ2EwotLtHcAu2dvTZBxG/6iz1AZ
         ARHTMzW0pWEwToS/UtBMIyiNElsu8MX20CBilt6k3NamxzVsAsFhgQEE7lZmWEK0pYgY
         rj8TEqx1DZu05lU5D4VYmmttfCBwSHQGmuRjs2gZqB/k64DuQVAykdjhDRyy1WKOHW5v
         4Caa76J/hBhB7eKpwO1YdbfL2hSer16w3zLObexh3ANlWYxenNENWF7GFrE8oWbHPF5X
         cDoj3j1LmROMQDNOiLZYXjwYtYKuxRrW3ItZWQxznnvG49N9SBpMuSF/22ZKgZkfutZc
         Wy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037609; x=1714642409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g8AoNgNK5FpEulQUEfO2DSIFwhKhldAuDagIIonV0I=;
        b=oYDEMh87XVq/UMiPKdRWt7bw3h+i9H6OI9sxyTx75qEiLf+qZ8rgtWOpYWzNNNZPzx
         8ZdtB3VcDDmSk9WM/gJNn5vOZ/BCrDhNu6m+JIejeJg9HVk2h81YiBOQmh+3KV/vXBtP
         yX09RumTQ6H6o+pDHpO01698KCoHuFNhyYTo5fOXyqeInAXLtymQGphdnbUjbmKtfizZ
         ibsBjPpVDkp9qVMJ61DiMrJCrVwSpkZ2Y96oG8RrynLGwoHcrEzMm2WQai5jUcb7Lyf7
         1bCkfZ8or7xdkOBWpOdLLP83f3aH6iLOaAFPhz7K27+tdt1Y5MeWcXPpwOHXBfXl18fb
         eeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMdZX2XwIfai58Xyq0H5D//f7pbIuqvjvXoVXYTa1DDQUO8M/uZ4oSfvz2h4kvfhIqAjkxOS4kTQB7MmCeo7KGzrHZuH8j5krBhXJt
X-Gm-Message-State: AOJu0YzuiEWBMIf+jzWjiKnXblxCcUkeGePdacq/2aTtYFuEiwuHCZ8J
	UUg/8k8QCRSre4DsexgliBUMg1UOEZmPdkG71R+OWjh3kwQTLuw3lfqcShk+oHQg/N4uAi53TDP
	QRHJYlBzNuqY3+J1yLZXjGsOLsxzz9cE9Ne/a
X-Google-Smtp-Source: AGHT+IFCvc0P3gNXdvnyCjs31aqeAWygOeIvfIkXydkJMxbuoBUSKjXhsNxdz1d3QA0O6jeJ/wXF1Kkwtu8TWptzKAM=
X-Received: by 2002:a67:f74a:0:b0:47c:11ba:fea9 with SMTP id
 w10-20020a67f74a000000b0047c11bafea9mr4095784vso.23.1714037608742; Thu, 25
 Apr 2024 02:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425092859.3370297-1-glider@google.com>
In-Reply-To: <20240425092859.3370297-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 25 Apr 2024 11:32:52 +0200
Message-ID: <CANpmjNPnn-1pr-Sz=xtQB6FwNrF5HJL_X0SMHL8HdMcYohD9ew@mail.gmail.com>
Subject: Re: [PATCH] kmsan: compiler_types: declare __no_sanitize_or_inline
To: Alexander Potapenko <glider@google.com>
Cc: dvyukov@google.com, akpm@linux-foundation.org, ojeda@kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:29, Alexander Potapenko <glider@google.com> wrote:
>
> It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
> false positive reports, because __no_sanitize_or_inline enforced inlining.
>
> Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
> so that it does not inline the annotated function.

Maybe worth noting that this is only a problem for __always_inline,
since that is inlining-by-force, and from the compiler's point of view
WAI.

> Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/compiler_types.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 0caf354cb94b5..a6a28952836cb 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -278,6 +278,17 @@ struct ftrace_likely_data {
>  # define __no_kcsan
>  #endif
>
> +#ifdef __SANITIZE_MEMORY__
> +/*
> + * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
> + * functions, therefore disabling KMSAN checks also requires disabling inlining.
> + *
> + * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
> + * within the function and marks all its outputs as initialized.
> + */
> +# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
> +#endif
> +
>  #ifndef __no_sanitize_or_inline
>  #define __no_sanitize_or_inline __always_inline
>  #endif
> --
> 2.44.0.769.g3c40516874-goog
>

