Return-Path: <linux-kernel+bounces-109983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AD885891
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503FF283253
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298965B693;
	Thu, 21 Mar 2024 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUI3aR36"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC558AD1;
	Thu, 21 Mar 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021738; cv=none; b=ZvsWviEVhDZFdSvaFIxgZ/I2IAWfnPyZJwwn3AtOU1gK7Tic0zKthcPsuDslnksB1x97Pi7VuAz+sGxQhsLhqj6JaaS7Cp0CtsNL8qBD7o1iDQxfFf6U6NzDMmM1zlGw86CaMwNBdtNNWJViqj5NACsrzt2p605vPf094C81rX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021738; c=relaxed/simple;
	bh=oyaxk/plSkXwNqfy8BRBwP+1IHu4SESNTkIjkLiy/fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYBf3YRiKIUXVLv18i+RnWPaphvnggIHb7T6Uaocx7J8OkRULSvzAmapJEHhMvWCa7eIQt9KKi1HLa2Ic+nloxzYsBmsXF6ddH5VG8IIZ6mtR+OrNOEBQL2Pak86t+uKzU2kJum1O+JTuuPYWiZxVRMoBkLo79RZjH0px+nt/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUI3aR36; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41476ddf668so1623805e9.3;
        Thu, 21 Mar 2024 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711021735; x=1711626535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBXuSoXBGzyYnzCyTr2t1+PEE5aIYSRJOIe9GFH+E6Y=;
        b=AUI3aR36uNe8KLc3VQPVmQ4m/N78hhQMRjy5sUrVHgBWX3rLhWIXj/XkTxnyDv3JOT
         rCNjrMBQ0KCmFU/g6T+Eieyr9fwv2BhFxsY9YpaFFK89NgoQZV74Bu1m5+s0PfJeeaMJ
         AyRQAMgGECCfYUHvPmcQ0eOQKXAwhZK+Kh5Cj/TTzwgOHzmhyZzjOv7+rRNjrBsbgn4X
         8r//ciIRmdIyQ4M6akOzZV7g9eLutrGjlCu4vQhlDNdtWfpvC2gqU34ye95ZM2U95kI+
         i/kQof9ysRhsikNBDZlqGL8Mtd56AmIhjdPL32IqZN0FwjmsSJD8usHWmnVaMef4oac6
         l/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711021735; x=1711626535;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBXuSoXBGzyYnzCyTr2t1+PEE5aIYSRJOIe9GFH+E6Y=;
        b=WzS8IkSTcixZ81pVMhe9YX4Kg/Eot6InLauFy32V0x4eXVYNBCt73HGPoQZ22KpAOt
         5aXswGiBEw6PrZ+OnUKJxF+zOY0KqzuLKUtRpUEBp4rUSzO3qmMa9vlzlZtHRtcZQgxY
         8+mJVvMrD7STVjKEPtjEiGPEkm62x6KTmi4yZRKwx23e9mAyRvM22m06OZ9Fw94T5aF8
         31NCQUYyHS861qIi1QqFzHM0ApS6zKbNHPDmUDCIuar+9K2Nzjzlr9ihF71lVntnNWJU
         qnjlviA080Dx1AB+/kVygX68wY+V1lrVS5eOfg4/eI6kn38mhYqW4DDa6+VnFM2E8Cqr
         tMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmqAZ6j8v2Du8JAdO9iNyIxunbHyjRAANhgIypEdeA6FAdiEvcsPT90h1UnijS3UZYBC3cUZH+7lyUXLemIIkjofQZuZw0scXi0uQqBk2tyVi0PSX8RA6ugB9wVZUXVY4xl32wKxGRuPymB2pE0zCdMvuFGEtaYyx6
X-Gm-Message-State: AOJu0Yz0s6H9pweHgAOnJutA2btLisxD1x+AbOHAuX8Of6zTvqpUyjCP
	I99UxNjC0foJveoqoSThNcbVBXV6Jv8d80+EuP7wyYtDHhFhryF1
