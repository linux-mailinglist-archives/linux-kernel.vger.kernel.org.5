Return-Path: <linux-kernel+bounces-86613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810786C7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56C11F21EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14137AE64;
	Thu, 29 Feb 2024 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj6At6cf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAA79DA7;
	Thu, 29 Feb 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205205; cv=none; b=EcaGJCd5JFYnpbU2C/f7f5mgW/pv7UkXfZWHjNI15e0KEgy4K36rTMpJWPFAcFJ/Jcth3sZg4elp35iYQyfIBlD/zDMzcDK0VPnUj5Svvv7jTgswoCCDMSpq2Mc755uKAPsyjrf9KsjIIilVp74fwHLT5OhcEVpSL62O82Je3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205205; c=relaxed/simple;
	bh=tESE2uXWtNJjeFHiSZN1kcOSsqh4sJow2lyAlnZ7PI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De+wnAG4KQVf5yXnSL3FOvV4D1C1ym2rG2uf+xlRbEOWzFYVSZsQWyo+11/ULdGt7DwnuGzMTHAtztJq5rIloGQwzBdUWzdrI1Ad8dwV45uV3OI8/ucYFt0JilKoQz9xAkq0aBuyH5YH1VC6uEGa+vrYe1Kw8B4k3sR1nrcgYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj6At6cf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so1088061a12.0;
        Thu, 29 Feb 2024 03:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205201; x=1709810001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnSgVErG3C6LPPMUhP6RgtRC5A2WM/87OBgi1hi3swM=;
        b=Cj6At6cfXt6AO8y4GnUB0KJnpzb0S/zlpr6QUEsfwevTHjAihkQcVmuzJ8PwQ+9v7U
         qFS7Je0iJSfe53u9D2QrlkaNsg7eYGACYOcUwMTwOB6XaPDFcU57tzhRXyIW/rldjtvM
         tY2YfSVAru3WcHKJI8KBvKtCi47TnYto9dK2um0SWkZUxw3WM361HiCXPcV1MZDw7rbh
         NFRFG4Ylc5xjQ+kXweS+gPg/E0NmLevuBWyeOJxUu5wZp28dajqNZ/UA/XLIWNAaY/qJ
         5xTppq28WZ6d954+zn8YKVhAE1UK3F5zV8YKF0xSKDNAnJYfqR+ON4ivHX0OkS4u2eR3
         yQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205201; x=1709810001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnSgVErG3C6LPPMUhP6RgtRC5A2WM/87OBgi1hi3swM=;
        b=bJbn76fTLIl+sDIsETs48mBiaIzAaiQKLqiU/uvtoCnIZbeabaHiF8R5UCM8rhLvuA
         0j9AZOMV/dmsRTKUf5koBqKxSX2umlLR9cYnqSujBG6lG9zR4oXTsPxCIuGulSSbUKNX
         YTmwWsu12rThUb9yLd4yOH3t6aTmdseMI9nOi3n5fCstBv3+c2i0+1IpLLkQ8ounr0jn
         TQRYZjXuHZPvC2O1wTbKG5ZsBNZkKaAvm8oSW4uDYn7F8TgoRvPShbHJkNQ2dyOTBc0R
         PeYpSJHSJdITj/GZVOH/S2/IUWWvBquP9OLcCk9f9WzYpOrK/aSPCFOeMQwpQgkYjrTf
         FFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42oKis/Erd/u+4MNRCKghP0dsVGCJmefjZU904mUEWwx0OEDStOZtbcFlGu3aoz+20ZGtmuocY6wMfE8GWEmA4tyFHZMMwsK7hpadqBdZn74qFkEG6GAj0LtKZtpt/qFdE1o/W+PNamMlp4+zvXKdGzB2mwQF/rBbKXiaP/u8LQ==
X-Gm-Message-State: AOJu0Yw6P7KrYEEAkQHXt/UzH/kSzE9bOsW+WZN44LxcVzzeWKL78tOL
	lQWOdao6Y9Bd+NWP4FsHCi9mSPZzRZV+lgAlvzIt7v1bjnnRV2a4
X-Google-Smtp-Source: AGHT+IHsYNfgSPM5XXvhnUiqjTKq9KDIMjCSWidpB0EUay+82St1bPtNDwZW8w8vtfoPEC6UaeIdow==
X-Received: by 2002:a05:6402:26d3:b0:566:6e4e:cb8c with SMTP id x19-20020a05640226d300b005666e4ecb8cmr1598521edd.38.1709205201407;
        Thu, 29 Feb 2024 03:13:21 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id c28-20020a50d65c000000b00565a9c11987sm532379edj.76.2024.02.29.03.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:13:20 -0800 (PST)
Message-ID: <9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 12:16:44 +0100
In-Reply-To: <20240229105204.720717-2-herve.codina@bootlin.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Just copy pasting my previous comments :)

On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
>=20
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
>=20
> For instance, in the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
>=20
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
>=20
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++++++++++++-=
--
> =C2=A0include/linux/device.h |=C2=A0 1 +
> =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d5f4e4aac09b..80d9430856a8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> =C2=A0static bool fw_devlink_drv_reg_done;
> =C2=A0static bool fw_devlink_best_effort;
> +static struct workqueue_struct *device_link_wq;
> =C2=A0
> =C2=A0/**
> =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
> =C2=A0	/*
> =C2=A0	 * It may take a while to complete this work because of the SRCU
> =C2=A0	 * synchronization in device_link_release_fn() and if the consumer=
 or
> -	 * supplier devices get deleted when it runs, so put it into the
> "long"
> -	 * workqueue.
> +	 * supplier devices get deleted when it runs, so put it into the
> +	 * dedicated workqueue.
> =C2=A0	 */
> -	queue_work(system_long_wq, &link->rm_work);
> +	queue_work(device_link_wq, &link->rm_work);
> =C2=A0}
> =C2=A0
> +/**
> + * device_link_wait_removal - Wait for ongoing devlink removal jobs to
> terminate
> + */
> +void device_link_wait_removal(void)
> +{
> +	/*
> +	 * devlink removal jobs are queued in the dedicated work queue.
> +	 * To be sure that all removal jobs are terminated, ensure that any
> +	 * scheduled work has run to completion.
> +	 */
> +	drain_workqueue(device_link_wq);
> +}

I'm still not convinced we can have a recursive call into devlinks removal =
so I
do think flush_workqueue() is enough. I will defer to Saravana though...

> +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> +
> =C2=A0static struct class devlink_class =3D {
> =C2=A0	.name =3D "devlink",
> =C2=A0	.dev_groups =3D devlink_groups,
> @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> =C2=A0	sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
> =C2=A0	if (!sysfs_dev_char_kobj)
> =C2=A0		goto char_kobj_err;
> +	device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> +	if (!device_link_wq)
> +		goto wq_err;
>=20

I still think this makes more sense in devlink_class_init() as this really
device link specific. Moreover, as I said to Saravana, we need to "convince=
"
Rafael about this as he (in my series) did not agreed with erroring out in =
case
we fail to allocate the queue.

Rafael?

- Nuno S=C3=A1



