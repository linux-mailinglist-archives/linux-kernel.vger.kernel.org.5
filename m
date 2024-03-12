Return-Path: <linux-kernel+bounces-99775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97870878D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CFAB21ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823128F51;
	Tue, 12 Mar 2024 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RWHroVnU"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2C79C0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211459; cv=none; b=EtrexBsKU33LRi5mVAFEJPD/5l3+Jlfwyy3FLMyD3cSrqJSUvUQzBciOxePcjS6kf9qIrzpR11QGSVzPkltZXi8wYO/iP/5l75J7tCErQNwTD4DXC3gKH9zo5Vz9atN/9UzmmqsifMiMtzt4Zol2mpUmydy1P2Vp/QgsjZ3Za3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211459; c=relaxed/simple;
	bh=w1TsuMUWzBMAa4sluemyX5myNv66iSIjpefpYiqw6No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR6qC07dhv49we0crGzckYyrJW2wwM6UoCBhy3SeyuMs9q8DilnmI6VTPkIc/NmbjFfa2iRJzoGxuGCYgwDwOz0nDB/zbDDRPPwaPpvy/cLA9dxXzQ0f3LaxOhdi2FzOHTgv7PuMMKASAhpiSAAlO9Wzcpl9UiYBIHBz0pt5N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RWHroVnU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b276979aso3558527a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710211458; x=1710816258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2/zqf8TfkF7fmO3ryrALVmJ2Vqgii1SZQQKBoGp30M=;
        b=RWHroVnUxNq25PSZi9Z1RDXpYssydo+icth3tlZHvUmzLWeeWJzk9/8oklJblkLmuB
         aLY8n3upiIeHo772B6JWHGk6j1AmhgZUYqqRtK11vAn0dqqCgS+i0Xea1aRj2XObWMlV
         GGtH4hmTLW6qB5m5X6qmZH7Qd+C309mkMQJtASCj6R/C9LRKIzLYTNVjir7O6A3j1AOx
         SEMM40o3rSP+SU/BynrAGdj417Vo85UMZpPC9h+l2bhxh8D1IGJ1PIo+Ia7c+AFSdRgB
         9pUnQCB+PgaiQQ9ymeXfsCRNGTtrtMfB06l2yZzNAqVhsGP0NU2vsHVz4r1qqxpYWi/4
         cWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710211458; x=1710816258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2/zqf8TfkF7fmO3ryrALVmJ2Vqgii1SZQQKBoGp30M=;
        b=YYWD11h55U3owBUhvEN60lJoDqvNskbBi+1cB8FGwrZ2u84mSldE1daNcUnNU+UHse
         WwOFIa/tCEHAVelASECBjxEXA0MHibHOPnL4ndIicgz6GInC7JfoZj75DhlzvW3kCPW1
         aAS1CpTUTD4M4GXKtSVs/pjiq9XRFEvlF4/oUSM2mgSF4rTS3De+CC0LuN4T19Vdt+XD
         /upsrSbaJ329NKOtSzx7mzcn4BDdtGSbvUps0J7FfOO7qAYKRlGu5idpsL/wX/50ci+Q
         sHYx/GPYuEQ6URgts53U7rjC6ATUbVFKSfqRkXGAmsXMlLIkPVahjw9SkbIID1W4J6Zp
         +m0A==
X-Forwarded-Encrypted: i=1; AJvYcCW6zsxcp+9EY1uSLS7Ghg66Q9/hBFJEYqAMnwDBT3ta+NBXl6yu3uFmP7T02JP0YR4Zc/Yj+/67fU/7+mW32Borpci1k3a1iId2Si7A
X-Gm-Message-State: AOJu0Ywwj3DdeBQ/Gjg5EqlekWQ5b9CMAff2F+JpYQvcMOFe9n3qBNTY
	As0P4UVoToIFYH9v7VvpYNTwJV6Dl6Si4A02vyBS1gMfjzOOtXmuYZX6eVTMerwbHpmvv8c/qqw
	4XRe52DtEIdEPvsnxvUQEou/2cqZCNfruQRLxeQ==
X-Google-Smtp-Source: AGHT+IGvIums+DTS3WHK+W5NCGfLkPUVfEDar4QbCGrncl6WQdDDS8a1T8ll9cvRYezwajGoT7cszDUrP5tYmNtBalM=
X-Received: by 2002:a17:90b:3ec9:b0:29c:4082:2d0b with SMTP id
 rm9-20020a17090b3ec900b0029c40822d0bmr49744pjb.28.1710211457742; Mon, 11 Mar
 2024 19:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
In-Reply-To: <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:44:06 +0800
Message-ID: <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
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

On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> >
> > -               err =3D libbpf_find_attach_btf_id(prog, attach_name, &b=
tf_obj_fd, &btf_type_id);
> > +               name_end =3D strchr(attach_name, ',');
> > +               /* for multi-link tracing, use the first target symbol =
during
> > +                * loading.
> > +                */
> > +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> > +                       int len =3D name_end - attach_name + 1;
> > +                       char *first_tgt;
> > +
> > +                       first_tgt =3D malloc(len);
> > +                       if (!first_tgt)
> > +                               return -ENOMEM;
> > +                       strncpy(first_tgt, attach_name, len);
> > +                       first_tgt[len - 1] =3D '\0';
> > +                       err =3D libbpf_find_attach_btf_id(prog, first_t=
gt, &btf_obj_fd,
> > +                                                       &btf_type_id);
> > +                       free(first_tgt);
> > +               } else {
> > +                       err =3D libbpf_find_attach_btf_id(prog, attach_=
name, &btf_obj_fd,
> > +                                                       &btf_type_id);
> > +               }
>
> Pls use glob_match the way [ku]probe multi are doing
> instead of exact match.

Hello,

I'm a little suspecting the effect of glob_match. I seldom found
the use case that the kernel functions which we want to trace
have the same naming pattern. And the exact match seems more
useful.

Can we use both exact and glob match here?

Thanks!
Menglong Dong

