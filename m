Return-Path: <linux-kernel+bounces-51728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28A848EA4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C21C212CD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A41224C6;
	Sun,  4 Feb 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXeVWQ0f"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006931EA6F;
	Sun,  4 Feb 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058241; cv=none; b=l3H7epAEM+2IDioKvn4Y19snu+LJnZanAoJEwp1GcLLPLhL1GsOEqfrPa7OKhp5hF+X4teJLL1/nnrKRzAGP2DUCta7NxglDFq7Ly56LykcLMauVbXQAlXCscb8eifiSboDAzKw2lop8KHosAbS+vDAgdcC0swECHcjSNlKPgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058241; c=relaxed/simple;
	bh=ggkn1nSdlfUbbzcKp+oXfOr8UTM7M88HiCnkeHGMl50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwX1wVgbSoOOgLXpjoZ6eL4OPROvjhn93q/q+zWoN/QBjo+KgkC8z/ZKGv3nbyQDJ3islXE/x48vWa4QN/o4NDTKg9exKqCQkH0E+rZTE7isJcco6pmdeSNgLrhnDnOOaXWimxzvgrcF/y6OleXngPIETttp3ZCT5LZ4IpdNL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXeVWQ0f; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd72353d9fso2827747b6e.3;
        Sun, 04 Feb 2024 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058239; x=1707663039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leJJ6Axw7wD2gO6odqX9o323K4rTJGwX8umGVdANTFE=;
        b=GXeVWQ0fYAGKyJCozHUcbjTGYQ/GsQXI7hwol4St7+kDDMpZ5h84Zo2JTl6WLzowO5
         YP9gJ2nRefsXp0vVLhaN3bYT5VbFfNyr6jwFkIBqhdImySuijZW5K8oGH3MQf+YRABps
         je/mhzfR3d8aQ+Mrkh5Y9xmXcc+olBn1bIJJlxB210gfIZwplx7tg1XgOtzPryh7cNw4
         8cDSBuP4xuUJlQWCQ3Y3bmMgs/CAtLNrGZ5gujVOou7ms2MqieOIBms7YXS01jaFOBUT
         1LvZ24hDWHl8MqeyzDj5SrFg/YAZgJ1lrEfa/ZjlzpFEcuafb/TA9bs7iwF1eTyGh5a9
         /RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058239; x=1707663039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leJJ6Axw7wD2gO6odqX9o323K4rTJGwX8umGVdANTFE=;
        b=Gt2U0vFnGMKDeMqOVuaDWVLYulhsd8+ixrc91NDZejSQBIrYQlZiyrLusZfmhQWyHI
         5UK4P7eIzmQBTao+ZfuXpfReqW69ASImgf344+POtRRaHi5T09P3ad8czSI/ae299IUg
         8kSMXaC+Y2eZuw5tPXrE8x3+pq3r6/14oTfwq+mUZYfBKWpe6fsEeinDwPMkMZ9qKGPh
         URWFXnvVkcHipqHYZ3uIUqwPM8r5cNvMXhKGW1qExvYahfBGlsduDitI2gBlCBUtiJ6x
         BeG8VFysx9xbYoChhkPRPu6X3JcxceV4OJGpfLqiFh97UIu8nAm+QmUJKvW2pFzWJ36b
         WHog==
X-Gm-Message-State: AOJu0Yyv2lV6mwKWOhG01POfx/esAWt8NfPCmaI+JjHvuBGWD1YpJfFJ
	dBnIAdMWfWerJzTf3mNyEtXQpkVcQbQz599dYKuIpOaG5YxeacSkBdhpqJp/Drq4CrJ4nVYKeWC
	1SRqrOPCxP6d6xYuqwlBHOHrsf06nMaiEjefDL2tS7mw=
