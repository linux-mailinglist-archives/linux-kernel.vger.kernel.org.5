Return-Path: <linux-kernel+bounces-95453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBAE874DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A16DB24EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5577129A6A;
	Thu,  7 Mar 2024 11:42:45 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BF85634
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811765; cv=none; b=IvLShLHgWuHXnv8bpnSZ+Pkj9SHwIPGubkmxtHbbfLoZR8emdENkm9I3hUzZrw3NemhRtApWlh23l7F4wgrRssvosHKrEbX1eEd+I7/CNTKHp3r/dNAMqUquWVdG9BGdeMtLHbuCzRkUUWCkI5amKymRCPuIWj/TiBqBw8ohV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811765; c=relaxed/simple;
	bh=HmiysDGoQdQ1CCsY7P4BykmggdQ+5ESOnGLry3+yVEc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ji9ksq+XS1Ow4q0PF44AWhOPuJrjG7u793OyYw37fpT3+yJj3lKXPmcnqGSXxJKNXcPXFGLP50ljRmXNOvi2mUFFCpH39W28P1dNP+aZck71tLJSS9t5xIHvfpVla8xJFNaHInJ247VCW6NaTeA/4h8Vlq0mHJrneOap2jTKDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1riC8g-0002VN-2E;
	Thu, 07 Mar 2024 11:42:18 +0000
Date: Thu, 07 Mar 2024 11:42:12 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: linux-mtd@lists.infradead.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Daniel Diaz <daniel.diaz@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
User-Agent: K-9 Mail for Android
In-Reply-To: <27c875fb-9507-4034-8468-c4d46c952754@moroto.mountain>
References: <31a20aead3419209991bf01aaeaefe07ab94d23a.1709081052.git.daniel@makrotopia.org> <8ae44e8e-fc3d-28bd-5d1e-e900ce53529f@huawei.com> <27c875fb-9507-4034-8468-c4d46c952754@moroto.mountain>
Message-ID: <005448D3-A311-4B2D-B515-C7A9399B48E4@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 7 March 2024 09:17:45 UTC, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg>=
 wrote:
>On Wed, Feb 28, 2024 at 09:45:13AM +0800, Zhihao Cheng wrote:
>> =E5=9C=A8 2024/2/28 8:46, Daniel Golle =E5=86=99=E9=81=93:
>> > A compiler warning related to sizeof(int) !=3D 8 when calling do_div(=
)
>> > is triggered when building on 32-bit platforms=2E
>> > Address this by using integer types having a well-defined size=2E
>> >=20
>> > Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes"=
)
>> > Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>> > ---
>> > v2: use size_t for 'bytes_left' variable to match parameter type
>> >=20
>> >   drivers/mtd/ubi/nvmem=2Ec | 5 ++++-
>> >   1 file changed, 4 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/drivers/mtd/ubi/nvmem=2Ec b/drivers/mtd/ubi/nvmem=2Ec
>> > index b7a93c495d172=2E=2Ee68b8589c4279 100644
>> > --- a/drivers/mtd/ubi/nvmem=2Ec
>> > +++ b/drivers/mtd/ubi/nvmem=2Ec
>> > @@ -23,9 +23,12 @@ struct ubi_nvmem {
>> >   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>> >   			      void *val, size_t bytes)
>> >   {
>> > -	int err =3D 0, lnum =3D from, offs, bytes_left =3D bytes, to_read;
>> >   	struct ubi_nvmem *unv =3D priv;
>> >   	struct ubi_volume_desc *desc;
>> > +	size_t bytes_left =3D bytes;
>> > +	uint32_t offs, to_read;
>> There still exist a type truncation assignment 'to_read =3D bytes_left'=
 below,
>> although it's safe in logic=2E
>
>Yeah=2E  As you say, from looking at the logic we know it's safe=2E
>
>    41                  if (to_read > bytes_left)
>    42                          to_read =3D bytes_left;
>
>Obviously the new value is smaller than the original, so it must fit
>within a u32 range=2E=2E=2E


I've sent v3 of this fix which should be finally be warning free now=2E

https://patchwork=2Eozlabs=2Eorg/project/linux-mtd/patch/ff29447dcee834c17=
e4e1e99725b9454c90136ca=2E1709178325=2Egit=2Edaniel@makrotopia=2Eorg/

>
>This bug has been breaking the build since Dec 19=2E =20

I have a hard time believing that as the offending commit was only applied=
 on Feb 25=2E

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/next/linux-next=2Egit/=
commit/?id=3D3ce485803da1b79b2692b6d0c2792829292ad838

> It's fine if you're
>able to manually create your own =2Econfigs to work around build breakage=
=2E
>But if you're doing automated testing at scale then it's a show stopper=
=2E
>Could we please fix it=2E
>
>regards,
>dan carpenter
>
>
>______________________________________________________
>Linux MTD discussion mailing list
>http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-mtd/

