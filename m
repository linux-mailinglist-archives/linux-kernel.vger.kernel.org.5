Return-Path: <linux-kernel+bounces-160363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857A8B3C88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5D41C20E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2BF14EC4C;
	Fri, 26 Apr 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SYd4FvY8"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2F14D452
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148009; cv=none; b=J9ftMGsgM+d3/3Zrjl24iy4hvan315PR1LRT6YMMcGS1p9jJzZDSQ1vVNguISmNv+pEVqEekugnq3k81qnpOrhfnCkxfxekBOJx6hUMtdfu4dm9ilByiuWtrAIaxreYTGIDNjvWijkNtTlu/oakocm17NPvsOw8dAWLOrVpCG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148009; c=relaxed/simple;
	bh=+DvfMUfVfSlvACLu6SZb+rXe3Bo6+Y2bt6RJFf/QlTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+jmYZTTTWI6YyE2Cpy3QmkC/TdMvjw3pUVDzOYyS/E+5Erw0rLiIeFTco3JFco5qg/Cg41SgGvfISVqg9qUPJ4cRri+JdO+RnnujLfbjaEnUmPn2n22BNUoBuAZ8xuXL0TWofv1d3FA+LTpt8iIyJpFms33zzIGq0aYyT12xHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SYd4FvY8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb7d1a5d39so1300302a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714148006; x=1714752806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yccucKA3aFNVlZUQSPzxnJHi7bfkvfAlVbgOCPgI34U=;
        b=SYd4FvY8Er6bnDH4wCMZrbqFSr5o0MLeIuqXMdcq0u+kMjrNjdsUWETduZK6381q6J
         MtEhhIermKUZbgFU6G2OqBXhrkxWjE7KuSzIqe7y9k5SNdOVEl1c78IwHWklws4amhLz
         joG1FeIXH9fhPXV8KfOdxxzvcLon+lXCSN+3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148006; x=1714752806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yccucKA3aFNVlZUQSPzxnJHi7bfkvfAlVbgOCPgI34U=;
        b=fB+zGpcuMX1+zWM5RxuZa9W0KzWTT0H+26XH4vr3zzlDl2JvXqJMVS9D5fGAjmmnPM
         J0SONoWvghLZ6vwnJkuTppfWElX37E9DIZLWtuzeZZcHj4O6Wh5hfNyefeJyUdEQ4AtK
         u54OQdc97d/WOmgSv5iQ18bI0/XtUCfxKlIosFBWcsN2/u/kxtazgJijJjpkDw1Fwhby
         MLTUE4rb+Igi3OqlQdUOaFHGWpFNfLqnL9IIKVpz11sFKmWjmhrbZQtL/4obGcvuM03K
         TWWULSj1giuaE2r6PWi2SnHESWq9i+2dJ9NvqRFaklWR49jLAG7zp9edSug7cahg+MOn
         mPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXLW1EVfxlaX3qhwiOPSRg5aeW7clZ1ExArdZYCQ8eg1qdtk1iOFToxgXmM97377GqNUnbGae+oA2o47EUlo/Z0cpUXejMxA/GSjCeT
X-Gm-Message-State: AOJu0YyUJh26h8aOvO5BOjvOz02ki6LMsphV6p3rN03PFEcrBH1inszB
	lcA4C1MHedtN+FpFsGmZJ/YD0w7dJYMJN7vMFWOdbdUx+3xI1IBNQufBZt8ITopKYLt0nX2LwGa
	EqQ8CgJtgs2716YYrG9y3d/uW0ScFn7TGSXgA
X-Google-Smtp-Source: AGHT+IGAiuyCDA8OC+TOraYAVrPt7fIfEUUSWYb91k+k/OXz1rvN52l5EyuOy2LTDvWYXGQZOWCfpUHfPeCF+Xnse9o=
X-Received: by 2002:a05:6871:148:b0:23a:a6f:ed5a with SMTP id
 z8-20020a056871014800b0023a0a6fed5amr3286784oab.19.1714148005651; Fri, 26 Apr
 2024 09:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <20240425210540.3265342-1-jeffxu@chromium.org> <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
 <CALmYWFsW5XcM8PYwd=SCthfgjC3TxqVz=DjnCuV8TU7k+_jLaQ@mail.gmail.com>
In-Reply-To: <CALmYWFsW5XcM8PYwd=SCthfgjC3TxqVz=DjnCuV8TU7k+_jLaQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 26 Apr 2024 09:13:14 -0700
Message-ID: <CABi2SkVvGWa0=Q9AEkTGAr6f_hZ54Ekrxw5CdgvrRKWtNPNkng@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
To: Jeff Xu <jeffxu@google.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>, 
	Andrew Brownsword <andrew.brownsword@oracle.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "jannh@google.com" <jannh@google.com>, 
	"sroettger@google.com" <sroettger@google.com>, "x86@kernel.org" <x86@kernel.org>, Kees Cook <keescook@chromium.org>, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:12=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
>
> On Thu, Apr 25, 2024 at 3:49=E2=80=AFPM Aruna Ramakrishna
> <aruna.ramakrishna@oracle.com> wrote:
> >
> >
> >
> > > On Apr 25, 2024, at 2:05=E2=80=AFPM, jeffxu@chromium.org wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > On 3/21/24 14:56, Aruna Ramakrishna wrote:
> > >> Enabling both the non-zero pkey (for the thread) and pkey zero (in
> > >> userspace) will not work for us. We cannot have the alt stack writea=
ble
> > >> by all - the rationale here is that the code running in that thread
> > >> (using a non-zero pkey) is untrusted and should not have access to t=
he
> > >> alternate signal stack (that uses pkey zero), to prevent the return
> > >> address of a function from being changed. The expectation is that ke=
rnel
> > >> should be able to set up the alternate signal stack and deliver the
> > >> signal to the application even if pkey zero is explicitly disabled b=
y
> > >> the application. The signal handler accessibility should not be dict=
ated
> > >> by the PKRU value that the thread sets up.
> > >>
> > > We have a similar threat model that we don't want "untrusted threads"=
 to
