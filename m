Return-Path: <linux-kernel+bounces-168047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C908BB300
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBAB20B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E4158877;
	Fri,  3 May 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iK2UPsdU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A91586D2;
	Fri,  3 May 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760683; cv=none; b=gqKeEKi+VlO96ydKAZ8CyAYY08CT/qG6bGIN9oV6A9OUuASkvxEWjWXfhWO3thmD6ymxi7Y5o9/9ZwX7q1580ncV01X7hkrCxs2Q4vKsBJ6NI8ITn4XHm/6s0mXD4CdQ8pBhj0RUfAgpaeCMxp6psNHx9E2Q98gQogBj0sudLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760683; c=relaxed/simple;
	bh=nHVU+u9gtwqSD7LqYNk6t0SbgUJNB+nI7WkfNcanCyA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ju8HGjWUhJYJOugNTGd7vLprFts0ly3e49Yl3eEz7LVSEfdQkWzaalQ72LS6o6zC0qk+pk8wdXwY6qmvxE7tmiVdq/wN/OOWJNFBfHSa+0NVRCZL4S/gD3DUyQdzQBv/1X56QClnTTUnuIoGwbk3b4/990krrLWr15hRkTY6cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iK2UPsdU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714760672;
	bh=nHVU+u9gtwqSD7LqYNk6t0SbgUJNB+nI7WkfNcanCyA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iK2UPsdUeDGgzYC4aPzbt3fpyn39PM/C+qWPGYU+6SkJksSUvzq8USxZ/VRBzGQJF
	 rG/hzFUiInQOW7DXDPAJyyJ/fHeLzyPugOLmFhxWPvLiLkykEV2kM+PJvZmlnR4r1j
	 xwOrmZOoFQ0JfgOiMHK//Qr/P5C5LPyeAvnOPiBk=
Date: Fri, 3 May 2024 20:24:24 +0200 (GMT+02:00)
From: linux@weissschuh.net
To: Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Alexander Popov <alex.popov@linux.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Message-ID: <266bd6e1-d444-43f5-a98f-c7069819029b@weissschuh.net>
In-Reply-To: <202405031054.9FFA75B@keescook>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net> <202405031054.9FFA75B@keescook>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <266bd6e1-d444-43f5-a98f-c7069819029b@weissschuh.net>

May 3, 2024 19:55:37 Kees Cook <keescook@chromium.org>:

> On Fri, May 03, 2024 at 03:44:09PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> Sysctl handlers are not supposed to modify the ctl_table passed to them.
>> Adapt the logic to work with a temporary
>> variable, similar to how it is done in other parts of the kernel.
>>
>> This is also a prerequisite to enforce the immutability of the argument
>> through the callbacks prototy.
>>
>> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack=
 erasing")
>> Cc: stable@vger.kernel.org
>
> I realize I've already Acked, but does this actually need to be CCed
> to stable?

You acked it without the Cc stable.
I shouldn't have kept your Ack, sorry.

Feel free to drop the Cc, it shouldn't be critical.
I suspect the bots will pick it up anyways.

>> Acked-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> This was split out of my sysctl-const-handler series [0].
>>
>> As that series will take some more time, submit the patch on its own,
>> as it is a generic bugfix that is valuable on its own.
>> And I can get it out of my books.
>>
>> Changelog in contrast to the patch in the series:
>> * Reword commit message to remove strong relation to the constification
>> * Cc stable
>>
>> [0] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0be=
ccb836e2@weissschuh.net/
>>
>> Cc: Joel Granados <j.granados@samsung.com>
>> ---
>> kernel/stackleak.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
>> index 34c9d81eea94..b292e5ca0b7d 100644
>> --- a/kernel/stackleak.c
>> +++ b/kernel/stackleak.c
>> @@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *ta=
ble, int write,
>> =C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0 int state =3D !static_branch_unlikely(&stack_erasing_=
bypass);
>> =C2=A0=C2=A0=C2=A0 int prev_state =3D state;
>> +=C2=A0=C2=A0 struct ctl_table tmp =3D *table;
>>
>> -=C2=A0=C2=A0 table->data =3D &state;
>> -=C2=A0=C2=A0 table->maxlen =3D sizeof(int);
>> -=C2=A0=C2=A0 ret =3D proc_dointvec_minmax(table, write, buffer, lenp, p=
pos);
>> +=C2=A0=C2=A0 tmp.data =3D &state;
>> +=C2=A0=C2=A0 tmp.maxlen =3D sizeof(int);
>> +=C2=A0=C2=A0 ret =3D proc_dointvec_minmax(&tmp, write, buffer, lenp, pp=
os);
>> =C2=A0=C2=A0=C2=A0 state =3D !!state;
>> =C2=A0=C2=A0=C2=A0 if (ret || !write || state =3D=3D prev_state)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>
> I can pick this up; thanks!

Thanks!

