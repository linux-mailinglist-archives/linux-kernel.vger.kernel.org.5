Return-Path: <linux-kernel+bounces-75226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411785E4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A901C23973
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020E84A2F;
	Wed, 21 Feb 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="bsl+zwnb"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2133.outbound.protection.outlook.com [40.107.247.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C431C20
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537838; cv=fail; b=U0WrAc2XgEj4wUbe4f4SHIued8YLcGUdpKuYnnv5ZTCqdEZzo0ijF25PczeuKbxNIXCjJD0byct93MreIg0msxj6UCZNCuPqz/QDHQW6B4jD2I0AfU4tpfk5BCqsjhU49L4RPLRyI96e0+b2kC7uAyXTuyr6tuzL9E0Kjy15YDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537838; c=relaxed/simple;
	bh=2i7toTgnAKhJvvAz9zkroKdUdojR6DP39zXLtg6d9NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5/uSijsdVjMpHjXpb6cM5ipv5458zdYGC7TCntf7ErxffUEk/jCoNbNR2bejrewRj5J2t5NySt8qX7ENuw+LeEgKLf+Ymb35f6rA02Hl3vB6vVAJdu6Ky6gUCmGO7hR0dd0RQWeHBd/BCfIJWNrnB9BqXH/lCpScOOLHuHWrpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=bsl+zwnb; arc=fail smtp.client-ip=40.107.247.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSJ6uSwqrDJfnHPNOD6f0MwtS+E/ltSbbS9CdCTeTsBjWhpmTjBxdVweTqr/UCwhvePJAimJWiJyB9Wm8shF2BYqBec/M25QvWUv01A0xFhn/iIJ4Gg/zD1K/J8MjGxzK9Q7PEwaK7VG+sMX0Eakl9L9oEd6ZD5E0jJFcK3t3po9+DElEpSsbKaTSbOVK+8Ib5iw982fwLTnmLFMLpksadIwcwvcamAAXiftO8zvT++Di4w0sP/I+Z1kY3dXBjwamviN+124x1r+xuSMa0jHREudSjaOCx9BmBaerY0foNHoqNLJ9L2bO1/uHTqZ//wa8ahqOxxghgabkNDHmhsYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acConbkRzyIFnrBwY+mlUIKJkFmis/rXsRMtEyJNpVE=;
 b=VcvZL7l1IlABmRoG/XBGLPh8veK5vDG9y+wIzcif2EEEBxxvI6aqh5VCUO/kxeFAr3DH9W43hiXxuNA9Glm5W0SpOxWrzYnX0loS7jaXlO3nWcwvCW7oNPpNEPt/4ZJowHkKP9eVHJ0BaG81F4SYSPIxBHBFgRa2X31sfAJQAqqN0If1yNqrye827NOv42zhScKOpbSM4GlnHse9vKsXApXDPwFW5OQqCuQsBtdFm98fnbXtCaKGAkaj7NQCpOKVKTUfBEYkmnLkdUczY91pMu4IYZRuu15Gm/vddd5vGq9YIpjZwhswJnpyzu2c75G/16urzN0z26c8ulhY2rl6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acConbkRzyIFnrBwY+mlUIKJkFmis/rXsRMtEyJNpVE=;
 b=bsl+zwnbdCAaVXiZZ8NTobkhgpZToAlu0usyDUdn1z3LkCuib2EsXhWQdPZOmv6CkcsJjflyo/wpq2iNOpDnlxcqUAYG47cwuZfoAt3S12/eIxnKiLPFKRlroawqwcv2iIuQTNR40mEiAKnENYN43No7BM3du3FMXwjW3UJeAmY=
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19)
 by GVXPR10MB8060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 17:50:32 +0000
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8]) by AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:50:32 +0000
From: Michael Brunner <michael.brunner@kontron.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "lee@kernel.org"
	<lee@kernel.org>
CC: "mibru@gmx.de" <mibru@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Topic: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Index: AQHaZOjnqjSdKUSjjUiE5C/QNxRHxLEVDr0AgAAEVoA=
Date: Wed, 21 Feb 2024 17:50:31 +0000
Message-ID: <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
	 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
