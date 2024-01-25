Return-Path: <linux-kernel+bounces-38193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECB83BC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD42B210DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AC1B95F;
	Thu, 25 Jan 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MT2saab9"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986851B958
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172605; cv=none; b=IaiP6FKFJxSYPK69Xp23mi8tgMUYHdDTElH9XJXoRxS2B6AEwAxGLlxnKw7QLn6qyW+n5WDPL03HyZNlZ/hW6fAdF/hc29sFsYRm3f+cSpo17T5VjO8Ur+JpkfyccMbS6nTLvDWIMhoFvA1327G9p480gKeqp9eFHI6M4rZldRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172605; c=relaxed/simple;
	bh=p4BO9u8QAGeKIOwzK1sY9h5zf9JQT29Y2W8Ay3uMVC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILtVe5bn0YiV2BMvxRJ5dd37bH57S5cxdJ5ysUTT+yQpjJDpHbPfgIsn4ctTOxH4Msy4XdqRNG05Yz+GM/GRpzT+7+3MoIFqp73Bvyuz82dbTEwm+lp+iMtUJod2pRZvNqCAKgirC6ntQpupcav7M56XWW+34GRdvdqs3c1tk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MT2saab9; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46b165745deso120300137.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706172602; x=1706777402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKffEL6mluctf+cUpjZAVkFUNhs9adzeOY5iA4Fn/I=;
        b=MT2saab9IBoZTjEHtNwc+e3YAPImc+zomcBLT/Z0pgH9BWa8k/Hb3AxWLmjFlJmAGT
         0TLiAuz0cPtnWzo4FyiWFDmHTBgagE6Ar9gaRxXI5sLXHPsZwZjiQ+QAIVlUqw88A4zI
         QiMYBUPEEUP/KvRZYyIiAHUBXROiew+YB8vdnk5TA5YYICwHD7VCTYa8+cjbpK15BI+9
         3r5GF8ai4OFseoskISp+36eNNwCVkr94epn5aau6RwKksvVBcO3LpoSKvPWgKvGMS2oT
         E7lKks4Ma/PHKXBq4aymMCF0aAKf5VpxspSA3L7duNklPLUuuLe/ztgPSKxUdj99tsQ9
         7aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172602; x=1706777402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsKffEL6mluctf+cUpjZAVkFUNhs9adzeOY5iA4Fn/I=;
        b=ndiaQQtvg4wogVsP1KsmqH83nXRTX79KdkI95Y1aCu+W9MU+i9o6JQzbKYnPNdNvtX
         6Xn7i9/bjV3YyMysVCapp0gwBBFIqlrlSE4jIV677atBta8HlUHLVIWXfNZoWNy2T79S
         ub8wvchWao70mfoqoxf6iuwSoK5DZDp28xJOlUgHoFqs9v1PAgQiZLSExCzknUnEPVhl
         namIMMQZkFdXwRfeUtcA8rpMXG9mZdjR7Wl5KAu/MIwrjBZTHnMRuf/aOWDbqub0jbrD
         SDGOFfwifQEvlrsI0xNxWk5vJTo9XHps6gIixgcaMuu7QqbfJLaksCCH++h817eP5NT8
         XBlg==
X-Gm-Message-State: AOJu0Yz9ZrdX9TL4yD38CaH7WU2WFDxRUJy0vgAhKsMRVfra3dWprWUV
	FQg+6OIb4YKlr6bWJy1Mv1Vh6Z88UWMXIkbW0Gegp66YaWiSkVn1WkHoJNG478lbFfA0LKlRhQY
	ksJHhCpz9qBIOr9a9Duomnx7WJcjrlEumcnSVaQ==
X-Google-Smtp-Source: AGHT+IEXyAabzgXxr3HfBXhvXdKu2rg2zJk9uemqtcciakhWkSZRpFr5cM94Z5De7H+I5E8qdr6SFsVNIxfIMEQUhDg=
X-Received: by 2002:a67:f752:0:b0:46a:fae3:d82c with SMTP id
 w18-20020a67f752000000b0046afae3d82cmr366729vso.22.1706172602526; Thu, 25 Jan
 2024 00:50:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
 <20240124074527.48869-5-krzysztof.kozlowski@linaro.org> <cc9683c9-356c-4cd1-a838-4ca92ded612b@linaro.org>
In-Reply-To: <cc9683c9-356c-4cd1-a838-4ca92ded612b@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 09:49:51 +0100
Message-ID: <CAMRc=MexZidVUf=0gHcXTUOxbSAtdDLZ2gBk6-2man1CSv18gQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:02=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/01/2024 08:45, Krzysztof Kozlowski wrote:
> > Devices sharing a reset GPIO could use the reset framework for
> > coordinated handling of that shared GPIO line.  We have several cases o=
f
> > such needs, at least for Devicetree-based platforms.
> >
> > If Devicetree-based device requests a reset line, while "resets"
> > Devicetree property is missing but there is a "reset-gpios" one,
> > instantiate a new "reset-gpio" platform device which will handle such
> > reset line.  This allows seamless handling of such shared reset-gpios
> > without need of changing Devicetree binding [1].
> >
> > To avoid creating multiple "reset-gpio" platform devices, store the
> > Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> > linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> > controller, GPIO number and GPIO flags) is used to check if reset
> > controller for given GPIO was already registered.
> >
> > If two devices have conflicting "reset-gpios" property, e.g. with
> > different ACTIVE_xxx flags, this would allow to spawn two separate
> > "reset-gpio" devices, where the second would fail probing on busy GPIO
> > request.
> >
> > Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ =
[1]
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > Cc: Sean Anderson <sean.anderson@seco.com>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Depends on previous of change.
> > ---
> >  drivers/reset/core.c             | 215 +++++++++++++++++++++++++++++--
> >  include/linux/reset-controller.h |   4 +
> >  2 files changed, 206 insertions(+), 13 deletions(-)
> >
>
> LKP reported issue when building !GPIOLIB:
> https://lore.kernel.org/oe-kbuild-all/202401250958.YksQmnWj-lkp@intel.com=
/
>
> but I intend to solve it providing the stubs. Therefore this patch will
> not change.
>
> Best regards,
> Krzysztof
>

Ah, so this is why you sent the patches. I don't like stubs in
gpio/driver.h but I get why they're needed here. Maybe we should
consider adding gpio/misc.h for that kind of stuff.

Bart

