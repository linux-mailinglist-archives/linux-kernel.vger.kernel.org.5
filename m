Return-Path: <linux-kernel+bounces-60728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAA8508F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5EB1C21D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040425B043;
	Sun, 11 Feb 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McCtZJxC"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E5A7A3;
	Sun, 11 Feb 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654562; cv=none; b=lH85nyCXaTxLle26u0QET1qQU+FgcGnjUeoiTkt7eDGkr1Gu+RoY0POj0+oWIdo7aX9OZXJz6sglcOvPKPLRYUiz4dE0vLxCa08DCpA4lsUiWroRSr7iLuso8pc2K3qnLQawfS+EQo+S+fT+t1i/ZBUtyYDOR4YVbOFT+Dn6OPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654562; c=relaxed/simple;
	bh=VwX8jTkGRHN45CR6kBtjZLzI/2h6wx1SMmLlG2uBUJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVXziJxhLMd2N6fGpkPxSgwGVUhPogolVaHiJ9bT474QpVObXK6vAhBGCCr402yLk5DVSXcqpC27PWv8cmsPqAZGGoLPFSiMFhN4yArl7nN2L6XNkugtovXgBz3gHzZyI6UaevJKFeBD52oRkMtQH6htlm1dukZ7rbkxp6zh9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McCtZJxC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso3018737a12.0;
        Sun, 11 Feb 2024 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707654558; x=1708259358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X35ILRBkG0W3UFNYMJqcSJcOeU1woxE6II9pSxpa6zo=;
        b=McCtZJxCH9TD7hrU3vP+hkdq/lj4lILvxcj1DsLalshv++Yor3YTJFdAoK4+1PK4r+
         UCCKZL60xD3XcPQLN8QuClTvSTgMsMOP/KmbSco8OSCv7JxtijxizULGTIM8Ck9yagQ+
         57lAW0GzNqs4OlRL8o7VE+DUnqrRsJbe4p1iHDF8Rw0Lf9pVgZ2P02Kw+jY24bqjhUku
         CmoThea1yoRvU1AQ8i6cjXecA6ewbeZdtymgld3cFnWRoh7t+Sr9bWF85sJHcLeYZsy2
         7qm2AsnViMxRKeCMnpWEJOnVXL2rBeofu6DMb7H8wr0Gnk2wTMQeuAZbj9OWjJWr5wOc
         fvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654558; x=1708259358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X35ILRBkG0W3UFNYMJqcSJcOeU1woxE6II9pSxpa6zo=;
        b=bbIn1/AQ3l2t44z+ECwnvArowBAhuJFN2wDo5n8NZ7fznB1QTLyxD3qzboKX7hpndu
         fnD6yFz8bpp3tlrruqRGlQrtZrQHDi8v2BI/mhWdo1dh0c/UP5TvTyL/+2HxzuXeTKJb
         qbIVdBHwJRAdkKJwNYoPf8LyvZCgekGowsi4j93cijk3Jxz6WiaibLbMuddERBbEGVYq
         RLbGk0Y/yO5eUtNXVLziRirQUANsytDNR2Shpwmt7iaNCwsvCvWUBAnjVWDn7kqNnO9p
         to0UL0kVhZr0I/GSF0eGnvqxmE+N18bDuzYJlvfh/CTiVjVZF1FRhcnEucxZbOAWdsCl
         CmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQCDCbPLagw34ETEn0fukNWQAdMD3uRgM5sUg93KSIZ6kvj0RsQxe+SFlv9VZJFzCz8yl4sn+WNPZady+drm3ll0n+L0tbAT9gy/rTztptoDH33VNVCFVi6HiGAV6rA8xkI+x9p20DIXrI3H02ZC0gEf+9OjMofAp/P8UYPKfm2kUyLw2jD+0=
X-Gm-Message-State: AOJu0Yyfm/FFyfU8v9jBUDXMED6oycWQDqyMHeXu/o+1eLl2iyayI+WU
	CGdRA8hGnZqFl30HT4d2Ep2BA93L7a0UjSqwlaXOSKyGAFxGQNZnIBTMYRY2o6nWqC0AQH+o7kI
	eXCqgFp8hk2taw3yFePnxibzQ98ZFI+T2YQiuLQ==
