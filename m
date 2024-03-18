Return-Path: <linux-kernel+bounces-106708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806B87F237
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEFBB20E15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E85916D;
	Mon, 18 Mar 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3Mq2qY+u"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659C58ABE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797671; cv=none; b=e5Ig1G/uQiOv8otMoCFsAnir+P69gpxOsz3EC3SbZVybBPH7q21APS3z4+arGYwmIgEn5hdrRY/T/kz4KdLSEPh67ylT68tIIqtTPyZAPDcfFbgVkmQRJwMVoSMPRTriUecTG1nltvdQ2BK3Hj6TKXP3e80JV0V9E02PJXH+Dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797671; c=relaxed/simple;
	bh=tDMM25GFM35ln5xFJFl8/1m4EvWiz90qb7o7MPzbLoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehNHMVNorP2wv3pFODa7LYIb5yPeYu1xct1lDypH/rpRvsY2uV3ALI2DjdPpwTNSYyw5RcNGmZYYzEecCz7zlQ5kB5E03Bhblb+tnBuRcZi/E/EvsbFuqRMiuB3zG7R+TMyKPLsB5R1IyrswOd0GA81gAx+tNCHNkfiJFDiRvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Mq2qY+u; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0310bb981so9541255ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710797669; x=1711402469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeKReu/YtEZ4HGj+nixBj489LFLFbiNCXrSvK0Sz0P8=;
        b=3Mq2qY+uJzGr/KI8Fmbt5z0x+j2fzDvkAD9hxmeiTIJonYOjGezSMxWlorQRoUbMEv
         ihQCQTwN9cjcpEiLaXF6vqfmqoNsUNxq4EBhOp2YCjVlf1l2f7qIPougq+v5ojktixFE
         sKob58cbM/eSMvkYySgJ4KodcfndxFhex98JKhEQ5YBl52Yt2/soYepCcVHdlFFY9mrV
         Sb0nRbR0vUxUGBbtRkexPTSAzuPIwILddhsm/z2c3arqh/ABwdaC7X+cqraw46UhDqks
         55t+MmQFLPUnpGjmvVL2vrp9tKBrSRw9UZ1MsaBnsN4G/L2J7bwXQu+ENvY+8BGLxEtA
         OKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797669; x=1711402469;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TeKReu/YtEZ4HGj+nixBj489LFLFbiNCXrSvK0Sz0P8=;
        b=uvq7bNube9EKPCacwCnQ6lMnzucTRm31MmYzdBoKcU7MLmTrEVtIJUB+gFUp2AZpVQ
         Pd9DQU248QYZrKoHvlVN9vaYjpbSUs4GZ/2RXpix/d8x81/RxI5+NvabJ7I8RRFTHRJs
         W5y9XNhYL3stv7qr6fGgKFkEE7YcO1VM5rNrc0FH94klgpoi/ahwN7mHkoQwtXlWNe/w
         BAA5FEoZg2ekz6n75KjY13u/GYV7kBManRfYuLJRy/6Sl7VR7U6TwbYy+xlHKibOv/ox
         tc0HuqGBbWIHAAXGndsOw0m7DskJhZ8732GDZvNroWH+IjzGnp8pmv99S2QkKqbDNXgA
         uVqw==
X-Forwarded-Encrypted: i=1; AJvYcCWG17WBNMYb2+qHtvgjxxA1/fMlif1Dpj3gN4eNpQKH7fNfXWFkjAf2vBk8fDsQ9wL3IUxrXfYVVsqL0GTekD77hqsCo/yPOP6tfZWN
X-Gm-Message-State: AOJu0YxoxnQkmpob9RjOY6qG+YHQExQS5U2EI6INFsfQITTXt/CDolQP
	ejX2R8AyHrm3Gt0EHwaGzQQ8sot4h2jpQH+YajIqB/5Hqa8OdqAmPD6aPygCSpzGKJSfLzexamd
	omw==
X-Google-Smtp-Source: AGHT+IHHFfh8bUUrLY2QtXWlRmbDtHa4OYjClyEvG8anTXs7Tp/AWB9SI9q73Zu0u18+D/q5oVz2ixwSpW8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1207:b0:1dd:761d:6c6e with SMTP id
 l7-20020a170903120700b001dd761d6c6emr824423plh.5.1710797669325; Mon, 18 Mar
 2024 14:34:29 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:34:27 -0700
In-Reply-To: <b7561e6d6d357fcd8ec1a1257aaf2f97d971061c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000005fa5cc0613f1cebd@google.com> <b7561e6d6d357fcd8ec1a1257aaf2f97d971061c.camel@infradead.org>
Message-ID: <ZfizYzC9-9Qo47tE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: syzbot <syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, paul <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024, David Woodhouse wrote:
> On Mon, 2024-03-18 at 09:25 -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:=C2=A0=C2=A0=C2=A0 277100b3d5fe Merge tag 'block-6.9-202403=
15' of git://git.k..
> > git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c96aa5180=
000
> > kernel config:=C2=A0 https://syzkaller.appspot.com/x/.config?x=3D1c6662=
240382da2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D106a4f72b0474=
e1d1b33
> > compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcc (Debian 12.2.0-14) 12=
2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://syzkaller.appspot.com/=
x/repro.syz?x=3D14358231180000
> > C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D1=
10ed231180000
> >=20
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7bc7510fe41f/non_bootable_disk-277100b3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6872e049b27c/vmli=
nux-277100b3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/68ec7230df0f=
/bzImage-277100b3.xz
>=20
> static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, uns=
igned long uhva,
>                              unsigned long len)
> {
>         unsigned long page_offset;
>         bool unmap_old =3D false;
>         unsigned long old_uhva;
>         kvm_pfn_t old_pfn;
>         bool hva_change =3D false;
>         void *old_khva;
>         int ret;
>=20
>         /* Either gpa or uhva must be valid, but not both */
>         if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) =3D=3D kvm_is_error_hva(uh=
va)))
>                 return -EINVAL;
>=20
> Hm, that comment doesn't match the code. It says "not both", but the
> code also catches the "neither" case. I think the gpa is in %rbx and
> uhva is in %r12, so this is indeed the 'neither' case.
>=20
> Is it expected that we can end up with a cache marked active, but with
> the address not valid? Maybe through a race condition with deactive? or
> more likely than that?

It's the darn PV system time MSR, which allows the guest to triggering acti=
vation
with any GPA value.  That results in the cache being marked active without =
KVM
ever setting the GPA (or any other fields).  The fix I'm testing is to move=
 the
offset+len check up into activate() and refresh().