X-Google-Smtp-Source: AGHT+IE4Q1jPytHW6rlTMBKbt6JqW0fm6nco7IQ8coY5gOCkCd5h72bte7ol91zUoHZZpHg/I+4Rir2Xy1HgDyAmxwM=
X-Received: by 2002:a05:6808:2e99:b0:3bf:bb23:c94d with SMTP id
 gt25-20020a0568082e9900b003bfbb23c94dmr11452766oib.55.1707058238957; Sun, 04
 Feb 2024 06:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117114350.3105-1-maimon.sagi@gmail.com> <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
 <CAMuE1bFEbrY2PiDB6OdZGzDNijPAhoGBircTpqiyVs0Qq6bOig@mail.gmail.com> <6b88bdc3-37da-423f-a665-308ac519a256@linux.dev>
In-Reply-To: <6b88bdc3-37da-423f-a665-308ac519a256@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 4 Feb 2024 16:50:03 +0200
Message-ID: <CAMuE1bFc6aduG8+26t157ZcaeUt1UeVk1RP47+Hu32G68AmwZg@mail.gmail.com>
Subject: Re: [PATCH v5] ptp: ocp: add Adva timecard support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks'
patch v6 is on the way

On Sun, Feb 4, 2024 at 4:39=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 04/02/2024 11:31, Sagi Maimon wrote:
> > Hi Vadim,
> > Sorry but I was on vacation for the last two weeks.
> > So What should I do now:
> > 1) Do you want me to set my changes into the main linux git tree:
> >      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >      and use  use '[PATCH v6] ...' prefix
> > 2) Or
> >      set my changes into the net-next git tree:
> >      git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >      and use  use '[PATCH net-next v6] ...' prefix
>
> Hi Sagi!
>
> Option 2 is the way to go.
>
> Thanks,
> Vadim
>
> >
> > BR,
> > Sagi
> >
> > On Wed, Jan 17, 2024 at 11:23=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 17/01/2024 11:43, Sagi Maimon wrote:
> >>> Adding support for the Adva timecard.
> >>> The card uses different drivers to provide access to the
> >>> firmware SPI flash (Altera based).
> >>> Other parts of the code are the same and could be reused.
> >>>
> >>
> >> Hi Sagi,
> >>
> >> Thanks for adjusting the code. One signle still have to be
> >> adjusted, see comments below. And this is treated as net-next
> >> material, but net-next is closed now until merge window ends,
> >> you will have to submit new version next week.
> >>
> >> Please, also use '[PATCH net-next v6] ...' prefix for it.
> >>
> >>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>> ---
> >>>    Changes since version 4:
> >>>    - alignment fix.
> >>>
> >>
> >> Please, preserve changes from all previous versions for next submissio=
ns.
> >>
> >>>    drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++=
++--
> >>>    1 file changed, 293 insertions(+), 9 deletions(-)
> >>>
> >>
> >> [ ..skip.. ]
> >>
> >>> @@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, str=
uct ocp_resource *r)
> >>>        if (err)
> >>>                return err;
> >>>
> >>> -     return ptp_ocp_init_clock(bp);
> >>> +     return ptp_ocp_init_clock(bp, r->extra);
> >>> +}
> >>> +
> >>> +/* ADVA specific board initializers; last "resource" registered. */
> >>> +static int
> >>> +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> >>> +{
> >>> +     int err;
> >>> +     u32 version;
> >>> +
> >>> +     bp->flash_start =3D 0xA00000;
> >>> +     bp->eeprom_map =3D fb_eeprom_map;
> >>> +     bp->sma_op =3D &ocp_adva_sma_op;
> >>> +
> >>> +     version =3D ioread32(&bp->image->version);
> >>> +     /* if lower 16 bits are empty, this is the fw loader. */
> >>> +     if ((version & 0xffff) =3D=3D 0) {
> >>> +             version =3D version >> 16;
> >>> +             bp->fw_loader =3D true;
> >>> +     }
> >>> +     bp->fw_tag =3D 1;
> >>
> >> Please, use fw_tag =3D 3 here, other tags are for other vendors.
> >>
> >> Thanks,
> >> Vadim
> >>
> >>> +     bp->fw_version =3D version & 0xffff;
> >>> +     bp->fw_cap =3D OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> >>> +
> >>> +     ptp_ocp_tod_init(bp);
> >>> +     ptp_ocp_nmea_out_init(bp);
> >>> +     ptp_ocp_signal_init(bp);
> >>> +
> >>
>

