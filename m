Return-Path: <linux-kernel+bounces-2585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F54815F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA969282CDB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AC43AAB;
	Sun, 17 Dec 2023 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6+N/5b5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805623308A;
	Sun, 17 Dec 2023 13:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD61C433C7;
	Sun, 17 Dec 2023 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702818047;
	bh=ceURb/yin7nwojjm8+LwtekPtcFpkviBi0xv8iONU88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6+N/5b5iLgxIysBZAhqwbeBjRXfaIQjnbntFC88Cpc+wZ4nkU7YgVvFhKswURIHs
	 hu7JOfmDiXGR+lLtm2U2Q4MbffLOH+4WFRLOIhqJDsUz5ZJPKSyWjXl370oRzpP/e8
	 75gyoCqrqhHXjbgucBM5+5wfPoTCl+14axw6juMKHJGuJ4arvggF5qTQagSTUzfLTO
	 6/iDzvbqaj+bzbwcPBs9Mf/5Kv/h9U0zmR1SihUohrXSq+pGY0zMS/HZy0kHUN/fy+
	 Nv9c45/kp5Ql8JV+Jlvqlo78jlW//WbfGqQ3+ORCQhK/no2kxIvRVaqj62Alge0XuY
	 GSipfc3xAu6Nw==
Date: Sun, 17 Dec 2023 13:00:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Stephen Boyd
 <swboyd@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
Message-ID: <20231217130033.0b3a5ac6@jic23-huawei>
In-Reply-To: <CAPUE2ut0gbSyzUQ+m=760kXeOqKoi+9OwaExXTSgg8S=bWhUvg@mail.gmail.com>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
	<20231028162638.5b477ded@jic23-huawei>
	<CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
	<CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
	<CAPUE2ut0gbSyzUQ+m=760kXeOqKoi+9OwaExXTSgg8S=bWhUvg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 15:51:04 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Hi Gwendal

I'll ignore this tag given the email you've replied to says there is a diff=
erent
implementation. Please take a look at that version instead.

Jonathan

>=20
> On Mon, Dec 11, 2023 at 4:46=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Hi,
> >
> > On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.o=
rg> wrote: =20
> > >
> > >
> > > We need to free it in other places too, like if the count doesn't mat=
ch.
> > > It may be easier to extract this section and just have 4 string
> > > literals.
> > >
> > >         switch (reg_def->reg) {
> > >         case SX9324_REG_AFE_PH0:
> > >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "se=
mtech,ph0-pin");
> > >                 break;
> > >         case SX9324_REG_AFE_PH1:
> > >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "se=
mtech,ph1-pin");
> > >                 break;
> > >         case SX9324_REG_AFE_PH2:
> > >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "se=
mtech,ph2-pin");
> > >                 break;
> > >         case SX9324_REG_AFE_PH3:
> > >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "se=
mtech,ph3-pin");
> > >                 break;
> > > =20
> >
> > I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
> > appreciate feedback.
> >
> > [1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity=
-sx9324-c-v3-1-b8ae12fc8a5d@google.com/
> >
> > Thanks
> > Justin =20


