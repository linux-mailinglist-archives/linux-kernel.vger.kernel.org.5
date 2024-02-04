Return-Path: <linux-kernel+bounces-51750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E0848EDF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768D1284C2E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE1224F2;
	Sun,  4 Feb 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AQKEizc1"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744E1E503;
	Sun,  4 Feb 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060094; cv=none; b=UOiwn3uVs7RShE8+IAtA9L5SKPkgngml8MEX7EJu+VNvYSjYGJ1JTBqi3EiFTkqQxpCUghBroezeI74Hrllzbb3uLYg733bw/bch7zRQBbHkVHd8Vs2Qr6QMNP18CYKF8SUbudmEx8Q2XrjAYa82ylyNxuTVlfq5uA12W41loWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060094; c=relaxed/simple;
	bh=qEq0hF+Gj60txzWb/+hgTp/WuE8H1Lq9zbgXK7pJOVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkJO1A8kgtPgFfJ7ri+msUhz0+P59NMfyz4P5tedm8p1+KBfwPpwYUm039L9x58QyYPCARcs7V3NUNHn4p9JeUhYCpSWrHt1rzTrXbX0tznhW/wIvBRVF52lsUiRG9NRbmxBp8ay9vRXamxDyYIgvrA4ww4ohRkL2KSEX/O/Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AQKEizc1; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=heusel.eu;
	s=s1-ionos; t=1707060069; x=1707664869; i=christian@heusel.eu;
	bh=qEq0hF+Gj60txzWb/+hgTp/WuE8H1Lq9zbgXK7pJOVs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=AQKEizc1nhOK45EH9TleAAGHfwGEMkVa8Lkn4D4dDAzuCd4YuV3KmEk+quS1SjPV
	 zLmHPpAmNJIKcPp2EaW6NeTwvIgjQ3JBoQrvhocwn2MJvZb6kWx2LyeC+ExqSajBh
	 6PBzWkCG6+vUzihqSvNhVK2rcQ3dwl/zEBO17nTyqnvikstDrXZg9+zJ+c3h9SnA6
	 Ong2AZ7Hb160xEKUSg3jhavO6egc0PgFhcv3cuYnts1rUOKQejTX+ADshMVT6DDaq
	 KQK0PE0yOLPrPOdHej9pEpbrN+neKsIEwFBcaRmVnwrAsZ/zoTYCi6P4mafvpekV/
	 EgJ8sLb/16X9bAaHzw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1McY0J-1qtjaK0Rfp-00d0jc; Sun, 04
 Feb 2024 16:21:09 +0100