In-Reply-To: <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7551:EE_|GVXPR10MB8060:EE_
x-ms-office365-filtering-correlation-id: 7006633c-aab4-4919-4723-08dc33059952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c+g67ceTgb6JRr8+usbzDg0bxiBRN0SWNtniMNdUgGzbTsL45sqXAYXvD2v6KCEw1BniC63D7QDCQYt9QU5ElVNHu2pWCWSTkh9StLL4+JfFWOo0wu23vDIEpPaATFgHtTu1rhbv+fWRjnEcAbZF4DZtizkFSz2LIOVwuBXqMcDi1mJY8khJdvsbypgfxLCR4K1byw9rRRcRP7/5A32Txfs+o0mXu7B2GRYoywzA1Zq4zNYPtY1unTeNzgpkuxpRuyOO8YLbVH/vnMCBjv9zWP5v81ybc6kMlvs8R0mtjKbjHUPaLEU/SH3ezADW1+0XAFQ5RYV7lpfk63awg49OQt+bGPtGVcGe3fH9LDCj3G1xGA4GOygcG6J7Qllc3LiePvydacmBd3VBjebaQ/OP+9w9vD/QmYMsL/7N9aaht76LClrsg7TN9Hn76Nbn0gFUz1V1+FPe0ftiQ+r1GMSX4EpvWUUTqZs2wWwsYo7DNxCi68omnMJqSkM7WqtWLH8153uuikTpmLFZKb6OQLdkDC+I9rF+wl7sHHPZvYPLst+FmcLRaVIM5yKa+gPvZDF4HIcuSng1kDBhkQctvSftCVYWsxROXVuh+bJ4CsGtrZ2EJqb81g2OeqacwCphTG+h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?9Hh1W4AMSuVQbyj3FuuVaQ5wCS+S+gmqTnAjJRHq6TId4rmlCpnan2aXV?=
 =?iso-8859-15?Q?UHU/YiT9aeG68d4vkpGBjzkidV3d249teQMRpzh1pLdEzAopIyQ6Dy3Bi?=
 =?iso-8859-15?Q?L+ZlqlwQ8XHzZ5U1JzYU6Hrbm7k5d0P36KUobEB0j6ztay2vqKvcXzxLF?=
 =?iso-8859-15?Q?KfXX7xrTUWcHR634CCCI+m4sZElYnAkw4587Fci+p6ZNH50em3b6X/rLq?=
 =?iso-8859-15?Q?7l2emFg0PDTC7KHVOoJi6Pfma4ceSNcew7Odcg/qWq1rds9QXc/d90yAM?=
 =?iso-8859-15?Q?kef4kVN1HCcf73MkzNnTooda3lwfj1udY/RyqVpOwMGg8yLpEqPK4pA4Y?=
 =?iso-8859-15?Q?a6hTgf/x239YXLPTuWzYEYeegzV4N6L3kMaZ/hQ2EHMuXu6biBjd9gfIj?=
 =?iso-8859-15?Q?nDZniFZaCok6CaZuh2AMDg3sYipLZsd/ARVhF70+jU0MP7JXJiF5jnQ3G?=
 =?iso-8859-15?Q?0Q3cES6NbkP0q+grjMJLTOMB23/t7Npe+QIF4BShZfbPinz00AXbKRS9b?=
 =?iso-8859-15?Q?cZZOjMJ1CbtNJJYTXCfsRjY5cU/5axoRniRcD+lUB9i5RNekSISfB6IC3?=
 =?iso-8859-15?Q?4IZC3wvigKoA9184++RmxCh2CX9F2RjYdJ4Dcbhw8lqdYkQeGb5FYTc8x?=
 =?iso-8859-15?Q?zM+dGAXbrBUVFTI58JdEzVLLFZoB6XgYQFyk3o+XoEwvoRkZveA8DCeTY?=
 =?iso-8859-15?Q?52Qa0Bbui8tlTIUfGqmRYqEbm6tOxGZ9kgeMWbzlSMLfFZsC2RHbn8C18?=
 =?iso-8859-15?Q?E9PjD0Lr21PhmCJpJIny63mSCCyeG+d5fIWq6OnqndZJkL43VWz3UbElS?=
 =?iso-8859-15?Q?s4fdCrBrJ4qagv9zHvJDXgOGMYEtJ216FAXXeGrxcvlKM4UTIMwLpBaqx?=
 =?iso-8859-15?Q?p7Yv/mk84Pm7XM+a6wMYX8E9yOzoMPb4uNau8fnslVtNkojqNU8O2IOVU?=
 =?iso-8859-15?Q?G0tYTZ/t1N8BIjV92DKGIamYy5jCMzfWR9MiTl3DqoJcqQNWHXcoVpdsQ?=
 =?iso-8859-15?Q?gXQTQxrfSdJuB/uwEKCG71rAD0YQakgfc+3sRPAH7wX0rah6ZefhUwnM4?=
 =?iso-8859-15?Q?DCDB0K5MTrMO8hVzncTL41o1/YsOUqPtHCXIhHYxTOCHbX52TPkaXy0Mq?=
 =?iso-8859-15?Q?T168tuJ+pQiE3XxWXehBQBLMPw2Ru/eI7e060nw7LSqrvj2znDsUWtnkE?=
 =?iso-8859-15?Q?ihE3PEyWityI/+l3fk8RhtW+6SWAFdK57FMKNpLlneCWxlb+ftq7anLVQ?=
 =?iso-8859-15?Q?ICoGyfhnbTtvSDZWQUulhwAFhEQrL62qql2F/tfQIlbsCv21Ledueb/Li?=
 =?iso-8859-15?Q?I1pZ4SArNeeKB1iJwuLvOJtiNl52Aw7TaGKpQQ9enFc/ISg9j8Li1f60X?=
 =?iso-8859-15?Q?mhkpGiDQs3yHgs64dezLXcsJuzrhX/Fn+g9b26/3eYeMWZZzTjDgg3xpu?=
 =?iso-8859-15?Q?HnxN9VXjgDKOwJTVJEW0W7euyhuSP2hlt84BjT8CDELvR5VxnZNB9dLmb?=
 =?iso-8859-15?Q?iA4jFss89WDEm0RqbqrZh85ALEGYDdQQHuDhhVKBv9JPtB4moyRW5AZm5?=
 =?iso-8859-15?Q?U+3guJQKMO8cIJ2d98XhGPVTTT3s/VyHcwMyL2mfrTpjF/FWhduYrklDg?=
 =?iso-8859-15?Q?2YEVSj2SVEw6r3LFTnBedixYN96cHnx6DiaFVSKyFvote0WLGcnLI4QJE?=
 =?iso-8859-15?Q?vpl+OU7hU+VtL0DmrCyeuXdCJeAjzdnA2M652HDLTJTXNfk=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <F7360FF35922C6458E795313BDD2F2BA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7006633c-aab4-4919-4723-08dc33059952
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 17:50:31.9737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8vrCmBoW/GqoxBcJS4DgjKn9v/RGLJ1GhMinQ+7RJt4ZA8DeRAXJ38W2XL2gJbIsCBEQ4S7UA8NDrS2U0KQN7xItS0uVRamrdmSKMraQt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8060

