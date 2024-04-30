Return-Path: <linux-kernel+bounces-164092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4548B78E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864121C226CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482FB17BB20;
	Tue, 30 Apr 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUphrbgv"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF4770FC;
	Tue, 30 Apr 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485861; cv=none; b=uC6m/akKqyzT7LiIUAr7HOTIJuhl8gLA5UPv59T90Fgyu4K1aLxU2aR1KU+TlSyb13sC5PONjeVycSH3gVlBmYgYlMjfpv6fSEJvZifZb0ppY425I/XahldBCJeiVY49sTgBgHweDz8qHCPB9N2NNLNFV3v2dOw7vB3uakTyFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485861; c=relaxed/simple;
	bh=56t2+Ew9OfwDvnVrXTcXYDJr1lI7iCCB7vtMImxlk7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVb+3+rGArWNePd69zyjV3YXUVxVEiMo+wRblhaau7mTKYOnddO8SxLUJ/luWAPTyUcQKIpaRs72oUJge1zT4l2Ez+fq9cvTvhNGDYgx3qOJPTOrPA2h/aJIzKzrMhCO1TNIj9ecII5ozgQt+6a7LWTGZbczV5yrkXtj8BabPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUphrbgv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so73026661fa.2;
        Tue, 30 Apr 2024 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714485858; x=1715090658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56t2+Ew9OfwDvnVrXTcXYDJr1lI7iCCB7vtMImxlk7Q=;
        b=JUphrbgvJRj5yewENT5dVWLb8yiNevloKM5oluyrkQlD8C/LL+BApZ6m3cJjXkeEDt
         cIDY+xHh0hVwJaYJdY6iu2kICwdxA4+utXhEHJk2MXeeE+g28ulgpn4yg7moSa5rE//v
         t058xI++wPK3wwdDIQVM2ZO1fEzHeizA4iIp6MbB7cifyr2Lzp8SPLTvTF7FHvLgKqO4
         V84j8IA4ejYWxu6cY86Xe60q/6VC/e/ITY2ApR6+fUZQaHQePAPSdMjKilH5tTIF0fWz
         +o863Y/Hm0uh7cDsSgecTHXN9NspVieF4GdzzfmhFcKDU2hALQgyNsrC3B5bT65MA7Vp
         ic3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485858; x=1715090658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56t2+Ew9OfwDvnVrXTcXYDJr1lI7iCCB7vtMImxlk7Q=;
        b=pe5xaFngcoOIkGtryGeyiCGa3I0PhpYgPgLuhgu2pvhRVUSlUVtqcdrbUdYyCvDBtT
         gsAP09jl/zxPXpMnXw+J9RMN3z0DCt4RGABTpmODvyU77eWjvcmUVsPlZq8JREyL7C9p
         kIddZeJ/iwo+GXuIoe5F2xPeL4+SGevdh/DS0O7NOpMDayAuWNYBH0d6ZrWboAkYb7sy
         zMNaIOIrwS8j+NsZ5T6ZuDpzqb3uYe3ac0YQoMNrmiJfsTjOzOCrJ/quPIps+KdcmPWm
         017I5Q7gO/xTiGD5csDk06c3NuWWmrS4nYkdxqfLuJAzb28gJ7JR5xR4MC8BlwRE1Rll
         y/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqjgtfIarEKxn7qdGc5HTHbZguXrbCPEU72WuMipxOlwsl66GTsyq3u7BPaGQWfCP6lH7l4VaZqAXzLNEA8dU4Oqk2Yrg4ORZXgGz3IiDYS96vSobY1LZo5Dkb5rjUrUgYP9RneHQ/qQkczLb/wHFx2+oYHiQ6oY7k0xi/+DK8K56B/bDr
X-Gm-Message-State: AOJu0Yyawp3BjYt4uvoFWGKFaG/naHSFRbs6l6zAX9BTBuLWKsQXSb7R
	D85O2LXtyyoQXlG+0Ak2s9mKn3kU/hX2V8YumjKTs9Lks0igCu9zlGhDIgijg1c7GC0WxW3Ba/W
	ZzCUt3jlyW7zo6etqeIIfgkS/Hk8=
X-Google-Smtp-Source: AGHT+IGI+0eGY8xQlwtd+je04QG3F2m7nCFOP050A/s/nGK4Rsol3C96yicHc7QyGe5D1cbzoT+YGnYnsrGJzE09imI=
X-Received: by 2002:a05:651c:11d1:b0:2e0:dc93:52ef with SMTP id
 z17-20020a05651c11d100b002e0dc9352efmr1906390ljo.26.1714485857803; Tue, 30
 Apr 2024 07:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com> <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com> <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com> <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
In-Reply-To: <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Apr 2024 10:04:05 -0400
Message-ID: <CABBYNZLCw08oo+RRWkBYAdBLhFK5+pQi59dz-f+P1QusfYoAAw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Doug Anderson <dianders@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Apr 30, 2024 at 9:07=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Apr 30, 2024 at 06:22:26PM +0530, Janaki Ramaiah Thota wrote:
> > On 4/30/2024 12:37 PM, Johan Hovold wrote:
> > > On Mon, Apr 29, 2024 at 01:31:53PM -0400, Luiz Augusto von Dentz wrot=
e:
>
> > >> Anyway the fact that firmware loading itself is programming a
> > >> potentially duplicated address already seems wrong enough to me,
> > >> either it shall leave it as 00... or set a valid address otherwise w=
e
> > >> always risk missing yet another duplicate address being introduced a=
nd
> > >> then used over the air causing all sorts of problems for users.
> > >>
> > >> So to be clear, QCA firmware shall never attempt to flash anything
> > >> other than 00:00:00:00:00:00 if you don't have a valid and unique
> > >> identity address, so we can get rid of this table altogether.
> > >
> >
> > Yes agree with this point.
> > BD address should be treated as invalid if it is 00:00:00:00:00:00.
>
> We all agree on that.
>
> > NVM Tag 2: bd address is default BD address (other than 0), should be
> > configured as valid address and as its not unique address and it will
> > be same for all devices so mark it is configured but still allow
> > user-space to change the address.
>
> But here we disagree. A non-unique address is not a valid one as it will
> cause collisions if you have more than one such controller.
>
> I understand that this may be convenient/good enough for developers in
> some cases, but this can hurt end users that do not realise why things
> break.
>
> And a developer can always configure an address manually or patch the
> driver as needed for internal use.
>
> Are there any other reasons that makes you want to keep the option to
> configure the device address through NVM files? I'm assuming you're not
> relying on patching NVM files to provision device-specific addresses
> after installation on target?

Exactly, a duplicated address is not a valid public/identity address.

Regarding them already been in use, we will need to have it fixed one
way or the other, so it is better to change whatever it comer within
the firmware file to 00:00:00:00:00:00 and have it setup a proper
address after that rather than have a table that detect the use of
duplicated addresses since the result would be the same since
userspace stores pairing/devices based on adapter addresses they will
be lost and the user will need to pair its peripherals again, so my
recommendation is that this is done via firmware update rather than
introducing a table containing duplicate addresses.

That said it seems the patch in this thread actually reads the address
with use of EDL_TAG_ID_BD_ADDR and then proceed to check if that is
what the controller returns as address, while that is better than
having a table I think there is still a risk that the duplicated
address gets used on older kernels if that is not updated in the
firmware directly, anyway perhaps we shall be doing both so we capture
both cases where duplicated addresses are used or when BDADDR_ANY is.

--=20
Luiz Augusto von Dentz

