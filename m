Return-Path: <linux-kernel+bounces-28234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CE82FBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E546728D65F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41220B3F;
	Tue, 16 Jan 2024 20:08:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551720B20
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435717; cv=none; b=reXDM/d4YP3yWACdhJGKxX50UaxD8CCBBYEcRyRrKCZ0XX6PnjhLH9hVAr5yy6f0RiH7OVrQjEIV3YzN465AZVnrjtue9bRWlcALa+GVEMZxvAtHr6qRTr4wdkY1ilvEb+fYOM0qVKGJ7R+tBM3/31n8JI33FOUOu+6pyY8+FeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435717; c=relaxed/simple;
	bh=+f92y93G1zWOtlpq6n0Sr2dabG7AgxMgV9bKCPRbafk=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=mLSFLdWIGa/XIjgcnw//OQpp2ONXWcT3lUt66A+62dGIVic/s2kprES9RBksFhaFmj6U9xxyntCYmb3FAeqN0g9Gfjznucw/PKpAgVlttlBKyOHnQ3jioJ9wOwXvg60fcBWbkJBJ+gM8IHg1VKNn1RuKsBg1rOn15yrPFc6zCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE48C433F1;
	Tue, 16 Jan 2024 20:08:35 +0000 (UTC)
Date: Tue, 16 Jan 2024 15:09:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: nathanl@linux.ibm.com, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: make DECLARE_SEQ_BUF() usable
Message-ID: <20240116150950.5f444a04@gandalf.local.home>
In-Reply-To: <407c467e-1f0b-4549-951a-83c295b27733@wanadoo.fr>
References: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
	<407c467e-1f0b-4549-951a-83c295b27733@wanadoo.fr>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 20:40:29 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 16/01/2024 =C3=A0 15:09, Nathan Lynch via B4 Relay a =C3=A9crit=C2=A0:
> > From: Nathan Lynch <nathanl@linux.ibm.com>
> >=20
> > Using the address operator on the array doesn't work:
> >=20
> > /include/linux/seq_buf.h:27:27: error: initialization of =E2=80=98char =
*=E2=80=99
> >    from incompatible pointer type =E2=80=98char (*)[128]=E2=80=99
> >    [-Werror=3Dincompatible-pointer-types]
> >     27 |                 .buffer =3D &__ ## NAME ## _buffer,       \
> >        |                           ^
> >=20
> > Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
> > compound literal to define the buffer array without attaching a name
> > to it. This makes the macro a single statement, allowing constructs
> > such as:
> >=20
> >    static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);
> >=20
> > to work as intended.
> >=20
> > Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> > Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_st=
r()")
> > ---
> >   include/linux/seq_buf.h | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > index 5fb1f12c33f9..c44f4b47b945 100644
> > --- a/include/linux/seq_buf.h
> > +++ b/include/linux/seq_buf.h
> > @@ -22,9 +22,8 @@ struct seq_buf {
> >   };
> >  =20
> >   #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> > -	char __ ## NAME ## _buffer[SIZE] =3D "";		\
> >   	struct seq_buf NAME =3D {				\
> > -		.buffer =3D &__ ## NAME ## _buffer,	\
> > +		.buffer =3D (char[SIZE]) { 0 },		\
> >   		.size =3D SIZE,				\
> >   	} =20
>=20
> Hi,
>=20
> just removing the & in ".buffer =3D __ ## NAME ## _buffer, \" also works =
IIRC.
>=20
> See [1], which unfortunately has been unnoticed.
>=20
> CJ
>=20
>=20
> [1]:=20
> https://lore.kernel.org/all/2a534333-b5f6-4b1d-b4b8-a1a71f91c3ff@wanadoo.=
fr/

I guess I missed that.

But it still doesn't fix this case:

 static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);

Which this patch does.


-- Steve