> > > access altstack. I think this patch need not be restricted to the
> > > use case of zero pkey for altstack, i.e. application can also set
> > > non-zero pkey to altstack and expect the same.
> >
> > Agreed. In the latest version of this patchset, this assumption has bee=
n removed.
> >
> > Link here:
> > https://lore.kernel.org/lkml/20240425180542.1042933-1-aruna.ramakrishna=
@oracle.com/T/#t
> >
> > >
> > >> Solution:
> > >> The PKRU register is managed by XSAVE, which means the sigframe cont=
ents
> > >> must match the register contents - which is not the case here. We wa=
nt
> > >> the sigframe to contain the user-defined PKRU value (so that it is
> > >> restored correctly from sigcontext) but the actual register must be
> > >> reset to init_pkru so that the alt stack is accessible and the signa=
l
> > >> can be delivered to the application. It seems that the proper fix he=
re
> > >> would be to remove PKRU from the XSAVE framework and manage it
> > >> separately, which is quite complicated. As a workaround, this patch =
does
> > >> something like this:
> > >>
> > >>       orig_pkru =3D rdpkru();
> > >>       wrpkru(init_pkru & orig_pkru);
> > >>       xsave_to_user_sigframe();
> > >>       put_user(pkru_sigframe_addr, orig_pkru)
> > >>
> > > The default PKRU of thread [1] is set as 01 (disable access) for each=
 PKEY
> > > from 1 to 15, and 00 (RW) for PKEY 0.
> > >
> > > Let's use pkey 1 as an example:
> > > The init_pkru is 01, if the thread has PKRU (orig_pkru) as 10 (disabl=
e write
> > > but have read) then new_pkru from (init_pkru & orig_pkru) is 00, whic=
h gives
> > > RW access to the pkey 1.
> > >
> > > When the thread has orig_pkru as 01 (disable access) or 00 (RW), new_=
pkru is
> > > unchanged from orig_pkru.
> > >
> > > Now take pkey 0:
> > > the init_pkru is 00, regardless what threads has, new_pkru will alway=
s be 00.
> > >
> > > This seems to work out well for pkey 1 to 15, i.e. signal handing cod=
e in
> > > kernel only give write access when the thread alrady has read access =
to the
> > > PKEY that is used by the altstack. The threat model interesting here =
is to
> > > prevent untrusted threads from writing to altstack, and read is proba=
bly less
> > > of a problem.
> > >
> >
> > This piece of code assumed that the init PKRU value allows writes to th=
e alternative
> > signal stack. As you mentioned earlier, that may not always be true - a=
 non-zero pkey
> > can be used for the altstack.
> >
> Only PKEY 0 has init PKRU as 00.
> So in your case, the thread doesn't have write access to pkey 0, and
> need the write
> access to pkey 0 during signal handling.
>
> > So the new version simply does write_pkru(0) (i.e. enabled all pkeys) b=
efore XSAVE.
> > Is this more reasonable?
> >
> write_pkru(0) will work, but it is unnecessary in the current patch.
>
> Consider the following case: A thread has no access to pkey 1,  and
> use pkey 1 for its altstack.
>
> In V3 (use write_pkru(0):
> Signal will be dispatched to the user, i.e. write to signal frame is
> OK, but it will SEGV at sigreturn.
>
> In V2:
> it will SEGV earlier at dispatch stage when writing to sigframe.
>
> I would rather that the code fails earlier for this case.
>
> > >
> > > Does this meet what you want? (Note the pkey 0 is different than 1-15=
)
> > >
> > > Suppose someone also like to disable all access to altstack, then the=
re is one
> > > more place to mind: in sigreturn(), it calls restore_altstack(), and =
requires
> > > read access to altstack. However, at the time, PKRU is already restor=
ed from
> > > sigframe, so SEGV will raise (the value in sigframe doesn't have read=
 access
> > > to the PKEY).
> > >
> > > Without changing sigreturn, using wrpkru(0) here might not be necessa=
ry:
> > > the dispatch to user space works fine, only to crash at sigreturn ste=
p.
> > >
> > > [1] defined by init_pkru_value in pkeys.c
> > >
> > > Best regards,
> > > -Jeff
> >
> >
> > I see what you're saying. In rt_sigreturn():
> >
> >         if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags)=
) <=E2=80=94 restores PKRU, disabling access to altstack
> >                 goto badframe;
> > ...
> >         if (restore_altstack(&frame->uc.uc_stack)) <=E2=80=94 needs rea=
d access to altstack
> >                 goto badframe;
> >
> >
> > I=E2=80=99m wary about reordering anything here. Also, this code is not=
 aware of the altstack permissions. I=E2=80=99m wondering if wrpkru(0) is n=
eeded here too.
> >
> We can't change PKRU after restore_sigcontext,  the calling thread
> would have PKRU 0, not the original PKRU from before handling the
> signal.

probably putting restore_altstack ahead of restore_sigcontext would be
good enough.
restore_altstack doesn't seem to need to be after restore_sigcontex,
it reads data
from the sigframe and calls do_sigaltstack to update the current struct.

