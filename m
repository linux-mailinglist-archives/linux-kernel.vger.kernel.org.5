Return-Path: <linux-kernel+bounces-57230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024584D55E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6474A1C25711
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6287149DF4;
	Wed,  7 Feb 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLe2ii8k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD8149DF9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341288; cv=none; b=dgHZF7/8ws7byPKTVBwXQpwlpvZ+Y0XftLj+PvdM2AF2JHQJr69A3wd2Tguin7yrdRCFNO4+RsWOenvpHZGCJ6i3Oe9aUoBExaWi6L+NECtBJmEcGzKuJxHPHV6tvpckmsPIlvPRbI8TavqOS2Bsv5hlJJh63/jqF3iKK3H3AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341288; c=relaxed/simple;
	bh=TcuoTBYzJOyVKpA/NOdorcJZuoBN+Bx+mnRuQV92i2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K07r7qom5idzmC1jHtCJvn89OA0a6B5SSqCKXW2mGlSFEEUexkHZEcL0vAEYXowefWWTA8dptGVv1RbHNbLFC6wBqUFwdpReAaNwUD/V6FZPYVR9wx0KqKjzbAjKQPPIuLtCW6uJGpVHSmOBk/lFlSYZDUiGR25HYPWNtm7COkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLe2ii8k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707341285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsF5scQbGC/NKEqVyzUdcfrlWaBsz3GB8A3Ix6fxwJM=;
	b=SLe2ii8k7kKcFBqUGf6uDUX9qtXHL2zLZVwwUbnSevIw5uUhz8yjDXCIhgD8KOWy4zIGeJ
	czqBTDPFZmkST8Ip/EJ0aAzCVJ+LZMtrXzHkmmVSS4+7I3IILzAPdOXUl3PO/Or73wfnNt
	JbrTmBtrdBqDP2/ocd0R4u7cOlvVnf8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-IlAHsi9YN8S_qxyIx9Z9rw-1; Wed, 07 Feb 2024 16:28:01 -0500
X-MC-Unique: IlAHsi9YN8S_qxyIx9Z9rw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d0a329e86cso10155081fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341280; x=1707946080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsF5scQbGC/NKEqVyzUdcfrlWaBsz3GB8A3Ix6fxwJM=;
        b=UMSLTonz0KhWySs+E9Ora3Fs7IObIHoPObMAhNWKQbvZanHqRIbahgMjmJkemvb58/
         HZI3XzpPJy36AU9DaNwgsXOUAKzZ1hDT/59UwsNPctJOmnXciZRh2lQpujjvaZg80B/o
         92sMKnorggIUR8AT/3RomTMJPL+tluw0+NbggyNYnPZmxl6lFy4NUcsl292uLPqZj6UN
         67r6sws65jrJ4vcscJklV6rAJytC38Iqkne9UQL/kzdiCIHBA+FRb7Et1ec2W4oOe4R/
         vHOKce4+9xLlTcSlwYe4p1NgVUwGOiHQ/DdBqMfeCfZ/G8kSpgH9HLje3T175f8RIN38
         YaWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdeJCKRzrvfJ4QtF3smD5N83MnpxaQDIlwygjW+XX1vgGgK6L699utzQciM7/URk3ueBkbl0XWDK32fnwy3m44WK1+zsZt8VzMso+b
X-Gm-Message-State: AOJu0YzUvBFZDJeslK89FQ+lvkh9R/JMgOVoCSXLSGpZV9RdoNMdWysj
	XojOZJ+PQdd0MdUcxiJMwIVdmYMRey5eeQ+3UgZBH0+CdUzL6/BBiu5Yjf/vdI732t5HaaQ7Gxz
	N9/jDbiqwhL5/S22er2ljljJUkija9FxYU1s3EM3zD3JRG+IMkDEPuI2RdCn1yYHPW2/eIBsidD
	uMmt++rRSRUzonX0tX/o6XPuk0l5fzE+a8zr9+
