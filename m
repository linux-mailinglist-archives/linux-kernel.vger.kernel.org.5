Return-Path: <linux-kernel+bounces-44086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A743841D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1A1F249D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45A5477C;
	Tue, 30 Jan 2024 08:05:22 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACEE54FA9;
	Tue, 30 Jan 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601921; cv=none; b=LcVieBIa43nY2YRHtDlv5sMbEefFwiZi0QpEBInE4+yTjs+ewvuCcIuorOb5UoU/oS8Fikot8/0HTNrC01JyV6vD/Pq0F8JZmTrwFxaqkjHYzgFnBGdiFPhWIrvLvO9cuLjONDbgOw2YXkqO/cH3GuZ87Kew0bj2YpFvBltP65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601921; c=relaxed/simple;
	bh=v35Nb17IxnLBqjE0Q360VOmx1We6fXnnoq/2yVY6DXs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HG9QMXYe9tYHwT01LfOvg2UuBXZWM11rusL4HOjeDqjI8clb/cx5Rzbwx3QIgUwMNmEsSRrzAA/jdYwiAZ6dGbW2j+aOXjQyc77eJ8OOgLOVglWd33UwfGK2VTwLLq2zU1zGO2CY6kTkYKtOi7Ilw+aNXg4FVGxeHyXGbrUK9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
References: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com>
 <20240129104954.1778339-1-geert@linux-m68k.org>
 <8ea40b3-adde-acb5-5e46-fe1fd395daf@linux-m68k.org>
 <56b9c222-4e97-4eda-89af-3e0d0c39acb2@roeck-us.net>
 <90cd0f1a-29c0-4c6f-9efd-92b69da194c0@gmx.de>
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: Helge Deller <deller@gmx.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, intel-xe@lists.freedesktop.org,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Build regressions/improvements in v6.8-rc2
Date: Tue, 30 Jan 2024 08:02:45 +0000
Organization: Gentoo
In-reply-to: <90cd0f1a-29c0-4c6f-9efd-92b69da194c0@gmx.de>
Message-ID: <87plxj8cwb.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Helge Deller <deller@gmx.de> writes:

> On 1/29/24 15:58, Guenter Roeck wrote:
>> On 1/29/24 03:06, Geert Uytterhoeven wrote:
>> [ ... ]
>>> parisc-gcc1[23]/parisc-{allmod,def}config
>>>
>>> =C2=A0=C2=A0 + /kisskb/src/drivers/hwmon/pc87360.c: error: writing 1 by=
te into a region of size 0 [-Werror=3Dstringop-overflow=3D]:=C2=A0 =3D> 383=
:51
>>>
>>
>> The "fix" for this problem would be similar to commit 4265eb062a73 ("hwm=
on: (pc87360)
>> Bounds check data->innr usage"). The change would be something like
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 for (i =3D 0; i < data->tempnr; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 for (i =3D 0; i < min(data->tempnr, ARRAY_SIZE(data->temp_m=
ax)); i++) {
>>
>> but that would be purely random because the loop accesses several arrays
>> indexed with i, and tempnr is never >=3D ARRAY_SIZE(data->temp_max).
>> I kind of resist making such changes to the code just because the compil=
er
>> is clueless.
>
> I agree with your analysis.
> But I'm wondering why this warning just seem to appear on parisc.
> I would expect gcc on other platforms to complain as well ?!?

-Wstringop-overflow and -Wstringop-truncation are known noisy warnings
because they're implemented in GCC's "middle-end". Whether or not they
fire depends on other optimisations.

See also https://lore.kernel.org/linux-hardening/CAHk-=3DwjG4jdE19-vWWhAX3B=
yfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com/.

>
> Helge
>
>> Are we sprinkling the kernel code with code like this to make the compil=
er happy ?
>>
>> Guenter
>>
>>

thanks,
sam

