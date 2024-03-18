Return-Path: <linux-kernel+bounces-106593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D909087F0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537A01F2406F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402D58224;
	Mon, 18 Mar 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG856S+G"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B757878;
	Mon, 18 Mar 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792138; cv=none; b=hUsqOyvUat6ydrTaRPeHxYWupM/0IAJuyQuONwEZ96glx2+cDlH0AAiNzRG6KGlsqxEKBnQ1WEo/IU0lOFdSUp12GUA/o8EDvky6Y/DVavfiIQCB0LM5trAqBvdDpxLDw7zUgwB+Afl6VwU77r0muuujd9p8Z3fMk6behp3ZvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792138; c=relaxed/simple;
	bh=mi3qAj2FHf0tEjhKImKJSUVUAS655fCK54mXzARxt+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6allNqdTz03zn/p7mAsamELbp1E6Alxr3ctgIhh+XTKVXa3Ogfj1SqdsyNYyRbw5k9lnua7yRUxpYY99yVxDZcKoQdFfksTdPspT7Q+DhdmIOT6sSahbUh5/tEJKLganTnsUtxVYVXAyFNh0tWxWjFZkcOULCkPRMXoelAu1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG856S+G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e02f839d66so8752065ad.1;
        Mon, 18 Mar 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710792136; x=1711396936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu61FhKAKTdlIvxSWUURfcRxp/hLcKTfnL8fJyKDvBI=;
        b=gG856S+GjXIp2IpY9TnQrHIxtf/BaHHlwHASP9Oc5hPg3wSvwj7R4wBv0UxkTvQcVd
         5nrO4wv1dblauKHYVhEBvXJO89KYZ0KcYBTMCI4Wasi4qhOGrVHlQjAaiOiPAPTJlOOj
         AFlGYboF7C/mGuS06r5kRhlslYPuEAba30CdGm2RazDlp4HG2kHTE7f5/L3fD3Bk8JkV
         78g6n3SuOsYshAFTpgfCITRfjYNJS4QasX8xvfAV/a/eeFMe6Env9Sf7yBC/8mWa/6t0
         Y8L82vje7gy4zomQs72nFSYcZywRQg/q9vpZbyd0k80+h2EoqTWtgIrWXGdYOpQ1i5t4
         FdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792136; x=1711396936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu61FhKAKTdlIvxSWUURfcRxp/hLcKTfnL8fJyKDvBI=;
        b=hnBH9smjxOFVEj1ztj4AUWkmVsXA3wyWHvh7kxUDs7P3o4Q58QoWN9v1zrC8JUkfmV
         pWw+yuoC5hkYJFoo7iclEbgl+8hs7478YlqGYhcVvsRgXgwDQ0pUhUwRoXRptS7qbf9c
         JUSf68950cQbkw8tL1vLN6t96U9Rpk37pQtZiStlkniV0wLs3+/JZuneXSJmpjXgeFux
         0+f58jSJaU5vi4/CKE+36KhbcAxCedobbUWzAp8NB+VKnfLIE3BxTRVa6T90ix0dxWPw
         nzYIB72BR6btoXZhA9Ti2hl6ry90llXEhin5A/FxMGkZDKM9zkwf2vRA0rDuLVyOqdVl
         AsQg==
X-Forwarded-Encrypted: i=1; AJvYcCXnCvTZIOLbLUGxQU7S0gVjzLJT0CGE1eJLmBYdvY3BE4c+XkRCXjA5K5R0x/OVGpRvQEiMtXJAV4RyhAeh3jpiU3CaKg5bGAl0tafIDY7RoEP9iYx5KX68/l++crmAxLCj
X-Gm-Message-State: AOJu0YyEquBZeBD4twGCJIJM2N/BlchIswDhTlJdUx0TAPwccaAkSf8/
	d8sPxnPF+HyiUdxsc8/tm9eDnZ/kRIWUEHXRDD0RH3KFF6df0tvO2i28xogYaRl+rsWDpvYMHp7
	jroNh9Jm7UP9+nfoPhZ1rsk/D6cQTk7nek1Q=
X-Google-Smtp-Source: AGHT+IEnFUiAWsxDP4hkD28ZTIe1vPhwB4HBhZs4uEDE1NRoqzjhEqrKkzWdfGUNtey0r7s6chXqB1nt//W2naPI8IY=
X-Received: by 2002:a17:903:2d1:b0:1dc:62d1:c69c with SMTP id
 s17-20020a17090302d100b001dc62d1c69cmr15775948plk.67.1710792135749; Mon, 18
 Mar 2024 13:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318031625.193590-1-zhangmingyi5@huawei.com> <ZfhwLIphSEY5IWB6@google.com>
In-Reply-To: <ZfhwLIphSEY5IWB6@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 13:02:03 -0700
Message-ID: <CAEf4BzZ05YuKmqV4_2A6fAjTP3SC4DU-2T+Qjj_OvjsjtaBf8A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix NULL pointer dereference in find_extern_btf_id
To: Stanislav Fomichev <sdf@google.com>
Cc: zhangmingyi <zhangmingyi5@huawei.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com, 
	kongweibin2@huawei.com, liuxin350@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 9:47=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/18, zhangmingyi wrote:
> > From: Mingyi Zhang <zhangmingyi5@huawei.com>
> >
> > During our fuzz testing, we encountered the following error:
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00000000005915bb in __interceptor_strcmp.part.0 ()
> > (gdb) bt
> >     #0  0x00000000005915bb in __interceptor_strcmp.part.0 ()
> >     #1  0x000000000087dc65 in __wrap_strcmp ()
> >     #2  0x0000000000951ded in find_extern_btf_id () at libbpf.c:3508
> >     #3  0x000000000094d7a1 in bpf_object.collect_externs () at libbpf.c=
:3712
> >     #4  0x000000000092be3b in bpf_object_open () at libbpf.c:7433
> >     #5  0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> >     #6  0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-obj=
ect-fuzzer.c:16
> >     #7  0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one=
 ()
> >     #8  0x000000000087ad92 in tracing::span::Span::in_scope ()
> >     #9  0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir (=
)
> >     #10 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{clo=
sure}} ()
> >     #11 0x00000000005f2601 in main ()
> > (gdb)
> >
> > tname =3D btf__name_by_offset(btf, t->name_off);
> > if (strcmp(tname, ext_name))
> >         continue;
> >
> > tname is passed directly into strcmp without a null pointer check.
> > When t(btf_type)->name_off >=3D btf->hdr->str_len, tname is NULL. norma=
lly,
> > that's not likely to happen.

Libbpf now does BTF sanity checking, see btf_sanity_check() in btf.c.
Do you still get this crash with latest libbpf?

> > Considering that the bpf_object__open_mem interface is a direct API
> > provided to users, which reads directly from memory. There may be an
> > input similar to this fuzzing, leading to a Segmentation fault.
>
> Are you trying to parse completely bogus elf obj files?
> I don't think we have been hardening against those cases. I see

yep, I agree, it's definitely not a priority to make sure that feeding
malicious or random garbage ELF into libbpf should never crash (we had
libelf crashing before libbpf could even do anything, for example). In
this case I think BTF sanity checking should be good enough.

But in general, I'd definitely wouldn't go out of my way to guard
against some ELF corruption, though if it's just a simple NULL or
bounds check, it's no big deal to add that (though as I said, BTF
sanity check was added specifically so that we don't have to
double-check BTF invariants, like having a valid string reference, all
around the code).

> a bunch of other places where we assume the return of btf__name_by_offset
> is non-null. Do we need to audit all those places as well?

