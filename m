Return-Path: <linux-kernel+bounces-103143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AB87BB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA031F232FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886906E619;
	Thu, 14 Mar 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EwLkY4XJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F05DF0E;
	Thu, 14 Mar 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413471; cv=none; b=LAum1D/vfBTKk3IUj55H9d4AhgArxdhhEEG37AKY8H/YIt+ANCVGiKv8hT8CkGCYW4FRcvRsmOK0SEBmbPE1EEmaCCw3zx8gctzpY1p2PhUz6s/SSiJMld4qmxDrmJ0FUS13QVcth5Qw4TM8DP4RN0stXFuLfs4FeDNcQnCAa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413471; c=relaxed/simple;
	bh=EWUlLis8X669AunKiPTK04qSVrQJU4W8sOADYKjgKR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehmMojLTjdQyRW3CAJhCh9fOX89XCPXuVEZz9Z6VVo1kxzOCQ+9jWCJ1PhBNwYFdwSP5/1gYK40htQDQuyUhibLTkkfDXQBES+HtKDngvIK5erQw5jW6ebV+eWceyRss+zNhPzRYNFVHX2Y0D/um8tJMls9nfHNm6pytBqngxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=EwLkY4XJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710413464;
	bh=DRdiHGqYqxjEF8hsA5ZH+kEbHXJ9gHLyaDJurUBUBU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EwLkY4XJ/XL6m9O01lkeRqb+bFGM+QvljzvF4nbDCTUEioyZoYoIMNbpMjw/ibU28
	 UaZLGEMxbKyyHXpBTLDqSOa9gMjkeg2wXcWsO6hB8FLPuII9r/uZvQoQ0axiGR9ZjI
	 OJoivYUdbYAy72HQQGSNAgfMInJNDl8EOWJ+HVA5xsz7/fbUPckzgw0OYMh8LYCfrh
	 AHfU/K+/T+ds+0JQChBbJxC55hFG5D9mFQW1g+NpydlfUrwdlDsmwljjoxuLlD129X
	 mFlBgg//ha/jnCRFFGrUoPpkT996Tpp2gKmcMniglSQgR/+XtpLQBEQyF4GYKAqh/K
	 6sl4QGJjol9Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwPLZ4lVKz4wnr;
	Thu, 14 Mar 2024 21:51:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] net: wan: Add support for QMC HDLC
In-Reply-To: <20240314081200.5af62fab@bootlin.com>
References: <20240307113909.227375-1-herve.codina@bootlin.com>
 <20240307113909.227375-2-herve.codina@bootlin.com>
 <87ttl93f7i.fsf@mail.lhotse> <20240314081200.5af62fab@bootlin.com>
Date: Thu, 14 Mar 2024 21:51:01 +1100
Message-ID: <87r0gd2iju.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Herve Codina <herve.codina@bootlin.com> writes:
> Hi Michael,
>
> On Thu, 14 Mar 2024 10:05:37 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Hi Herve,
>>=20
>> Herve Codina <herve.codina@bootlin.com> writes:
> ..
>> This breaks when building as a module (eg. ppc32_allmodconfig):
>>=20
>>   In file included from ../include/linux/device/driver.h:21,
>>                    from ../include/linux/device.h:32,
>>                    from ../include/linux/dma-mapping.h:8,
>>                    from ../drivers/net/wan/fsl_qmc_hdlc.c:13:
>>   ../drivers/net/wan/fsl_qmc_hdlc.c:405:25: error: =E2=80=98qmc_hdlc_dri=
ver=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98qmc=
_hdlc_probe=E2=80=99?
>>     405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
>>         |                         ^~~~~~~~~~~~~~~
>>=20
>>=20
>> IIUIC it should be pointing to the table, not the driver, so:
>>=20
>> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hd=
lc.c
>> index 5fd7ed325f5b..705c3681fb92 100644
>> --- a/drivers/net/wan/fsl_qmc_hdlc.c
>> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
>> @@ -402,7 +402,7 @@ static const struct of_device_id qmc_hdlc_id_table[]=
 =3D {
>>         { .compatible =3D "fsl,qmc-hdlc" },
>>         {} /* sentinel */
>>  };
>> -MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
>> +MODULE_DEVICE_TABLE(of, qmc_hdlc_id_table);
>>=20
>>  static struct platform_driver qmc_hdlc_driver =3D {
>>         .driver =3D {
>>=20
>>=20
>> Which then builds correctly.
>
> My bad, I missed that one.
> I fully agree with your modification.
>
> Do you want me to make a patch (copy/paste of your proposed modification)
> or do you plan to send the patch on your side ?

Yes if you can please turn it into a proper patch and submit it.

No need to add my SoB, it's trivial.

cheers

