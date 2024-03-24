Return-Path: <linux-kernel+bounces-112819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAA887E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA51B20E13
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6EDF58;
	Sun, 24 Mar 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEvH1XHq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64F79DE;
	Sun, 24 Mar 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307535; cv=none; b=BLrSOuZLO8BwIBJmo6+uq+JnC8O5YIw+DjuqWPMeahzSiEGUc5OX/2AjgaYNE/5Vebr8ntDmhVJnzRB7J9vOxOrfoDvQvuui4xJGvpVXy4y2TGpAKkLPzriBABUZ342mCMxyMVPm6Fe10yNFVGYy9ELaY4nWx70ZXQPy65X/OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307535; c=relaxed/simple;
	bh=HxrL3yrY+BnVWjRVhzTVwqwSmIK98ryV6vDwq/y0eSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIJ6rP0wM5vgjcevHB39SP47IMJbciI4QWzE0dXWsxaL3dVjIEBQs/zTg3aQODZMzN4recP5lnelzDj6Cw0H3nkgCKIpJdpKAVmYkwfUcNSLiBAA9NzolQqOV5XQywnOSzuftfFQBOeJX2diQTsPjyD41pO3JeBYvX6nkC0st6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEvH1XHq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3416df43cabso2546374f8f.3;
        Sun, 24 Mar 2024 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711307532; x=1711912332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XPrkYswoGZZY13BgeysvBXQ3QtJFj2Q510OZd4P6Cw=;
        b=XEvH1XHqhIODVTSEhV6RXqWMfvyHUBJhLs/xUOSNiFXxLjUTcTTvRpQxHcf5P5aqrd
         nQ59pV0xSX/eIMuEUvda49fazRQ//EErGrtk1XCE2CakYFXLv+7sCQrh71+c3Q7J8iwN
         2QdfbBS+QRU47ujX3iQXhjMEAxiiq5B7fmjWw4GJGaUrjlGK4zKqUrOI9nLB1ng8W1zj
         qQp8wqVpZ9TZUVfHD++Hjir9MGw2dc0mUmR85mDxtmbwuUlc7thA+6LhvBM/iB5Vysni
         w6dI2Jf1ZS2UMQN55E2PH1Ctlm0o/uhd/HKhmuDm8rUCf0i37B7bnmrO6OGuvaax1Xo2
         PHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711307532; x=1711912332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XPrkYswoGZZY13BgeysvBXQ3QtJFj2Q510OZd4P6Cw=;
        b=Mv8H/blDn7tw1uKOOCk3ukfUvn1NKQET7YO3JKVwTEvtfNF1/7CfOE8ZC2kDvs69op
         Sv/vk3vWbHm3hbTNcTzAqWOneVOUciHwkWrDGaiXKapHEVR9iNj+j2Uzyh7HIuJUFMGl
         qv09Z0GkaB0kIvJL1lXWhT9esdOsuGkHLld7wd6lhQStXtNlaY9AlFhkNYo3ZPMabx3b
         t9mYOUzPKd+wGZef45iYdS9AQvqqUF6/HjwTzRjpoaDb0zPzHGmzc5TnUCj61HkyGH4G
         Mzk60xNLNSYD4irRDZ79lGcI+XH2806WLZE7kCrEEzElOAasP8sxJC26aBjaCIaYdMhV
         +4pw==
X-Forwarded-Encrypted: i=1; AJvYcCWqKjdL/1EKPbL2piuIvS5jL4Mt7XnQ7MvBnZSYba3rSGawfeV2Yu7kp7YmINpbR085ou8Fsm9imK9be5Lm8r0vqiYF4GHUBtGgS+FS6YFnJYg3DvRXb9j7zDZeny/F9w8EHfP1+dSyYJ+LZaHgBADUE4OexbQd97LC
X-Gm-Message-State: AOJu0Yw3JyEM3QIkmMkK4BKVrYdzYc99ROq+DlyOXiBw6ixaiYtQ1zfk
	nBv3rAxFfJcozKnZ6ueHOzcMY3Av5gUaxYyV+/VINNVrTjFVvP2mSUzDu8WbMz21VUXmURnfRsQ
	vZULvb7PgFB0e6T1NFjP46h7Gwos=
