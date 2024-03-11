Return-Path: <linux-kernel+bounces-99232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B187855C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A35E1C2143F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94256B81;
	Mon, 11 Mar 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tbydqMK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C456B77
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174085; cv=none; b=c7FS+XqbEoi7FvcsFpKb8xomYRzTFD47q24we7qHaLJXpI7e5IXV5ZPo/50xiPuj/6CmD2Ao+zr/nukfnUxJDo2mOlMtvVQKLtY0U0Bu9CPDOlc+rde+M25YWRC2eq9KmU0mVJM40TORCUlo1rcPwHcWoUwrBMuxLL38QfEmY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174085; c=relaxed/simple;
	bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYHZkqbYqxZBfNrd57qrkTOGNqdIMPWkAbafLJNTPFUQGddH8RImQB7SRobCIkvpRcabJKePamTk+f5HB21XXoWBs5Vg7Ci9b+gpn77+RzpLN5WOlNppACKuvrr/a0fi1DiJ9dn54JNOoOkklQVA1Rtl+FmFoXWa4p1haDHckOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tbydqMK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513173e8191so4428667e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710174082; x=1710778882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
        b=1tbydqMK5d47mP/AaFRs9nz1D/0UrgShdiSVhxxPlu+qsgZaWxGTY2sz/C6Jhx9iEU
         huW8lbcM6IYIKN7X2pOKKaoWLojo7y3yyoEZfJSJYOulvBnuwavrcrztBTYy9avGuRH9
         UUSQ0PFIyxzBRVD8SY61mjoMmOMNOB66kUqUG/Giq2ASBuGDqtnwzdO5eXx0c2PH7Tr3
         7Px6Q5TjM+jTz2Ab5aw/sBaBGC6mbnqD5MvjunYczQ5xqj9oEgISprLXQIHDeKFUc7SK
         NDiQkxAnaF8t5H/n7OuXbz8K1BEaXXru6a45u+MACSs8PlfdAgSBMi0CoWzuREmu6jvg
         d//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174082; x=1710778882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
        b=JKIMfVADTTgdCyjLdidn6O5dQBRID3PSdNs+7R+yWXvKVPos+a2JKD7u3oDZfXqXPM
         WKAavdiC9NFzYXEM8hr+OTryOAnVf7U4atlWnLmfPo4hxJjumso7N8j/fdWJUyHF1RYR
         HJeea7pu/9HUvy8UuyBRKFu5E7PYy1FVRJVWRGfzXP7FtXe9rD6Xkg6IhmdvPH2a5YD2
         iEypondBbBD+xDgxihJ5bMO+WjgyrPBVz8zWim6E3Yz50Gb9/FRbREb8eKeD7I5tLw4q
         uboqdyxGqqNd3rnc2IpuI0X0b4wpxDxHQr++oMrQHEUTdzuiunyka9HohPJwMMlsn5J6
         O5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfKAVY/5DJMQxsuOHfA54EjYP6HD95+PCGYC44V3ksUgXADClytZief3sUH7g/yHcU8x7cVl1OW0PQzCDOFX5pvtjwYuKNu+asr7lC
X-Gm-Message-State: AOJu0YyKIr+zp3WHohYhnitHEkF2Lf2Y+iyofta6BwimMYdwasPGy+Sc
	M1ll7H+rWTgFb0K/dPZ3fIqi3kc3n+9yKxtWkEDSTNiYUdYNI6VHZQ7cGlXU1GTklrTQLIzU+V4
	aaHnOwLefyvbWdWllM4XHPzusEFdGQ+QtqWFv
X-Google-Smtp-Source: AGHT+IHS01FCe9haSj8hz/MjlOpYjKoCZ7p5Q//xT1au7RU9ERgiqKLg8dLzsYObrWdNTUdk4e7k8GKHb5tETRrwm2g=
X-Received: by 2002:a05:6512:3996:b0:513:4afa:a719 with SMTP id
 j22-20020a056512399600b005134afaa719mr6647016lfu.59.1710174081606; Mon, 11
 Mar 2024 09:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-14-irogers@google.com>
 <20240311114009-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240311114009-mutt-send-email-mst@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Mar 2024 09:21:06 -0700
Message-ID: <CAKwvOdkGALie1d6oNXKNT8vwGmHbymsQ-dv-i0U_SQGFrhEJew@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@aculab.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Christopher Di Bella <cjdb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Mar 09, 2024 at 06:05:08PM -0800, Ian Rogers wrote:
> > An issue was reported with clang and llvm libc where the noinline
> > attribute [1] was being expanded due to the #define in
> > linux/compiler.h (now in compiler_attributes.h). The expansion caused
> > the __attribute__ to appear twice and break the build. To avoid this
> > conflict, rename noinline to __noinline which is more consistent with
> > other compiler attributes.
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#noinline
>
> Following this link, I don't see __noinline there - only __noinline__ and
> noinline. What's up?

__noinline (which is what this patch is changing the preprocessor
define to) will not be expanded in the presence of
__attribute__((__noinline__)), __attribute__((noinline)), or
[[gnu::inline]], unlike the previous macro definition.

--=20
Thanks,
~Nick Desaulniers