X-Google-Smtp-Source: AGHT+IHijx2emtorcDgngiDo0i/V17ZPuizjCZcYAzuuxRkHCFvkuCCJlYtGIve/UVxtNwgrIItMRsx6ltLZT81U1PM=
X-Received: by 2002:a05:6402:1293:b0:55f:f94d:cf76 with SMTP id
 w19-20020a056402129300b0055ff94dcf76mr2604857edv.27.1707654558468; Sun, 11
 Feb 2024 04:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADT+UeAfCTd8c+dHn3mgT=g6Boip=oRPdkODMN_j2KaROcT0AQ@mail.gmail.com>
 <5600b643-0d07-5583-4858-a521676476a5@gmail.com> <CADT+UeBXkHTGdqpMqXPbXj3Dguci1tEJTUYr5xRkT0+G-6hzgg@mail.gmail.com>
In-Reply-To: <CADT+UeBXkHTGdqpMqXPbXj3Dguci1tEJTUYr5xRkT0+G-6hzgg@mail.gmail.com>
From: Biju Das <biju.das.au@gmail.com>
Date: Sun, 11 Feb 2024 12:29:07 +0000
Message-ID: <CADT+UeBAprPpYaxwZB=HFXTOQgmskFX7Y7QMwkftQnKVBFcChQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, claudiu.beznea@tuxon.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Sun, Feb 11, 2024 at 12:13=E2=80=AFPM Biju Das <biju.das.au@gmail.com> w=
rote:
>
> Hi Sergey,
>
> On Sun, Feb 11, 2024 at 9:40=E2=80=AFAM Sergei Shtylyov
> <sergei.shtylyov@gmail.com> wrote:
> >
> > On 2/11/24 11:56 AM, Biju Das wrote:
> >
> > >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>>
> > >>>> Do not apply the RX checksum settings to hardware if the interface=
 is
> > >>>> down.

Gb eth supports both Rx/Tx Checksum

The intention is not to apply any hardware feature while the interface is d=
one.
So please add a generic commit header and description.

Cheers,
Biju

> > >>>> In case runtime PM is enabled, and while the interface is down, th=
e IP
> > >>>> will be in reset mode (as for some platforms disabling the clocks =
will
> > >>>> switch the IP to reset mode, which will lead to losing register
> > >>>> contents) and applying settings in reset mode is not an option.
> > >>>> Instead, cache the RX checksum settings and apply them in ravb_ope=
n()
> > >>>> through ravb_emac_init().
> > >>>> This has been solved by introducing pm_runtime_active() check. The
> > >>>> device runtime PM usage counter has been incremented to avoid
> > >>>> disabling the device clocks while the check is in progress (if any=
).
> > >>>>
> > >>>> Commit prepares for the addition of runtime PM.
> > >>>>
> > >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>
> > >>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > >>
> > >> This will do the same job, without code duplication right?
> > >>
> > >>> static int ravb_set_features(struct net_device *ndev,
> > >>>     netdev_features_t features)
> > >>> {
> > >>> struct ravb_private *priv =3D netdev_priv(ndev);
> > >>> struct device *dev =3D &priv->pdev->dev;
> > >>> const struct ravb_hw_info *info =3D priv->info;
> > >>>
> > >>> pm_runtime_get_noresume(dev);
> > >>> if (!pm_runtime_active(dev)) {
> > >>> pm_runtime_put_noidle(dev);
> > >>> ndev->features =3D features;
> > >>> return 0;
> > >>> }
> > >>>
> > >>> return info->set_feature(ndev, features);
> > >
> > >> We now leak the device reference by not calling pm_runtime_put_noidl=
e()
> > >> after this statement...
> > >
> > > Oops. So this leak  can be fixed like [1]
> > >
> > >>  The approach seems sane though -- Claudiu, please consider followin=
g it.
> > >
> > > [1]
> > > static int ravb_set_features(struct net_device *ndev,
> > >     netdev_features_t features)
> > > {
> > > struct ravb_private *priv =3D netdev_priv(ndev);
> > > const struct ravb_hw_info *info =3D priv->info;
> > > struct device *dev =3D &priv->pdev->dev;
> > > bool pm_active;
> > >
> > > pm_runtime_get_noresume(dev);
> > > pm_active =3D pm_runtime_active(dev);
> > > pm_runtime_put_noidle(dev);
> >
> >    There is no point dropping the RPM reference before we access
> > the regs...
>
> I don't think there is an issue in accessing register by the usage of
> below API's
>
> pm_runtime_get_noresume:--- Bump up runtime PM usage counter of a device.
> pm_runtime_active:--- Check whether or not a device is runtime-active.
> pm_runtime_put_noidle:--Drop runtime PM usage counter of a device.
>
> Cheers,
> Biju

