Return-Path: <linux-kernel+bounces-91458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6DF8711C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901501F22E39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3A4A1B;
	Tue,  5 Mar 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iJv1f3GZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9547F;
	Tue,  5 Mar 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598966; cv=none; b=DW0WmxI5Tnvhyb/pp5PL4REhEo5gVy8PbALZysxEkwMKwRRsTejCABYOqGp3BWDg9EH/DgbX2lTsgoAjRig9elma6nt6+z91OnA9jJZOofF8JoPosg7Tnwstsb8OqgLLPqSePcd6uq0z5C2UyzG7QDmLxyOz7GcbrrOR9qwXCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598966; c=relaxed/simple;
	bh=UwML5y2vhoh9QVMv6PqKer0cXI4igOD78GFrAVLk9MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkDO52VMvgrtEo/335SEETJu9gg87j7Zdl0jlWM5g16++jxTYWwBgQYp9Zm84fJbQyfzCixM9AhSZkmtqJn6A4JI381Dxu334p9S2GphE/SxDWB1ooFiwf6twDEUVRi4DBeQd7vytA+KdlxerAulQydUoDnablBdSVqfPGd7tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=iJv1f3GZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709598961;
	bh=UwML5y2vhoh9QVMv6PqKer0cXI4igOD78GFrAVLk9MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iJv1f3GZr/p7GDoeFB+pZsZ364q4CQlAYiYSxfEmvNfLB4Gw87GIqIHKh1R2F30M4
	 sqrsDwyT4MupBNrTX8NAR3sFWHtL5Epk3gpkrUCFmPyzkYJA9CmJTksaa6beXbKS3z
	 Fl+DMzFLxQvFY2e4YJiMAhvd+ktC1IRpxKDv7kEz8tGIEwnKgLAAQHe3p7I0EhVFJZ
	 oArdiEhn/cJgn1NJA80cXbRqq45qv46aRzQXIQnig00yVq0uN25Mi/tRTdRAQCu59f
	 KzabnInMntq+4BH18bdbKU2zMH2CdW9MFl+FZgYR5PKhEcqZ4eDGbpzjoxi22F/urg
	 YvK4SFNifvE2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tpc743tdBz4wc7;
	Tue,  5 Mar 2024 11:36:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jani Nikula <jani.nikula@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Helge
 Deller <deller@gmx.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lkft-triage@lists.linaro.org"
 <lkft-triage@lists.linaro.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
In-Reply-To: <e5a0e44d-d2b9-49f0-9a08-fb7d9254266c@csgroup.eu>
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com>
 <eed9bb0f-486f-47f3-b4b5-c07adda4a1c7@suse.de>
 <e5a0e44d-d2b9-49f0-9a08-fb7d9254266c@csgroup.eu>
Date: Tue, 05 Mar 2024 11:36:00 +1100
Message-ID: <87frx5plan.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 04/03/2024 =C3=A0 11:32, Thomas Zimmermann a =C3=A9crit=C2=A0:
>> Hi
>>=20
>> Am 04.03.24 um 10:55 schrieb Jani Nikula:
>>> Removal of the backlight include from fb.h uncovered an implicit
>>> dependency in powerpc asm/backlight.h. Add the explicit include.
>>>
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Closes:=20
>>> https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU7=
5YiueA@mail.gmail.com
>>> Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in=20
>>> header")
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Helge Deller <deller@gmx.de>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>>
>>> ---
>>>
>>> Not even compile tested!
>>=20
>> That's one of the cases that's hard to catch unless you get the config=20
>> right.
>>=20
>>> ---
>>> =C2=A0 arch/powerpc/include/asm/backlight.h | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/backlight.h=20
>>> b/arch/powerpc/include/asm/backlight.h
>>> index 1b5eab62ed04..275d5bb9aa04 100644
>>> --- a/arch/powerpc/include/asm/backlight.h
>>> +++ b/arch/powerpc/include/asm/backlight.h
>>> @@ -10,6 +10,7 @@
>>> =C2=A0 #define __ASM_POWERPC_BACKLIGHT_H
>>> =C2=A0 #ifdef __KERNEL__
>>> +#include <linux/backlight.h>
>>=20
>> Thanks, but I think this should go directly into chipsfb.c. I would have=
=20
>> provided a patch already, if our mail server didn't have issues this=20
>> morning. Let me try again.
>
> asm/backlight.h needs it for struct backlight_device
>
> At least if you don't want to include linux/backlight.h in=20
> asm/backlight.h, then you need a forward declaration of struct=20
> backlight_device;

It's preferable for asm headers not to include linux headers (to avoid
loops), so a forward declaration would be better IMHO.

cheers

