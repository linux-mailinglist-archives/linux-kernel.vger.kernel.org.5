Return-Path: <linux-kernel+bounces-104789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A867687D3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB8DB23A48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B411198;
	Fri, 15 Mar 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTvFAQV3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E86101C3;
	Fri, 15 Mar 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527450; cv=none; b=i4QRcgqgHEGUUylWd+BRoNpr9PF7Tzyme6XnEoLRBHLy4AZLzUHs5QcUoBq+d5ohrOU4rxa4Ykcs4bdPVDS4jWeJLIER4SGvH0oC/R2owBVkCe9KA9QGCP21iDjM0AdBEaZ7vN+0k8omsYBx57a1hFxSUBCwg17MS+TBDGXqf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527450; c=relaxed/simple;
	bh=5Xz50tDh2SV78HMFTMD1A0h2hu+XSpD2m/eQOXfHhI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E05vYzy1SS+eWWAmLEdSHa+VG374zgpOVNEQugIgjem5DU7oJq+Tzi80+HdZpy54UhDFEtfJsWPHPEVG5/zfaS0gWNa3nzZoc02ecJfnv7ijf9MHf6ttvt2l455lsK+u3BY+4/obnrBgqKhDdyEScqLiGKDp7G0ywfVitRpKd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTvFAQV3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddaa02d22so14383695ad.2;
        Fri, 15 Mar 2024 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710527447; x=1711132247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbpFTqBdS3olh9wHBTkJECdWAd4sQa56r15EYsGS4Ms=;
        b=aTvFAQV3aeCVRB8hITKHmGHY05tQgchzNu6PBMqsJ1WXC0+140Lpu9m+EC/EBqhkk9
         7wExeyGpkfhzJKUyQqHo+VM9cqEyWit17zXuvFpwhDhUB8FNfEfBDczolycTyz+b887x
         bKyBmfkrJgMUQRRGRA+yP3bb8EE11ac7yB2i8QefD/trcPU7NX6X5N5iQCEOGVJcCB6t
         mO3iQT2qnsTiSRix94OByoANhq4naMwz7swPiaU3tm5187iCqQUw194fBAPB7XHuvCPG
         Mne73n9OwWktgZ6fEXeiNzH/Map+INGtmoRJbJia+SeTXao74dkpimMhAPkcMEI1CW5j
         XZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527447; x=1711132247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbpFTqBdS3olh9wHBTkJECdWAd4sQa56r15EYsGS4Ms=;
        b=LfcMMJRD/mKLMf3+PDYaNhJiVCyVLQ8x6PLRlAYDi7ZiIeLtZwNbtSgPN855VunF3o
         PsVIW7PraO3rjyhx6gu8HXQx4ZEwgRfawsWaEBUloHeUDOKWhTtS1BNk3RWOtxe39xMC
         M9RGKzqgd1BtAj/m5GDqGs4E5dDvG2ULBxqt6/dbrfXESysFl/LUzx5DaARTFHEGEhsv
         t/LYWTk96yfCyEW3Zfw0V0Y+CYAGYt9SRAgZJByk9NrJho88PZkiMg0zNanBMn+VQ1Q6
         0xvDQhxHmI46b0rWJZsPdeRVMJ2qMXZ8dknaRZMWyT94thF7Qnyq99fgCTGGFqSzUnMB
         7XVA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6WNI8RcHJPUQhhUUg5QC9L16vT2vYVM65SpiTC6bN82lYi3JcCilJskqI2jxB4Ak/dBZ84+6tngSlzx22zJ6rS8wu/vOqNp1wN+l59WPfG6uzPGHjGZa7Gd3d4iHsMmtFDglCUX5QWMRxfmWWZcw0BWb5zkqXGt/vVVonzw=
X-Gm-Message-State: AOJu0YzDx4O4QafwkhocHpePi3lew4uFHe66pNFckM1sTYm5DbWYo3QI
	kiG1AA/Raq9jKWQvnpWgaWOk34rjorFAb1YdnofovZ+jyNcq5M7qhg3OPHVcKupGCqonEW9nEbl
	ldJUeisG7I9iOef8nj1XdGx24O8E=
X-Google-Smtp-Source: AGHT+IGZzgq/mjcEak1ubFRlLXArgTzr7DYoX/TCFR4XWCKf5ZaHunqGl/IwrB55WvC+mXm1BtOkCc60Ds+UWhpFy6g=
X-Received: by 2002:a17:902:ba8c:b0:1dc:42da:bad with SMTP id
 k12-20020a170902ba8c00b001dc42da0badmr3428728pls.62.1710527446870; Fri, 15
 Mar 2024 11:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com> <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
 <CAJ2a_Dfy3DKnsZZhKUXiMbG-NZqH0APwz3tGF1Fdma+nYcHmOQ@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfy3DKnsZZhKUXiMbG-NZqH0APwz3tGF1Fdma+nYcHmOQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 11:30:34 -0700
