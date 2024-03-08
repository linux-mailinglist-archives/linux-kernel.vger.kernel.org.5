Return-Path: <linux-kernel+bounces-97686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8589876DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B44B20D84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A345974;
	Fri,  8 Mar 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwE1HGDt"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E31208CE;
	Fri,  8 Mar 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939309; cv=none; b=oC2ZfsYcfhcrYoy+lmK4WysHh7F71eCWgyAl8n7Xu59mEEkVsjoBygfJJQ3S8TMKl33QHPFdxojNjPlFcldCrQ8M4X2/597Mr5Mm0Q5P+pWvlCGsk9NPn6v2uuc5lOOdu687OHOo4DLsRK7r2bQ7DjqYmFvI803+HF2qFqrFiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939309; c=relaxed/simple;
	bh=UJVZE40w2xVflJyZ4aRiYYyrigkF6oh3kpuWamlR8Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mx4p2RUBjyEUy3eEkxDyW1j+pAVUb+ZkQ4WLoMEE6/odRHzUX3aVaW11OYkiu1aBchKAg2d4CX57OVeYsyc69x0zv8EretUMXQDwx8A4FPjZTrsBseSAUUKQl3BNm35ow7FCF+1jqMHn10p/uZCxZkf3gvWd8WJ6hXiGPH7mFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwE1HGDt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e2774bdc5so1938760f8f.2;
        Fri, 08 Mar 2024 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709939306; x=1710544106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtEGCi8NbJuLHRrQr6RIH8vzm74/hNUbVpQLNwkOn2o=;
        b=TwE1HGDtyAz0lTFP9ujrH10KnwrWIOf2Qj/GeYy/PoU6GSRpoaaYI255ibJxRCybU2
         uJQU/kmpJ/LFrGHCa1h1A7Ah6oMc8Asl+lx9fWnGZLOyI/IkFBGKRh38asHJRAPDtKFc
         RXID6g4biYwlDgALDlr9bMuxEG40MlNrg9AjG6rm+RcZ846tEmtu4iEdEPuU8HiaDqhf
         rUbMQmxJxbHKq4iAfvgr8Avjn1tLG56uQfzJhjALeOv2p8++aAwOVrsrwNy+aX2CCXdS
         ERbJQPlozGnt9Un/tkWZujcKx+wzmWSvyvoloy/tS1jB6iRd+pMcaA+lbjzT/VAOG470
         ViyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709939306; x=1710544106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtEGCi8NbJuLHRrQr6RIH8vzm74/hNUbVpQLNwkOn2o=;
        b=CnwCnHYKQW2Ff5D3q/NWiUkZgJUZECNBnbnKPdM2yIHPkaHoQchvQxhfUZzmqpkPG/
         uUbymti8GFO3Zcc+kejb8WhGAP0semuZq5nvQc0gK/KVv5UMyxQFsPKmYydwAnLI6BLk
         76R8WACF9rU+zFu7IKE/RVsaIeASqzGYe9Fx4Q4xy+ceIzPABR+j2IxQKY2QIz5PROcJ
         jqRXkzbijn3wDRE8xnLXzt9ZKUSutqhZpFAOjbUbdiphY9GfiHhIeu79YxZHmF/IWttT
         zdQzNbhQvSXiRKohGfyehCGd0et3PWvVL2/VZ1Dj38MD04NzqFqf9O4kKo3no0W2CRRO
         abqA==
X-Forwarded-Encrypted: i=1; AJvYcCUmrtcV6QDUqYiFw7CdAKH87PwfmJTZuVhk9Ar50dkJX3JRfKh9kmobH0yL/UHsLQwXl0X1H2uqbr/0vjdnsT4kvMuBnDjXpxmKWQsQ7PtzM0uhTuK5S20xQiFKZ4yUQsns
X-Gm-Message-State: AOJu0Yw4rQROCWxxTd8nrU5zzi7lW0UJnbELolog7zoL2z+w4skk/RQq
	k/FNu6ue8Opyw537Y6tG/Q0PHkfqT91oIE++azEnGlAlSok+7yC6+8/GCybTCJn4QS7Yoo4Ledr
	VtU4eHn5j5sitwpSd6t8phrN5ia8=
X-Google-Smtp-Source: AGHT+IFa12Dt6HWZXul96zamhBKKBck+Lb02UWp8DmstrS/08jdlksbqYA+3DxF53VsEF2xaaKKe5lZR3g8nO5HwSng=
X-Received: by 2002:adf:e541:0:b0:33e:7718:f90 with SMTP id
 z1-20020adfe541000000b0033e77180f90mr379781wrm.41.1709939306130; Fri, 08 Mar
 2024 15:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308120712.88122-1-puranjay12@gmail.com> <CAPhsuW7Do8c8cA6rVykhVnFRgKA0s6nO8JyGXkEB7gm94KR7Mw@mail.gmail.com>
In-Reply-To: <CAPhsuW7Do8c8cA6rVykhVnFRgKA0s6nO8JyGXkEB7gm94KR7Mw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 15:08:15 -0800
Message-ID: <CAADnVQJkcF82ekPXK1ox0sW5x-P67wbL_2uiivXXxBP8zFrVKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: cap BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
To: Song Liu <song@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:55=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 8, 2024 at 4:07=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> > On some architectures like ARM64, PMD_SIZE can be really large in some
> > configurations. Like with CONFIG_ARM64_64K_PAGES=3Dy the PMD_SIZE is
> > 512MB.
> >
> > Use 2MB * num_possible_nodes() as the upper limit for allocations done
> > through the prog pack allocator.
> >
> > Fixes: ea2babac63d4 ("bpf: Simplify bpf_prog_pack_[size|mask]")
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Closes: https://lore.kernel.org/all/7e216c88-77ee-47b8-becc-a0f780868d3=
c@sirena.org.uk/
> > Suggested-by: Song Liu <song@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  kernel/bpf/core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 134b7979f537..83a3b6964e54 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -893,8 +893,17 @@ static LIST_HEAD(pack_list);
> >   * CONFIG_MMU=3Dn. Use PAGE_SIZE in these cases.
> >   */
> >  #ifdef PMD_SIZE
> > +/*
> > + * PMD_SIZE is really big for some archs. It doesn't make sense to
> > + * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE t=
o
> > + * 2MiB * num_possible_nodes().
> > + */
>
> In BPF code, we prefer a different style of multiple line comments:
>
> /* PMD_SIZE is really big for some archs. It doesn't make sense to
>  * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
>  * 2MiB * num_possible_nodes().
>  */

Fixed up while applying. Thanks everyone.

