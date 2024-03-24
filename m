Return-Path: <linux-kernel+bounces-112635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E3887C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC1D1F2164D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676AB175BF;
	Sun, 24 Mar 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYvB5sgx"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301A33F9;
	Sun, 24 Mar 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277054; cv=none; b=NedWSsl9izTsMqPQYyJkmGET6XNhhbyluGtSowXo8iks3CbezoZ5ir4AiPW7P9dsbtGPv+Pet7QgPvyEvFl9aM231IhnPbXZhBHtO6YNKYHOaokiI0hGeUVbeY60lMmH5Q3TU5uZvoEcsXtuucS0RUndbxiCsSGjbPGV7Q419G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277054; c=relaxed/simple;
	bh=MgeEKYRUkfHUMypUhDM+pgDwBgka/ZUioY24LhF9q74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKh2+UiXR3gkuwZF6BzhQnoDEctUU/fRboUzAa7VLA3eN62WwSsJh5ZcPisnY8qQUEHm6GQlb4+nqv55pA2lMpGN+/P8nsbKjtT0f2UrjJYEjBCnu0D0hhO+hjHdkAbrgmH1M6whhigwaKrpUmDe9ioaicEwarRPA/MNJmjVj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYvB5sgx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147fbe6146so7198945e9.1;
        Sun, 24 Mar 2024 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711277051; x=1711881851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUdV8FF+BI4dVa5TN7lmP24qHxhF6e2K9idJyEape4U=;
        b=XYvB5sgxzQyrNnulg8QKFRvRI1EaZrJ0X6+HuYlmbz242xp6DfPcn6j5LsJWMzmBWV
         r3RXAux6Ju+BnqKdzpnPZyXr0nlFkQzm8608Hp2cWyW0prLFCURF5PmeJlknU/CihCMG
         fLnv+T3BUjJ79nLKUCi66u1b3hYCZ7rRkxYcBraxVcp3N5b87u1TuLqw3Je26tkUlt3K
         SRjm5Ex49eGAjSYGH87BjAXe0w6FF/G3lHGc46eTzApnK8drpCZgt+TzLH4w4QuLtRZa
         h0ieTxd5QFicRYwQPW/TV2ph6zuJL3lPCW3pOAEaOY5nPs6kxanUC46Iw3/02EFG/0me
         B3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277051; x=1711881851;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUdV8FF+BI4dVa5TN7lmP24qHxhF6e2K9idJyEape4U=;
        b=ACAr1C/LV42EZ0sbM7N4irmia6t0Gx574OAmclnJLhKrwuN/Xhp5+OzggKD63AWKl4
         I3mWMe/M4Ex9rBL0wYq/BfjUcK0a+h8Wc4AwOCjzHrmsLXRBQ9xlo/QJjVG9Zvg14Z2y
         4HySAsPlMPb9HW5JhvpMCzY9IcIk+KMb/JH5EB6VcQQTS/UygTfOjFbCUhOlwsAHLyeP
         5sKSxLxy1D06BGL7fSb/cQO/xKA4ixdAVq1f+4sahtU0SCnVU8k9ABG8k86bsl+UMdin
         ZvI0eE081i9MUoNYVPMKR6QcACO6v8G+1QyyRfuX8A8O6EQTtCxF2y4r6VBu6f38nYB6
         ysoA==
X-Forwarded-Encrypted: i=1; AJvYcCUWO8vGdLPUcOyL6URbapdzD/d8gdi3UYpi+0U6FUO/MCufx61gTesKpqN5VSqH8T6v39T76bRb461kawMMbTvPn135GW29RzPearSlwsgEulb846RLK/Vocf16rRexaz+eeFtzWp1CVYL/uCMDPSF6FkNuxkXz8Xmj
X-Gm-Message-State: AOJu0YwLqHgNviDath94Q/EeopR7ThyuO15XxkgNFc6XmGGBWcgTOW90
	T4aRilPnFmMMLk4StTIs4Q18p6w/ZKFJcm2qEilWgUQOTu/19wLK
