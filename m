Return-Path: <linux-kernel+bounces-107207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CFA87F925
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B51F24979
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC554776;
	Tue, 19 Mar 2024 08:12:38 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0651C5F;
	Tue, 19 Mar 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835957; cv=none; b=ECefPDykVXKeZuaIcOBk+HpOmS0qe4MU2ynvwu6MaKqXiezTNOQU8EoCSIOr1AG9MW1IaPrCnft8dBwv/oAkul9830dummtyoD3HLYu4jgGiFcO/RU61OMBCQQKMmUObgEY+JoSB3avkon5Q7dIEkZiZ0lS3d0CDWszfp7IsKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835957; c=relaxed/simple;
	bh=9caLd301JPjjyVwXBcpRgYu6Tjsc9zw0rESPSmtUeG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU3JKU60o5/DLKv27tUX30v7+UA5c4GmQ4qLKdifXplg49RRUG5erd+PiyThbhoOJcULk0ccIAZKnD0RtksvVxwLHxcw6XwC51yQw746UX2KBs/0NmkkvGaEVuaLjH75/RcV7SpC8c/dwRvO3pPM8jf7tUX7rWf5X6ZNBk7CHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 11:12:23 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 19 Mar 2024 11:12:23 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>
CC: Thomas Zimmermann <tzimmermann@suse.de>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH v2] fbmon: prevent division by zero in
 fb_videomode_from_videomode()
Thread-Topic: [PATCH v2] fbmon: prevent division by zero in
 fb_videomode_from_videomode()
Thread-Index: AQHabwRs4YTUR6hF/0+sHxdCA/um27E4WY8AgATgDMOAAId3gIABCvMT
Date: Tue, 19 Mar 2024 08:12:23 +0000
Message-ID: <57b3f6a6cc184c8ead51ecc50669b503@omp.ru>
References: <20240305135150.23240-1-r.smirnov@omp.ru>
 <64bbc4dd-b617-4f3d-809e-763bedf37fb7@gmx.de>
 <9688d1d453b0472cb90f5e2151cbd2f8@omp.ru>,<b5d52c4c-534f-4897-ab96-351f09bee89a@gmx.de>
In-Reply-To: <b5d52c4c-534f-4897-ab96-351f09bee89a@gmx.de>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/19/2024 6:00:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 18 Mar 2024 20:15:55 +0100 Helge Deller wrote:
> On 3/18/24 09:11, Roman Smirnov wrote:
> > On Fri, 15 Mar 2024 09:44:08 +0100 Helge Deller wrote:
> > > On 3/5/24 14:51, Roman Smirnov wrote:
> > > > The expression htotal * vtotal can have a zero value on
> > > > overflow.
> > >
> > > I'm not sure if those always results in zero in kernel on overflow.
> > > Might be architecture-depended too, but let's assume it
> > > can become zero, ....
> > >
> > > > It is necessary to prevent division by zero like in
> > > > fb_var_to_videomode().
> > > >
> > > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > > >
> > > > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > > > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > > ---
> > > >    V1 -> V2: Replaced the code of the first version with a check.
> > > >
> > > >    drivers/video/fbdev/core/fbmon.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev=
/core/fbmon.c
> > > > index 79e5bfbdd34c..b137590386da 100644
> > > > --- a/drivers/video/fbdev/core/fbmon.c
> > > > +++ b/drivers/video/fbdev/core/fbmon.c
> > > > @@ -1344,7 +1344,7 @@ int fb_videomode_from_videomode(const struct =
videomode *vm,
> > > >         vtotal =3D vm->vactive + vm->vfront_porch + vm->vback_porch=
 +
> > > >                  vm->vsync_len;
> > > >         /* prevent division by zero */
> > > > -     if (htotal && vtotal) {
> > > > +     if (htotal && vtotal && (vm->pixelclock / htotal >=3D vtotal)=
) {
> > >
> > > why don't you then simply check for
> > >          if .. ((htotal * vtotal) =3D=3D 0) ...
> > > instead?
> > >
> > > Helge
> >
> > Thomas Zimmermann from the previous discussion said:
> > On Tue, 5 Mar 2024 11:18:05 +0100 Thomas Zimmerman wrote:
> > > Maybe use
> > >
> > >     if (htotal && vtotal && (vm->pixelclock / htotal >=3D vtotal))
> > >
> > > for the test. That rules out overflowing multiplication and sets
> > > refresh to 0 in such cases.
> >
> > This prevents overflow, which is also a problematic case.
>
> I don't like adding another division here and I doubt we have
> a problem with possible overflow.
> So, I suggest to keep it simple, something like:
>        ...
>        total =3D htotal * vtotal;
>        if (total)
>                fbmode->refresh =3D vm->pixelclock / total;
>        else...

Okay, I'll prepare a third version with that change:

    if (htotal && vtotal && (htotal * vtotal))

I think that will be enough.