X-Received: by 2002:a05:651c:211c:b0:2d0:c176:ebcc with SMTP id a28-20020a05651c211c00b002d0c176ebccmr5145860ljq.18.1707341280228;
        Wed, 07 Feb 2024 13:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn1f4xD8ODxbeXjM0ldAqf8jj+ZejpBEaAt+zqZ446U/CEMk1rYJTD5iEcL9px/pawkKbLVveasSpw7fcHSDI=
X-Received: by 2002:a05:651c:211c:b0:2d0:c176:ebcc with SMTP id
 a28-20020a05651c211c00b002d0c176ebccmr5145847ljq.18.1707341279916; Wed, 07
 Feb 2024 13:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
In-Reply-To: <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 7 Feb 2024 16:27:48 -0500
Message-ID: <CAK-6q+hza9yXb5KpBS2VJMNHJa805nXqiYPTovnf9G-JFadBsg@mail.gmail.com>
Subject: Re: [regression 6.1.67] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Jordan Rife <jrife@google.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Valentin Kleibel <valentin@vrvis.at>, 
	David Teigland <teigland@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 7, 2024 at 1:33=E2=80=AFPM Jordan Rife <jrife@google.com> wrote=
:
>
> On Wed, Feb 7, 2024 at 2:39=E2=80=AFAM Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
> >
> > Hi Valentin, hi all
> >
> > [This is about a regression reported in Debian for 6.1.67]
> >
> > On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> > > Package: linux-image-amd64
> > > Version: 6.1.76+1
> > > Source: linux
> > > Source-Version: 6.1.76+1
> > > Severity: important
> > > Control: notfound -1 6.6.15-2
> > >
> > > Dear Maintainers,
> > >
> > > We discovered a bug affecting dlm that prevents any tcp communication=
s by
> > > dlm when booted with debian kernel 6.1.76-1.
> > >
> > > Dlm startup works (corosync-cpgtool shows the dlm:controld group with=
 all
> > > expected nodes) but as soon as we try to add a lockspace dmesg shows:
> > > ```
> > > dlm: Using TCP for communications
> > > dlm: cannot start dlm midcomms -97
> > > ```
> > >
> > > It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> > > (e9cdebbe) was merged to 6.1.
> > >
> > > Checking the code it seems that the changed function dlm_tcp_listen_b=
ind()
> > > fails with exit code 97 (EAFNOSUPPORT)
> > > It is called from
> > >
> > > dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> > > dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> > > dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> > > dlm_proto_ops->listen_bind() =3D dlm_tcp_listen_bind()
> > >
> > > The error code is returned all the way to threads_start() where the e=
rror
> > > message is emmitted.
> > >
> > > Booting with the unsigned kernel from testing (6.6.15-2), which also
> > > contains this commit, works without issues.
> > >
> > > I'm not sure what additional changes are required to get this working=
 or if
> > > rolling back this change is an option.
> > >
> > > We'd be happy to test patches that might fix this issue.
> >
> > Thanks for your report. So we have a 6.1.76 specific regression for
> > the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
> > kernel_bind()") .
> >
> > Let's loop in the upstream regression list for tracking and people
> > involved for the subsystem to see if the issue can be identified. As
> > it is working for 6.6.15 which includes the commit backport as well it
> > might be very well that a prerequisite is missing.
> >
> > # annotate regression with 6.1.y specific commit
> > #regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
> > #regzbot link: https://bugs.debian.org/1063338
> >
> > Any ideas?
> >
> > Regards,
> > Salvatore
>
>
> Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> and 6.6 stable branches,
> it looks like there is a mismatch here with the dlm_local_addr[0] paramet=
er.
>
> 6.1
> ----
>
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
>
> /* Bind to our port */
> make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>    addr_len);
> }
>
> 6.6
> ----
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
>
> /* Bind to our port */
> make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>    addr_len);
> }
>
> 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap)=
 which
> changed
>
> static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
>
> to
>
> static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
>
> It looks like kernel_bind() in 6.1 needs to be modified to match.
>

makes sense. I tried to cherry-pick e9cdebbe23f1 ("dlm: use
kernel_connect() and kernel_bind()") on v6.1.67 as I don't see it
there. It failed and does not apply cleanly.

Are we talking here about a debian kernel specific backport? If so,
maybe somebody missed to modify those parts you mentioned.

- Alex


