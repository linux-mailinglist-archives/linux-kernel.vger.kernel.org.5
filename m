Return-Path: <linux-kernel+bounces-22248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18360829B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36812833D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73514A983;
	Wed, 10 Jan 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tbVn4XmO"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2144C63A;
	Wed, 10 Jan 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704893585; x=1705498385; i=markus.elfring@web.de;
	bh=RnhFZzqFP21H6mHBzHvMIpfQtdiPSMkVFOutsyi3vUM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tbVn4XmOugNswqCvTt0ISjOo2W+60xRWRLtnchnRwH8A/s1x8r6RJtOGXveiQW1G
	 IzOeMNJFFyOwtmKVJN5PokuAhzeMnPC1s0cRzY3flGZGKWOcMr/YsgwAAUzhCZakS
	 KzQhodSsA2viM9QLkwtxNY463HNnP4txpSoatwhrSyXG8eCOfrUiBdwH+SvLCqKxw
	 5N16pAEiQmmxDwr/RBfRV6Jhgd7eVm2oJ5XC7T9GA5lKNwxbwGY4A4JNik3CS0VNO
	 gIp7OARbSONnVlt/zsUeCB+quNRuvXXanPX/0Y9k9a+Yb24cjfNRdIbCLT+1/3UTc
	 RyH/peKebc3EE17gyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1qi9bj1BMU-00fRcl; Wed, 10
 Jan 2024 14:33:05 +0100
Message-ID: <1df4916d-421c-4c87-8503-5a36934d03d8@web.de>
Date: Wed, 10 Jan 2024 14:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/4] overlayfs: Adjustments for ovl_fill_super()
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
 <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
 <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
 <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sR4rQTtSYytVnVBdP1/d3E7GPPa8HOhhDRPvzDXFi2UK8060jYO
 GQBshFtoDKifWRZ0Qiuh5mQ6tecfzLFlcTqy4suRtfHRN6viFEmam9deD1FfL9Ej5F0xeuE
 1T93FEy1dZ0dtC063PuBRiQz0HYzLlCMXF/HJGASl1mHFx6eatO7jOBT28ZN1CSGpBmwKpy
 oy4Zfv7FNkOu/SpM5GEog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JzdfnNQ9PNY=;gDs/TB4KQUmIb+ze3lX1auKhdX+
 N88AI0I1T4TkJzYA4iyoFH+lVoBMMNu6rUf7zYNA2nHOzzndPPbinArvGXXHK9aR567BXDHCW
 u80pXGeaXVdsa4E/U3xH47t8SPlyH7/FjK6Y1rJq6RYFB2htKOTIduup0+rPWcBYvX4c0VwzI
 fn8EZonv3LElpZvPeZhJgFVYSoc3eoJWagJCmjxDMjfooPwxD+VYj2/76YvIYE0VwHCi11EbC
 OBO6PO04ZGqCcLp9Ffzg1WqidpMfdFeRu52kyJoMK8bDBVQkwJETILvMCR8BVf+s8nvn8Sjhd
 lqF2f3itCv53S6QocxiR9HyIR5eQQKuoU3bRgUOzyoPA4qIVn2wJn/zh7PY1pL9ilMe01lB9q
 QoH1620eNuzyFXR7KNFog42gD7RbPdr4N8R7o7DZfp79KMkfWPxQzFDMZ/CGjhtjiweCOGXO/
 A4kiuIymlowJ/ELxdXsidPRwXKrS+rGR4OT8/IW4D7d6Iaa7UnItDCXGBP4mhXHOJn6+y7cXF
 m+A43DTuF8eM5v0bNSJsZvMFrjioyco2HXLFGPccFIB5frxByMO8pm46XUgY9A4gw4dF7DWHe
 JvaEe0ISboEAxSPHTPzJe1cVWzBmOpveR9UlGVAY+KTD8JWeJfmgSR1xvesIEy79aJdB9thBc
 EMcS0nva+5ep3GB27xHw0FKXrjqiMsSIwAhUA+n60EdIsjU8XX78xp94LIo4KOyuNRazbxH7o
 ZmZc+esTVgBHg7we9ShBrknbskcEbUxfi3SRSqy69JG4+IEaz1NuFMHhfrUm01WkBmEja6vOl
 WweYw4Dx+J76D36QNpWDDLhB8qMs07Cx5SD+D1fnURyiBMQS4L30bNimAw7GCfiFIdsL0+ixa
 C0ie1LUvaIrhSEa4XRkeWGBseWL6b/8RsowFL23KjkBsq0TBRuabomZcs4fgw31wso63HFH7M
 FCv8YsFP5Cd2nF1wHK5WzQEm6uA=

>>>> See also:
>>>> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@we=
b.de/
>>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
>>>
>>> I will queue cleanup patches 1-2,
>>
>> Thanks for this positive feedback.
>
> Sorry, these patches do not apply to master branch and patch 1
> is no longer correct in master branch and the new mount api changes.

Do you want that I adapt the linked development ideas to the current situa=
tion
a bit more?


>>>                                   but I do not like patches 3/4 and 4/=
4.
>>> I do not think that they make the code better to read or maintain.
>>
>> I would appreciate if the details for such change reluctance can be cla=
rified better.
>
> patch 3:
> I much rather a single error handling label that takes care of
> all the cleanups - it is harder to make mistakes and jump to
> the wrong label when adding new error conditions.

There are different coding style preferences involved.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


> patch 4:
> Overlayfs uses this coding style all over the place
>
>   err =3D -ENOMEM;
>   ofs->creator_cred =3D cred =3D prepare_creds();
>   if (!cred)
>       goto out_free_ofs;
>
> I don't see the benefit in making err =3D -ENOMEM conditional.
> I don't see the style after your patch as clearly better than before.

Can it be nicer to set error codes only in exceptional data processing sit=
uations?

Regards,
Markus

