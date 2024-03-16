Return-Path: <linux-kernel+bounces-105118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8E87D955
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2142EB214CB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4212B75;
	Sat, 16 Mar 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIA67Atj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147F107A9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710578916; cv=none; b=uQbuOkS9axYBOQrso0imLS2zc/mpkxDSovnIARYpAKlnLLDp+Fty6Q07k89iZsJQm0TEYJF3cQAi1yq6dOlEr5qVMQZBPVKV/BMv7XXKokIaOGtpchdyzpwCOhFs2xEQ3aTXC1dV0gZRP7tMBkoWxOvv7kpCLo6rNEabCtZOvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710578916; c=relaxed/simple;
	bh=0JlhthgrKHV29IVjz2EO44f92zWT1eQJTAcBHY3ySlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onz0Jw87PJJ0KYjBEroslSV6ALHnR7f3LKouAKDBYqRfH+Cs0iiolA0f5ErhnQHddupaVB4fv7dzb3KarYu8djLSRdRPqU5mj168DzRuZ+nClcd+OJckCUp1C9v47u1/R64HVlrDZdsUElUmWlQBqteAhTZSdTYiZWuv3FEnW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIA67Atj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710578913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAx0yq8BORY9e0dLO5aHnSZgcaI3RI+C7Cfvwd3q8TI=;
	b=LIA67AtjrhMC4JWRt0LLr48mZMTh0nPyd0XRv4355cj5UpYiI/3UDwl8D74gs+ipmcGiwd
	LLHBoBvNGC6TEM29E+IS6fG6niueq7MBFlF3wehp12QjFqgFIjJq11By4UC93jsLshBUJa
	4Nbloc4w7YX+83ictYEfisTZZkn0i2U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-baND0BC6NB2hcKqoyZoxIw-1; Sat, 16 Mar 2024 04:48:32 -0400
X-MC-Unique: baND0BC6NB2hcKqoyZoxIw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d478badf3cso22336751fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710578907; x=1711183707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAx0yq8BORY9e0dLO5aHnSZgcaI3RI+C7Cfvwd3q8TI=;
        b=k4V4rDj7S3jnm0xjtQa5oCb5bZf5+o/PioMmjrP96TaQ9dYqvrOWk3GlVxDWqWgd21
         WQ6uRQQr74Ti8uPaLOtwxKUvPIA9PQ6IdxUmcaSNhU87TzJSSfPycUYC8ha5PY9VLy3l
         gccS8R1wc+AHLKVAgBno91PEzhFUHQhpOTmvngcbrIPokP2NajfV/Q+eFGYs9Hs1PaQV
         2kDCiZkTchhJ0u3o9Tr0glULYEtwvdSA0bKy6EmTrC5rx/MQjAtOWR5lAAe2JayP0ywj
         slI9grsjiZVOGvf9+hdgiJ0HOcGUHkyb+pOrNdbpEMbzMdAn5cshISOXLHcH1B7V+UPO
         EX9w==
X-Forwarded-Encrypted: i=1; AJvYcCUdRPlV9dSJFcrTx0VoTh3JIXedd+aa8U61pc0tyY8enrg8ioucv1UEX37c/7z0u6w/UDSIdvH4Qksgb86DspJR0MenaaN36KRV3ctU
X-Gm-Message-State: AOJu0YwiCG4Pfqk/LnJJReg5FzM2azsMpJV69qXvbqD9yGCAo+gfOjy3
	S3hwmqNRQxg/6x69Dpodtff9dh1Dif05gSUeGZLlODbbOW/e44zi8Bzpie2p5KKkOJ8uarNeb4X
	taebVMfqsrhmeLjUtH8cfkWfapPf+zzdklgnEGZ1v1edvcPx9H1DIbGHfgc7xJToJOgXrDF5oVb
	VBltP7YSsS/nqpAnwMB5A5jpA5LAsftUH7rUcUc8h6yUN4yTw=
X-Received: by 2002:a2e:a792:0:b0:2d3:b502:3ff1 with SMTP id c18-20020a2ea792000000b002d3b5023ff1mr4145966ljf.11.1710578907179;
        Sat, 16 Mar 2024 01:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDJCaU78jy/WvCx6Z35UZXS6G0J2u/HJY/F6+G+vMKF6uUTQdpjGov40899dUzAEqnrRR95Vy0eFoqwYr53OM=
X-Received: by 2002:a2e:a792:0:b0:2d3:b502:3ff1 with SMTP id
 c18-20020a2ea792000000b002d3b5023ff1mr4145955ljf.11.1710578906817; Sat, 16
 Mar 2024 01:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315174939.2530483-1-pbonzini@redhat.com> <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
 <ZfTadCKIL7Ujxw3f@linux.dev> <ZfTepXx_lsriEg5U@linux.dev>
In-Reply-To: <ZfTepXx_lsriEg5U@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 16 Mar 2024 09:48:14 +0100
Message-ID: <CABgObfaLzspX-eMOw3Mn0KgFzYJ1+FhN0d58VNQ088SoXfsvAA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 6.9 merge window
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 12:50=E2=80=AFAM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Fri, Mar 15, 2024 at 04:32:10PM -0700, Oliver Upton wrote:
> > On Fri, Mar 15, 2024 at 03:28:29PM -0700, Linus Torvalds wrote:
> > > The immediate cause of the failure is commit b80b701d5a67 ("KVM:
> > > arm64: Snapshot all non-zero RES0/RES1 sysreg fields for later
> > > checking") but I hope it worked at *some* point. I can't see how.
> >
> > Looks like commit fdd867fe9b32 ("arm64/sysreg: Add register fields for
> > ID_AA64DFR1_EL1") changed the register definition that tripped the
> > BUILD_BUG_ON().
> >
> > But it'd be *wildly* unfair to blame that, the KVM assertions are added
> > out of fear of new register definitions breaking our sysreg emulation.
> >
> > > I would guess / assume that commit cfc680bb04c5 ("arm64: sysreg: Add
> > > layout for ID_AA64MMFR4_EL1") is also involved, but having recoiled i=
n
> > > horror from the awk script, I really can't even begin to guess at wha=
t
> > > is going on.

Linus, were you compiling with allyesconfig so that you got
CONFIG_KVM_ARM64_RES_BITS_PARANOIA on?

> > So unless anyone screams, I say we revert:
> >
> >   99101dda29e3 ("KVM: arm64: Make build-time check of RES0/RES1 bits op=
tional")

Yes, in retrospect it's kinda obvious that, even if it cures default
config, allyesconfig still fails with this change.

>   b80b701d5a67 ("KVM: arm64: Snapshot all non-zero RES0/RES1 sysreg field=
s for later checking")

You can also make CONFIG_KVM_ARM64_RES_BITS_PARANOIA depend on !COMPILE_TES=
T.

Paolo


