Return-Path: <linux-kernel+bounces-122083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D523588F1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746481F29BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEC153837;
	Wed, 27 Mar 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mywy/MLX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63648150982;
	Wed, 27 Mar 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577710; cv=none; b=G87xTNC68QF1JGe3dTjhdnNL4p719HWxoybEtShdY6zsPOoGGI0USYeKNutrrUdt75yjgFKIuBeLCRJZtvmvFIHlm0wEhS9Xugi0Cjg68UkjZg3DZD7EUisLfqqz2PBWHLwbalX+gGBcOxoHOZasYqoWxV7u1oVS/g7B7gYcz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577710; c=relaxed/simple;
	bh=EmGfbaHPm+aFTlR4ccslw1IMrcCRecczkG1J6vjkS7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrTBiUMHPzInL6bEd9zoHVVznw5/TvynGNRvZcUmHNs4Aa0bQTbPS23FNLI3gWNq6SpPyBhEhJ+yqqYbuClk1aZ+z9RyGCacwP+4z+SXx27HJUlZWNTfyJFAOstiqGBKsvl8IDsD2LwZ6bGT2RjaK2qo8DkA02XW5fyZPILPDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mywy/MLX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4149532da36so2732015e9.0;
        Wed, 27 Mar 2024 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577707; x=1712182507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auzs3g7lc20T4kV1ZR58p05peuhuFlI73ot3Pl+s/Hg=;
        b=Mywy/MLXMHi2DoQEw4S7+FSMyxsoSOOaF7Vf3RyrC2+0kuZRDyJGzIwGEqCBk5NgYV
         L0vray300PchH4TqdTS0CKRECbfHCrD83MSI11qzMf6DjfMkDhvCPlDbvSBtBaVimLqW
         Qdt1zGoAfgBe1h8jWyZ8m4OvKSSlz6Zxd01lio8MTOBA07R2IRgo5j07wfXlTmqWF9CE
         IiQbn6kWLyRPDoBRqxsLe8WCTfSyVTZKISvgCjZ0w/RrUYFp+VgXiqQUBT7A8P1hgL8B
         /pq8EecS03UklkYKiBM1qiPWCol1tKmEhF/CDZzuUs28obf+No7k94kZL/yJDbTWIsKw
         fkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577707; x=1712182507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auzs3g7lc20T4kV1ZR58p05peuhuFlI73ot3Pl+s/Hg=;
        b=ATN+RDsKLh9u5k+Lj0ylnivBoGx0qj4snyX8Rw1IizP0n7aao5Bd35qwVXxNwpDZhy
         AYO2MHFWIk1g0mitLEsQ0z/+5KSollkL7iiBsB8ryA2QgdBlGpkZFR7xi5NN6k43+tNh
         ZR+Dtcgi6CWiaOBd8B0+BkvHp/9Q5w0thxPzK+OpjRJw2ZT5+oByQIrZzjf7ixGWLgDK
         gO9AnQSs+LGlh5BFyrvkCcNewjy7qSZ9AvnEhDOUpghw9cVXlgFKhvVEEchiwtzu7k1e
         rV0aBE2/k5jqRswi5bmjB5PY1FAqF4PkPJdgGyQgGQd/yzuPRjjHuif9EqEn+AmsEKbt
         WvIA==
X-Forwarded-Encrypted: i=1; AJvYcCVsnRjdhfqfvjwOKbPE62UsvAJjPKvQXfQ7rCmucMZKNFB6LaBhX3yumSHK7yeJMTLr0tE5PDuOYnD/ja16Nd5bo8MHW2p9dLKY3x31/Tb4oGuzljh7eOyGREF8PWbxKQx/
X-Gm-Message-State: AOJu0YwDewqkmj1uiFGxkPNMAPYoP5L6E3wy7yWWslvqe7gU82504U32
	kMPuAjpM0PhYfx8Pb6wNsbRvac57GT/yiUMr+S1r0DyjZm1lYL2eUzQs2ySfcILUhdf5r86+C98
	Vhqkb00mSlwnXZWAiK2P2NgFtdCQ=
X-Google-Smtp-Source: AGHT+IEpvuMiIiuE5X2OxxBkqw+arGCfXvVvpYJ504Na3WVmQ8g8bHXmvyvm636hSMCK6hYsO3XBOKMLXeSaHnXc6lQ=
X-Received: by 2002:a05:600c:35cb:b0:414:910c:450b with SMTP id
 r11-20020a05600c35cb00b00414910c450bmr881775wmq.4.1711577704932; Wed, 27 Mar
 2024 15:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326003832.102750-1-cam.alvarez.i@gmail.com>
In-Reply-To: <20240326003832.102750-1-cam.alvarez.i@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 15:14:53 -0700
Message-ID: <CAADnVQLfo0m+j6g03epR5Or46AycWbFb7yER2R9RNCT6-6Tx1A@mail.gmail.com>
Subject: Re: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
To: Camila Alvarez <cam.alvarez.i@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:41=E2=80=AFPM Camila Alvarez <cam.alvarez.i@gmail=
com> wrote:
>
> BPF documentation specifies that the maximum stack depth for a BPF
> program is 512 bytes. This is not enforced when selecting a bpf
> interpreter, thus casuing an index out of bounds error when trying to
> obtain an interpreter with a bigger stack size.
>
> This patch enforces the stack size to be not bigger than
> 512.
>
> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
> Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
> ---
>  kernel/bpf/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 696bc55de8e8..8167b3a721e9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2196,7 +2196,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>                 BUG_ON(1);
>                 return 0;
>  }
> -
> +#define BPF_MAX_STACK_SIZE 512
>  #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
>  #define DEFINE_BPF_PROG_RUN(stack_size) \
>  static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct =
bpf_insn *insn) \
> @@ -2345,7 +2345,7 @@ static void bpf_prog_select_func(struct bpf_prog *f=
p)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>         u32 stack_depth =3D max_t(u32, fp->aux->stack_depth, 1);
> -
> +       stack_depth =3D min_t(u32, stack_depth, BPF_MAX_STACK_SIZE);
>         fp->bpf_func =3D interpreters[(round_up(stack_depth, 32) / 32) - =
1];

That's not the root cause of the issue.
syzbot is saying: index 16 is out of range for type '<unknown> *[16]'

somehow stack depth got bigger than 512.
The bug is somewhere in the verifier.
Please debug it further.