X-Google-Smtp-Source: AGHT+IEdFXcZjYG/ojvsgSzDOiGLCbVdXamxzEsEZdU9c6RIH093BXmj+TvCSPlBpOH19ScOlJ4vTQ==
X-Received: by 2002:a05:600c:1391:b0:413:ef69:df65 with SMTP id u17-20020a05600c139100b00413ef69df65mr3064211wmf.20.1711277050892;
        Sun, 24 Mar 2024 03:44:10 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c354500b004146a304863sm4922142wmq.34.2024.03.24.03.44.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 03:44:10 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf v4] bpf: verifier: prevent userspace memory access
In-Reply-To: <CAADnVQJhxQV0xBJDWVkTGXJ+XYpsq5kFmMsuMEHBEaqUmkh0iw@mail.gmail.com>
References: <20240321124640.8870-1-puranjay12@gmail.com>
 <9f2b63b5-569c-1e00-a635-93d9cd695517@iogearbox.net>
 <mb61p4jcyxq5m.fsf@gmail.com>
 <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
 <CAADnVQJhxQV0xBJDWVkTGXJ+XYpsq5kFmMsuMEHBEaqUmkh0iw@mail.gmail.com>
Date: Sun, 24 Mar 2024 10:44:08 +0000
Message-ID: <mb61ple677vuv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Mar 22, 2024 at 9:28=E2=80=AFAM Daniel Borkmann <daniel@iogearbox=
net> wrote:
>>
>> On 3/22/24 4:05 PM, Puranjay Mohan wrote:
>> [...]
>> >>> +           /* Make it impossible to de-reference a userspace addres=
s */
>> >>> +           if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
>> >>> +               (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
>> >>> +                BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)) {
>> >>> +                   struct bpf_insn *patch =3D &insn_buf[0];
>> >>> +                   u64 uaddress_limit =3D bpf_arch_uaddress_limit();
>> >>> +
>> >>> +                   if (!uaddress_limit)
>> >>> +                           goto next_insn;
>> >>> +
>> >>> +                   *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src=
_reg);
>> >>> +                   if (insn->off)
>> >>> +                           *patch++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_=
REG_AX, insn->off);
>> >>> +                   *patch++ =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, =
32);
>> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, ua=
ddress_limit >> 32, 2);
>> >>> +                   *patch++ =3D *insn;
>> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> >>> +                   *patch++ =3D BPF_MOV64_IMM(insn->dst_reg, 0);
>> >>
>> >> But how does this address other cases where we could fault e.g. non-c=
anonical,
>> >> vsyscall page, etc? Technically, we would have to call to copy_from_k=
ernel_nofault_allowed()
>> >> to really address all the cases aside from the overflow (good catch b=
tw!) where kernel
>> >> turns into user address.
>> >
>> > So, we are trying to ~simulate a call to
>> > copy_from_kernel_nofault_allowed() here. If the address under
>> > consideration is below TASK_SIZE (TASK_SIZE + 4GB to be precise) then =
we
>> > skip that load because that address could be mapped by the user.
>> >
>> > If the address is above TASK_SIZE + 4GB, we allow the load and it could
>> > cause a fault if the address is invalid, non-canonical etc. Taking the
>> > fault is fine because JIT will add an exception table entry for
>> > for that load with BPF_PBOBE_MEM.
>>
>> Are you sure? I don't think the kernel handles non-canonical fixup.
>
> I believe it handles it fine otherwise our selftest bpf_testmod_return_pt=
r:
>    case 4: return (void *)(1ull << 60);    /* non-canonical and invalid */
> would have been crashing for the last 3 years,
> since we've been running it.
>
>> > The vsyscall page is special, this approach skips all loads from this
>> > page. I am not sure if that is acceptable.
>>
>> The bpf_probe_read_kernel() does handle it fine via copy_from_kernel_nof=
ault().
>>
>> So there is tail risk that BPF_PROBE_* could trigger a crash.
>
> For this patch let's do
> return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR)
> to cover both with one check?

I agree, will add this in the next version.

>> Other archs might
>> have other quirks, e.g. in case of loongarch it says highest bit set mea=
ns kernel
>> space.
>
> let's tackle loongarch with whatever quirks it has separately.

Yes, having the current patch will not break loongarch, it will help it
skip some userspace addresses. We can later implement
bpf_arch_uaddress_limit() in loongarch JIT to handle its specific
quirks.

