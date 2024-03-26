Return-Path: <linux-kernel+bounces-118314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1288B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741542E722E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A712881E;
	Tue, 26 Mar 2024 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEe3uYiH"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D65788E;
	Tue, 26 Mar 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421300; cv=none; b=E75zyIoiqMFItJr9NtaIFbtHll7l7O+L09MdE1uQtNVz9aYAymxof/zIxlDF8Dsnv0ZomnHkN0npslhGyNt0thL967EV7k5lX5LZYY88uFf2XKp64WB4lJyXf8sOFeuJDvxQrzhG8HPnyEWu6d17WBcXE5KGYasZFxIYOyh7mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421300; c=relaxed/simple;
	bh=Gx9X7vXUylCb0AsyGcpvgof2jbtykG7sjHQU5fJhc9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQvfipLOC/YYAaDRzMFgFSKmyGZmvDb7z4KMVSh8Qf1zmfHenMDpsKRhfNW03ufKKnm9J6VLiOwqwZDQdC4LiNSSvjKjb7Q3iZA/uVhALHPx7RRV0yNkk0Y6Nzg1qMU5FtBZ67wLhWChvIuLzAlfT+TAPW4K3VC7ElBlICAdydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEe3uYiH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so3890946a12.0;
        Mon, 25 Mar 2024 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421297; x=1712026097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPPOsfiak5LVxPgduynFfOGZl8R/zGRlnbVETVUqeDA=;
        b=FEe3uYiHwlcji/cI4IAjnmHayORuB8t5ni+lS9yV9x7Nfijo4dM/SlH4gdCqJclmF8
         orXRXW3bElOi0AoXHc845pW85Pqq6OlG0KVV0OOrqHFZlbbHCahC50oDfnqPpUKNsxTd
         0l3yN4TLGNkTWYdkOXi3In5UDr5KUfNN7j5BF2f64k8p5PJPv3utAXfZGsd3RWh25HSj
         7bL/VZB7HdjxQchwKFoDtAusDpp/WOJcZe/FE5rYpxaIRtgZ6UO/WlaKUTlH/Md7XlC1
         F+Hpm4yktOxfXxdy7T234uzcpw1/Nuf0TuHEjkMjrTw+rbNEk2gpCtHq76s5b64wAsHw
         PNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421297; x=1712026097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPPOsfiak5LVxPgduynFfOGZl8R/zGRlnbVETVUqeDA=;
        b=U119UVC4Gw98Iz24RIQzJC8WkuFa4Ip2H+1ECaL8hmqkc1hTeugH3vSncXjFvrV3W5
         /CDi2CP820v3d4kOPDvNMi62GUFoUjjkXpfptUSfU3OPAoExVP7WJV1CuZGAze3pR2Dx
         YDbStUMvAyNw8GWnpg4h8BxZdOHTu7PwARxbcmdumrN55AqPo/3Uhlm6aTNumTu4doiO
         MCp95kU002pt18DQ7L9DC0+KRWvcdSa0ZR3bz63bcNkfOIgdswFoSu6P0K8JrN9BD5NN
         oJ2amP/MIqnYiehfvCFb23EgVEGTt1XehK+SkpPZAhEQu92MgoNqW1WmsxzicONSry4s
         GW+g==
X-Forwarded-Encrypted: i=1; AJvYcCXltP9XIbXYd05Xv/xe2N0pw1V2Uxol8GM1Rp6bpT/Yh+pRMtfFXjYeXjq5zIHAVWQjoah88E8PNMJeSO9H0RzZJhMLfGJTvHwTVgXhAUM6obJoM7U7LsA1HJr+FMapzzACWSFhOhCAqDLAMIRa70/tJM/fJWjcnBK4
X-Gm-Message-State: AOJu0YzyP+8NunBCRHcRRgGKv0R6CtATEx38gyd4/JEY+bYmuXQ1G+kM
	bwu8HiNQbve944xRT9FA92dvlJX7+VhCV/DOCkg1zEOc38HsTLhIVUU480D4ia4kUzG0nHk2VBW
	HYEk/LKU+0M3sX+KF0Rl9LicA21Y=
