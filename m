Return-Path: <linux-kernel+bounces-45931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A58437FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41E6284D00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8653807;
	Wed, 31 Jan 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRCPF6pj"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE05102E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686615; cv=none; b=qLClvEv5PpYlbK/ejgw2ibiek2Lxkfu5DEUtLbX/5kEJCNf710/LUKXWVwvQ75l+wccf4iBXM2KuQ6afhMYKfbPvgltog9lou4d8IOwovYz9GIeqIOM3hYO3zybeyC6dzf0UpRKnPCKL9zDBH5cG7+rx+CW9jjKmvVmKkBmw6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686615; c=relaxed/simple;
	bh=ONMwRoagJJCdpjb5YFob1PKApm3nE1P2gxex5MPb0cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtmOCjT7NzNIx2ESQpoiscE5OIIAqyWeNsLU//83nC5rjhWt40vX7fsrnJZnX8DR1LHcdgdFH8m9fK40lsGg6YiK2ALvFn1ukbfnbBHN0jfCMolIT7s6Qtd4bK7NS6WsMH/kJqTUlunpYOdw8/p15eyyimcbNNr3BzC/YrEy2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRCPF6pj; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bdb7f016b3so1228485e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706686613; x=1707291413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eXOji0IrBqHCJxYNDpUP1Xw0OEZpIf/OWOMNZXwOMg=;
        b=YRCPF6pjBVawyyfrpUh/pGLgiQ2H8XtazdmL92VukdZHGvjtxBaBdwq6N42cfvsR2k
         Mt3DX4MJpFZ4hj+jbt//tWg47xhu6jFAI27Q9QpEfSr9YCfxjba2792hWHDCLX1W+u3J
         Me8L1njTlvktENf6gJHEaeUgg282Jy6bLA1dygdSKxjRTZfq3yWG7V07DfI36+wR3YjH
         kucErBwJnhtQQNBoVK4ReePKRAHZZZdTc9yGTDoF20NVbHTkG8u5IBolCezsNyihU1d0
         99lOJH0YOUg+ZHCy8waqZIX+awZs14Lo6ashhOFbWNyvss5v50HBX8D3iLGlB0UQKc8B
         mGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686613; x=1707291413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eXOji0IrBqHCJxYNDpUP1Xw0OEZpIf/OWOMNZXwOMg=;
        b=Nr29bakSpaFa+vSHNBy2jTE2jV9D98sod/mQZvRcX9FqmmdUFr3yrLHMSQE+b98qCH
         7cDk+Z1rRqWfwzvHmGeYnKdDrUjno33440JE+VdS619Pxm8D9whGDnoGR8c95VB7pQD6
         IpAMuhcmPvXC3A3WKlmyxq9og+VPSZ49fhBhUIYJrJiGWU1LKTBchnILamqxiwmdEu1f
         6tx/jc9qlmG4FLj5Qf92qV4q6SoxcHbMgFDY8b9gouc+I2049eRPGPMZFwVt2yMN012E
         4rOjmTxpWrOC+b/TIZKJZ0+s087VS0I4OahM9q7sL8X4QTvSPDZbi71SleywhRYhTFoT
         79kA==
X-Gm-Message-State: AOJu0YwG9kTLOKNvSAm2kn1j0S/47/gOeV2Ggba6ZzZvOO+cDkQqOHgC
	HRcaQfDRS4L5WyOFwLce25w2UY8OLyDGc3QFJgPo4DiYMGiKuSn0cY3aXiPPAiDjz3zAYqTUZXc
	0rYSsna7XpsNTrFNR8f5r3yIp/OaZcpbzf/X1
X-Google-Smtp-Source: AGHT+IH5SJSMGqzxNLce7PflbhTZIQv3thWEKP0c/eAGURCe6SE+FIoLq0uzLYf82YDtK29aytx/+/SC5aVV3NE3MC0=
X-Received: by 2002:a05:6122:3981:b0:4bd:5495:ef1 with SMTP id
 eq1-20020a056122398100b004bd54950ef1mr808297vkb.5.1706686612864; Tue, 30 Jan
 2024 23:36:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130234634.work.003-kees@kernel.org>
In-Reply-To: <20240130234634.work.003-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 31 Jan 2024 08:36:14 +0100
Message-ID: <CANpmjNOt46O-WNQ74x7QXeCvwhibOzC6ctngNpz86w6i117bUA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 00:46, Kees Cook <keescook@chromium.org> wrote:
>
> The kernel hardening efforts have continued to depend more and more
> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Hi! I figured since I've been carrying UBSAN changes more and more lately,
> I would just make an actual entry in MAINTAINERS. Are you all interested
> in being listed as reviewers? Or would you want to be M: instead?

Sure, if it helps:

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..19b8802b2f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22471,6 +22471,22 @@ F:     Documentation/block/ublk.rst
>  F:     drivers/block/ublk_drv.c
>  F:     include/uapi/linux/ublk_cmd.h
>
> +UBSAN
> +M:     Kees Cook <keescook@chromium.org>
> +R:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
> +R:     Marco Elver <elver@google.com>
> +R:     Andrey Konovalov <andreyknvl@gmail.com>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> +F:     Documentation/dev-tools/ubsan.rst
> +F:     include/linux/ubsan.h
> +F:     lib/Kconfig.ubsan
> +F:     lib/test_ubsan.c
> +F:     lib/ubsan.c
> +F:     scripts/Makefile.ubsan
> +K:     \bARCH_HAS_UBSAN\b
> +
>  UCLINUX (M68KNOMMU AND COLDFIRE)
>  M:     Greg Ungerer <gerg@linux-m68k.org>
>  L:     linux-m68k@lists.linux-m68k.org
> --
> 2.34.1
>

