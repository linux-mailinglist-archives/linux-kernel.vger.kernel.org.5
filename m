Return-Path: <linux-kernel+bounces-83562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DA869B78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928411C25145
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CAE146E8A;
	Tue, 27 Feb 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I4mwwlWB"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA8145B09
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049698; cv=none; b=WhuPuHnGYHRiJmFhQCmlVhHM/bnqXVnclnyHszlUTfLokLtIiVLvtXjyUmbs9H0fA/WRnCvDFL118RvB4M84Q5Vpiw7y4VEFJaHXMsvX2Refs6QxUEjfLtA5B80BREYMH8sm/ihG3S0NxElcpHxptSTAF7Z4I/pcCY6u9LnklC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049698; c=relaxed/simple;
	bh=YcbXQMW6orIGD2J32M5lewwEx24IkTPl43MiFtSywpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP1X/04Otlax0g3AMSZRopEamNfA/Wb7SUD3OpIOXm3euvZUd5mlyYlbe0QchN+I1gWOCwp/g+5uuK8hHFh5r4OjKd4xGf/bD6WXYUMy/hgDhD3VHZaqW9vmP6PVFoDAHlSWqvsTtku4jtMNuNJX2uF+HipjX5AbZ+1KroUhVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I4mwwlWB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3428623b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709049695; x=1709654495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=I4mwwlWBWiZMVsYyZri+BrABvznzJdfpLDhkf6bWJYaTPX71+h5/owfxnSjWNfpkAY
         nPAdR0wGWT1lxu/+UQb3/bQyhQWeavbcexWPhORfXfQR6jV0GV5VtR3ENgGtuv7WXUCA
         la/fYWCwguC0k9foii7UY+o/2LPWd66tZP2LUIEnpfv1m208fqfjrBKVelMIO4mU9P/G
         2yppWWb5N/tKS4kfxQfQoRWaeK0L5rHiu1aC7I8zhzQ9lE7CNPfetjuk5eVJwmU3KXVB
         IJhTc2PzPUuylsC0lz9KYnBBhdGFEUzrwK+UEKqtz6nVjEvUcwYdMx1OlyaKC1QPOz7S
         Vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049695; x=1709654495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=vBxxBMIbrpMIz6bfwDlOWUrB52fUtbYq99kECp+l9SOFc7xn/2omzaoj3A79oUZ46P
         WrLWkNSj3235n+tPDoydb/+mBlDSOoYx7On2HdHsPdSJ9OJQ9ZqaBocCrjUgCPoOD98N
         GJpKgQKGwL3WuUhZCRoa7fHPvmvsS+TqxmX77jfzPTiauUe1eptgj8MY93WiNLvrFx1k
         cR2yvHtL3ASPqDovsvC+uXau3otgOucgnhn6q76dH+OcQDgr/lFbwRLXKYpSHrC+JZsN
         geiKkBAWRdrJaZNxzgVTwEOo1YasZSgrHtaD3NsftTqK6Oh/JJApB4vsgpmA2qBa4/YA
         IwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5DeMWqaKYVrW9CtQdcJYClTdoRxpVIYqS/hU4UPhlnuRaLZoslmmEaek8OLR6tIG2OCltk1IjdGDJEuX8ilSD27iZDbz+poQPNXlH
X-Gm-Message-State: AOJu0YxGPbvMOkL8hxIu0oP1cEHG21DfrOwCL1AoRt5cipBWwQOiOBA9
	uujjnZ0Lwl/9Vx1SqnKCGvq6jwrucuQJd1dfthSzIN2KQUSbjG8KekCTa+jChDLO3LIycK/z7NF
	kX2dGvBRD0MbwGf/xBuuxLijrImJLicUxWQ49
X-Google-Smtp-Source: AGHT+IE9MdMFU9x6FoxeTlyyLtbrwrCH54o03/D8XMEA7Si2aBMN5Aya/Dkp9vESrpYl2ue09rzvpreM73e0UemlMqU=
X-Received: by 2002:a05:6358:5e8c:b0:17b:5d21:e86e with SMTP id
 z12-20020a0563585e8c00b0017b5d21e86emr12410573rwn.3.1709049694861; Tue, 27
 Feb 2024 08:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com> <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 11:01:24 -0500
Message-ID: <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > aa_getprocattr() may not initialize the value's pointer in some case.
> > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > >
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: John Johansen <john.johansen@canonical.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/apparmor/lsm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > If you like John, I can send this up to Linus with the related SELinux
> > fix, I would just need an ACK from you.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> This patch looks good to me, and while we've still got at least two
> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> good to get this up to Linus ASAP.  I'll hold off for another day, but
> if we don't see any comment from John I'll go ahead and merge this and
> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> happy if v6.8 went out the door without this fix.

I just merged this into lsm/stable-6.8 and once the automated
build/test has done it's thing and come back clean I'll send this,
along with the associated SELinux fix, up to Linus.  Thanks all.

John, if this commit is problematic please let me know and I'll send a
fix or a revert.

--=20
paul-moore.com