X-Google-Smtp-Source: AGHT+IG2UDeQj0KZ8zVq2N2nObvvo2nYE/2IM60oh/gA+7rYApndDSID315TbUOlMANw66iWPUDkZ+8cS/yrGaa9fSw=
X-Received: by 2002:a50:aac9:0:b0:568:d315:b85e with SMTP id
 r9-20020a50aac9000000b00568d315b85emr6124163edc.36.1711421296733; Mon, 25 Mar
 2024 19:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
 <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com>
 <CAADnVQJAa1SREsqz9LY+-1OnbazWC-=O=TPuq-VEWkzp1ckH1Q@mail.gmail.com>
 <CABWLseuLmAys-YuyFVeug+XR0_xjZROvgRTXz3U6cNiT+pBX0g@mail.gmail.com> <CAADnVQ+oqe6EtC8rc9TSFeUPE1Rbf11Oi-CfTyDxfXT9qM0Vpg@mail.gmail.com>
In-Reply-To: <CAADnVQ+oqe6EtC8rc9TSFeUPE1Rbf11Oi-CfTyDxfXT9qM0Vpg@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 25 Mar 2024 22:48:05 -0400
Message-ID: <CABWLses5ZpokYC==6cVKkAz25rYtgtMYn+GpxOd4TuJ7jwcNBw@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixing in https://lore.kernel.org/bpf/20240324230323.1097685-1-andreimatei1=
@gmail.com/

FWIW, I managed to decode the BPF program that syzkaller used:

0: (18) r0 =3D 0x0
2: (18) r1 =3D map[id:4]
4: (b7) r8 =3D 0
5: (7b) *(u64 *)(r10 -8) =3D r8
6: (bf) r2 =3D r10
7: (07) r2 +=3D -8
8: (b7) r3 =3D 8
9: (b7) r4 =3D 0
10: (85) call bloom_map_peek_elem#322320
11: (95) exit

Where the map is a bloom filter (as Alexei somehow already knew on the patc=
h
thread) with a humongous value size.

4: type 30  flags 0x0
        key 0B  value 2147483649B  max_entries 255  memlock 720B

On Sat, Mar 23, 2024 at 10:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 23, 2024 at 7:12=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > On Sat, Mar 23, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Mar 23, 2024 at 5:50=E2=80=AFPM Andrei Matei <andreimatei1@gm=
ail.com> wrote:
> > > >
> > > > + Edward
> > > >
> > > > On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > Hi Andrei,
> > > > >
> > > > > looks like the refactoring of stack access introduced a bug.
> > > > > See the reproducer below.
> > > > > positive offsets are not caught by check_stack_access_within_boun=
ds().
> > > >
> > > > check_stack_access_within_bounds() tries to catch positive offsets;
> > > > It does: [1]
> > > >
> > > > err =3D check_stack_slot_within_bounds(env, min_off, state, type);
> > > > if (!err && max_off > 0)
> > > >   err =3D -EINVAL; /* out of stack access into non-negative offsets=
 */
> > > >
> > > > Notice the max_off > 0 in there.
> > > > And we have various tests that seem to check that positive offsets =
are
> > > > rejected. Do you know what the bug is?
> > > > I'm thinking maybe there's some overflow going on, except that UBSA=
N
> > > > reported an index of -1 as being the problem.
> > > >
> > > > Edward, I see that you've been tickling the robot trying to narrow =
the issue;
> > > > perhaps you've figured it out?
> > > >
> > > > If the bug is not immediately apparent to anyone, I would really ap=
preciate a
> > > > bit of tutoring around how to reproduce and get verifier logs.
> > >
> > > The repro is right there in the email I forwarded:
> > >
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c3871=
1180000
> >
> > I understand, but how does one go from this to either BPF assembly,
> > or to running it in such a way that you also get verifier logs?
>
> Adding logs to repro.c is too hard, but you can
> hack the kernel with printk-s.
>
> Like the following:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de7813947981..d158b83ed16c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7179,6 +7179,7 @@ static int check_stack_range_initialized(
>                         return -EFAULT;
>                 }
>
> +               printk("slot %d %d spi %d\n", slot, slot % BPF_REG_SIZE, =
spi);
>                 stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZ=
E];
>
>
> shows that spi and slot get negative: -1, -2, ...

