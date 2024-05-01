Return-Path: <linux-kernel+bounces-165013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2C8B8678
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4ADB2111B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18494E1CB;
	Wed,  1 May 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXHCjHrW"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEED3D556;
	Wed,  1 May 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550089; cv=none; b=oOlCvLDC4KDYyRrC9EoXHtv2bObmGTDXJLUzYTqhStS5DMP6LDUxU6hIyu6fmu0UJ0D/QVyRL2n50Uv8Hsvx2EsTY+cgYqiwd+uKzmp8mN3C+vmrM7zfcHCBxU9Cy+W79M6e6kB9Du6fkg8cgFq5nwlyAT2Jen53tkaTJF05QXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550089; c=relaxed/simple;
	bh=j2XT9iQsFZQa6Fjh2X72M1N1VeElDtC0hJ47xBaDOzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TeFxko+9dRksylDQLc0GTmkcW8pIoKnAiHgNZkENQJapEmYRuesQX5Opwix8ClYAejyJFQrx+jC8KzofS4pd4aZRlndBfFomq4HladCbZ65tUPP29yW02hYMduVxA+GOMBW5SL3fAmmIWIabQmyNeu6beTAGaXVERRCnl7pAoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXHCjHrW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-613a6bb2947so2068782a12.3;
        Wed, 01 May 2024 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714550087; x=1715154887; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzAwahuGtK7hRiLSlWGC1HCezqllP/i63RMLPgdJihw=;
        b=DXHCjHrW5c6fDmBJwSyVv6qRdx+acdgwbFVjw9biECrg5gLk47+pb2rbh2/w0zyJB8
         aCzvSY+n5ijw9kNtmgzmpVsDv47aCX5OYrLtwduICnbl9EdICfwP8uY/zFA13/42izv0
         C4nc0nKyfLORzBf6jYFN1ohCQ3x/tz/LeUJ/X9/HAwAWZdXe8rxWLKFlYybmVGi0vqc+
         S7g3NXPoVmsLkEJOyXxYx+JPGYymw1xWX0VPcungRmvmf++mc8tensQtODZX81zb7lL+
         24YyPMkLrjLYuMvPKbb6UHaNghYhnmQVKbA0ZA79UQW34QHkFYaqCHOhKP1iPT2Rwsxw
         YQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714550087; x=1715154887;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzAwahuGtK7hRiLSlWGC1HCezqllP/i63RMLPgdJihw=;
        b=nZ1/qSg7Ho6fOP+TBWwC9EQ+e00Erozj4GL2m+i60szRQNQPBZ1BS9OaQ6wbA8RNdt
         CZM0VIOm78YLApami5+Xvwm6DrFw8kxPbr/af8sw7c69kgUXhqy0iuz+LmqqlB0xgC8w
         WvD1ClUEcNkFbJg9Gdu0VMW/O3oFLkl7GMGie88/z4x3v7/B00B2k+54EZ6uxaPdUKA5
         NrswG+RZK1VOrotyYeNuBKXRX8fJa7xSpEWeUFNuI6jxVz21ih9Cn3qwlPsXXnWJGVId
         h/9vMOp/ZrR7hvxanm/w2O98c07OrKkNmIdpyjuz2SjkiOs2OG6CVW6sE4IwttThcpOu
         ptPw==
X-Forwarded-Encrypted: i=1; AJvYcCXN4QLBuY0EL0FgLFe6/2jY0hFPrfQ8mJajFE/wtSYu7swTfAVkngejv2igPq7kd6Qr0YQ1zsHxkhfVqne2k3IZjMXJilvu2PGIpdaPQ98aKMqeHFQ6JjH8zNzS4rOPjkLF72OaGBWUPng=
X-Gm-Message-State: AOJu0YwPSoN7qd2KS97imee/wuRV4CbZy2938jMF2Lj7AOxpwXVcBZYD
	FabdzFiI9Sh7kGmfM4JZm4i6679b6lvItUKmdme2vd6wBvy2rCvHG8AVdlpsPAQw/M/CxWS/b8s
	Wr9kZtqXw6h1u8eGNMsFAyYcHRn4=
X-Google-Smtp-Source: AGHT+IGOe8OCDEZGhCLHxUmCnemj0Hk4sKbvlMPTR2p1n4WQeoDgNivMXYTJMJuiDzzsWXV690B5e4WEtxWLy859PUg=
X-Received: by 2002:a05:6a21:1a9:b0:1af:5a19:70a4 with SMTP id
 le41-20020a056a2101a900b001af5a1970a4mr2411491pzb.29.1714550086911; Wed, 01
 May 2024 00:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308121338.1983-1-yongsuyoo0215@gmail.com> <CANXPkT6Bcj0Xbn308jNGp-vqTEcB9LKtUjZ1_zS-tc7KuBEMwA@mail.gmail.com>
