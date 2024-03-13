Return-Path: <linux-kernel+bounces-102351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6887B110
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83F6285B51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F060ED2;
	Wed, 13 Mar 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZmY8SJs"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AE6F506
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354005; cv=none; b=EluPEqlaBv8cnnoxSwTO9vq/CSLJbxwCFAAsu5USeYZfbNHZsQ+qRNTXKD1pDMPJcLO214DphqXjY6aUuOJ2dkCmMSO18DBLXPEYtjQSKHdaTS79ogqmfGisEURqmad1zzZTIcrlSpUBzTSXdHidLL89cxNT+6401odB1yeOHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354005; c=relaxed/simple;
	bh=L0TUJUEe3F3S4BPPtNOK8X+sljmeLdwYmEqhwB1kg0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeY4ue+muf9qKGgdu7AzMLKe3onKjQLKP1uGCzLCrGdNCHUpiPo5JL0W8M0jmBlGcLDd/rLT+RkOHCk0g066XwyCEOXChadMN/1bAQVObf+558yzFM3oBE0NRn2a9IuJLbXvB9Vpw8miobSIIeJVybl83CQk7v0dHYI3/Zo2Ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZmY8SJs; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d3634a8015so18524e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710354002; x=1710958802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwvnBQtlcUyRAyfwaWKEGU4GgQpA6zLF0Jl2IAoI3iM=;
        b=1ZmY8SJsSlw3bxJHMmmrKmIbgDEq6dfanv9pWRN/crzc0VD2LEXH6IejUMaYG3qJU5
         byVKPfNX9HqJHPXkK2p/CHIR3JwLYNm9fNv/lkzE9X3b4cN21vAGCV4mZPSqtdvctpMb
         bHJBe1y3h3mv+itxwBmPzOTWBlKLoiRpHaxFwk6V5ZjRvpal9nb/LMIFDjw+/vZPnYIT
         snkXGVYLRPN3r84UNqfDqh9FAwsJGacIWF8XtVet9cV7P83/1VgxqFtIt00ABiXrU0zS
         Zm+xN/ONLXRhcv+blDEr8f6GsAHKVVfcLPNCPIXpILw00R7MjrFMINR0yoQHJVtPFo/Y
         h9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354002; x=1710958802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwvnBQtlcUyRAyfwaWKEGU4GgQpA6zLF0Jl2IAoI3iM=;
        b=BcBwDSEfgkchxvEK+gVCFQWZUDRUOQohGb8s72bIc6I8QA4RK5iLPdZwkWVVPw6Sc/
         qYcHRiCeeMS3qDAEcWQGDVQiOYoBflMKnIfzLl+22aIyUUf6ygZb1yo0mHB202hhhQog
         PE3CCBiOoEqIWSENJWGTAMXdKDa4xtPL/hpE9NUi8arRAzADMO1gyQ2tUlEdmCuyKvSG
         LKhU5ZSMqr4NIacuMW4QPJfmkbt5LQqhFsunTDt+CVlaT6gDTDoBU0jeJJlK/PeDdAg1
         HOb5xCobBT1tc268XiNRG0OYjcGTz0AoTt57SfKrHOZGnQ3ceY5NGhGzz/pYM60EVe6t
         DH3A==
X-Forwarded-Encrypted: i=1; AJvYcCU5VwmTpXF4DevGEMN4yVd1hdjbZtycyFitaGKF9Lz3mUV2Isy0eKRB/ZfKOdRqqkCbgY2A++EFQnfbVnVGpE3xkDYTgZpRwqyqOjiV
X-Gm-Message-State: AOJu0Yxh24cMuRK4yAFcYuOV/QuyDeXVnhaShIeKbJ/i7rLGOUJPuqo0
	9S4kh4Djlx2aU3xFPxWN8o/2BIwfp+3qTov09nHmzmomsNGp886HX3CEmjZULcVKwaJbkrvV8a9
	EcZeK4NDa46VSzSbVH4tK2KSBWu2IhDvQ5sRc
X-Google-Smtp-Source: AGHT+IENq4+fLNjOtsp1KLmTSShOf6STqsSNv6/Z8z3t15lTEvNjAKcpCW1lEH3moZzUh6HKi5go/EepN5L2gekJQfc=
X-Received: by 2002:a05:6122:3d13:b0:4d4:5b5:5287 with SMTP id
 ga19-20020a0561223d1300b004d405b55287mr977068vkb.7.1710354002256; Wed, 13 Mar
 2024 11:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313181217.work.263-kees@kernel.org>
In-Reply-To: <20240313181217.work.263-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Mar 2024 19:19:23 +0100
Message-ID: <CANpmjNPxHkSe6iG+=D84Zk8=d6tTwTxDgR=nX+4QWirv4avS_A@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Disable signed integer overflow sanitizer on GCC < 8
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 19:12, Kees Cook <keescook@chromium.org> wrote:
>
> For opting functions out of sanitizer coverage, the "no_sanitize"
> attribute is used, but in GCC this wasn't introduced until GCC 8.
> Disable the sanitizer unless we're not using GCC, or it is GCC
> version 8 or higher.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403110643.27JXEVCI-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks reasonable:

Reviewed-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/Kconfig.ubsan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 48a67058f84e..e81e1ac4a919 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -119,6 +119,8 @@ config UBSAN_SIGNED_WRAP
>         bool "Perform checking for signed arithmetic wrap-around"
>         default UBSAN
>         depends on !COMPILE_TEST
> +       # The no_sanitize attribute was introduced in GCC with version 8.
> +       depends on !CC_IS_GCC || GCC_VERSION >= 80000
>         depends on $(cc-option,-fsanitize=signed-integer-overflow)
>         help
>           This option enables -fsanitize=signed-integer-overflow which checks
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240313181217.work.263-kees%40kernel.org.

