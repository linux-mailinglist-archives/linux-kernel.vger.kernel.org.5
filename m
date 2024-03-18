Return-Path: <linux-kernel+bounces-105808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F887E4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A601C214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0825760;
	Mon, 18 Mar 2024 08:12:03 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A024211;
	Mon, 18 Mar 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749523; cv=none; b=TZoyobNPq+dievOBRjnQV9ulsmuwejtkqpF/S0ovL0TPiWeAwyq1tEOXGapFzbBdlehSvxgq1xEwAlCkVMFaElAgxzLi7W6I651Yzf3103qCcOimJ6g6OZtrcDB5qTN7dVNLmvyePj4dtC4VmTg0D8nUru4N0l+/v0CgwtAtqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749523; c=relaxed/simple;
	bh=4RM3TpWBDiLZkLsDmGc/CKsM/sjmp+1va4efrECH3uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdWA4bgPzxlKNx09ReM3IJ4DgZhgY/f1eSM7zD/zCRdCdMiyJ5OuO0SUFiA2RZSEWi2AVKyEP0dYUeWdYNAQHnKiGZi3Wf7BHQMaftK3HVsNDGsUp6z6x9gWHSMkfuUlcaTgAFKgH3UecZP2jVIBnvwCv18rABe4Irtw1WCBExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 18 Mar
 2024 11:11:48 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Mon, 18 Mar 2024 11:11:48 +0300
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
Thread-Index: AQHabwRs4YTUR6hF/0+sHxdCA/um27E4WY8AgATgDMM=
Date: Mon, 18 Mar 2024 08:11:48 +0000
Message-ID: <9688d1d453b0472cb90f5e2151cbd2f8@omp.ru>
References: <20240305135150.23240-1-r.smirnov@omp.ru>,<64bbc4dd-b617-4f3d-809e-763bedf37fb7@gmx.de>
In-Reply-To: <64bbc4dd-b617-4f3d-809e-763bedf37fb7@gmx.de>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/18/2024 7:14:00 AM
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

On Fri, 15 Mar 2024 09:44:08 +0100 Helge Deller wrote:
> On 3/5/24 14:51, Roman Smirnov wrote:
> > The expression htotal * vtotal can have a zero value on
> > overflow.
>=20
> I'm not sure if thos always results in zero in kernel on overflow.
> Might be architecture-depended too, but let's assume it
> can become zero, ....
>=20
> > It is necessary to prevent division by zero like in
> > fb_var_to_videomode().
> >
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> >
> > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> >   V1 -> V2: Replaced the code of the first version with a check.
> >
> >   drivers/video/fbdev/core/fbmon.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> > index 79e5bfbdd34c..b137590386da 100644
> > --- a/drivers/video/fbdev/core/fbmon.c
> > +++ b/drivers/video/fbdev/core/fbmon.c
> > @@ -1344,7 +1344,7 @@ int fb_videomode_from_videomode(const struct vide=
omode *vm,
> >        vtotal =3D vm->vactive + vm->vfront_porch + vm->vback_porch +
> >                 vm->vsync_len;
> >        /* prevent division by zero */
> > -     if (htotal && vtotal) {
> > +     if (htotal && vtotal && (vm->pixelclock / htotal >=3D vtotal)) {
>=20
> why don't you then simply check for
>         if .. ((htotal * vtotal) =3D=3D 0) ...
> instead?
>=20
> Helge

Thomas Zimmermann from the previous discussion said:

On Tue, 5 Mar 2024 11:18:05 +0100 Thomas Zimmerman wrote:
> Maybe use
>
>    if (htotal && vtotal && (vm->pixelclock / htotal >=3D vtotal))
>
> for the test. That rules out overflowing multiplication and sets
> refresh to 0 in such cases.

This prevents overflow, which is also a problematic case.=

