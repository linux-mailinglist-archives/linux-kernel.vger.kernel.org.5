Return-Path: <linux-kernel+bounces-3001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F08165DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554122819BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5663C5;
	Mon, 18 Dec 2023 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IoBic/rp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0563AC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI4rs2a005504;
	Mon, 18 Dec 2023 04:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LZAxFx4EonWNZR1Ir6a5e5qF8MZSqMxZbimtZ7i+N3Y=;
 b=IoBic/rp4N2L1W4tnCyKKFkJzCJRBEfLrb7ofi7OI4fVovrxiM4Gr2WZA+5yN7YrXqKF
 2sp4PbwtdNzNkX+Yai2LjLFVqMNHPFDknWbKtIYsueJ0eeVIM856WxAxULeS9DGHC1uT
 DvsSEX6cubRsIYQCUwvvmUKj8FtnXZebD9nWMIn+gpxF/8ZGjHJbulh2pcrK+5dgmRD/
 25LbITYu78nQ6epNpeeqM1exMPj3oXroWPXfLmxyVSIbXXYx1NgyL2euvdXPesWAZ25j
 raAxrTwPmdF2h/+NQ27/549ty6nwx1znL1098fGEhRVIdUAGvxGN4qF51E+dF0Wd0xvW gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2c4xmjyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:57:07 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BI4bl12002614;
	Mon, 18 Dec 2023 04:57:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2c4xmjxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:57:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI3BXH4013763;
	Mon, 18 Dec 2023 04:57:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqjxj4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:57:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI4v3Cn14090916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 04:57:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BAC52004B;
	Mon, 18 Dec 2023 04:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E5D20040;
	Mon, 18 Dec 2023 04:57:02 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Dec 2023 04:57:02 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6012E6016C;
	Mon, 18 Dec 2023 15:56:59 +1100 (AEDT)
Message-ID: <2b35027ca6c61c2211117d30bd84c0e26cced1f6.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Add a null pointer check to
 scom_debug_init_one
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Kunwu Chan <chentao@kylinos.cn>, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mirimmad17@gmail.com, Kunwu Chan <kunwu.chan@hotmail.com>,
        robh@kernel.org
Date: Mon, 18 Dec 2023 15:56:48 +1100
In-Reply-To: <20231208085937.107210-1-chentao@kylinos.cn>
References: <20231208085937.107210-1-chentao@kylinos.cn>
Autocrypt: addr=ajd@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mDMEZPaWfhYJKwYBBAHaRw8BAQdAAuMUoxVRwqphnsFua1W+WBz6I2cIn0+Ox4YypJSdBJ+0MEFuZHJldyBEb25uZWxsYW4gKElCTSBzdHVmZikgPGFqZEBsaW51eC5pYm0uY29tPoiTBBMWCgA7FiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQj1Qx8QRYRqAdswD8DhIh4trRQYiPe+7LaM7q+0+Thz+CwUJCW3UFOf0SEO0BAPNdsi7aVV+4Oah6nYzqzH5Zbs4Tz5RY+Vsf+DD/EzUKuDgEZPaWfhIKKwYBBAGXVQEFAQEHQLN9moJRqN8Zop/kcyIjga+2qzLoVaNAL6+4diGnlr1xAwEIB4h4BBgWCgAgFiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwwACgkQj1Qx8QRYRqCYkwD/W+gIP9kITfU4wnLtueFUThxA0T/LF49M7k31Qb8rPCwBALeEYAlX648lzjSA07pJB68Jt39FuUno444dSVmhYtoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YWCYse8US4TUUpg0jRtmDF8BKdKFc5N4
X-Proofpoint-ORIG-GUID: xJhNnQO6dBMc8QbgzBAyh7-ogqXrdcio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 spamscore=0 mlxlogscore=677 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180033

On Fri, 2023-12-08 at 16:59 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> Add a null pointer check, and release 'ent' to avoid memory leaks.
>=20
> Fixes: bfd2f0d49aef ("powerpc/powernv: Get rid of old scom_controller
> abstraction")

[+ robh]

This commit just reshuffled around some existing code. The commit that
appears to have added this is actually b7c670d673d1 ("powerpc: Convert
to using %pOF instead of full_name").

> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
> =C2=A0arch/powerpc/platforms/powernv/opal-xscom.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c
> b/arch/powerpc/platforms/powernv/opal-xscom.c
> index 262cd6fac907..748c2b97fa53 100644
> --- a/arch/powerpc/platforms/powernv/opal-xscom.c
> +++ b/arch/powerpc/platforms/powernv/opal-xscom.c
> @@ -165,6 +165,11 @@ static int scom_debug_init_one(struct dentry
> *root, struct device_node *dn,
> =C2=A0	ent->chip =3D chip;
> =C2=A0	snprintf(ent->name, 16, "%08x", chip);
> =C2=A0	ent->path.data =3D (void *)kasprintf(GFP_KERNEL, "%pOF", dn);
> +	if (!ent->path.data) {
> +		kfree(ent);
> +		return -ENOMEM;

The caller of this function (scom_debug_init()) uses a bitwise OR to
aggregate the return codes of multiple calls to scom_debug_init_one().
This doesn't really work for returning specific error codes, so I'd
just return -1 here (or change the way the return codes are handled on
the caller side).

> +	}
> +
> =C2=A0	ent->path.size =3D strlen((char *)ent->path.data);
> =C2=A0
> =C2=A0	dir =3D debugfs_create_dir(ent->name, root);

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

