Return-Path: <linux-kernel+bounces-48708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E170A84600B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9871D293A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D97429F;
	Thu,  1 Feb 2024 18:35:22 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712612FB1E;
	Thu,  1 Feb 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812521; cv=none; b=MNFezmk4IY2l2DCl335SnZXJyEVG+aIGZk3ucxuLM0tRzjZBf1oJ6CA1KDRCXMVarWo2oASqlE8B84tuMSQkrj/a15wf8aQbNjpEfy4ZZ48vdQhcPpzOwZqjw/fz/sb92OHMekoRr3kaiXB9SBwQpenMrgAQRs9O/PSv/BcJA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812521; c=relaxed/simple;
	bh=wVEE4o4YbZnycETZF+nnePTwghfVH/i+QCzGYI/C7Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPuCgYgrfuCm1AKaDX/uz66iBDcDsozszEzcNg+a5fUFrMV/VclNkjmnMgeA9R4CHxMg+F5+ITGk4QpP5kpW40uzc9TsVtLLvDaZVlFVNrkcFinzoKBpH2eE8Uonseu56KuogKwb60H7XSWznqQBLxhHpkWDxbFzGe1MoAbXEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bc21303a35so355476b6e.0;
        Thu, 01 Feb 2024 10:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812519; x=1707417319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ2QxOAM6wQKlIfCJl9Vqv3s9SEP5nb9j+tik6gXq34=;
        b=k8FBOBkhReTYkq725gZ8UHcXf4YPkoF2oQsMuorjc5+Ta0OVC33pSTumxkm1LrZOTQ
         FgKzCLSUga6j9XF3MUpLsi0LqjOYyUS7GsbGRQIxWH6CHbFnFQ4jPJSus5sPhwsY4DEl
         AlPlaqmxFpB7LF/fCR52QaADkwPlU9mdv30rZlWWD0HbJf3r/vc7HZrKfzBEVkeh9wmn
         NzHHTn9BcsDT3oyj1IsRdBV0MMtDuhpyDkn9hmIl4WfcG3BH17qeCFbkgg+VMYVTnJ2W
         brD7KEjwjgWZXl1COdGjPL9RKVLiwfZnCjzgZc7oBaZgkbIgPW8o7CaWCBAtfw5xQZIR
         gD2Q==
X-Forwarded-Encrypted: i=0; AJvYcCUZug+fTKeu7vYOl5pIygXBSAYzmV/6N0igik4D+Atkw/weimeKBD3dV22XtwpBONhMvRqKAelll6V+oC6GMc2SscgqpamShrM17vdsJWtjgJKzgqbuqzSzc8w3nV9XlFlipnbNA+WrlcWcqiu0QpivRG+hzG+iHXKCpSBA3e2F4O5d593DSRbUwOVB6lR9B/V8hdtey4E/ROBWx/Tcw/6MPTyoeEY8gPE=
X-Gm-Message-State: AOJu0YyI9/uHJxi5NLsy0D6ngYGn5s/mGIe6nS3oB8p/+PNuAA1Q0fQC
	HewcJVH6J09OLf6olvhN8IXhrmujZvomGDIgqYqc8u2ihO1W6LsltFgLSbVhtPEjYoxweni6IpD
	n0GoN8KD6o1+zji6jtyJ4MHqM0oY=
X-Google-Smtp-Source: AGHT+IHl7ZfSyZbTn+BWGDtWxJDfxiYL/7G27PGTV4hoHIkYyvlUdRPgeAmUY/ilFubDbzYjf+gZYDcJUx+rdd1MQuI=
X-Received: by 2002:a05:6870:b6a4:b0:218:d1b7:e8cd with SMTP id
 cy36-20020a056870b6a400b00218d1b7e8cdmr4165119oab.3.1706812518874; Thu, 01
 Feb 2024 10:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 19:35:07 +0100
Message-ID: <CAJZ5v0haFEGOjaMC4a8CZbQe+cxFfaB1hD60NkN297NY2TZB5A@mail.gmail.com>
Subject: Re: [PATCH v1 00/18] Thermal: Part 1 - Introduce new structs and registration
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series is a preparation for a bigger cleanup that will be split in
> three parts in order to avoid immutable branches on multiple subsystems,
> as in other parts of this series there will be changes in:
> - drivers/acpi
> - drivers/platform/x86
> - drivers/power/supply
> - drivers/net/wireless
> - drivers/net/ethernet
>
> This is the first part which adds new structures and starts reorganizing
> struct members around, plus, this migrates all of the thermal drivers
> found in drivers/thermal/ to the new thermal_zone_device_register()
> function, and advertises that the old registration functions are
> deprecated and will be removed.
>
> The reorganization is supposed to be complete (or mostly) but...
>  - struct thermal_zone_platform_params has a temporary name:
>    this is done in order to avoid compile time failures for
>    the drivers outside of drivers/thermal before migrating
>    them to thermal_zone_device_params/thermal_zone_device_register();
>  - struct thermal_zone_params temporarily has two duplicated members,
>    governor_name and no_hwmon;
>
> Part 2 of this topic will migrate all drivers that are external to
> drivers/thermal to thermal_zone_device_register(); I will send that
> part only after part 1 is confirmed to be acceptable, as otherwise
> I'd be spamming people for no reason :-)
>
> After all drivers will be migrated to thermal_zone_device_register(),
> we won't have to care about changing anything outside of drivers/thermal
> to finish this set of cleanups/changes (and no immutable branches needed)
> and this means that...
> Part 3 of this topic will contain the following changes:
>  - thermal_zone_device_register_with_trips() will be removed
>  - thermal_tripless_zone_device_register() will be removed
>  - thermal_zone_params will be renamed to thermal_governor_ipa_params
>    - governor_name, no_hwmon members will be removed
>  - thermal_zone_platform_params will be renamed to thermal_zone_params
>  - Removal of the THERMAL_NAME_LENGTH limitation for `type`
>
> More scheduled changes, which should end up in part 3 (at least that's
> my intention), or eventually entirely after this cleanup topic, include:
>  - Introduction of Thermal Zone names
>  - Disambiguation of TZ name and type
>  - Addition of `thermal-zones`, `thermal-zone-names` parsing for
>    devicetrees

You really should start with this, because that's your goal.

It is quite arguable that it can be achieved without making all of the
changes mentioned above.

>
> ... Summarizing ...
>
> Part 1:
>  - Reorganize structures (some temporary names/leftovers)
>  - New registration function, deprecation of old ones
>  - Migration of drivers/thermal drivers to new registration

I kind of see where this is going, but I don't agree with some of the
changes made.

Let me comment on individual patches (which is not necessarily going
to happen today or even tomorrow, so let me go through the entire
series before deciding what to do next).

Thanks!

