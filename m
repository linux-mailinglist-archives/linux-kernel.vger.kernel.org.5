Return-Path: <linux-kernel+bounces-162759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B08B602F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D771C2257E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572D1272A5;
	Mon, 29 Apr 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYP4Qowj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D48614C;
	Mon, 29 Apr 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411931; cv=none; b=IHQE4K2sy3ooQl2yMX7TVDizxv0KPAAf5uYnWl00Ahila7CBS5qmkCYRqTCiRf7zLBs/vEkpXgYK+FxKTn7hmcAJHyW/cd/jUb7huTtu6tDB+eQbiqII+euaQbLii71FsODXYyX0nG3Zde/UDnjkPRxhrEEIcujkYQNHXYWO1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411931; c=relaxed/simple;
	bh=iqIHXbJjoR/NNhKJl08ktzgkIFOTMzL85HRzlBgYroM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc6CaSQFdNngsrjEwbvwnjWio5Givm67fEcKFaggbdRzJFLABnH6ZvPcsrzrWpC+r3nHr1TIe1qUrRI4Gg9WRxcXyEzaoVKEaszpimlm+VeB8z+0Hzr1c8IdaCHjIclF/JZgYx2KL2wLuUr7ZNFI8bq6vUFLOODT4CAit2wL/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYP4Qowj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e51398cc4eso42966675ad.2;
        Mon, 29 Apr 2024 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714411928; x=1715016728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yO0axpmFWwXDk/UVwdYYKF708XKLao28CV2qhrurHw=;
        b=dYP4QowjUoq/cUSxtQfW8kUmDChpDErO8rEp7zZVc5qb4ZPBfzqBcCOa40pWeycGJr
         Doa9s0SWI7+5YJzp4njdOu6XvshCIIaC/lmEbg/MuJdAKUBFF6OXtjI7CC39nHI0iL0L
         rKCf46RmZCJVKY8QrJiRBg24rTMAENCIO5N2/3ofzkKvKY/eItkrl6Tiv0Nos6rbpYLU
         FgI0jziAo0an8G4yuJOK2U5WZreQch3tg08zOIsp/hIpYSdB0xtV5EtHiRX4y329Up9o
         x5Wn1yThvfSsmagD5fLeTF/e08xioSfl0Tc93XjhHAUErpwK4bvndaScPQfTiLZKwXwo
         tuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411928; x=1715016728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yO0axpmFWwXDk/UVwdYYKF708XKLao28CV2qhrurHw=;
        b=HCePAj8CeCMUW7cTgSO4v0CAUnRyNjYIZI2YEmPofna6z/n3X1goJ5WYWUHXT2vddS
         te2sysOrHBjcjpsD3ji8uL1OZge/b7g1PtFOBjTuVBJHO1cV13i75lCh+rIgXJviR/pO
         dW6UFFFWTarea0rizhxtORJ25itdbJOvmk5zpPbNwlonp4/LnUSBEB+I49VWMiADDh/x
         46/AeAkWQ8oKTw+z+EXKB5d1dUGQCghNiUS64tUd4a+ooVSDUG37unIWV54oSu4Lhnfn
         F4clHs06JTfNntUWlGIEU6YCFwv6vaGIwoLDZvwPg4GLElQc7JEoJh6JtTp6pRoBC8d/
         VTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC8XHI5eRMoi+BifPZ+Lhr/0hj9btrN29Zz+QVIXGAFIpYHgn/GkUqQjxKuZbhkialEtstapPvFVNqWwGWieuE6UxFL2qSQEmnLZ9dOrT3792aTBglI6PdgzUUCrIkrR8ZmssTncc/xo3gzPV7wFvPVBOhP4h9/WiDrRzd80Pw1zHNP2iI
X-Gm-Message-State: AOJu0YwlxISgri9b9Z5uoeesAHDGNeMljVrfP5C+uzwZVxkMYpFD4yIk
	M8JZNJqDGLoJfCcFyBP7KARzAa3X8JgfT8O8bgT+dbN3w+A7/faCi9My7Winx7miV1MxiiM9w0P
	SuNF6OP9RYwLM1wmxLfE6Lf1BqKc=
