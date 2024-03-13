Return-Path: <linux-kernel+bounces-102524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C449287B34F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AC91C22B72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54D535B7;
	Wed, 13 Mar 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTjQ/DD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DF4E1CE;
	Wed, 13 Mar 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364534; cv=none; b=abQMYrYUig3aGmpuXZzSey75Xn4oD3w87mX8fEkPZKET0r21ScTkMJzZFGkyHNyDY1qrfCKlY7rvbSYS2dXJkfxfVGnpzSDAnXwioISz+TT1093VLWop9ALZKY/GoKQMRHYuORgd3Tb5NehlvNzmUdfxUAGsTBDrxX+JKijn5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364534; c=relaxed/simple;
	bh=yHAWjHhvqpsmBkd0EpSmvltytpSj+yDGYXAeVc4655g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7kkdk8y3O0yu7/FD76+qUrwvKrtnXCQqvsjmLWzJXmoCWHHgUzaWEc/rNo2kO+KFFKjcYfTo4SlYDU+N+euCuWUmGb91YDTqSHgKqtKtrOdL+h4Pj3RdjFrEvDfZDuYKF5gdjHFpZZ6PvZKzbavWdpkfhtDCPbt6gxRbaEwgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTjQ/DD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC101C433C7;
	Wed, 13 Mar 2024 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710364534;
	bh=yHAWjHhvqpsmBkd0EpSmvltytpSj+yDGYXAeVc4655g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fTjQ/DD/ZvdiQ7aDeD+ppLkKKS4/KAHvxnIPXAhOh95DO7D/Gkq1dIHtazi7wTYIy
	 wKh5RtDh/Q4YYd/QhR6jeUvJdYb+LyiBIT/GyV9/wrgrs4eJLI7c1g4letxD4EW9Yc
	 atx3rzQXQHJQmPVdqKhfR+kNiEnIuD2VepKn/mzmNJnRdbuxIAqGgMtJE4HI8EpMWh
	 HgkWzH9oxjFr7KuLwCilYwjLEbOYJv8O4Trn/9UP8d6rDffhANtYrYcqnC/OpoTPLL
	 sl36Xj6rJvZArDS63LGqU71/ptW88tD1vswuZaXvjiYSx+CtMJfDHO+9MkbTFLyk2b
	 JMuPzdm4svErg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  linux-spi@vger.kernel.org,  Mark Brown
 <broonie@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Mika
 Westerberg <mika.westerberg@linux.intel.com>,  "Chia-Lin Kao (AceLan)"
 <acelan.kao@canonical.com>,  open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
In-Reply-To: <493cdb11-72b7-4d03-b982-448451fd5824@broadcom.com> (Florian
	Fainelli's message of "Wed, 13 Mar 2024 13:06:35 -0700")
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
	<CZSSWP7A9UM7.1R20796VHLU0F@kernel.org> <mafs0o7bic7fs.fsf@kernel.org>
	<9420b802-5361-4f47-a069-52c43f5fd253@broadcom.com>
	<mafs0il1qc4n2.fsf@kernel.org>
	<56318d3f-1d5a-4a73-9d3a-e7ebc66860d9@broadcom.com>
	<493cdb11-72b7-4d03-b982-448451fd5824@broadcom.com>
Date: Wed, 13 Mar 2024 22:15:31 +0100
Message-ID: <mafs0bk7hdea4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13 2024, Florian Fainelli wrote:

> On 3/13/24 12:34, Florian Fainelli wrote:
>> On 3/13/24 12:29, Pratyush Yadav wrote:
>>> On Wed, Mar 13 2024, Florian Fainelli wrote:
>>>
>>>> On 3/13/24 11:28, Pratyush Yadav wrote:
>>>>> On Wed, Mar 13 2024, Michael Walle wrote:
>>>>>
>>>>>> On Wed Mar 13, 2024 at 6:10 PM CET, Florian Fainelli wrote:
>>>>>>> After commit cff49d58f57e ("spi: Unify error codes by replacing -EN=
OTSUPP
>>>>>>> with
>>>>>>> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the foll=
owing
>>>>>>> visible in the kernel log:
>>>>>>>
>>>>>>> [=C2=A0=C2=A0=C2=A0 2.196300] brcmstb_qspi f0440920.qspi: using bsp=
i-mspi mode
>>>>>>> [=C2=A0=C2=A0=C2=A0 2.210295] spi-nor: probe of spi1.0 failed with =
error -95
>>>>>>>
>>>>>>> It turns out that the check in spi_mem_exec_op() was changed to che=
ck
>>>>>>> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but=
 this
>>>>>>> means that for drivers that were converted, the second condition is=
 now
>>>>>>> true, and we stop falling through like we used to. Fix the error to
>>>>>>> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
>>>>>>>
>>>>>>> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP=
 with
>>>>>>> -EOPNOTSUPP")
>>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>>> Change-Id: I4159811f6c582c4de2143382473d2000b8755872
>>>>>>
>>>>>> Ha, thank you!
>>>>>>
>>>>>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>>>>>>
>>>>>> FWIW in next, there is commit
>>>>>> e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op()
>>>>>> calls")
>>>>>> that probably will conflict with this one.
>>>>>>
>>>>>> Also, - not for this patch - but with that logic, spi_mem_exec_op()
>>>>>> might return EOPNOTSUPP *or* ENOTSUPP, even for drivers which might
>>>>>> still return ENOTSUPP, because there is one condition in
>>>>>> spi_mem_exec_op() which will always return EOPNOTSUPP. That is
>>>>>> somewhat confusing, no?
>>>>> I agree. I suppose it would be better to do:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOTSUPP || ret =3D=3D=
 -EOPNOTSUPP)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>>>>
>>>>
>>>> But with e63aef9c9121e ("spi: spi-mem: add statistics support to ->exe=
c_op()
>>>> calls") applied, would not that mean duplicating the statistics gather=
ing,
>>>> or
>>>> were the statistics gathering only intended for when ret =3D=3D 0?
>>>
>>> Hmm, I didn't properly understand this. Ignore my suggestion. Your patch
>>> does the right thing.
>> What I meant is that e63aef9c9121e will increment statistics not just wh=
en we
>> return 0 from ctlr->mem_ops->exec_op, but also if we return -ENOTSUPP or
>> -EOPNOTSUPP, and I am=C2=A0 not sure if this is exactly what is intended=
 But this
>> is somewhat orthogonal.

No it won't. This is what confused me in my earlier reply as well. If
ret is either of -ENOTSUPP or -EOPNOTSUPP, the expression

    (ret !=3D -ENOTSUPP && ret !=3D -EOPNOTSUPP)

becomes false (along with !ret also being false). In that case, it will
_not_ go in the if statement, and not call spi_mem_add_op_stats().
Instead, it will go via the normal SPI path and that path would do the
accounting based on error or success.

>
> It looks like the handling of a non-zero return code will fall either in =
the
> -ETIMEDOUT category, or in the general category of an error. I suppose th=
ere is
> a question whether a operation that could not be supported should fall in=
 the
> "error" category.

The only questionable thing I see in spi_mem_add_op_stats() is that it
increments bytes_{rx,tx} even in case of failure. It mimics what
spi_statistics_add_transfer_stats() does but perhaps that also is wrong.

--=20
Regards,
Pratyush Yadav

