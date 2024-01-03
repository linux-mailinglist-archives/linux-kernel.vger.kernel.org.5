Return-Path: <linux-kernel+bounces-15302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BCE8229EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F7E1F23EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A7182BF;
	Wed,  3 Jan 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YRY4Vu/u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF118623;
	Wed,  3 Jan 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704272779; x=1704877579; i=markus.elfring@web.de;
	bh=Fb/E0bLfK4HYiwHmpycQDyjgyUrLghAFd2etpy2dGyo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:
	 In-Reply-To;
	b=YRY4Vu/uF/q09ZyO20+wDkEtIp40KkprS+whmkQ2V8g4+/dyjXryX6vxXUHw8fxf
	 gVov6sfLeWV3cICN4x2SyrYQtT1PrdW64VnBQgU3fHsmQF79JZl8AMqeZScgS3JvZ
	 gpXYCeVzkDFIIHWu19FiZw/YH/Z43Z3PKJeO3lib5V9sJZMkUZEtOyPoef55e0xzE
	 VkGJ1+IMX3pCJ9CWAKtq7fUNsFrVrNW+JCU+lHYBauXsIk61OcL0Og9yERX5n003W
	 dN8cCnXK5fSvcl3Hoiikj03ZW61XEIxVrlM67dX+Ru0z+jtdS1v5Rd4GJjx6dCCrN
	 rXq1vFykn47Ff0wtHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODiN-1raAhm0cNl-00ONpl; Wed, 03
 Jan 2024 10:06:19 +0100
Message-ID: <bb11fd85-1fa7-429b-a379-f4a92f7f0f88@web.de>
Date: Wed, 3 Jan 2024 10:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fbdev: Completing error handling for fb_alloc_cmap() calls
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Helge Deller <deller@gmx.de>
References: <913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4M3xaazTPrShaIJhrVteu/4GqbA0GzEzzmVrL1bCQrpmNVDERV
 WCyj1rRRUVyO4tU+6n2OPqpaLolyJWevbPvHuMV8wcMGamejJAOCPt/ZKl28Bl2Unrgdokv
 osfl2ei4VkEePSz3yBcHEnanhLcMn1tFi5zDrS7X8Dfb0m5kW5J+aj4cgw/KMlbmRrEyVcH
 Y+ih3krKSGjJIq+ORzevg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vA+xCXVlgZI=;Rno+HfKZxe7/PQaAe9RUvnekz2K
 7dLwz68F9SG/kBRGvZmCXV/PXJVU/I2nhQ2ohxLew8EI4ROJyP8x8Gt99unFaFnw86wHbcbXG
 tjZ1Xi8eKBDEY810Yx9bYGa4V4Cwm7FCra08Ladj9OSO0U/GaDESfck2m7tF6sGg02qUGqDiI
 3z6/cKT3+2tiEpxCH4aJBruDR5ltWLSf53qI1rapg6kHJ5iFmxazGeJ7x00T8PGCCNZafqukg
 bQWm8gJBiOyoC7L6M8yyMtHIoapf5aAxS2CTEj/0j1iwsn+WsWDAnEplCVTtJoId28GLf69E6
 pIKLp4JBpidsUC6wQc8biLZqm4+cBrsKjn9Oxu8JgxQEzRtLDmEzbSDhdkGD9XCfnxFToSRdN
 coxvZ9pyTPHiju0DBjJbCLmZHoEw4RJiOe0UcQDXxdSyQ9E7sgL6MHDQDSjxct8qtO7ctURNz
 C+Us9to9mGSFKPIaMQMUlzI+t9cL4Ml7HjmEQOYEsezyTo2KaFcWjXzluhtzk8czqx8WAs6kU
 WxoaN2nzFalI7d4tHvx1wQ6GjQV76nZSeAF2H1G2DzopgJHZzV6K2CRvqS3ASa+UwLPxDHOOj
 KhDtuc1SPWSps24uKePPIXCMc9jCYwKFqKEjCPd7Bft2cf/48ddssUJ3V1kOMdehiDMjUeg6B
 XW2mD8WS8Gji9xKKD/63/b01yT0bIDkrZycZ1SYSMR+NP7JR4Tl2UBRIWev1ASdCng0aTaCCE
 K4x9PYILpRx/BbOcnXJFezfwEesXVEjn0l9SpzNqMfFWRVxQcj8dX4fRvdtIxUEyF9Fi+ca8I
 WIe8woZzRbzt+iFyHau0mmtoHipNoXAMAZ/ctQYYVtqTzsxbf5KVKSIgHGFCLYeoSxxgSZX+i
 RsD5gixoEtxUzzdWxbb8hvTn+kN2eYk9twXvK/tyJATVh2j3NfyyhyNqu3Slwo2+WZFMPv7zx
 MAMNvT8DnDrNCB1QUQaHljBjhhQ=

> @addition@
> @@
> +{
> +int rc =3D
>  fb_alloc_cmap(...);
> +if (rc)
> +   return rc;
> +}

How do you think about to apply this script for the semantic patch languag=
e
so that remaining update candidates will be found?


See also:
Clarification approach =E2=80=9CChecking addition of local error code chec=
ks=E2=80=9D
https://lore.kernel.org/cocci/913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-01/msg00000.html


Do you find further change possibilities still relevant for 23 source file=
s?

Regards,
Markus