X-Google-Smtp-Source: AGHT+IF/cMVRZqUF4PJpmz/ctyeQby+RhUwdslYpqxX493gwiftDdBuuSTd0L/iWow1IH+ELZJg2338tGJD7t+pWy6s=
X-Received: by 2002:a17:902:ce87:b0:1eb:7285:d6fe with SMTP id
 f7-20020a170902ce8700b001eb7285d6femr8369860plg.23.1714411928438; Mon, 29 Apr
 2024 10:32:08 -0700 (PDT)
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
In-Reply-To: <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Apr 2024 13:31:53 -0400
Message-ID: <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Doug Anderson <dianders@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 1:12=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Mon, Apr 29, 2024 at 10:02=E2=80=AFAM Johan Hovold <johan@kernel.org> =
wrote:
> >
> > Hi Janaki,
> >
> > Please avoid top and remember to trim unnecessary context when replying
> > to the mailing lists.
> >
> > On Mon, Apr 29, 2024 at 03:34:32PM +0530, Janaki Ramaiah Thota wrote:
> >
> > > Having a default BDA list from NVM BDA tag value will prevent develop=
ers
> > > from using the device if there is no user space app(In Fluoride) to s=
et
> > > the BDA. Therefore, we are requesting to use default address check pa=
tch,
> > > so that developer can change the NVM BDA to make use of the device.
> >
> > But a developer on such an old platform that can patch and replace the
> > NVM configuration file should also be able to just disable the check in
> > the driver right (e.g. by commenting out the call to
> > qca_check_bdaddr())?
> >
> > >   List Of default Addresses:
> > >   ---------------------------------------------------------
> > > |       BDA          |      Chipset                       |
> > >   ---------------------------------------------------------
> > > | 39 80 10 00 00 20  |  WCN3988 with ROM Version 0x0200   |
> > >   ---------------------------------------------------------
> > > | 39 80 12 74 08 00  |  WCN3988 with ROM Version 0x0201   |
> > >   ---------------------------------------------------------
> > > | 39 90 21 64 07 00  |  WCN3990                           |
> > >   ---------------------------------------------------------
> > > | 39 98 00 00 5A AD  |  WCN3991                           |
> > >   ---------------------------------------------------------
> > > | 00 00 00 00 5A AD  |  QCA DEFAULT                       |
> > >   ---------------------------------------------------------
> >
> > What about WCN6750 and 64:90:00:00:5a:ad?
> >
> > And then there's currently also:
> >
> > > > bluetooth hci0: bd_addr =3D 61:47:aa:31:22:14 (qca/nvm_00130300.bin=
)
> > > > bluetooth hci0: bd_addr =3D 61:47:aa:32:44:07 (qca/nvm_00130302.bin=
)
> >
> > Which controllers use these configurations?
>
> These are not unique addresses though, we can't just have addresses by
> chipset address mapping logic as that would cause address clashes over
> the air, e.g. if there are other devices with the same chipset in the
> vicinity.

I see where this is going now, the firmware actually contain these
duplicated addresses which then are checked and cause
HCI_QUIRK_USE_BDADDR_PROPERTY then the tries
hci_dev_get_bd_addr_from_property which loads the local-bd-address
property from the parente device (SOC?), btw that could also have an
invalid/duplicated address.

Anyway the fact that firmware loading itself is programming a
potentially duplicated address already seems wrong enough to me,
either it shall leave it as 00... or set a valid address otherwise we
always risk missing yet another duplicate address being introduced and
then used over the air causing all sorts of problems for users.

So to be clear, QCA firmware shall never attempt to flash anything
other than 00:00:00:00:00:00 if you don't have a valid and unique
identity address, so we can get rid of this table altogether.

ps: If the intention is to have these addresses for testing then these
firmwares files shall probably be kept private, since as explained
above the use of duplicated addresses will cause problems to users who
have no idea they have to be changed.

>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