Added Lee Jones again, as I erroneously used an old eMail address in
my original mail.

Thanks Guenter, for the review!

On Wed, 2024-02-21 at 09:34 -0800, Guenter Roeck wrote:
>> The current implementation to retrieve ACPI resources is faulty
>> and may cause issues that even can lead to non-booting systems.
>>
>> When adding data from an ACPI device, the resources are already
>> assigned to the platform device. Therefore there is no need to
>> retrieve the resource list from ACPI and manually assign it to
>> the platform device. Also there shouldn't be any BIOS in the wild
>> anymore, that does not have resources added to the KEMPLD ACPI
>> data.
>>
>> In particular this fixes an issue where the retrieval of the
>> resource list using /proc/ioports is disturbed and does not list
>> the assigned resource for the kempld device or even no resources
>> at all.
>> On some distributions this also leads to problems during system
>> initialization (e.g. with udev) and causes the system to not
>> boot at all.
>>
>> I have reproduced the issue with the following kernel versions:
>>      5.10.209
>>      5.15.148
>>      6.1.25
>>      6.6.17
>>      6.7.5
>>      6.8-rc5
>>
>> The patch applies to all of those versions and seems to resolve
>> the issue.
>>
>> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
>
>Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>>   drivers/mfd/kempld-core.c | 37 -------------------------------------
>>   1 file changed, 37 deletions(-)
>>
>> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
>> index 67af36a38913..5557f023a173 100644
>> --- a/drivers/mfd/kempld-core.c
>> +++ b/drivers/mfd/kempld-core.c
>> @@ -428,50 +428,13 @@ static int kempld_detect_device(struct kempld_devi=
ce_data *pld)
>>   #ifdef CONFIG_ACPI
>>   static int kempld_get_acpi_data(struct platform_device *pdev)
>>   {
>> -     struct list_head resource_list;
>> -     struct resource *resources;
>> -     struct resource_entry *rentry;
>>       struct device *dev =3D &pdev->dev;
>> -     struct acpi_device *acpi_dev =3D ACPI_COMPANION(dev);
>>       const struct kempld_platform_data *pdata;
>>       int ret;
>> -     int count;
>>
>>       pdata =3D acpi_device_get_match_data(dev);
>>       ret =3D platform_device_add_data(pdev, pdata,
>>                                      sizeof(struct kempld_platform_data)=
);
>> -     if (ret)
>> -             return ret;
>> -
>> -     INIT_LIST_HEAD(&resource_list);
>> -     ret =3D acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NUL=
L);
>> -     if (ret < 0)
>> -             goto out;
>> -
>> -     count =3D ret;
>> -
>> -     if (count =3D=3D 0) {
>> -             ret =3D platform_device_add_resources(pdev, pdata->ioresou=
rce, 1);
>> -             goto out;
>> -     }
>> -
>> -     resources =3D devm_kcalloc(&acpi_dev->dev, count, sizeof(*resource=
s),
>> -                              GFP_KERNEL);
>> -     if (!resources) {
>> -             ret =3D -ENOMEM;
>> -             goto out;
>> -     }
>> -
>> -     count =3D 0;
>> -     list_for_each_entry(rentry, &resource_list, node) {
>> -             memcpy(&resources[count], rentry->res,
>> -                    sizeof(*resources));
>> -             count++;
>> -     }
>> -     ret =3D platform_device_add_resources(pdev, resources, count);
>> -
>> -out:
>> -     acpi_dev_free_resource_list(&resource_list);
>>
>>       return ret;
>>   }

