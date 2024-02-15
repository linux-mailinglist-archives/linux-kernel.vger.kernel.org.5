Return-Path: <linux-kernel+bounces-67453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0E856BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78679B239C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003E1386B5;
	Thu, 15 Feb 2024 17:56:36 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBA1369AC;
	Thu, 15 Feb 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019796; cv=none; b=X1/h3xgy8acEN2N4sMoh6ZHt9DaJW/z4Mq5ScUlrJ0SPz9ssHWpVQofa9LwsJBTzEeO0BODeIzKj+6r6I9UbUnHsBLdwDRf058sB6LO4ALyPlmFMpEfZy2myCx14mQWLj+bOLMWR3kLO2u/+gpA0UtaQmoPdTrMw40XoFNPY77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019796; c=relaxed/simple;
	bh=TuF1KEybph6ylUIliKE2DQ1QggXNi9SZIZBAKqc+ogY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbGmiVmSfKw/FeOI0EU4038pTXzTb/fAVnsAbcBVpol8WAT1GYDTBGInh0eK9DIlZ2N1Flcz9JuDUUMcEM4QGJGtgy/HVWR1xpT37So7g/y3QJRWs3RhfcjsIBQnSjBoOIJOq7FssDWIrpbCW4egmZLFzrtVt0bqfkAw7BZQe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59cbf204d52so124678eaf.1;
        Thu, 15 Feb 2024 09:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019793; x=1708624593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ8FCvjBSwO1+PySvFl38tJc1e3pyzew41E1PYnJ2OE=;
        b=k/XVB4JVQ5nVgiRu04Ch+3xnfAr40iXerPaJs6qH+YvTpAreOgQkHUFYkhuDnoBGdS
         deB3PvpNCu8o2whsSFpuLkFNGAz0UFVVLvM++uPx0kLDs/Nh7lxzGg62fFOSY0P87JyV
         hlQzIIKjN1rB9PKhAlnVFG+puvlIL2jIPpqSHUC9slsU4eJSNWBzU9shFt3dN++chWCA
         pxR/4HPjKZ+zDKr6Jq0wMPYe/Y2OOa+izSe3tHlAIe0y6HWUoyaerbrwq+jpU3ZR7K30
         tw1pSBxe3qS6wN8W+04gfvBA18s7e2r8gze/ucp6V9EnMx2Qrd2dbeSlDq01j1Ph5v1G
         TBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0IyIGbWNlLPZgsN887Tyy1RIZgp0mC2WJhHVDj5nr6TTACwVIK43qU3AG/7BmP9D7kaaI+LpTJowGAcnZYLwmjq0YY3IQJE2RQVjqgFtpwlNLhbiVPg5sI+KMXTummi/qtq5phflbmh8n2SqXd7uQ+iThh01QqZD0M3Rx2ZajA/NznqI=
X-Gm-Message-State: AOJu0YxXGW2DhNILXXINNlw0+MV1G7NdPFtN+GMzaxJnPey/2PhB2q9n
	ydfN1otBFTVD96QD6HOMKypzymNlYEGn9oS4CHEUktGGStP5rM/LcjcBpFnbJo4yHnxkKm7uD0P
	kQljmRkp6Mnj3zw/n2kXjhFkMNXY=
X-Google-Smtp-Source: AGHT+IH/vNu6c059P8zO30xGLCar/Psr/gbqRAJZY8XQC76s0ZF1GUieq2Cmd3doYtNrBJCuQcncnK+ZAl1Cf2RqLFs=
X-Received: by 2002:a4a:d5d8:0:b0:59c:d8cd:ecee with SMTP id
 a24-20020a4ad5d8000000b0059cd8cdeceemr2196209oot.1.1708019793504; Thu, 15 Feb
 2024 09:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher>
In-Reply-To: <6017196.lOV4Wx5bFT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 18:56:21 +0100
Message-ID: <CAJZ5v0jNNYmmiVHgMpTb7nqCty9Pw6zn3+ydNHEdHJBCZJCJ4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] thermal: Writable trip points handling rework
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:44=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This is an update of
>
> https://lore.kernel.org/linux-pm/3232442.5fSG56mABF@kreacher/
>
> fixing a few bugs and renaming the new trip point flags introduced by it.
>
> The original description of the patch series is still applicable:
>
> "The purpose of this patch series is to allow thermal zone creators
>  to specify which properties (temperature or hysteresis) of which
>  trip points can be set from user space via sysfs on a per-trip basis
>  instead of passing writable trips masks to the thermal zone registration
>  function which is both cumbersome and error prone and it doesn't even
>  allow to request different treatment of different trip properties.
>
>  The writable trip masks used today only affect trip temperatures (that i=
s, if
>  a trip point is in a writable trips mask, its temperature can be set via
>  sysfs) and they only take effect if the CONFIG_THERMAL_WRITABLE_TRIPS ke=
rnel
>  configuration option is set, which appears to be assumed by at least som=
e
>  of the drivers using writable trips masks.  Some other drivers using the=
m
>  simply select CONFIG_THERMAL_WRITABLE_TRIPS which pretty much defeats it=
s
>  purpose (and imx even sets this option in its defconfig).
>
>  For this reasons, patch [1/9] removes CONFIG_THERMAL_WRITABLE_TRIPS and =
makes
>  the writable trips masks always work.
>
>  Moreover, trip hysteresis, which is not affected either by the writable =
trips
>  masks or by CONFIG_THERMAL_WRITABLE_TRIPS, can only be set via sysfs if =
the
>  .set_trip_hyst() operation is provided by the given thermal zone, but cu=
rrently
>  this thermal zone operation is used by no one, so effectively trip hyste=
resis
>  cannot be set via sysfs at all.  This is not a problem for the majority =
of
>  drivers that want trip temperatures to be set via sysfs, because they al=
so
>  don't want trip hysteresis to be changed for any trips (at least as far =
as I
>  can say), but there are use cases in which it is desirable to be able to
>  update trip hysteresis as well as trip temperature (for example see
>  https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quic=
inc.com/).
>  Those use cases are not addressed here directly, but after this series
>  addressing them should be relatively straightforward.
>
>  Namely, patch [2/9] adds flags to struct thermal_trip and defines two of=
 them
>  to indicate whether or not setting the temperature or hysteresis of the =
given
>  trip via sysfs is allowed.  If a writable trips mask is passed to
>  thermal_zone_device_register_with_trips(), is it is used to set the
>  "writable temperature" flag for the trips covered by it and that flag is
>  then consulted by the thermal sysfs code.  The "writable hysteresis" tri=
p
>  flag is also taken into account by the thermal sysfs code, but it is not=
 set
>  automatically in any case.
>
>  Patch [3/9] is based on the observation that the .set_trip_hyst() therma=
l zone
>  operation is never used - it simply drops that callback from struct
>  thermal_zone_device_ops and adjusts the code checking its presence.
>
>  Patches [4-8/9] update drivers using writable trips masks to set the new
>  "writable temperature" flag directly instead and some of them are simpli=
fied
>  a bit as a result.  After these patches, all of the callers of
>  thermal_zone_device_register_with_trips() pass a zero writable trips mas=
k
>  to it, so patch [9/9] drops that mask from the functions argument list a=
nd
>  adjusts all of its callers accordingly.
>
>  After all of the changes in this series, allowing the hysteresis value t=
o be
>  set via sysfs for a given trip is a matter of setting its "writable
>  hysteresis" flag (and analogously for trip temperature)."

By the lack of comments I gather that this series is not controversial.

It unlocks further development and it should be run through linux-next
for a couple of weeks before the merge window, so reviews are welcome.

Thanks!