X-Google-Smtp-Source: AGHT+IHgvLDMn+HkPdYkZPwv15NBsccTvbOlqisMgSHZldgyQSO7CfPZdAwWDR8KqP6FTQIBVCRBDQ==
X-Received: by 2002:a05:600c:19cf:b0:414:7751:c55e with SMTP id u15-20020a05600c19cf00b004147751c55emr355510wmq.0.1711021734847;
        Thu, 21 Mar 2024 04:48:54 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e68338fbasm9338930wrb.81.2024.03.21.04.48.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 04:48:54 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Network
 Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: verifier: prevent userspace memory access
In-Reply-To: <CAADnVQLHrmkJ5p2gEUJkf_CRxq9gv8rcSuBm5GeZ_nUJxQOE0Q@mail.gmail.com>
References: <20240321101058.68530-1-puranjay12@gmail.com>
 <CAADnVQLhwLgq=QuXD-Ls=t9Scr_4Zn9JwdkXfZQfZkT=ysx64Q@mail.gmail.com>
 <CAADnVQLHrmkJ5p2gEUJkf_CRxq9gv8rcSuBm5GeZ_nUJxQOE0Q@mail.gmail.com>
Date: Thu, 21 Mar 2024 11:48:52 +0000
Message-ID: <mb61pwmpvst3v.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Mar 21, 2024 at 4:05=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Mar 21, 2024 at 3:11=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
com> wrote:
>> >
>> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp=
c
>> > index e613eebfd349..e61a51a5b4be 100644
>> > --- a/arch/s390/net/bpf_jit_comp.c
>> > +++ b/arch/s390/net/bpf_jit_comp.c
>> > @@ -2691,3 +2691,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>> >  {
>> >         return true;
>> >  }
>> > +
>> > +u64 bpf_arch_uaddress_limit(void)
>> > +{
>> > +       return -ENOTSUPP;
>> > +}
>>
>> Looks good and should work, but s390 CI is still not happy.
>> Ideas?
>> sock tests were not failing before. So something is going on.
>
> I think I have an explanation.
> -ENOTSUPP and u64... and later:
> u64 uaddress_limit =3D bpf_arch_uaddress_limit()
> if (uaddress_limit < 0)
>
> I bet the compiler simply removes this check since unsigned cannot
> be negative.
> Odd that there is no compiler warning.
>
> pw-bot: cr
>

Yes, I verified that the compiler is removing this:


                if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
    a944:       7100047f        cmp     w3, #0x1
    a948:       540013e1        b.ne    abc4 <do_misc_fixups+0x66c>  // b.a=
ny
    a94c:       721a041f        tst     w0, #0xc0
    a950:       54fff4e1        b.ne    a7ec <do_misc_fixups+0x294>  // b.a=
ny
                        u64 uaddress_limit =3D bpf_arch_uaddress_limit();
    a954:       b90003e6        str     w6, [sp]
    a958:       94000000        bl      0 <bpf_arch_uaddress_limit>
                        *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src_re=
g);


We should do:
   if (!uaddress_limit)
        goto next_insn;

and in the disabled case return 0 in place of -ENOSUPP.

Doing this adds the check:


             if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
    a944:       7100047f        cmp     w3, #0x1
    a948:       54001401        b.ne    abc8 <do_misc_fixups+0x670>  // b.a=
ny
    a94c:       721a041f        tst     w0, #0xc0
    a950:       54fff4e1        b.ne    a7ec <do_misc_fixups+0x294>  // b.a=
ny
                        u64 uaddress_limit =3D bpf_arch_uaddress_limit();
    a954:       b90003e6        str     w6, [sp]
    a958:       94000000        bl      0 <bpf_arch_uaddress_limit>
                        if (!uaddress_limit)
    a95c:       b4fff020        cbz     x0, a760 <do_misc_fixups+0x208>
                        *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src_re=
g);



I will send v3 with this approach.


Thanks,
Puranjay