In-Reply-To: <CANXPkT6Bcj0Xbn308jNGp-vqTEcB9LKtUjZ1_zS-tc7KuBEMwA@mail.gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Wed, 1 May 2024 16:54:37 +0900
Message-ID: <CANXPkT7Sv3TSNaPuPMVdpST4vGYZrvh+cfuEX7WjO+i0SP__PA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic into CA_RESET
To: mchehab@kernel.org, yongsuyoo0215@gmail.com, v4bel@theori.io, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Can you review this patch ?
Can you share how this modification is going ?

2024=EB=85=84 4=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:02, Y=
ongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Dear All
>
> Can you review this patch ?
> Can you share how this modification is going ?
>
> 2024=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:13, =
<yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > From: Yongsu yoo <yongsuyoo0215@gmail.com>
> >
> > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> >
> > In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET ioct=
l
> > is called, in a normal case, the state of the thread of the
> > dvb_ca_en50221_thread_state_machine will transit like below order.
> > DVB_CA_SLOTSTATE_NONE -> DVB_CA_SLOTSTATE_UNINITIALISED ->
> > DVB_CA_SLOTSTATE_WAITREADY -> DVB_CA_SLOTSTATE_VALIDATE ->
> > DVB_CA_SLOTSTATE_WAITFR -> DVB_CA_SLOTSTATE_LINKINIT ->
> > DVB_CA_SLOTSTATE_RUNNING
> > But in some problem cases, the state will become DVB_CA_SLOTSTATE_INVAL=
ID.
> > Among the above mentioned states, the DVB_CA_SLOTSTATE_NONE and
> > the DVB_CA_SLOTSTATE_INVALID are "already stablized" states,
> > whereas other states are "transiting" states.
> > The "already stablized" states mean no matter how long time we wait,
> > the state will not be changed.
> > The "transiting" states mean the states whose final state is not yet
> > determined. The state keeps to be changed. Only after some time passes,
> > we get to know whether the final state will be DVB_CA_SLOTSTATE_RUNNING
> > or DVB_CA_SLOTSTATE_INVALID.
> > During the "transiting" states, we do not yet know whether the
> > CA_RESET operation, which triggered the "transiting" states, will
> > succeed or fail. For this reason, during the "transiting" states, if
> > another CA_RESET ioctl is called and if this new CA_RESET ioctl
> > operation begins again, it will be meaningless and waste time.
> > For preventing this problem from happening, we make CA_RESET ioctl do
> > nothing and only return EBUSY if the ioctl is called during the
> > "transiting" states.
> > ---
> >  drivers/media/dvb-core/dvb_ca_en50221.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dv=
b-core/dvb_ca_en50221.c
> > index baf64540dc00..2e8aec354b7c 100644
> > --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> > +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> > @@ -1362,13 +1362,19 @@ static int dvb_ca_en50221_io_do_ioctl(struct fi=
le *file,
> >                         struct dvb_ca_slot *sl =3D &ca->slot_info[slot]=
;
> >
> >                         mutex_lock(&sl->slot_lock);
> > -                       if (sl->slot_state !=3D DVB_CA_SLOTSTATE_NONE) =
{
> > +                       if ((sl->slot_state =3D=3D DVB_CA_SLOTSTATE_RUN=
NING) ||
> > +                           (sl->slot_state =3D=3D DVB_CA_SLOTSTATE_INV=
ALID)) {
> >                                 dvb_ca_en50221_slot_shutdown(ca, slot);
> >                                 if (ca->flags & DVB_CA_EN50221_FLAG_IRQ=
_CAMCHANGE)
> >                                         dvb_ca_en50221_camchange_irq(ca=
->pub,
> >                                                                      sl=
ot,
> >                                                                      DV=
B_CA_EN50221_CAMCHANGE_INSERTED);
> >                         }
> > +                       else {
> > +                               if (sl->slot_state !=3D DVB_CA_SLOTSTAT=
E_NONE) {
> > +                                       err =3D -EBUSY;
> > +                               }
> > +                       }
> >                         mutex_unlock(&sl->slot_lock);
> >                 }
> >                 ca->next_read_slot =3D 0;
> > --
> > 2.17.1
> >

