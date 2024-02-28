Return-Path: <linux-kernel+bounces-85466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718E86B670
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3886A28B2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795D15E5DF;
	Wed, 28 Feb 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS3tbMlM"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429222F1E;
	Wed, 28 Feb 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142688; cv=none; b=ntaKPTuCyCmBty0yva8GVPZ4gAPoghRSuAMChRGEFkiI3xFa7rpsaQuw5ITJwr7Qr8WFXOzipcq6NX1uGGCkuj325X4hZnAars57OK689aszQdlG4EHSNWQ5MlQ8BO6jLGJQ/N3od5Y1YRrDr4zxjKO/2J0xDwSQUcSZv78kHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142688; c=relaxed/simple;
	bh=X0SFgac44AGTtRt3bpXGtzG9V/AziVxJderyrCtjMW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVgSQ8jRTejhjrQHXwu21CoKTElCpyi0+W0ble2V8O+khRJBEahUGlAP0y6Cx/ce11Qeg9tkptUm9NAOhTRUZz+jaq1LIY45IGPh9ZUHI74RMBLm91uSMsgfFKKUwUVj+5apWVK1iSp/GV2RHJ8ukx9PLw4AYTBgxup8Pqe0WY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS3tbMlM; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso2876106241.2;
        Wed, 28 Feb 2024 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142686; x=1709747486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FSxoYCjI8KHEKvT+a2H+wwDJ3Fc0JNH4HEuSuWDa0o=;
        b=YS3tbMlMLKldW4cWRRZKzDBIHd7Cf+OhO/WEZMfwOxT9ocN9DUYggZ0JBnWDwd0fb0
         AucfsXHs2CFSk8aZeFNPRdxDVEMGdnNWWkU9K6B/QXWz/E2HEQNDzXVlZtOlRPKrA57a
         cYdbQLsG4PKoTOEZfj+3Gcf7eSMpPPq9fUTzMqvRjD0+PbyiMqXsH4YRYfK8e+ue7A5g
         Vlri25OI2LJZHENvCGXQIbIgLUMfur+bYCpZlDGBKuj2M5W9I23I7v+xYiV+3No79vCy
         O48GNQDlAZoBEkjCy5mPDqPMC2dGCj99jClAanFfGMvKdiwkPGpygMaGWIbxqy29TGOb
         Nbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142686; x=1709747486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FSxoYCjI8KHEKvT+a2H+wwDJ3Fc0JNH4HEuSuWDa0o=;
        b=ikKRNXwpmqePqkD2CUUxQiE5PUnimwjL6ZyAbE0FQjSfHs7438GBh46Tkg0vuqTiW0
         hfLfUsJIWAYaxKQN2BBXEtQWpvOh7VAZA8H7RYlTuYs3CDke61RmOkCCW6hrelTeHe0m
         r5Y0oCMJ/jcbqSxnHC85DlGlrEeLlpTviO8UcUyRw5d2LiEjI4IlhdS4BSE5KBzpiHmZ
         kwHWTETHkro7TYuaCHDamz3C8VTzW7CnxcHbyE1yiq/+0tJF3j67RcyF0a01UOX+Byq8
         15r9dduSB/6M+N3snRBXGIGLc1tT2yY9FwvqOWTERwUbSuF7QXegwSOGVJkoaeyf4HE9
         ICMA==
X-Forwarded-Encrypted: i=1; AJvYcCWKm2roe+3pciqbHb2WsR7APSe/mD+IfCc2iAGiVz9oytso3R2HInsaXsVFt7BZifKb/PoLC8VroyxMV+K5WOrXsQRAtCY8wEdFFmJrL5PmvrwAD/z0FO5DAZEzlXlUbcWm2/oZ
X-Gm-Message-State: AOJu0Yzn3ANxgcrETfrJpU1d0fdarl5iAlGrraeaxm8rnSHU7II0nyXV
	p/28tFE1PPdTVuseci+vbwo564ralhQbwQF8QNcy8tegSm38kaBsfJRn5+EsRn3+FJ6WueVNoS4
	NvLL7EiRfdxKcSM+L6LPgq8GFEZA=
X-Google-Smtp-Source: AGHT+IGucqGCPOj4OwzGw3o5YGuCjVzCIuIxy9Vz1LlGyTtV0gAAR0EVqbRMIlHOsZttATj1JLjjxl/G0nOm/rrquOk=
X-Received: by 2002:a05:6102:55a1:b0:470:4e67:3b38 with SMTP id
 dc33-20020a05610255a100b004704e673b38mr372791vsb.14.1709142685683; Wed, 28
 Feb 2024 09:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
 <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com> <CAHsH6GvX7zYSoA7JVemRtunWWSaew1S11Y996WAGt6B9d8=cOA@mail.gmail.com>
 <aa5f1c11-4528-4d53-91f3-5ce8c02363ac@gmail.com>
In-Reply-To: <aa5f1c11-4528-4d53-91f3-5ce8c02363ac@gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 28 Feb 2024 09:51:14 -0800
Message-ID: <CAHsH6GspzSsSJX2Xuerp3NApJnobv7_eoNdwMSX=Mqw3EVhAzg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com, 
	petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com, bpoirier@nvidia.com, 
	gavinl@nvidia.com, martin.lau@kernel.org, daniel@iogearbox.net, 
	herbert@gondor.apana.org.au, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:03=E2=80=AFAM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> Eyal Birger wrote:
> > Hi,
> >
> > On Thu, Feb 22, 2024 at 12:54=E2=80=AFPM Richard Gobert
> > <richardbgobert@gmail.com> wrote:
> >>
> >> This patch adds support for binding to a local address in geneve socke=
ts.
> >
> > Thanks for adding this.
> >
> >> It achieves this by adding a geneve_addr union to represent local addr=
ess
> >> to bind to, and copying it to udp_port_cfg in geneve_create_sock.
> >
> > AFICT in geneve_sock_add(), geneve_socket_create() is only called if th=
ere's
> > no existing open socket with the GENEVE destination port. As such, woul=
dn't
> > this bind work only for the first socket in the namespace?
> >
> > If that is the case, then perhaps binding the socket isn't the right
> > approach, and instead geneve_lookup() should search for the tunnel base=
d on
> > both the source and destination IPs.
> >
> > Am I missing something?
> >
> > Eyal
>
> You are right, I missed it.
> Binding the socket is the main reason for the patch, to prevent exposing
> the geneve port on all interfaces.

I see. The use case I had in mind is allowing to differentiate between
tunnels based on local IP, but not exposing the port sounds like
a good use case too.

> I think it should be searched in geneve{6}_lookup and in geneve_find_sock=
:

If the socket is bound to a specific IP, i'm not sure you'd need to
change geneve{6}_lookup() - only packets matching that IP would arrive
there no? In that case I think the change you suggested to geneve_find_sock=
()
should be enough.

>
> static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
>                                             sa_family_t family,
>                                             union geneve_addr *saddr)
>  {
>         struct geneve_sock *gs;
>
>         list_for_each_entry(gs, &gn->sock_list, list) {
>                 struct inet_sock *inet =3D inet_sk(gs->sock->sk);
>
>                 if (inet->inet_sport =3D=3D dst_port && geneve_get_sk_fam=
ily(gs) =3D=3D family) {
>                         if (family =3D=3D AF_INET && inet->inet_rcv_saddr=
 =3D=3D saddr->sin.sin_addr.s_addr)
>                                 return gs;
>         ...
>
> This is also true for VXLAN

I haven't looked at the VXLAN code, but if the lookup is similar there
I would guess the same.

Eyal.