X-Google-Smtp-Source: AGHT+IFTXptGYk9BxinQVry4WaEeRCpyiuzlOV5YMpfbWeT0jfiwEUSMOLzrK5twk3Qj42doM5X8K1Lsn9SIGSQ9y1w=
X-Received: by 2002:adf:f689:0:b0:341:bff9:2e4f with SMTP id
 v9-20020adff689000000b00341bff92e4fmr2868556wrp.44.1711307532417; Sun, 24 Mar
 2024 12:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321124640.8870-1-puranjay12@gmail.com> <9f2b63b5-569c-1e00-a635-93d9cd695517@iogearbox.net>
 <mb61p4jcyxq5m.fsf@gmail.com> <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
 <CAADnVQJhxQV0xBJDWVkTGXJ+XYpsq5kFmMsuMEHBEaqUmkh0iw@mail.gmail.com> <mb61ple677vuv.fsf@gmail.com>
In-Reply-To: <mb61ple677vuv.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 12:12:00 -0700
Message-ID: <CAADnVQL3m_pDaTF9aL85Sz1Fr8UWcWmnKe2foqzVj35GiEofYA@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 3:44=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Mar 22, 2024 at 9:28=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> On 3/22/24 4:05 PM, Puranjay Mohan wrote:
> >> [...]
> >> >>> +           /* Make it impossible to de-reference a userspace addr=
ess */
> >> >>> +           if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
> >> >>> +               (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
> >> >>> +                BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)) {
> >> >>> +                   struct bpf_insn *patch =3D &insn_buf[0];
> >> >>> +                   u64 uaddress_limit =3D bpf_arch_uaddress_limit=
();
> >> >>> +
> >> >>> +                   if (!uaddress_limit)
> >> >>> +                           goto next_insn;
> >> >>> +
> >> >>> +                   *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->s=
rc_reg);
> >> >>> +                   if (insn->off)
> >> >>> +                           *patch++ =3D BPF_ALU64_IMM(BPF_ADD, BP=
F_REG_AX, insn->off);
> >> >>> +                   *patch++ =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX=
, 32);
> >> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, =
uaddress_limit >> 32, 2);
> >> >>> +                   *patch++ =3D *insn;
> >> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> >> >>> +                   *patch++ =3D BPF_MOV64_IMM(insn->dst_reg, 0);
> >> >>
> >> >> But how does this address other cases where we could fault e.g. non=
-canonical,
> >> >> vsyscall page, etc? Technically, we would have to call to copy_from=
_kernel_nofault_allowed()
> >> >> to really address all the cases aside from the overflow (good catch=
 btw!) where kernel
> >> >> turns into user address.
> >> >
> >> > So, we are trying to ~simulate a call to
> >> > copy_from_kernel_nofault_allowed() here. If the address under
> >> > consideration is below TASK_SIZE (TASK_SIZE + 4GB to be precise) the=
n we
> >> > skip that load because that address could be mapped by the user.
> >> >
> >> > If the address is above TASK_SIZE + 4GB, we allow the load and it co=
uld
> >> > cause a fault if the address is invalid, non-canonical etc. Taking t=
he
> >> > fault is fine because JIT will add an exception table entry for
> >> > for that load with BPF_PBOBE_MEM.
> >>
> >> Are you sure? I don't think the kernel handles non-canonical fixup.
> >
> > I believe it handles it fine otherwise our selftest bpf_testmod_return_=
ptr:
> >    case 4: return (void *)(1ull << 60);    /* non-canonical and invalid=
 */
> > would have been crashing for the last 3 years,
> > since we've been running it.
> >
> >> > The vsyscall page is special, this approach skips all loads from thi=
s
> >> > page. I am not sure if that is acceptable.
> >>
> >> The bpf_probe_read_kernel() does handle it fine via copy_from_kernel_n=
ofault().
> >>
> >> So there is tail risk that BPF_PROBE_* could trigger a crash.
> >
> > For this patch let's do
> > return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR)
> > to cover both with one check?
>
> I agree, will add this in the next version.

Sorry. I didn't look at actual value when I suggested this.
Let's think how to check for them with one conditional branch.
Maybe we can REG_AX >>=3D 24 instead of 32
and do some clever math, since we need to:
addr < 0x7ffffful || addr =3D=3D 0xfffffffffful
?
If we have to do two branches that's fine for now,
but we probably need to leave it to JITs,
since they can emit two faster conditional moves and use
single conditional jump or
introduce new pseudo bpf insns equivalent to x86 set[ae|ne|..]

