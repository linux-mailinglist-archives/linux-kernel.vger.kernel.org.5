Return-Path: <linux-kernel+bounces-110272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF918885C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624ADB23703
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0B86276;
	Thu, 21 Mar 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs3LJ04Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924585940
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035860; cv=none; b=eiB7caYYFYWd64WqDDC9VgW9lYIcz1PBjFGOoRPf+ux0vYswlvvtBGbp2syWLK28ura2jss+59MY1/96aB/st54mXu4e2qXioCzy68XFGIwtUJC0nRBJetz9Dfa/2qMyqX26KzTh4Ud3REw6+F1v/oXTKSYPXubRmLvVP7B33hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035860; c=relaxed/simple;
	bh=phrwu6hEFwR3OmRq0xmE0wJeGnZ2XPtxhImxOPSRs8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx3zxbVzO8tyuavryxkOvpWiRv9Ek4lbjE4JmFFHH6n499O/mCZyDqe1nzSCkiOts3QaCOhITs0WfS/JizUHLI3APQTSKC3upbmBvhaUsq3C+t2NkdOvXULVvy+KGJvOIWOy18jJ8c8+namNmBe15OW+FU4vAWfhQTyTC7FG4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fs3LJ04Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711035857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9X/54MANsD/vA3gDB6Zr3YBdoXorm5FGsBGyONKCgo=;
	b=Fs3LJ04ZtiUPGoM1CQnvBJ4It570s9nkn9kisAUcgEMuMstYAWugyVNJhNeaHrBvIRhXdp
	WI8rVkE905v0lUM4B6DJjYnNyIrVn3hPIwldfJklSVPG8Fqcr7sv5Zm5w3irj0dyMJzh2r
	TEeBcKUu3lcYb626Wue3kolOpiJDIRI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-fBiKanHENraHKqQKbW4-QA-1; Thu, 21 Mar 2024 11:44:15 -0400
X-MC-Unique: fBiKanHENraHKqQKbW4-QA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d49ce3736aso12062841fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035854; x=1711640654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9X/54MANsD/vA3gDB6Zr3YBdoXorm5FGsBGyONKCgo=;
        b=LxHHxYTpvPOt8PI+t7wYJMitsw6FqF39JfgO9IU9Ni/SiDi2Kb6rWT3tZzgdAuFQKM
         exGN48P/nEjXLQaq9skkpZQvapIb2V0ATcLYYtX4N02daDqCCm2qsvrnG1NDwHKoaghs
         mIuNYb4tGvb45mQ8ay6Pb714ScfLPYBGoxQm2rAcVyx4zMdgYPQT8Oiideuga275Kzw+
         CnOFZ61sQy5Ar4Xotr9+a/JCFEAgrv+feg3caTEi7fIW/FC4CqOeW4YLZGtg8M6eqR+N
         UfNaeLodjfcsSSRwKNSgMLAF+l1CDOk1KCsCIVvqA8e21fDid0o3IfZ5eYl94Ut7bTfg
         C5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDdCMmMn9SctbAwuCBzsADl2Lzs1qEw9jp1ETPiZwYiNFILEMhiuUfTHCT+2Byzd2PNpYoUpDXh3vS2IMQzTj9kHYOUc38NVGH3+N
X-Gm-Message-State: AOJu0Yw/3m/FvnY5KMxCiH2CC3yRGlk+A9LYnxDzdBmJDz3GY54YAlJl
	Ilz0hgLa+SqmaghvgqcKWDZU7QXRFZe+rrLwJ+F2zwWZQi5J8sO1h9a5+N3NpKeCkVnU6YEfB8Z
	nm242RVfStB+oRSycTQS4aFnLc89c6nD9hO5q+G20vGu14Jlm6yAlPPFjzIkapIK/C6yrTIiwH4
	c2QYY5hJ9sSG12RogkNObREjFyin6iO1Glow2d
X-Received: by 2002:ac2:5b50:0:b0:513:d82a:8d3a with SMTP id i16-20020ac25b50000000b00513d82a8d3amr2417722lfp.35.1711035854146;
        Thu, 21 Mar 2024 08:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZIKyQs7CyzkABKXj1SHOyLGf1WPq90wMOMnQeFNTWTzKPNsmeP/5JcobJ6xacp+RlyAuScGQ1FCFgg1A4Yk=
X-Received: by 2002:ac2:5b50:0:b0:513:d82a:8d3a with SMTP id
 i16-20020ac25b50000000b00513d82a8d3amr2417696lfp.35.1711035853790; Thu, 21
 Mar 2024 08:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-3-5658f2540564@kernel.org> <70ae8d7d2ed950466a61d118f59c16cb07fc9688.camel@gmail.com>
In-Reply-To: <70ae8d7d2ed950466a61d118f59c16cb07fc9688.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:44:01 +0100
Message-ID: <CAO-hwJLqp4Xm20_CDMvr-GJGFShQ1gSmyWr0MqPvh_+icPJVTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
>
> This patch looks good to me, please see two nitpicks below.
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks!

>
> [...]
>
> > @@ -1350,6 +1358,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_ker=
n *, timer, u64, nsecs, u64, fla
> >               goto out;
> >       }
> >
> > +     if (t->is_sleepable && !(flags & BPF_F_TIMER_SLEEPABLE)) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
>
> Nit:
> the BPF_F_TIMER_ABS and BPF_F_TIMER_CPU_PIN don't affect
> sleepable timers, should this check be changed to:
> '(t->is_sleepable && flags !=3D BPF_F_TIMER_SLEEPABLE)' ?

Sounds fair enough. Scheduled this for v5

>
> [...]
>
> > @@ -12151,6 +12175,16 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               }
> >       }
> >
> > +     if (is_async_callback_calling_kfunc(meta.func_id)) {
> > +             err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> > +                                      set_timer_callback_state);
>
> Nit: still think that this fragment would be better as:
>
>         if (is_bpf_timer_set_sleepable_cb_impl_kfunc(meta.func_id)) {
>                 err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
>                                          set_timer_callback_state);
>
> Because of the 'set_timer_callback_state' passed to push_callback_call().

Yeah, sorry I missed that part from the previous reviews.

Fixed in v5

Cheers,
Benjamin

>
> > +             if (err) {
> > +                     verbose(env, "kfunc %s#%d failed callback verific=
ation\n",
> > +                             func_name, meta.func_id);
> > +                     return err;
> > +             }
> > +     }
> > +
> >       rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
> >       rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
> >
>