Message-ID: <CAEf4Bzaw8jV8KxHcO71MCkqA9e2vE9f0XqkGY2CUgbRFiUzjng@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 15 Mar 2024 at 17:46, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Fri, Mar 15, 2024 at 4:39=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > > alternative to multiple `capable()`/`ns_capable()` calls, like
> > > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> > >
> > > `capable_any()`/`ns_capable_any()` will in particular generate exactl=
y
> > > one audit message, either for the left most capability in effect or, =
if
> > > the task has none, the first one.
> > >
> > > This is especially helpful with regard to SELinux, where each audit
> > > message about a not allowed capability request will create a denial
> > > message.  Using this new wrapper with the least invasive capability a=
s
> > > left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
> > > policy writers to only grant the least invasive one for the particula=
r
> > > subject instead of both.
> > >
> > > CC: linux-block@vger.kernel.org
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v5:
> > >    - add check for identical passed capabilities
> > >    - rename internal helper according to flag rename to
> > >      ns_capable_noauditondeny()
> > > v4:
> > >    Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
> > > v3:
> > >    - rename to capable_any()
> > >    - fix typo in function documentation
> > >    - add ns_capable_any()
> > > v2:
> > >    avoid varargs and fix to two capabilities; capable_or3() can be ad=
ded
> > >    later if needed
> > > ---
> > >  include/linux/capability.h | 10 ++++++
> > >  kernel/capability.c        | 73 ++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 83 insertions(+)
> > >
> >
> > [...]
> >
> > >
> > > +/**
> > > + * ns_capable_any - Determine if the current task has one of two sup=
erior capabilities in effect
> > > + * @ns:  The usernamespace we want the capability in
> > > + * @cap1: The capabilities to be tested for first
> > > + * @cap2: The capabilities to be tested for secondly
> > > + *
> > > + * Return true if the current task has at least one of the two given=
 superior
> > > + * capabilities currently available for use, false if not.
> > > + *
> > > + * In contrast to or'ing capable() this call will create exactly one=
 audit
> > > + * message, either for @cap1, if it is granted or both are not permi=
tted,
> > > + * or @cap2, if it is granted while the other one is not.
> > > + *
> > > + * The capabilities should be ordered from least to most invasive, i=
e. CAP_SYS_ADMIN last.
> > > + *
> > > + * This sets PF_SUPERPRIV on the task if the capability is available=
 on the
> > > + * assumption that it's about to be used.
> > > + */
> > > +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> > > +{
> > > +       if (cap1 =3D=3D cap2)
> > > +               return ns_capable(ns, cap1);
> > > +
> > > +       if (ns_capable_noauditondeny(ns, cap1))
> > > +               return true;
> > > +
> > > +       if (ns_capable_noauditondeny(ns, cap2))
> > > +               return true;
> > > +
> > > +       return ns_capable(ns, cap1);
> >
> > this will incur an extra capable() check (with all the LSMs involved,
> > etc), and so for some cases where capability is expected to not be
> > present, this will be a regression. Is there some way to not redo the
> > check, but just audit the failure? At this point we do know that cap1
> > failed before, so might as well just log that.
>
> Logging the failure is quite different in AppArmor and SELinux, so
> just log might not be so easy.
> One option would be to change the entire LSM hook security_capable()
> to take two capability arguments, and let the LSMs handle the any
> logic.

that sounds like an even bigger overkill, probably not worth it

>
> > > +}
> > > +EXPORT_SYMBOL(ns_capable_any);
> > > +
> > > +/**
> > > + * capable_any - Determine if the current task has one of two superi=
or capabilities in effect
> > > + * @cap1: The capabilities to be tested for first
> > > + * @cap2: The capabilities to be tested for secondly
> > > + *
> > > + * Return true if the current task has at least one of the two given=
 superior
> > > + * capabilities currently available for use, false if not.
> > > + *
> > > + * In contrast to or'ing capable() this call will create exactly one=
 audit
> > > + * message, either for @cap1, if it is granted or both are not permi=
tted,
> > > + * or @cap2, if it is granted while the other one is not.
> > > + *
> > > + * The capabilities should be ordered from least to most invasive, i=
e. CAP_SYS_ADMIN last.
> > > + *
> > > + * This sets PF_SUPERPRIV on the task if the capability is available=
 on the
> > > + * assumption that it's about to be used.
> > > + */
> > > +bool capable_any(int cap1, int cap2)
> > > +{
> > > +       return ns_capable_any(&init_user_ns, cap1, cap2);
> > > +}
> > > +EXPORT_SYMBOL(capable_any);
> > > +
> > >  /**
> > >   * capable - Determine if the current task has a superior capability=
 in effect
> > >   * @cap: The capability to be tested for
> > > --
> > > 2.43.0
> > >
> > >

