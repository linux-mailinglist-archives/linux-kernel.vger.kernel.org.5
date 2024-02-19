Return-Path: <linux-kernel+bounces-71399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BE85A491
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C1D282A39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9636133;
	Mon, 19 Feb 2024 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxKxvUE/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747ED364C6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348937; cv=none; b=nh+ekG/oSA1kkEHHnBp/QCOXU1dGhXJisBA5CDjftiN4xfzNio3mRxfg6QclytiijM7Ny7auVIlQ9yapkatya7XX0sOvViwMyEP0ylyFVmvAtLLrc8Iym+J9mnPCZPTrZ5m+rQj7VObopuCJneIcTFFzF5vh6AGcytvFv4SvkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348937; c=relaxed/simple;
	bh=7gbzT0bFlv7Vx+qBIh0t/oLWx0mTJwXdNjLV3zbFmRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA1oy3LDYSRZLgAUrCbDevM/X42YlRpcI/uEZqdvstxmS+Y8Jj9N2ICf1kxRDY5Ph7BLvqvVq1uU9xI8lCma6oCcmpA8EQg6NqJXoBQkVIp46Qj3dI1UFgIAnI08eFKk6omYWoOvAwFDgIvyG2ZS7TF/a1Zb+5EozwDjtAVnv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxKxvUE/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5647f4aac6aso7092a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708348934; x=1708953734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR/z2c5RZraUzauY2z56Ou90i3GAu2aYjsgtVMp28As=;
        b=dxKxvUE/0uVP0R13Uri2E2vM7/cRDswa7hV7Wiekqx6dUuev7d3+nG9k/Cej0NhUnO
         AyGz4duGKTbwCsEzytJw1Y1TFf7PtrdUmHJBxOdUfAY9XWwjOe2eySWLCWhDHBMrXpl/
         if6HP1itS5gN6ErgWppcURwDjhjvjtVDF1SVb8fOtYIqcbsbJchs3C8TNfDCXLibzhqs
         Lylm9vkW93wM5yLV8kz/K2D0vvceD/hp/ycYCOJH3VHS56cn9lpS214CDOTbuaVneHah
         OipvVonwqCasJ+RiBnrg63+bpQ5E46+k8PJio7By6K7UVl0TLop6ZGHUa39J65vquGmP
         VRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348934; x=1708953734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR/z2c5RZraUzauY2z56Ou90i3GAu2aYjsgtVMp28As=;
        b=V28IApBLfhRI9ConvfPu7sGuMe/EtPnwo4ENLxbInUECGSI8aJzyP6/O2DX/eDEvl3
         TH12W5iqt28ecNnO6sZrUZ4ULYXPRpRk5LpSgFUB7Y75sGLwpCFCE5BsfKQrSWA5zEam
         8YdDNTabf+poYSEIXa8vwriCj6qYNxk+RU4qj1DXX0tLQsjsKAPcJM6yu8DvjsCtDcEj
         e4T5iCIIPyuk/R52RVBvTwSC+mDYyqpw0oWSP8uhZWMlgmo3i5UTSgKt3zWhiusb44sU
         Jp4g0oVMP2eyocis2zDCrHJ9VhlOpq6S7ZLDpQvPUKPY6oZX1J2AGkYkP+wvN3EHz5hD
         jZnA==
X-Forwarded-Encrypted: i=1; AJvYcCXZi61J9+qrK60whtroraH23hNvu3LE1V8VYt80PHwEllnx7D1k8VY39KzVvfj0iuj3WXJeqNw8rDJY0TXtTJnXQxqk45XdZ1+cqCEd
X-Gm-Message-State: AOJu0YxDn5T76+nTraGYuDswyJ5VrW0YRWKDunekduZQx4UxBy8Yfgv2
	DqLNM+arQX9F+9K/SPumjRt5L3BA4if9rGHVqSXMudWuDBx00jrR753cfDKDKtUDuiZnQIy/hlw
	vx1W9UR0EKNRN28eEdDGF5GNtkTEJvKr0sBOLBPDmtW9gq9RXqfQl
X-Google-Smtp-Source: AGHT+IFPRzTY5t73jcifT3Rn47qUnlB2DlUaCnDpkGWwzhR6nZzTzUdbK/OxBtetxy0o+T2EaUFM+sbLktcNGyhaz00=
X-Received: by 2002:a05:6402:1649:b0:564:55e5:6ee1 with SMTP id
 s9-20020a056402164900b0056455e56ee1mr140228edx.2.1708348933587; Mon, 19 Feb
 2024 05:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218073501.54555-1-guixiongwei@gmail.com> <2024021825-skiing-trustee-a56a@gregkh>
In-Reply-To: <2024021825-skiing-trustee-a56a@gregkh>
From: Jann Horn <jannh@google.com>
Date: Mon, 19 Feb 2024 14:21:37 +0100
Message-ID: <CAG48ez32+y7jK5e7WHJxD9aP20WHLmHiXX8U8F=jBtFO3qakAQ@mail.gmail.com>
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guixiong Wei <guixiongwei@gmail.com>, linux-hardening@vger.kernel.org, jgross@suse.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org, 
	Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Feb 18, 2024 at 03:35:01PM +0800, Guixiong Wei wrote:
> > From: Guixiong Wei <weiguixiong@bytedance.com>
> >
> > Restrict non-privileged user access to /sys/kernel/notes to
> > avoid security attack.
> >
> > The non-privileged users have read access to notes. The notes
> > expose the load address of startup_xen. This address could be
> > used to bypass KASLR.
>
> How can it be used to bypass it?
>
> KASLR is, for local users, pretty much not an issue, as that's not what
> it protects from, only remote ones.
>
> > For example, the startup_xen is built at 0xffffffff82465180 and
> > commit_creds is built at 0xffffffff810ad570 which could read from
> > the /boot/System.map. And the loaded address of startup_xen is
> > 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
> > address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
> >  - 0xffffffff810ad570) =3D 0xffffffffbaead570.
>
> I've cc: the hardening list on this, I'm sure the developers there have
> opinions about this.
>
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > ---
> >  kernel/ksysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> > index b1292a57c2a5..09bc0730239b 100644
> > --- a/kernel/ksysfs.c
> > +++ b/kernel/ksysfs.c
> > @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct=
 kobject *kobj,
> >  static struct bin_attribute notes_attr __ro_after_init  =3D {
> >       .attr =3D {
> >               .name =3D "notes",
> > -             .mode =3D S_IRUGO,
> > +             .mode =3D S_IRUSR,
> >       },
> >       .read =3D &notes_read,
> >  };
>
> No objection from me, but what userspace tool requires access to this
> file today?  Will it break if permissions are changed on it?

FWIW, https://codesearch.debian.net/search?q=3D%2Fsys%2Fkernel%2Fnotes&lite=
ral=3D1
shows that (from what I can tell) this is mostly used by stuff like
perf, libdwfl and systemtap for figuring out the kernel's build-id,
probably mostly for kernel profiling?

