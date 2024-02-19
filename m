Return-Path: <linux-kernel+bounces-71685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683985A902
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5256B281FED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BCF3FB14;
	Mon, 19 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2MMEgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84493F8F5;
	Mon, 19 Feb 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360490; cv=none; b=Kc1MLRL7fst8YN3iEwqV0//N6IFRBdxbaNjt5E1uum6PHnoV7ojk3xFKs/raIRkMhzQqMP0Wg+wOvNJm1QHkPEa7hw75n1ApNtZjUKgJjPol81jojlAnjyqeHjz3g6/ylrZN4cqFKpBz0Y91foJfiF57wkxzbZ3a5cp/qZOsa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360490; c=relaxed/simple;
	bh=jV0rIp63KGyH+KzU4vplZ8yKIQsIcNqUJwkrA3PnXHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ofytJLNBtHgtlJOUqDYRfhRSuMQLFv0frF5pAAXjOtkEVsZ2SfCpGhe5ZgDrIYtzL5bsn1Z9MLV1/mdn6QhvV5tuK7EOuq4unweJSh8mml+YOnQPUTIxIZNAO4m/Ahe8/vSO4U1dSw4z2c8snKSy+At7yqsPB2dwZUBmMCXpQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2MMEgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B49C433F1;
	Mon, 19 Feb 2024 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708360489;
	bh=jV0rIp63KGyH+KzU4vplZ8yKIQsIcNqUJwkrA3PnXHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PM2MMEgbwGFGtAmfrBcuYO0k1CQvBTa8tJMoiRJSRc3cWBrqB/vMl2i1lLu/ZNyti
	 m69ufJpbuM88GBTJ6PUOJg7xVYMTZuzYr/9hxhoGPKG4GfpoGpPPG+xOrXEbLwFLBS
	 7oO99JkfZDSz+lOAQFxbQ59WFRDDNZvVt4IE0WyDoWebZ+sQvUtvHh4VujeiQ66x9a
	 WaQ11vCUlbiIeCEQf266aNaM9E3tjdOBE3EJAN3WB2xQix4XS9GXddgf8aZUfdvEOp
	 3HEvi5UJwmYAPCwiXPo5q/vAtDc7ynTGkz8yPyz8+UIyUcTxMyk8U3F/xe1BiMGETD
	 H90XPFjAYgkXA==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  Claudiu Beznea <claudiu.beznea@tuxon.dev>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] wifi: wilc1000: fix RCU usage
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
	<87h6i4mnoj.fsf@kernel.org>
	<b3c31f4c-e837-47b6-bd0d-e8cf2b9964aa@bootlin.com>
Date: Mon, 19 Feb 2024 18:34:46 +0200
In-Reply-To: <b3c31f4c-e837-47b6-bd0d-e8cf2b9964aa@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Mon, 19 Feb 2024 17:24:55 +0100")
Message-ID: <87cyssmmzd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> On 2/19/24 17:19, Kalle Valo wrote:
>
>> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:
>>=20
>>> This small series aims to fix multiple warnings observed when enabling
>>> CONFIG_PROVE_RCU_LIST:
>>> - add missing locks to create corresponding critical read sections
>>> - fix mix between RCU and SRCU API usage
>>>
>>> While at it, since SRCU API is already in use in the driver, any fix do=
ne
>>> on RCU usage was also done with the SRCU variant of RCU API. I do not
>>> really get why we are using SRCU in this driver instead of classic RCU,=
 as
>>> it seems to be done in any other wireless driver.
>>=20
>> And even more so, no other driver in drivers/net use SRCU.
>>=20
>>> My understanding is that primary SRCU use case is for compatibility
>>> with realtime kernel, which needs to be preemptible everywhere. Has
>>> the driver been really developped with this constraint in mind ? If
>>> you have more details about this, feel free to educate me.
>>=20
>> Alexis, if you have the time I recommend submitting a patchset
>> converting wilc1000 to use classic RCU. At least I have a hard time
>> understanding why SRCU is needed, especially after seeing the warning
>> you found.
>
> If nobody else comes in with a strong argument in favor of keeping
> SRCU

And emphasis on the word "strong"...

> yes I can certainly add that to my backlog :)

Thanks! Your wilc1000 backlog is getting long, I hope your todo software
won't overload ;)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

