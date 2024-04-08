Return-Path: <linux-kernel+bounces-135951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895889CDBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795C8B21DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF714882B;
	Mon,  8 Apr 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kyl8fTW9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D031146A74
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612604; cv=none; b=FeyN9nAl3Sgz5sxM3eqJJflgZU8i/3nuPvZwxk6XfwXMlguaQYH8SsFMCGtxAmnhYvx/HVwoTI46kSdt8smKmKhk8lepU7Dfw+37jA9sWWqsRypdDkm8rtesMoR6Z9UQoULh2eGwPfwa+4q4RONwCpzq6IGDOn+1iwnfW8gAJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612604; c=relaxed/simple;
	bh=apa8Ycj0j8naOvh4JelaV7kxni6AgMh2aaN4ewxznek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyWPsQWpjOVgnz0U6TmhxUVk9CZsKsMLVYSdnMveDeRxZfhepDh8xNBBZ6JYYjm7pwbaGgF68Zns+0pBh0s3b8CNMvYEAcmHLPjlO/f2aL94Uo9UhbHKL74xa+94KBU76zySKbrU1LDn3gdUAHBpsKG8WCDz+9+b+ETiFFH0RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kyl8fTW9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46de423039so347009866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712612600; x=1713217400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4vQAFlYG/6Qo7oBuCHhBQsEdbkR4a/vMZEqym2juF0=;
        b=Kyl8fTW96Dxthhl/mYPmUoVdDXKinzF/O0vp9T6lh5SfNYNV0GGjF7R9Xnr7WIx2Zv
         Zw8Sr8YLwbrt8z+I/tLf7wHi0/Jt7WC3jbXyPQU/7339rfsNbm6HDb+ex7I+ioggVDHZ
         YvqbkAP1tkMLELeH/Bv4fqB2VCso0qRvGuuEeuTSQP4W2RUG3gppoWbr0D1Xs94ZW+8q
         LL/p9w4qg8sgn2h/cNQFKyFxJfhw5FF2WfGIIp/+M1i4ag468JAlnn61mPzjqrQolc2Z
         U8T+LMfP5Ken0UoyJgpKkCA32Vjox6cnYCt5uCrHLJOCKRbsS4fX9b8+20bdRH66A82w
         I+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612600; x=1713217400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4vQAFlYG/6Qo7oBuCHhBQsEdbkR4a/vMZEqym2juF0=;
        b=aCcrGUAn6h6m6LsoC7NMN0UXQgUi/Hw0yomV6Fxl/tzYIrIeNQ3Yuc7b0smdpRhMvl
         orpjthZE/ThNXBZiLlQkPXxkY6tKgp/5EFoqNbtueo6HZK6bKTQ3jmXpvre3vD7WpygE
         qwZetgfNpEcN/eOmpHKtjfybcQikRTwAcq6VAPOmP72duq0hs/NlRMhGl+V5/Cenxji0
         4ywGHDinuFhI8FxGZIK/eag2d5CVM7n6mkcEFUlAR1xqSbelpqdBhU9rIs+N0K2ven3a
         WET5zBnupDT6P+0qOPESA78jhUMJIchwX2zbzTKiJLpCoGFxG3K7tJTneqoe9waATNHF
         WKyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY1vfFj1Nmh+cBE/wyHAY/O1hIbNtFoJp3lI57887bGDiDzgNv+iXUZXvdDcf80zpuChwxrtOQFYk6bCY1aXaquDzctRN4iK5ije1C
X-Gm-Message-State: AOJu0Yzo4PaCQRxmXGOguUDyusqQKjmYlyKqtl6+CjsIMDbSom7xYDqw
	QVthZzUJ04VG0NSkx4e41eZ8pFtqlF9YflKSV+n1KWv1qq6PiIwi3JxecDKIPdZxPqScd7mFPO4
	UmKna8eGajTrP9LfwmXaqe+SVO1EcaYseBGnt
X-Google-Smtp-Source: AGHT+IEm8jqnicmW5nkOw50duqY7RyFZhzu1CDgPdFVJGHa4FKyz9cRBhBph98h4jvYQzNt8e3LA//leAkZ5o070rS4=
X-Received: by 2002:a50:8d15:0:b0:56e:ddc:17ad with SMTP id
 s21-20020a508d15000000b0056e0ddc17admr8315004eds.30.1712612600330; Mon, 08
 Apr 2024 14:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <zrqicnpeu52n42yulmrupxmrejd7mhbsu35ycd2bgfjz6gmm2a@dtpv5qdxhmnu>
In-Reply-To: <zrqicnpeu52n42yulmrupxmrejd7mhbsu35ycd2bgfjz6gmm2a@dtpv5qdxhmnu>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 8 Apr 2024 14:43:08 -0700
Message-ID: <CAFhGd8pFy5=BYcYr_fa4fkLB54ktXRwS=QVJunzMd5z15RYDaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
To: Erick Archer <erick.archer@outlook.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 2:35=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi,
>
> On Sat, Apr 06, 2024 at 04:23:35PM +0200, Erick Archer wrote:
> > The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> > trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> > use the preferred way in the kernel declaring a flexible array [1].
> >
> > At the same time, prepare for the coming implementation by GCC and Clan=
g
> > of the __counted_by attribute. Flexible array members annotated with
> > __counted_by can have their accesses bounds-checked at run-time via
> > CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> > strcpy/memcpy-family functions).
> >
> > This is a previous step to refactor the two consumers of this structure=
.
> >
> >  drivers/infiniband/hw/mana/qp.c
> >  drivers/net/ethernet/microsoft/mana/mana_en.c
> >
> > The ultimate goal is to avoid the open-coded arithmetic in the memory
> > allocator functions [2] using the "struct_size" macro.
> >
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero=
-length-and-one-element-arrays [1]
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open=
-coded-arithmetic-in-allocator-arguments [2]
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
>
> I think this could have all been one patch, I found myself jumping
> around the three patches here piecing together context.

I now see Leon said to combine them in v2. Whoops, sorry to give
conflicting feedback.

>
> Reviewed-by: Justin Stitt <justinstitt@google.com>
>
> > ---
> >  include/net/mana/mana.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index 4eeedf14711b..561f6719fb4e 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -670,6 +670,7 @@ struct mana_cfg_rx_steer_req_v2 {
> >       u8 hashkey[MANA_HASH_KEY_SIZE];
> >       u8 cqe_coalescing_enable;
> >       u8 reserved2[7];
> > +     mana_handle_t indir_tab[] __counted_by(num_indir_entries);
> >  }; /* HW DATA */
> >
> >  struct mana_cfg_rx_steer_resp {
> > --
> > 2.25.1
> >
>
> Thanks
> Justin

