Return-Path: <linux-kernel+bounces-13520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48804820799
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851201C212C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94265CA49;
	Sat, 30 Dec 2023 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BH6JKtWm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A1C139
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703956671; x=1704215871;
	bh=QQ0ltPLjZpeG5P5hw0GwaUTAFyp/TZCuilQIFffY7L4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BH6JKtWmsCx/bk+7ArCWqZLg3Ym49iUdiCkEvm5KWnafwtYLvqpJDX/ee71Nf9PyL
	 jRyTggQa5u8GUTm9RCCXE2fSr3Enz04U1YdCIoeQ1ZpFYZwfsAf6cTY0niQttQsRuR
	 9VIzjxhA7k32R+usnLJ5XjPlLnpUCOgK+C73qQpWzHVAbAOTqvkgj/zuXZJElUdILs
	 3w78rHinKJNCt5glyUgaOleGgn7/qe43O98vddIOwuEhrChXaOkLOeuerv9x25+HMi
	 HLPA1DczAuavfbH8LN7GpM/+mGJZ7awU3Eu25JQHhcSH4TfUXzUz48ypx2onZ0L+ka
	 4+OfozbHgTPoA==
Date: Sat, 30 Dec 2023 17:17:40 +0000
To: =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 1/5] wifi: b43: Correct OpenFW QoS capability warning conditional
Message-ID: <874jfzk3tb.fsf@protonmail.com>
In-Reply-To: <20231230143455.4d64ffc7@barney>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-2-sergeantsagara@protonmail.com> <20231230143455.4d64ffc7@barney>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 14:34:55 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> [[PGP Signed Part:Undecided]]
> On Sat, 30 Dec 2023 04:51:29 +0000
> Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:
>
>> Trigger the warning message should be when the OpenFW capability for QoS
>> does not advertise QoS support. Previously, the warning would be
>> incorrectly triggered when OpenFW reported QoS capability is present.
>
>> --- a/drivers/net/wireless/broadcom/b43/main.c
>> +++ b/drivers/net/wireless/broadcom/b43/main.c
>> @@ -2713,7 +2713,7 @@ static int b43_upload_microcode(struct b43_wldev *=
dev)
>>  =09=09=09dev->hwcrypto_enabled =3D false;
>>  =09=09}
>>  =09=09/* adding QoS support should use an offline discovery mechanism *=
/
>> -=09=09WARN(fwcapa & B43_FWCAPA_QOS, "QoS in OpenFW not supported\n");
>> +=09=09WARN(!(fwcapa & B43_FWCAPA_QOS), "QoS in OpenFW not supported\n")=
;
>>  =09} else {
>>  =09=09b43info(dev->wl, "Loading firmware version %u.%u "
>>  =09=09=09"(20%.2i-%.2i-%.2i %.2i:%.2i:%.2i)\n",
>
> I don't think this patch is correct.
> It should warn, if the firmware advertises QoS, because that is not
> supported by b43 in case of OpenFW.

Thanks. I had a hard time understanding the intention of this warning. I
figured it could be the case where the warning is about the driver
disabling QoS when firmware has support but was not sure. Will drop this
patch going forward.

--
Thanks,

Rahul Rameshbabu


