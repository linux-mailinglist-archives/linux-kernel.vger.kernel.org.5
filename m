Return-Path: <linux-kernel+bounces-117890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16288B0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE7D1C3A390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDB41C79;
	Mon, 25 Mar 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q2AwBBDB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2062.outbound.protection.outlook.com [40.92.19.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51011CFAF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397453; cv=fail; b=Orif0dLXklB11E2SFPttzPwepwk8PhbhNAyc/1HlW4NZ9wgAJMt4Qck+bELwgj0V3OEuruwI6nbh22FSvdBB7/VZjiOtYmV8Q3uURv70AFJQz/KhxXU82BrAKaCDuJJ03NnqfN0TE7zWCdNXmhdd1ReGpxaOrl4RqyK3r6UN4v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397453; c=relaxed/simple;
	bh=YrU0XYUvyoe2ertzpajLqMYVfJ3BULs/yakzwyFye5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHvve0vtnCWVREg4PeBdI0QiZsL/37gl/BQMGNorJqM/C3LFc2hoBJJOeypZwIGWsWRpzV0pFCP4Ad2gOyjSRplBNdGIokP9Pu9afon1sJJ8dGAT28napji/8r/QQ9Dm7ugy39dPg0bSGUx1N243CMn1dDfKZ4/2OtOxuz/tn3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q2AwBBDB; arc=fail smtp.client-ip=40.92.19.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh3SnZ/ekA9mw89SBSVplU+y2pNbi+ep8URzsYXHY2n1K0JMxBrYaiHbA50q5zl53faSPV8grXypWQAwGY+MZ0cFaT3WKGp6dHUr+kPNOv/VWGnuCDNPQxtK42lZ4Vdje2wttX4YXcSU57Mn6S0T6mZ7pMGujGx885Jq26F/Qc3dewXMvH2kPCzQ94oLJpHjt8vmEvLfdwb3nIUxCfBIEVPXIktJtm0zqe3nvf8hI3h8XTCDzxwjRWHhv2iJzXO27ej7ahprTZum7Z2kbvgy1ooPNuGIAw1CS9Ds76OdLrExtYWPbcl0YnNmNP3Y6f4WhPq0UdNCHo+k8nygHj0ETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMyDKbheXEM5DPOywjJn40rkxzd4VU4M8Z9IXJXzpK4=;
 b=Jytlz1YwZSFtSwSVsEza4DmJ/9Avyj574J15JgOeAzny0Tn2Vym54DN5nzvXn4HkogO2SXHfqbGXgrHrmjArNFh7IkPZGb/EigWJ/hr8eYH4fRnkttvh047mVPgZgPZjImZXr8BvgycIeVwn8a7DYXm9q+AGuNeOCGsgQ0QhXFu5E37/HjkYVd0OqFEwdLnHmICGZwWUyBC6WLGr1WrqyEBn9c1Xfmxr3oWbQjTsE0EuaOqtbDnlFivP92Jfgo6BrufHhtzxXT+2zYQg12ZFl8qmtysAOdOxbu8iTsDLfL3sDU7VFJYW3m2O9qvngfAsy3L3UgAw2RQM67FTzP0sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMyDKbheXEM5DPOywjJn40rkxzd4VU4M8Z9IXJXzpK4=;
 b=Q2AwBBDBLUtsvozQ8OgV3RghKoVKzqrHEUzBDdKMvRyk4atyl0z3IDLLHjzxW1b9kBjhy9bJP/sH2foG7aM7ecjLzRgVxqliF8YIEGSCSBIiCsYOUQ1+RANF3Y1lx7UHHF5ZBMqciDzAg8z4EDSz4s2zG/8G0dsczPHdMD73fHHET+F653OqOJZ+Pqrq21u3gTcsLnuVHMM8CzWjroI3udlGSZ7xU+LphfsUbjn1KGRXrqJhvdIhaWtAVPU5Yp2gDiFeq5lM+cjWb/NuohmRvRR7LSoQ4cUlOMb/UMDmnGvdEuuFpMZKA7l8jsX91Oj7UQJVeQeg6Gds0vUCz17bgw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8866.namprd02.prod.outlook.com (2603:10b6:208:3b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:10:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:10:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, Petr Tesarik
	<petrtesarik@huaweicloud.com>
CC: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Roberto Sassu
	<roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH 1/1] swiotlb: add a KUnit test suite
Thread-Topic: [PATCH 1/1] swiotlb: add a KUnit test suite
Thread-Index: AQHadSjFkQAbswHN/0CHWY8wcxBdj7FIkQCAgABlAWA=
Date: Mon, 25 Mar 2024 20:10:49 +0000
Message-ID:
 <SN6PR02MB4157992232ED1362C41804DED4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240313092740.192-1-petrtesarik@huaweicloud.com>
 <20240325150641.0c7b2d73@meshulam.tesarici.cz>
In-Reply-To: <20240325150641.0c7b2d73@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [YWHbQo7uZJnkbbLcFcWg+7mzx77NrFni]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8866:EE_
x-ms-office365-filtering-correlation-id: 688f9820-ee56-45ff-bd0b-08dc4d07aa14
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhFs9rO1mK5NDxwqkoYDlhzR1mFl43RjkvymBBhaPV4h1HZXp1Z8o2jRABreDrmKGXyd5JZPjWMbHIZ+SMFhET0/r/zpGAmzWTWrfm+b2WR1gvxgrXRzrlp1M64pKDwEcEHcsFzxmJRFWYcIBFBomF/QJmJFx7Mu57ZnxIhtBJJeuQw7OxOG9zQ6sBYo55DCKZDcG7tcul41kBbDQy0QmZkmUabmmyvghzVntHkFFo8FaHmKlvtjK3nKQdFDWLh5PrEwJIfSOYlQEngbIlEHTr94gQKcyUW41w6JcgSjCB6OVmGC/Ep1RmW62Ke9maWyKnm1H33X/CrcDzvCrPE/ddyhYG7ZYvsteWsU8wZy2ztnlZXeCd07SEyQuXlheQyjaKtILbFhxqyS0pfRtqfg/QJbFec7nidg46ic0P4EBP6OKDhby7BGlwvGyH11xYlyB7ADEcim2mY3ZpOVUHBLB70k9d5bFq8+lFGSj+Q6ocCUfV4HTTnOsCGDa/0KWoeq/o8zPiF4q2CvWrybyFNtH0YxQeS22yGglCKNBPKeMm4EMfgLcmcckUO3cCsGB1zPFGcshnClVSQoPa1xNvWY+nmNQNXGGdL9a2drpT8coA0N+J+VuRGj9CoEfg1x9+4suGn5e8cajTO78YD++pxl6I6OYdQRzcqjqp/DO4VOjYDo/WnbmLIyY9EZl3QoXlfQebQ=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mEDaFvQPyeENTLV9wpwQYDzM9vfyQPbEIP4IDVXyBqgcbnzdObrkh9Mv7qHRRg9gYRraqkhXR9F4eIXMbE1W9m+u8kppLj2jb93CY8PbaeFfCJrEU7ckeRqOnb7FgX0AIIx6Vic+2caudqaBTAzEzkd/5CJzMQkJ59BO8aSk9ZeSLR1KUrFaz3ehC17m+qjuXJQLStOIYzhYsYOC6emfKmT0989RcSY/wDKkIZCizwVVndlYoj7oNfJN0UpvSfhgUW35bEIMyQXgkYXfk8h63NSJ4zvS5FrJ8RavpanvahQDYunkHzGIqcbP2Vmw7MovzjPxAH6V+A9Azk02rCpmQrJ+rf29fQXwlKT1cG7wg1HCab845C51B4R7F26EMEoo4f6cKtzzQCd8ZnyZrhq4eJyuA2RPkZK8e5J5pn7T4fDdSBwjiaYQUIKMKmL4Zsb0gTC1ECo41Jeqt4MNIDeePYRJw5Gv5C6FOhwmgx3f+sVaQbbJm1Mi+D1M95Gvvfs5RNDkuq2P6DaknMBjnawrpsseoAcFBXyBIwxd3pLzE8edozEyYwHxghlLLJQ3F46x
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?xpF3ORWm31U/f+j7Po8q2Fr0fk+jGtOLD5oSNjf3gEEFkvurl2bcmbFUWB?=
 =?iso-8859-2?Q?njNZAF5tfvrHXM9NfLJYVUZnSoCWfCc7AL++temLI2SpaeSmnhlzTcFfeA?=
 =?iso-8859-2?Q?Lh8YxQSmCmP8R/DXt5PxR1+wUoinrivPtGtdxlaielNVgMAKWXe5jhpn9x?=
 =?iso-8859-2?Q?9MwrON0hkp8ehhphgOPKTRqIaFwO9mVp6Yr0WaaBX5P0P48vdmEfLXNrZj?=
 =?iso-8859-2?Q?yZmvUvQSMsBylOtK2XJxTmB7kmY33RfbVsfWP+7ZiwyHfXhtQCvhHEsBPK?=
 =?iso-8859-2?Q?5LnUexpkOIEF/97Yf+X6SxqjH7GrKU11zZcmabknB5VmonP5ADHtvJadKd?=
 =?iso-8859-2?Q?Phs8N2Z0mmfX3N/WhRr73YcSSyEiAN/7jAopYFXczwDgMS4YC+svLcte7x?=
 =?iso-8859-2?Q?kAs7QJ6BNDAb/h2tWxmNqhJ2R0+P7lgWe8R65X7DGgjwhPXAFNv22Qd6Do?=
 =?iso-8859-2?Q?UFZANJbyy5+de58nHw4YeFJsJEmPWTsD0yktch/Ztt8CKCgzqkxqNpkrrF?=
 =?iso-8859-2?Q?U3ouK31zw8VhwCKwY3LM4tapRSnnCIO8N96jCgAa2bKXVjJcccO8q5F4o3?=
 =?iso-8859-2?Q?wL7iQkr0PzmSRXJhdY08sdC3Gf0GHiEdKJDf4miHvlUR2m/bOWGoXbbvAI?=
 =?iso-8859-2?Q?ohjv45rnV2FdT2frR40MKRWNbDAtnXsdMgkT+KbCrFZWMiNb/rIhEHCrkT?=
 =?iso-8859-2?Q?Wvv+ELPsnGfnXp3Hko4tizCxw+lbNMyiB/tRmXbT2rDR1+IliDZeYuoYql?=
 =?iso-8859-2?Q?geKQc7EoDx6CEI5g9PGT7mFf5y4iJB4qlk4e8bjgo0L37P/iZ8DKNjHkwl?=
 =?iso-8859-2?Q?VohOgE5YwCzy4924Xe47iqHKDlLCoql8ch3B6kG8vIAKD9HRxpOYIT91aT?=
 =?iso-8859-2?Q?kuFOYN+2rlbLa2+Dj7mSl4Kyz9y6RMOE6KTqSQetUetMWG26MJvb3FQxVm?=
 =?iso-8859-2?Q?oze+tTVLo8hF7neITBqIEgoGe9t0lyV7IoSwAWpIs0Aqlnw3qfUrry2FYs?=
 =?iso-8859-2?Q?+4ik855X838s3nv4SzX8gO3rphZl7PYHGZTA22M/JFG2w6ueXp3/ipTLr3?=
 =?iso-8859-2?Q?nZATCb+Ea3CuX4caXxV3nm4JbKK4+M1WpHl92HpWd2giKldtQzEm4W0meA?=
 =?iso-8859-2?Q?Av4uvgVxroRuXU5vnUD4pxcEJLRhiyUub2Xjzc7qiuvcaLhP+hJBTDBB63?=
 =?iso-8859-2?Q?/7efgYr9PmwRcRodtZJagoAayU3s+Ey0Z0yZJLmwsbmrRZZB0nVoHEr+4R?=
 =?iso-8859-2?Q?tsVqMxTigGf+mcPj2l0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 688f9820-ee56-45ff-bd0b-08dc4d07aa14
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:10:49.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8866

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Monday, March 25, 2024 7:07=
 AM
>=20
> On Wed, 13 Mar 2024 10:27:40 +0100
> Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>=20
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >
> > Add unit tests to help avoid regressions in the SWIOTLB code.
> >
> > These features are covered by the test suite:
> >
> > * basic functionality (map, sync)
> > * alignment based on mapping size
> > * alignment based on min_align_mask
> > * explicit alignment with alloc_align_mask
> > * combination of alignment constraints
> >
> > Select CONFIG_SWIOTLB rather than depend on it, because it allows to ru=
n
> > the test with UML (default KUnit target).
>=20
> Hi all,
>=20
> I know it's not super-urgent, but I'm just curious: Has anyone had time
> to try out this patch? Did it work for you?
>=20

I've read through the patch code, but I haven't run it.  I'll need to
do some reading on Kunit as it's not something I've used before.
I'm not sure when/if I will get to it.

Michael

