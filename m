Return-Path: <linux-kernel+bounces-99748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A135878C96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD5D281751
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F076FB2;
	Tue, 12 Mar 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gqzO+a1j"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB61C17
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208438; cv=none; b=Vn7L0c6KPiaiIbWKWl9Hq3dzg+2Zhg5qQJvymlvKjYsKJIa/yuDs7y30fziomhQkJdtpkPwU1WYtoURkThAPXXLZz7NfmJot5EUQuACBqkcRigf/sXidCD3+KkpUlL83norMeHfUpotx8MRPBB/3lzK/fSvXiW4VEMRVfmYvZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208438; c=relaxed/simple;
	bh=I3fTBn/wVvCv8wJz3S0c7XFDmGuGRN+xuP6W+JUCPFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux6xq5QWKApmj7XyOLzd3TXHCTbxX47hGI/0GLPiZZ4WKlJuBukoYvF6qyxI9E5Czyk6VWIgCjJfvWKIs3bNLezvseypMj4VquCKl2XE+eBYcRzBaHcuI+vKs1AoYppkBohVHb5iL3e4WYfZJpoxN5u2dEBmNCIHM+Mr/jyYQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gqzO+a1j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc949f998fso4625370a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710208436; x=1710813236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+8U24REJsycoMY3gapLXd6No4Kdp5va5OvGqVZaNtY=;
        b=gqzO+a1jjHOI/w0pMfToI1QKtDcRnyMXI1L4htcnM9oM3BxUP5MzM64TykQ1A/w61B
         6SN/UpkjdOP/nLhZYMxzhkf8I1bt098WSz2tbezMnBmbXzK1vSkzxRCr8zwY23epb+Hq
         DwyNxPr4uAglsLiod8M5wN3XSVQztL9k2Tp8h+TsVRhyLfTqLN4yAscHjE9s4XdONMG6
         rQI98uDiDheGtIYYe3ikSJZFDL+DpK7Fof38hYjjh7hhvmvNvRVBJ9z6xdbZtgnGTfww
         0s9ah7zPLeQ/eP8dnV6Ocnt06QcFG5Mz3K5dRAaYWlLI7UWaVi0l8kTd77ldtBLe7SAP
         DjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208436; x=1710813236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+8U24REJsycoMY3gapLXd6No4Kdp5va5OvGqVZaNtY=;
        b=hOT38En+hg8VmuB1Exs/ZWlMvfvqGWziVugbFbogOxxMVuOXUzxWN/O52HfIK4xaWd
         7vUcSjlPdjQwBdRNxqfsM5Hqdxwd1ZQiJuy1jvPS/NzzzxO9z+J0iL3ic1mbhCYtQuW+
         lyPDx4VTxvOrJjHxvpLd2yDPKTdqm06cS2IGJUIqbd3/Ptglc8vWxusKljaCGxU7VBLe
         A+/sCgygfMX0IuUfcmcD0roH2g5HJmk0yhj4n0fT3rt8fnVDycUL0TgeRVdrwXv2uBrU
         GxhbA/FDvuoNQy05VPhlNWZ8Ha/q0CtkX1lHoNFimBIMQo/sRmVvJZBNLpHbWt5QoIz+
         E7ow==
X-Forwarded-Encrypted: i=1; AJvYcCUpd/bz0Z9onJ3hHASGOoBYjCNWrWQuVJhGxoN7K8GZz/FTJ3dHUIq44YoU3P75pAvftsgydXMCtg+wrQBynQ3N0GtGIAczSCZBR+nO
X-Gm-Message-State: AOJu0YwcSw1L0CdfkAAAgAoP8Fjr8LJ0Jc8Ws+fiCLQkDxOwQRRBPOMK
	0phgQAm0dsezZBQ0kF0RHA8LYU7OUCvkLn9pNS29sobXQXIrDPhGwQY7Y5WuePXocaNWJfu6bEO
	FUUlkJ4tmzA9iTK/KRhdetZkDme5lLTeZae/JlQ==
