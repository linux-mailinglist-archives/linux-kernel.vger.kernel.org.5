Return-Path: <linux-kernel+bounces-37562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C683B1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041D2B2A4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F224131E3F;
	Wed, 24 Jan 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aoVUMSOA"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124947CF1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122782; cv=none; b=j08C7tbP3IbGLWPNi6CxqVc5hWZPwekUQrTuD+U69DmO/eO39mjCqI3r0zdkG/SU8fZ6Hqf5C+mPmdHitV4NO2yIXaylFsrFShVYNekX35h7FtoNO95jlWGiG/MWJVPTt4Yq5QRGCE3ISahhofHJmkoYXUsue05X6u6a5cSDOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122782; c=relaxed/simple;
	bh=Yl6yynRwqlzywAWtFeFQqDvgiT8QYAC0mcPkalJ8b2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYCVO+fglcfuIHYf0sprj/I3bjkxJ2hF9sJpUmm/t/Qmv8t01Bjnatqz8rQhgUqnvRDJVnRTItTkkY7bxK8yL+TSV1un11AkeHoGxzTSAwZGkJnmGt8yGTRJjdt7X6Qe4r6iYQE3XqnRYOtZ+rQUoq6+Mt2sgCW+8EharqFkesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aoVUMSOA; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc2308fe275so4990206276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122780; x=1706727580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6PL8UnNoNRmqQyb82Ctczzo51piu7gV+xPgMEYy95g=;
        b=aoVUMSOA4QF5kBpCwGdc97wd9Od7X/0D8z9MgFxFqazFrF4I1T5tNk4sKesXpMwxU5
         SATFctCLXjMPOR8riEDyKeaa2TeT9eR0dTSetg03rJK9mGWrtSbj382fYomz9b73sDoG
         9Yay194Tt26nWzxjwAsqYP+O/jpWEpRoOv8cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122780; x=1706727580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6PL8UnNoNRmqQyb82Ctczzo51piu7gV+xPgMEYy95g=;
        b=HvMCrPvB+L84G38vKHVr7WEagyu4PD4eIWrLj4HFjGlSxhkiRSG39Pq7g0ZcQzs64f
         jCzIS4/9umTPj1xsynBcQOukgM+02UCzo8tO0khs346kELmUF8Or0AV7fm72iVP2GhWp
         BL6RYAqB/VMHeNMlrySzxMUdg5fMr3vqdnMR9gFq1r7qIbG1jaTvHthd2f08ccuacKZ7
         citZhmrPhwslREclvKPz54n6StB068dsoVPHwOv+LMIDfaqLhy9Onbqb+3ugUtL2+oG9
         jgfxGXJuazTIufadCppdwJjPIed+mh+xmdugFvdLSpBpjM1pNQGeFwb0VlskCe7Dem9e
         AKIg==
X-Gm-Message-State: AOJu0YwsjgDlCCpJCTRiKTL+F6GLEJPsdOwg9ulk87V2t7156bhbx7Lk
	A9HbD++cmnzFrBLelUFfdHZTMyR4Fd2lvI4hDrhKnqAg0YCc/O5p9dlJyzJY5dbu9fBLueHAVkz
	Pb2jl7CBrH1V9Fh1EE4w1U4ghoct0tznW+rPs
X-Google-Smtp-Source: AGHT+IEK2MoUyyeVyti680IBepHWRvLzn+5AeBV/afLBuANUkn6E3lt+kVYlsVSRbSC5Q2J15QVgz5mEwT37aAUypww=
X-Received: by 2002:a25:9c03:0:b0:dbe:a209:3305 with SMTP id
 c3-20020a259c03000000b00dbea2093305mr927061ybo.98.1706122779981; Wed, 24 Jan
 2024 10:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
 <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>
 <ZbEV/qp/EhUkHVhA@kuha.fi.intel.com> <2024012405-stung-freckles-e196@gregkh>
In-Reply-To: <2024012405-stung-freckles-e196@gregkh>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 24 Jan 2024 10:59:28 -0800
Message-ID: <CANFp7mVEF36TCb_4vGbF-0wM-Vn4agT6NXVOrnnDSC0JVpnLmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: ucsi: Limit read size on v1.2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Prashant Malani <pmalani@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@google.com>, linux-usb@vger.kernel.org, jthies@google.com, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack. Will make dev_dbg on the next iteration.

This seems like a good addition to the style guide too:
https://www.kernel.org/doc/html/v6.7/process/coding-style.html#printing-ker=
nel-messages.
"When drivers are working properly, they are quiet. Prefer to use
DEBUG messages unless something is wrong."

What do you think Greg?

On Wed, Jan 24, 2024 at 6:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 24, 2024 at 03:51:58PM +0200, Heikki Krogerus wrote:
> > On Wed, Jan 24, 2024 at 12:12:26AM -0800, Prashant Malani wrote:
> > > Hi Abhishek,
> > >
> > > On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
> > > <abhishekpandit@google.com> wrote:
> > > >
> > > > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > >
> > > > Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region wa=
s
> > > > increased from 16 to 256. In order to avoid overflowing reads for o=
lder
> > > > systems, add a mechanism to use the read UCSI version to truncate r=
ead
> > > > sizes on UCSI v1.2.
> > > >
> > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > I have one nit (mentioned in side-band but reproducing here for consi=
stency),
> > > but will defer to the maintainer on that.
> > >
> > > The above notwithstanding, FWIW:
> > > Reviewed-by: Prashant Malani<pmalani@chromium.org>
> > >
> > > > @@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
> > > >         if (!ucsi->version)
> > > >                 return -ENODEV;
> > > >
> > > > +       /*
> > > > +        * Version format is JJ.M.N (JJ =3D Major version, M =3D Mi=
nor version,
> > > > +        * N =3D sub-minor version).
> > > > +        */
> > > > +       dev_info(ucsi->dev, "Registered UCSI interface with version=
 %x.%x.%x",
> > > > +                UCSI_BCD_GET_MAJOR(ucsi->version),
> > > > +                UCSI_BCD_GET_MINOR(ucsi->version),
> > > > +                UCSI_BCD_GET_SUBMINOR(ucsi->version));
> > >
> > > nit: I think this doesn't need to be dev_info() and can be just
> > > dev_dbg(), but will
> > > defer to the maintainer.
> >
> > I think that's okay.
> >
> > Reviewewd-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> No, when drivers are working properly they are quiet, this needs to be
> dev_dbg().
>
> thanks,
>
> greg k-h
>

