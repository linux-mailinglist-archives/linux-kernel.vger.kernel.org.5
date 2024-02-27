Return-Path: <linux-kernel+bounces-84114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00D86A242
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF1E2889AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DA156961;
	Tue, 27 Feb 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YIEt4nxW"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85915531C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072053; cv=none; b=vAA21pFva7eIn0wDMCQrpD+QSnpuMxu8/aZ6S+Aax8NkiNv2eF+XHoSaOtOtnmtQ37OtnRp7f/aDlZaDb4dW6+iwPpmjZ/lY1kqeytuTSV+hj8/FBnt5TvZkRGd+1snRqX5SIujG+zCM83nGf6njllAcKTCzByAMNkz0z29j9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072053; c=relaxed/simple;
	bh=zqNdet0cnYxR5tdxAeiTzCtzka8qTvfd46LDjmjCpT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYYJ3Dd1m3y8Kh9U0Jg/vG87YLAx++cSpZzAa727Je1SvrSkJvUqMO68nsZp/qqkh6TmbUe2pJ/q9UieSd7ruDo5b8OpOfUqJZbStheLjrSFZhRET+eFrLbeqfBfn6JXCsRe3du7pFaPZ/KaRCVTkaHN+GSlGlFl4CSFj8DpgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YIEt4nxW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5040093276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709072050; x=1709676850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1lHK46c00j9c5AVxNh7l6QQvoesmPrCexEpKozkdkw=;
        b=YIEt4nxWg3rkcDVhUOT6Zj42MVF2gBuH1EaoEe/1JWOqTJ7u2CvVNRdJyEtlgrBKvA
         s21VglZjwQG46dFhvSO1DFGs+YIcX7hjYvImwrk7y+FLT4kQJC2erxQN9ATlE0zSTHzj
         IRf0dnxsvbBvBeh4cm60uErg+EkTiRl8mgHAUQLasO/2aLCN4sWeix6b2F7/1vgLrj9M
         ATpN37NbOsk8XyVuD0i4Rka/oCZgoaEC7hab2FGOxpEsmtQxLdQj8wwTaf5RglKzoXAD
         Sbd2U/xT584UbN3Sg9QI3sMGaiAIr0Oq75zG+hTHFdhP7kUeM8MXWODAkd3WW2xawk9B
         LAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072050; x=1709676850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1lHK46c00j9c5AVxNh7l6QQvoesmPrCexEpKozkdkw=;
        b=mVhIuoPdcpiPsoC8MozpZSHNlS1QsgcZG6U8PCWASY2LfXi8W9ZAG+p6dllhgZJoTv
         HsFmN+HvN/jceSuMmPwYLoZ1EoOfLXodLGzfICPYxEnBOMjar6u07cLNRmmtmPJM7Whl
         CZIyeEfSrzHoDVsU2ofig/leiPqZDt3QzRbxF9WPaCRJ/qp1gv3P5DvbV4iCTLMJwOaI
         Y/SD3cQ1/uCk5Y8BCdLm7gViFBmEGLy6e/OvEaOnNsXXiF9negAqZY1cYLqvG10W/W0x
         3ZaCGjNlR4Ayj05n6Q6Ui3chlouOg6ou6fTNoI0IPprxA5EGxHiIc0fc17uAD5MIuQki
         Gilw==
X-Forwarded-Encrypted: i=1; AJvYcCU3HuQUomgloeNFWnqGCa+n2rLE/4Dgm941DXmqlDJRIb9cyeu3K2B64Uep2xIslBCytw1mbwuMwfqO7XVcyQcJ4oUgEMe8ImTNObc7
X-Gm-Message-State: AOJu0Ywh/9FSGOHFrIE3uYdLKBlKtk+ahM2WgFnhMPewQNyona7Aa+/d
	egxRAUNyPibAr7Psf96VM8TcLsY4pBtKqoyPKDXl3AGb3LdkLeo0GyCTcB34nJ5P9o+gtmyzkFD
	ZsMQCw9uni4+akpCaSc7/iUAlGiLu330/FZ2i
X-Google-Smtp-Source: AGHT+IGRVvvOY/VqcmO82mSRPFB0J3eVmQ9MxGbLqbRmchF/0OyQlRzjMchsC/uFbZTJZUF0dxbNTvAoF7VQECE+/vI=
X-Received: by 2002:a05:6902:100a:b0:dcc:1f6a:d755 with SMTP id
 w10-20020a056902100a00b00dcc1f6ad755mr838760ybt.39.1709072049607; Tue, 27 Feb
 2024 14:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com> <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
In-Reply-To: <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 17:13:58 -0500
Message-ID: <CAHC9VhR2=bzVqHtcPH7-cSQRBnfphzzBQ4n9agXWMtasK9wh7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Feb 27, 2024 at 11:01=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > aa_getprocattr() may not initialize the value's pointer in some c=
ase.
> > > > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > > > >
> > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >  security/apparmor/lsm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > If you like John, I can send this up to Linus with the related SELi=
nux
> > > > fix, I would just need an ACK from you.
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > This patch looks good to me, and while we've still got at least two
> > > (maybe three?) more weeks before v6.8 is tagged, I think it would be
> > > good to get this up to Linus ASAP.  I'll hold off for another day, bu=
t
> > > if we don't see any comment from John I'll go ahead and merge this an=
d
> > > send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> > > happy if v6.8 went out the door without this fix.
> >
> > I just merged this into lsm/stable-6.8 and once the automated
> > build/test has done it's thing and come back clean I'll send this,
> > along with the associated SELinux fix, up to Linus.  Thanks all.
>
> In off-list discussions with Micka=C3=ABl today it was noted that this
> patch also needs a fixup to the commit description so I've replaced it
> with the following:
>
>   "In apparmor_getselfattr() when an invalid AppArmor
>    attribute is requested, or a value hasn't been explicitly
>    set for the requested attribute, the label passed to
>    aa_put_label() is not properly initialized which can cause
>    problems when the pointer value is non-NULL and AppArmor
>    attempts to drop a reference on the bogus label object."
>
> I've updated the commit in lsm/stable-6.8 and I'll be sending it to
> Linus shortly.
>
> > John, if this commit is problematic please let me know and I'll send a
> > fix or a revert.

I also just realized that both this patch and the SELinux have the
stable kernel marking which shouldn't be necessary as the LSM syscalls
are only present in the v6.8-rcX kernels.  I'm going to drop the
stable tagging, but leave the 'Fixes:' tag of course.

--=20
paul-moore.com

