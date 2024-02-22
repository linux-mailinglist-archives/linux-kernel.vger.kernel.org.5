Return-Path: <linux-kernel+bounces-75807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBB85EF46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646CB1F2317A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC27E9;
	Thu, 22 Feb 2024 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pBQMNP78"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B980196
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569984; cv=none; b=POBysMGp7QDeis+Lp5ULFiV9HfEDM2HUT2oI29lwRuZf1zz8u1kQjutnfWAFt3f5P4LA4xy5EeeZxaP21TpvNhFfKCyunNC3M+hKG24k4TSZXqNP9TtkIMDIh+BrhkmCoJS2Krwru7PTkaC8jlUwOvl+ykyTakebXNJh8QBlNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569984; c=relaxed/simple;
	bh=DYCV5IoExiKqKVmE48ZjMCbNoFE4P2ozeozZJWgd/CM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjdnIFzkjlyXlkXN1233jmrXr902oIB87OXGmnNhqiQzAwfucUT1pbA7y4S1xX4P1W5CbVi2Vtat2w0gLL/wTCSUdY+jeGoNobtV70v5rDmDK2CF1d3n0DBNYgDA3QonZYF0avY+ZRdFtPETH0GuNIiVKvg9jfTo/sKyXSxJi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pBQMNP78; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M2QNfT024206;
	Thu, 22 Feb 2024 02:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GiP2adjLMmN5GvecuJnVYayKGHJPA6hHp9FtGDCdvEs=;
 b=pBQMNP78gU/tv30U9sEbIHj1o1xiodEM3p74o+gSjIaAw4qbQMUI53ARy8ALxrtwAkn+
 AcOYyW5VBBzGGLign2a3cE7SAKzQwkNqQltslYTPejVnEZbstG/+52BxKbrzfwFhnFXT
 pVa9YEa+SJHk4Do0KIjiwjkoTNoJfgLKWFJz0XHATcItna7QOEswOBa3EKpJbDAZato/
 v9PMn+r1EEXekOm6yAbyPxEtfsYU61n3Q2edB/PiZbf1swJMPPHeCM8P3LmJr4xSQxk6
 CTjsH7ytNHbLKFKDFEaLyQtwIrb95xei3VPT3g3o9VchRJ+10U7Ogycia//14XyaO6fP RA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdurbj7km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:46:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41M2U7kX009551;
	Thu, 22 Feb 2024 02:46:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pkdae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:46:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41M2k8xu20447886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 02:46:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70AF72004D;
	Thu, 22 Feb 2024 02:46:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 018EF20040;
	Thu, 22 Feb 2024 02:46:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 02:46:07 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 10B6C60170;
	Thu, 22 Feb 2024 13:46:06 +1100 (AEDT)
Message-ID: <d8bb9ce729404068315d5f5087470bf5d741bc87.camel@linux.ibm.com>
Subject: Re: [PATCH 02/11] cxl: Convert to platform remove callback
 returning void
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann
	 <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 13:46:00 +1100
In-Reply-To: <add08320eef9ea20ceca78648370590a4bd447b0.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
	 <add08320eef9ea20ceca78648370590a4bd447b0.1708508896.git.u.kleine-koenig@pengutronix.de>
Autocrypt: addr=ajd@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mDMEZPaWfhYJKwYBBAHaRw8BAQdAAuMUoxVRwqphnsFua1W+WBz6I2cIn0+Ox4YypJSdBJ+0MEFuZHJldyBEb25uZWxsYW4gKElCTSBzdHVmZikgPGFqZEBsaW51eC5pYm0uY29tPoiTBBMWCgA7FiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQj1Qx8QRYRqAdswD8DhIh4trRQYiPe+7LaM7q+0+Thz+CwUJCW3UFOf0SEO0BAPNdsi7aVV+4Oah6nYzqzH5Zbs4Tz5RY+Vsf+DD/EzUKuDgEZPaWfhIKKwYBBAGXVQEFAQEHQLN9moJRqN8Zop/kcyIjga+2qzLoVaNAL6+4diGnlr1xAwEIB4h4BBgWCgAgFiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwwACgkQj1Qx8QRYRqCYkwD/W+gIP9kITfU4wnLtueFUThxA0T/LF49M7k31Qb8rPCwBALeEYAlX648lzjSA07pJB68Jt39FuUno444dSVmhYtoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d8tGGwje4Ct3BQNX-E9e0RdHXMvkGTHZ
X-Proofpoint-ORIG-GUID: d8tGGwje4Ct3BQNX-E9e0RdHXMvkGTHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220020

On Wed, 2024-02-21 at 10:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which
> makes
> many driver authors wrongly assume it's possible to do error handling
> by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource
> leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all
> drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the
> remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0drivers/misc/cxl/of.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> index 25ce725035e7..bcc005dff1c0 100644
> --- a/drivers/misc/cxl/of.c
> +++ b/drivers/misc/cxl/of.c
> @@ -431,7 +431,7 @@ int cxl_of_read_adapter_properties(struct cxl
> *adapter, struct device_node *np)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int cxl_of_remove(struct platform_device *pdev)
> +static void cxl_of_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct cxl *adapter;
> =C2=A0	int afu;
> @@ -441,7 +441,6 @@ static int cxl_of_remove(struct platform_device
> *pdev)
> =C2=A0		cxl_guest_remove_afu(adapter->afu[afu]);
> =C2=A0
> =C2=A0	cxl_guest_remove_adapter(adapter);
> -	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static void cxl_of_shutdown(struct platform_device *pdev)
> @@ -501,6 +500,6 @@ struct platform_driver cxl_of_driver =3D {
> =C2=A0		.owner =3D THIS_MODULE
> =C2=A0	},
> =C2=A0	.probe =3D cxl_of_probe,
> -	.remove =3D cxl_of_remove,
> +	.remove_new =3D cxl_of_remove,
> =C2=A0	.shutdown =3D cxl_of_shutdown,
> =C2=A0};

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

