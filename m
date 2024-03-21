Return-Path: <linux-kernel+bounces-110312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15464885D08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE61C218EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425A12BF37;
	Thu, 21 Mar 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoo3Siob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83812BF1A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037391; cv=none; b=ralrvxS2jrB8SRTSEgs96aDQ0imcN4b/GVjgIasUFBQRpHMtKAEaEyfYJ/zGhzhGwE45eBUHHWqQbaPj/ZroAZ+K+RpUz6huFlhegwzoz3gBVhsq3sGMX32a7ZPB4o0vXIxGEm0cQjlOxvYpUl42cBtxmGLSI4Lh5qJYeYV2yGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037391; c=relaxed/simple;
	bh=Efa9pooFtZFexc8t2FHAlDSOT6+OQH2tDlvcl4EcU6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1h25r17iK47SGGHSoDiRrKin6j9dSadjUneAqSdi5Ev3Dweu02SH1a3jlNhg0zCFHQfoI3PNBvEGZLzozyH3rKMQu4LGSwPjZM0kw8gNLQ0k98z2a7f9IxuCSNA3fwIqst47PYv2vohuo0RAIjDVzrMhLd/Gn3bglsDQapkX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zoo3Siob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711037388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
	b=Zoo3Sioby/zzX/878P7HZKdxDD+j4mIoD+9EIxeWxYvtR/dKD5BjX3ok8d+iZOHChTSyUH
	fz6xu5F0Os8/xK5EeQTaRZHEui7wi6YCU3AD/pjR03Q6ClsadrbQ9pCtH6b0rMkPofWc+r
	LBcnaMwmKbixhlRnFsbiV5ErE58DR/I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-2VBo6QdyOTG6Bbg179lG2g-1; Thu, 21 Mar 2024 12:09:46 -0400
X-MC-Unique: 2VBo6QdyOTG6Bbg179lG2g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-568728e521bso1060678a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037385; x=1711642185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
        b=WitsCJJ52EiSvGsrRgcoPD2uE25sxdnJqoLPG4I5WlOqA4OLX077bJUwpD7LYhPn2p
         hbns5QfEGxOBv/SjQ6GhZ35gvAxQ4Kt9ikcq7NjMIQPvwaVkfbOFV/5x0xIWFF7QOhce
         y5dneNOwb6Qj03PSjePI985IwqyecpzjvPL/3sfvHlNfjssk5bEegtrbDBpwNmt+MBRY
         VeRnsXd6OKK4YKOjsltgVorYjpXcwEr1OfB2Bd/QcRiiirS73vCLSuf6dQIaiPBUm289
         Tsvb2uK+DPuDDKn/Z4PYbGPeTD3j1002YsmbNPtfXJ6g/cYkvbUjaDHOVndbhH6VWzSV
         SN6A==
X-Forwarded-Encrypted: i=1; AJvYcCXlBHyt+1dqmvkW1x5D3hg2qDFaz7bUTBuCe7MNKEEybKnNS6kNZ7C/fxz6JuWzNAuZIKerbkKGh2tXBTV8j1CINlGyyES83tLbbWO8
X-Gm-Message-State: AOJu0YycLiuC6ku9wd0E3cpg+hjZUlFnAD0GoDExDiAhWNFkYjwkvJ4Q
	GyfQ718z6W0zvlnVZcD68vkPmqqQHRAh3vCjPb7D/QrYufKjMk1GsuE8mFesf6JiUoasy9zurKP
	zdNsEHxXP/fuVgJOP6pIJXuniBDYD5FWdRvYqR5L3Z9j4mXUbNOTsZjPna2z6R+ffK4+SE5+KP3
	fYLQ1HvmXpUATZVJfwFt5aV7xMgizhx1B1StjL
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id t33-20020a056402242100b00566f5d604b4mr6854709eda.12.1711037385197;
        Thu, 21 Mar 2024 09:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJczUOKWHiXnEN5u0YPmmuAnhgkpGir9OOZXAH68RtsDs3o/mdfwXGaEp7tIlIBwPP814Hb6KspJCMPCXLbDI=
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id
 t33-20020a056402242100b00566f5d604b4mr6854684eda.12.1711037384888; Thu, 21
 Mar 2024 09:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org> <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
In-Reply-To: <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 17:09:32 +0100
Message-ID: <CAO-hwJLh00--9AbS=7z4+W7FgA+hLA8hViMmaMMfz2mERcMwhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
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

On Tue, Mar 19, 2024 at 12:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> [...]
>
> > @@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifie=
r_env *env,
> >
> >  static bool in_sleepable(struct bpf_verifier_env *env)
> >  {
> > -     return env->prog->sleepable;
> > +     return env->prog->sleepable ||
> > +            (env->cur_state && env->cur_state->in_sleepable);
> >  }
>
> I was curious why 'env->cur_state &&' check was needed and found that
> removing it caused an error in the following fragment:
>
> static int do_misc_fixups(struct bpf_verifier_env *env)
> {
>                 ...
>                 if (is_storage_get_function(insn->imm)) {
>                         if (!in_sleepable(env) ||
>                             env->insn_aux_data[i + delta].storage_get_fun=
c_atomic)
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_ATOMIC);
>                         else
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_KERNEL);
>                         ...
>                 }
>                 ...
> }
>
> When do_misc_fixups() is done env->cur_state is NULL.
> Current implementation would use GFP_ATOMIC allocation even for
> sleepable callbacks, where GFP_KERNEL is sufficient.
> Is this is something we want to address?

I honestly have no idea of the impact there.

AFAICT, if env->cur_state is not set, we don't even know if the
callback will be sleepable or not, so if there is a small penalty,
then it's the safest option, no?

Cheers,
Benjamin

>
> >
> >  /* The non-sleepable programs and sleepable programs with explicit bpf=
_rcu_read_lock()
>