Date: Sun, 4 Feb 2024 16:21:06 +0100
From: Christian Heusel <christian@heusel.eu>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
Message-ID: <x5cvyptbvaaadmbbhrza6jb65d5i4djmpqfkdpg7aj2z77jhkz@kofpufdqgm2m>
References: <20240123180818.3994-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y4azmvpmfn76pvnt"
Content-Disposition: inline
In-Reply-To: <20240123180818.3994-1-mario.limonciello@amd.com>
X-Provags-ID: V03:K1:uVLbiXNdFw85cEFv/1AoaWjJFrBzJpd9zuI9LEHS3gJnSdTKC0s
 BP8dWP2+PmdMMl0cQc3FNStqsKNCvZ4CL6Q1IMSAqMIvJ0NRt69pEoIX3CPCoY4mDKWmWFX
 2PK7tNvhn7WUojEaY25fqE1RFeNbV+uEEixq6Qkwg4rnN5VbJLFB7lAdjezDC7oBBsC0fT5
 i+vV4Ju7Ov5lmmy1sCWGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2alwNBgJgvM=;cvnORCtelnKyIcc+TYuaYiQJO7l
 63qzTMMV164/TFIbtsvWTSloWCc/BAGGvX3mi5ei/ylrKOPwHaFJHvU4c+frzzx5FdWkUg7eG
 Mu0G1TzyClk2h+BK+370jyXnZC0gqDvwnTz7o1tBrfySd7xtaEneyia+RAMQf383lVMyrBuSJ
 oWOxJ01EErOfSnXxmN6Bst2S1LchiJwlD6W/YiXeydsTqKMYHVCKjjsj7dtO3/1UuIGQHqSy2
 OsIDW1jaxDoOR/eYNJW5B5qz+qHDllnsdm+8k5XfraZpLJtBWzFltBDlH+J7zh0a4bpLOtADC
 jPzqjhxUaK8MFCOnQIMiM7EIrspL2rdERRYsbK+MbZ+ABa9CabRinWzDCZQSlACdMa/sZwgK3
 FHcuyEGnWzXLFOlP09pDIJIcTkgb5i6QaEyif2HY6J1DczOuVbAAK1bGzVTTylVYkXHRFJFLc
 aQ+io7yHn9cCtFek21nYFbgd3soIYyrDAixwNoIttRnS7bxt8rpXtl9HDptOAwoHaD0gqBmbQ
 wKJy93rJsHUWMZVgIJJ/iizfe7UvNiOZyZV0OT0uSIGyZUG5+WK5E/6lgt2h6PfAEJ8gCgTej
 pnNkxybJT+XZ1N2M2Raz9KcokyXP2xay4AVLQEc4pl4LPhbWe71FjvkUOFG9aQaftXrSHkTwu
 hMUrvOVfrhwrEgqTYb5z94Ons2YIitU3rAsFjzI/z9OyDx4dHkE08PBLwdlT9rgdI/7NGAA75
 aC/zC1PxKWygwgnXmx7qUbdAFwK1NKCx4dnBDgbn6WUx7vZhxCfTrM=


--y4azmvpmfn76pvnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/01/23 12:08PM, Mario Limonciello wrote:
> This should fix the GPIO controller failing to work after commit
> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
> ```
> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 00002080 (acpi)
> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
> ```
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218407
> Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")

Just a friendly poke regarding this patch as the bug is still present in
rc3.

Cheers,
chris

--y4azmvpmfn76pvnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmW/q2IACgkQwEfU8yi1
JYVDXA/+II2HQqgg1/xf39S3NLNIHrRXx5dAsrRjx2BPMF/aA5PkSIlD5tTQws+P
lrKKmetScNWOtrMRhtpr2Bxm0IJ+b1ScWMondhbYfwt3owe03AtRuKE9NjHq2I1v
1S3fDp3JAZ68Jfh0Z6+vreR2XKIaAOH4k6lIfPq857uYt69sjk7VlUQ3lii8TDi7
7MeVcjqo/Nu2VD/qwW/GhXdmqVzAs9eS68SO9z5NnvnqtKyhWUlwxMGpTbdsdM+5
gZKOW0rutYSgm3g3rfHF/qQqVILpGsJkWr50bs8UXIVA644I4l53nPHMi4ZogbvV
DGbzvSXGi3KieKH3FvG+UIi72BwiUxVUYWyVBRPsP9ZBO9S+RTl/9AispVZ+fUzg
x+bCpBub4osjLVKvNC0Z/GIAzOnRew9nMS9bDY8RTZKq8L86BhW00LT0K0dAzcBQ
oG4qsSElq1GwQFhr3x6chrzn+VxxYj5HKYsUoPzS5oHwP3oa0y2BVy2kD8AgJXcH
HFW1cUF8YE2+TUyrDJfC8v+3WSRWhOCvx1o02Q/FBtgQ3LBKUzQX3RK/1+K4Op0H
HYdqZX7JIonVXtaM81PST11tNp8uW+GhKHACK4jeBHHbjciNLqlyxVMU/IOggloE
RQWYnceulJ150CT4DXnlNtIEUDWnmIWPrkxaZv/Q0PtoVIEo6kE=
=onNw
-----END PGP SIGNATURE-----

--y4azmvpmfn76pvnt--

