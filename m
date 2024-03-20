Return-Path: <linux-kernel+bounces-109175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD08815BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0170D1C20E80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07515A8;
	Wed, 20 Mar 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2T0O2jrQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4FCA50
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952594; cv=none; b=rCGwmZQILG7MsYiVjHkw8vHOS+OiyBCqSMFlNZ4OfABCqQVGwoT77FF8cF1SY04uLajNyUDUZu1WLuvrk85fqenovEcDgoA4hf/I/1JWKmVkEsto59LuxhHm8dLOiHuRbBj/9ltzvPW9lKRixnXNpQuTmQUn1k+iQcy9HX9g9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952594; c=relaxed/simple;
	bh=l5AeG0Hxuv67K1Go/GLyYqU3kNt94rkpGVsR7OP3Qes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bg1h4UqFszUEV6XejPDQ8C46nwB/FhQiObBPoIveuSJXNIuZIwuIfTs3ub/2h6RgE/GVeNY8pIyuW6D8EwlXWuH8HWp/FxvSd+4LBHUtwMvF9xlR2n0ul7vtQMDBaN4/7kBXTV0wvDnjyZ2rsoBLcA6p4M2zRyV4tafPyEIyeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2T0O2jrQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e058b9e479so855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710952593; x=1711557393; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4izGi/rNzGfjGaZHpmZ8og5U3NrqJ/cahTTnT/gINSY=;
        b=2T0O2jrQFy48ftyN8F2076c31ZYs+Q/WlnZfEjwzhzoKvAYjsKCINLDT9qqIvVVolt
         +st9SbUk0cSlpeOPDT6f+cVpBpwaARk+l6KD2xCm/0e5Die54o0ncUeimwbGuZh1eguo
         Ff/MyhPgGjOfvgbgO06UXC/wT3Dirkr8Iowg2qZjdk+ZB5fY4exAQvguydPydTgSNSH0
         SvpjuKxlmoeCKuhHo28F2tW6Ga7lbLGKLSBWpzHAWvMP3Ehe3FtI/ny5ZR22Xx3UZskP
         52AW8+zBhM5655himUySTCj2OHGUKRjfQxl544QLzuD/WANqbXcjc7NbuD5pBB9gMmq7
         e0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952593; x=1711557393;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4izGi/rNzGfjGaZHpmZ8og5U3NrqJ/cahTTnT/gINSY=;
        b=kN9HSfuEVBK5hOBZr5xFtJhpj+IVd7pEmOk0e2DH0vKxq+onpjVSBT+lDQcZj9d985
         Hbxkq/l9vNCZdCvGGunkryNOtMG/uWCAfEl22fUbfdXdobnuxrEj11ye9XAfDkFH9mBJ
         W3Oh7NLGXXbYfWVjW6GTlH0ZUJUT9VShTaobk4RI32E6P2uo1WG+VzlzCmiUqCCq+7kL
         fJwNKQ6uGR7RF999EMiljHg7CEqtN6iZNLmVT+rPKtTMfnA8WDW6qvJt0ORW+0h7JxGQ
         xpdp7UOLdFOeSSfehP2uYzQzw1Yzt0b3Hkw7Rbx7cUpS22OPH8E1MYprvYq+dag+zkeZ
         8XiA==
X-Forwarded-Encrypted: i=1; AJvYcCVXUJvTDK9vrrCy0quEYir9AYz/eKgFS7zLVT0IMG2SMPtauF7tR+392LNk1/Zsy0v1fUztmqAZ3uNqDKyVthtlTDSc59BZD+P/afkx
X-Gm-Message-State: AOJu0YyE2NO3G6+0zTD7jvVgNhglvR4Z97oeVmquJSa8mVQ0da8pU1AF
	H2+YCQLBEm+kxU9QUhAeEs5VL7N4GK5UI4qUN//rxilMUkBdyjkzz3tCWp/ueEfB5CD0xIanMfi
	hcDzqnnyGhg/Apcbt6I4ezWYcRwXYkFwzttA5
X-Google-Smtp-Source: AGHT+IF7jYpEg16J8IICPrk2uxY/KNN1OfAQNS+bv5buJgizk1nYFdnC4gxFboKp3i5ehUdUJUD65mXqfnDdWgLG8xs=
X-Received: by 2002:a17:903:2447:b0:1dd:a473:750e with SMTP id
 l7-20020a170903244700b001dda473750emr240457pls.27.1710952592275; Wed, 20 Mar
 2024 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320163244.1287780-1-irogers@google.com>
In-Reply-To: <20240320163244.1287780-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 09:36:19 -0700
Message-ID: <CAP-5=fUVtGgaLgVhoSa3SZdSceifFWs_v1rMnEANj3N=VdpC_A@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Pretend scandirat is missing with msan
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:32=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Memory sanitizer lacks an interceptor for scandirat, reporting all
> memory it allocates as uninitialized. Memory sanitizer has a scandir
> interceptor so use the fallback function in this case. This allows
> perf test to run under memory sanitizer.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Note, as msan needs to instrument memory allocations libraries need to
be compiled with it. I lacked the msan built libraries and so built
with:
```
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -fsanitize=3Dmemory
-fsanitize-memory-track-origins" CC=3Dclang CXX=3Dclang++ HOSTCC=3Dclang
NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_LIBPFM=3D1
```
oh, I disabled libbpf here as the bpf system call also lacks msan intercept=
ors.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1fe8df97fe88..74e0b17050b5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -486,7 +486,10 @@ ifdef NO_DWARF
>  endif
>
>  ifeq ($(feature-scandirat), 1)
> -  CFLAGS +=3D -DHAVE_SCANDIRAT_SUPPORT
> +  # Ignore having scandirat with memory sanitizer that lacks an intercep=
tor.
> +  ifeq ($(filter s% -fsanitize=3Dmemory%,$(EXTRA_CFLAGS),),)
> +    CFLAGS +=3D -DHAVE_SCANDIRAT_SUPPORT
> +  endif
>  endif
>
>  ifeq ($(feature-sched_getcpu), 1)
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

