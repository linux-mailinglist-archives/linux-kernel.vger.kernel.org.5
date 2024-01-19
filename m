Return-Path: <linux-kernel+bounces-31065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B783283C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84961F21C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35344CB33;
	Fri, 19 Jan 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+N38//4"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24064C61D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661694; cv=none; b=TYptqEz3XkrO+wnJ5nu3NBvxCpyL1q41vJqM19CYyCt9iU0dd9n9C4AiKnhEtgW/870sKdnMhzdE8ewabecf5UsETmlv8ijtI5vrqoEXKgWo1kWe0tx4D+UsPBx6qQI28jPPif+vM2u3PFWX800izJjK+96C+0rD/DQZyVQvaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661694; c=relaxed/simple;
	bh=m18szehcgIZyGC92ETa72dOynkQ2f6n24be0IltSxcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RakRhpTazujbHROG9GgN5rJ2LcsgXkEXlOOahu/MiKulpxnQfoHbmDkDwWKs5UvCCwAzIamSsmAlrltDPGCFCXwRDg/i2PZ1V7ZdikXjorEkUvrXRARfLFf0hmB4nlNsBPnbFeWt8iFQkf32irkSpufmVDcirkjEc5aRxoLrifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+N38//4; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4698c58c589so164162137.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705661692; x=1706266492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xb+juV7I4ZaGbrlpY2PUAxU1pIC4OKmMwt1hcg3KeQ=;
        b=u+N38//4Pq2J2IhdqxzrDWt2GGMKtvZez+jz7ORN2U9KkOo7JzuDzJiHg3KWV3NFfm
         SUlpQXgSUDMudJWR8u3U7IsuV95p2zGRcnSnyNmbB1uKbWwMLhaVKZAgmvkSwB5G11g/
         eYNCqTBOoXeJfK8+Vpz0u6Ye0rQG2Sh0aL6jyQos5Gm1ahLqptQFqBauLNg3RRrWnOmv
         jBaBtHTNMMil2PnPorxV5K6zLPaAdn5CoKqhVpbWgFS20z4L9WBnO7tLUnBFcgO32g1G
         8uEI9ZVQ+jMQLIsswESxS41O2fSuk4nuOKmdijAyfY/VN8Fat4Thh+Rg3r8J4A/03blT
         8EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661692; x=1706266492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Xb+juV7I4ZaGbrlpY2PUAxU1pIC4OKmMwt1hcg3KeQ=;
        b=nV7oktoc2pYD32/lyCKN+nfGqq6hkIMbWJRg4/FYSqR/+NDnM/H5vHYp+lSwJ5p209
         9TKjeRAPdEHDSKaq3hRrSOJLxKY5obBjFHIf0myRzg7GS2OruqP3RKKG73NYAl/1bx5V
         wcLiorNWLCYN3VmiEkVcAnYx2roDwruE4lkr7Et3wneasjrJ6UFHTDzBrlfibsINDxKF
         l5y7ok+ODY98a+CuQLadQkMSSXGd0SeBsQ2niKURb6sIRzpR8dj5tU8SWYKk+zvCVU9k
         BbGftcgbHiUPE+CJTjnuoNWO2GZw9EOWSwVUAWttr8TKFV7wLaSLlM7c1kaqb9KnZ0hj
         otLA==
X-Gm-Message-State: AOJu0Yxa6SikGE+ARWld72rEc/VA/ZRajDDz7tCYU84DCYBvp8HqqhwU
	UQpYFXqFPIvARdytm5ysosT/POBxc21AH1UVeTzBzBQWbtbglbo24XMaALCUF1IqvqMU7WU26HW
	SKwsekqiSKVmMQAqrs1inMNzmASmNA9Om7KGp
X-Google-Smtp-Source: AGHT+IGfGiELClmDzev+0sWDa7A19EKW7tm37U7fiBmUfUP3YgUO4ewnFd/UnPwUYszhWmGdM00WaZHtrI4Lm8Qd9PQ=
X-Received: by 2002:a05:6102:214f:b0:467:cacc:bbf2 with SMTP id
 h15-20020a056102214f00b00467caccbbf2mr1927163vsg.8.1705661691706; Fri, 19 Jan
 2024 02:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
In-Reply-To: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Jan 2024 11:54:14 +0100
Message-ID: <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: andreyknvl@google.com, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 11:46, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> I use a system with KASAN sanitizer everyday.
> Because I want to catch difficult-to-repeat bugs.
> And all worked fine until commit 773688a6cb24b0b3c2ba40354d883348a2befa38.
> After commit 773688a6cb24b0b3c2ba40354d883348a2befa38 all working
> jerky when I compile something.
> The sound is interrupted, the cursor moves jerkily if I try to do
> anything when all the cores are loaded.
>
> > git bisect bad
> 773688a6cb24b0b3c2ba40354d883348a2befa38 is the first bad commit
> commit 773688a6cb24b0b3c2ba40354d883348a2befa38
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Mon Nov 20 18:47:19 2023 +0100
>
>     kasan: use stack_depot_put for Generic mode
[...]
>  mm/kasan/common.c     |  3 ++-
>  mm/kasan/generic.c    | 22 ++++++++++++++++++----
>  mm/kasan/quarantine.c | 26 ++++++++++++++++++++------
>  3 files changed, 40 insertions(+), 11 deletions(-)
>
> I attached here my build .config and kernel log.
> Who could dig into it, please?

I was afraid this would happen - could you try this patch series:
https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/

Thanks,
-- Marco

