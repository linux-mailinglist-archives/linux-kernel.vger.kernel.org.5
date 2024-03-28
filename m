Return-Path: <linux-kernel+bounces-122205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323088F36F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971111F2B72E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17B63B8;
	Thu, 28 Mar 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmqnBj0N"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B823193;
	Thu, 28 Mar 2024 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584791; cv=none; b=XHFxAf14J8XHUq8MMshCY5vrzrZ1FhblrNu+QZ/SRFyce9UXchS6QoH34SlrmU9Ueu46/18HSqFEqCCPyZG2LxJp0ccIwea27BTP44iU2FTxsq3vb6wl/KfBAmXHREPeB2+F6oyH7xMmtUwkToj6xYZeOew4sqnvyXvft66FaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584791; c=relaxed/simple;
	bh=DyNxlN+eZeRw9Yeq75xoGqiNrNHyIXDie/JPcFLU8ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj8hYvJG67Zgvtwx7fBK/sQ7SYHiDzfHBUK4Bzh0YhPMcD79a+wNYa1wRoJoytARQkvzNiCw3/PjStEpaVilwzInAssPregB5uak2PfuKPshZbmjVpaaC7saFqjtC7QbAF6hjTEun4Ue0s0uzAMEOiScwkK7k2X9B/UPdUcAgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmqnBj0N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ed6078884so827404f8f.1;
        Wed, 27 Mar 2024 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711584788; x=1712189588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYP5DWUrKLTTwT+sg5pB8c1G5q9nAtl+vodYL3+O2EI=;
        b=cmqnBj0NtnetiBdVXzBBLpkphzD6TtNqxyz3cOIx02WqexFaboj/SWLjwmLa+o1UYg
         HbrierlIDh7zUcs7BorUEi359Qk9YXM0nUuH4VJxEdF1/m6pMMV4vtlOGGfVjs/3MN0x
         vO8nwud/9kVaKyW1buSFkjiqi3m+8UB3eTtKCFQ8WwnPDY4EuxOUapQOwspCTOqe323Y
         fisF68gBXRaKMlh0O+cCTU/SXUPxaC8Te3PNciVp5FJiKd+zYgfWmGO8i/kpFlShsHNE
         3xZ4kixUcGPtJrksv5Qcc1HDcIrTHgkDUpHm2U/4XU/Xcm6GSuLNxkT1gdKVFKfUzJP8
         YbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711584788; x=1712189588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYP5DWUrKLTTwT+sg5pB8c1G5q9nAtl+vodYL3+O2EI=;
        b=ELrWIQQgmehRERb4i148SGUwnuoQCyfRC/4W/91RBRYDCxDGbjNWglcezF3X25Nq7q
         TeSKw/w0NzA//OP5aXEXXEHXtDwlbJpz12VdY1f4f3gs+ETR6d7kTY5lsGnFFG18lBG6
         0q55FQQ6PoFyiAgDCijeZ9rKJ5a1gF+i9swxtPCoLstGxExmd1DSylIDjMVMTP+8Uonb
         pjigfmaniRwmYySpBP0Vcb+U4G4FXNZh4WY/q9THnHRH/3DEC+VUiQO1JDDdezufKePD
         WAbWtjB+1I9ItcOk+EpY/lzLrgfs/9BCJK94FIbv68tlGxFvhbxASj8kpZWIfQ1ujvP0
         UOcg==
X-Forwarded-Encrypted: i=1; AJvYcCXMSh6tYiRpXoav+IF6UwtBOzapi4SJEFmEa9r/iuPec9cXuFn48O6LFWZORrhEAGq+aPX/2VXxSi7k4lZ4pEXT38+p3OcDkEL46V12XBno49WzEWbIFEOjT8lAjZRWVUb297CqW5wlBNCyJvsGlPzRjR10X6wK
X-Gm-Message-State: AOJu0YxQuecK0BwnZ/Mlxb9pCru8Nbw41K43Hqy+0mKsFMC12ndOczDP
	klrSk9Di7g3xvCkxT6zkAz7XY2skPQvYcQg1tsiVkpAtToTAO63MhtS/wDp34i8JgtGLnt+Nqag
	BxSVgSg2Rq3pVzHc5LFDunCcfATguOpMc
X-Google-Smtp-Source: AGHT+IFiABvKuRN82z03WIvitfsoxZgDOKps9I68JRIy2YOPVAH6dn+n39+2GwRGYDFeX67RZlh5XeLIE35CSN4Nyd8=
X-Received: by 2002:a5d:680e:0:b0:33e:9763:75e1 with SMTP id
 w14-20020a5d680e000000b0033e976375e1mr538773wru.33.1711584788213; Wed, 27 Mar
 2024 17:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f2f0c0061494e610@google.com> <CAADnVQKEU0yL=GpaNQw=z0J9f_S=i+rQp9QZK3mYv6632WhfUg@mail.gmail.com>
 <6fd11cc9-9376-4742-8f54-1d2988622a6d@paulmck-laptop> <4dc396d9-b57c-4ccf-bbef-887d5a42ab66@paulmck-laptop>
In-Reply-To: <4dc396d9-b57c-4ccf-bbef-887d5a42ab66@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 17:12:57 -0700
Message-ID: <CAADnVQLKzumBG0GG3cSxQMVRKM_Km9YMb6ub=n9C957qx8=ExQ@mail.gmail.com>
Subject: Re: false positive deadlock? Was: [syzbot] [bpf?] possible deadlock
 in kvfree_call_rcu
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:04=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Tue, Mar 26, 2024 at 09:37:43PM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 26, 2024 at 12:53:35PM -0700, Alexei Starovoitov wrote:
> > > Hi Paul,
> > >
> > > syzbot found an interesting false positive deadlock.
> > > See below.
> > > My understanding is the following:
> > >
> > > cpu 2:
> > >   grabs timer_base lock
> > >     spins on bpf_lpm lock
> > >
> > > cpu 1:
> > >   grab rcu krcp lock
> > >     spins on timer_base lock
> > >
> > > cpu 0:
> > >   grab bpf_lpm lock
> > >     spins on rcu krcp lock
> > >
> > > bpf_lpm lock can be the same.
> > > timer_base lock can also be the same due to timer migration.
> > >
> > > but rcu krcp lock is always per-cpu, so it cannot be the same lock.
> > > Hence it's a false positive, but still interesting.
> > >
> > > I don't think rcu can tell lockdep that these are different locks.
> >
> > It might be possible.  I will play with this tomorrow, modeling after
> > the use of lockdep_set_class_and_name() in rcu_init_one().  I am a bit
> > concerned about systems with thousands of CPUs, but it just might be OK=
.
>
> Except that each of the resulting separate locks would eventually be
> classified as participating in the same type of potential deadlock cycle.=
  :-(

That sounds like we have to address it on bpf side,
since we're being spammed with syzbot reports of various
forms and all of them are about this false positive.