X-Google-Smtp-Source: AGHT+IGOVuFmtgDB4ZKZlti8h1HNW5R33qsIGe5aBgT97QBW6StCjxMixdB7ixy5JtN/Q4HVD/m09pDHUBGfcjfmCjc=
X-Received: by 2002:a05:6a20:429a:b0:1a1:4a4c:9f5e with SMTP id
 o26-20020a056a20429a00b001a14a4c9f5emr646029pzj.49.1710208436407; Mon, 11 Mar
 2024 18:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-3-dongmenglong.8@bytedance.com> <CAADnVQK57PziY+xdzW=d3HaG-bn87E3p9zf7thvmqV1t0iR4Yg@mail.gmail.com>
In-Reply-To: <CAADnVQK57PziY+xdzW=d3HaG-bn87E3p9zf7thvmqV1t0iR4Yg@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 09:53:45 +0800
Message-ID: <CALz3k9jNY8NmB-=qKogA=WVC1dGA=git_hy95UoJV2=KLfhb5g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 2/9] bpf: refactor the
 modules_array to ptr_array
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > Refactor the struct modules_array to more general struct ptr_array, whi=
ch
> > is used to store the pointers.
> >
> > Meanwhiles, introduce the bpf_try_add_ptr(), which checks the existing =
of
> > the ptr before adding it to the array.
> >
> > Seems it should be moved to another files in "lib", and I'm not sure wh=
ere
> > to add it now, and let's move it to kernel/bpf/syscall.c for now.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  include/linux/bpf.h      | 10 +++++++++
> >  kernel/bpf/syscall.c     | 37 +++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
> >  3 files changed, 54 insertions(+), 41 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 0f677fdcfcc7..997765cdf474 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -304,6 +304,16 @@ struct bpf_map {
> >         s64 __percpu *elem_count;
> >  };
> >
> > +struct ptr_array {
> > +       void **ptrs;
> > +       int cnt;
> > +       int cap;
> > +};
> > +
> > +int bpf_add_ptr(struct ptr_array *arr, void *ptr);
> > +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
> > +int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
> > +
> >  static inline const char *btf_field_type_name(enum btf_field_type type=
)
> >  {
> >         switch (type) {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index f63f4da4db5e..4f230fd1f8e4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -479,6 +479,43 @@ static void bpf_map_release_memcg(struct bpf_map *=
map)
> >  }
> >  #endif
> >
> > +int bpf_add_ptr(struct ptr_array *arr, void *ptr)
> > +{
> > +       void **ptrs;
> > +
> > +       if (arr->cnt =3D=3D arr->cap) {
> > +               arr->cap =3D max(16, arr->cap * 3 / 2);
> > +               ptrs =3D krealloc_array(arr->ptrs, arr->cap, sizeof(*pt=
rs), GFP_KERNEL);
> > +               if (!ptrs)
> > +                       return -ENOMEM;
> > +               arr->ptrs =3D ptrs;
> > +       }
> > +
> > +       arr->ptrs[arr->cnt] =3D ptr;
> > +       arr->cnt++;
> > +       return 0;
> > +}
> > +
> > +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)
>
> Don't you need 'void *mod' here?
>

Oops, it should be void *ptr here, my mistake~

> > +{
> > +       int i;
> > +
> > +       for (i =3D arr->cnt - 1; i >=3D 0; i--) {
> > +               if (arr->ptrs[i] =3D=3D mod)
> > +                       return true;
> > +       }
> > +       return false;
> > +}
>
> ...
>
> > -               kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
> > -               kfree(arr.mods);
> > +               kprobe_multi_put_modules((struct module **)arr.ptrs, ar=
r.cnt);
>
> Do you really need to type cast? Compiler doesn't convert void**
> automatically?

Yeah, the compiler reports errors without this casting.

