Return-Path: <linux-kernel+bounces-100442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9778797A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14821C21895
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399197CF23;
	Tue, 12 Mar 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qrv27bOw"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A17C0BC;
	Tue, 12 Mar 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257598; cv=fail; b=YSAewGIx0l3tgbk06j8HHG2oObMsHsuyf2433lRUib97Yye9RrlTeBjqxZVq2HY8e5sZ9Z/yODxKB+4H5Mye43mVpnhYrf8A+DBeYWVloJbVmvadw48dE2PNTODrUmllWuQuv3DVaxDKUeg0tA5gvczrvph784egUivmI95uJPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257598; c=relaxed/simple;
	bh=c/YbzWGznLV3QaYFpGRm+Bga6NDuvFHSiXXBpMg1lYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVkQKHOFymalYlQ4zhFG8FfIoQcZOj4F2lhAmgYXse1AT77aL9z/bRkNaBGyklyXXRSbnI5XKj0pnVta8oawo4EfhFVNBePyM91CEKzQ7fIebD95AlXT3XOlWtQRIw6Vo5jTv+z0MqmYBfFYbiv6BnMWiH4+0tK3ZkGjEvmDtxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qrv27bOw; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuAbuUq0L38Xs2/e3Uo1uKJgjNckxLZR5rTNl/LSLZM9/Y7wbtwz5qKFW0P5vesX/F/vvUgCH9MZ+ltlpQl2TBZtpAuVNbTWMSBqSuKjKXaIQe0M0pHvi9pQrQrWzD+C1fRja62cVvcf7NkpFw3PeBecEvFC/ZW6eJ7jfQQaPtWGWu60ECRl5Q8kXBrY08Dzqm5Uxh7ORWlnowMgZ+MMzMpgbGwbS6eAwq8+SWOiqxMSuH76DnSIdadgXb/Jo8MkaNmIv/W08orVrMwI2RNAVf4Oa3UwsWmV+mMNzZ0yoYDcA2vAsL24w0AsL4dinhczZyYA/LRsQXv4qNhsje0dbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBEAf9xVmQUvBeG4104tiu9ztat7qxqCtTi8oRSphn0=;
 b=NEt3/yvfsm7A04/hh01INrbflYeFz+NVZTS0MNhm5/US7CVBtRKIUuFkL3LTfvwa5g2bSHC4EmF+c0Eb+IL2ucHVIW31lMselv1V7dJOLiqwkPYBFBiTn8mq+BPU4cG3CLA8//Q0ix4fyH4U3TcFaSxhwjuI9XG0wjrXNnLYrwAd3VG+QoLRk4g3xHepqswekdCZpGJv1OdqQb5v3xhYFZV/DfVKUkdo3r/iUvbxNAo8rg54IrHL9Ki0/phJ2nWmxo9oKDKoASSP11ns+tEgbg5I/gssAEOmQv51eM9DES74cZkyljYX7CFXf/mUeF0MF60BD3h50huYla522LEn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBEAf9xVmQUvBeG4104tiu9ztat7qxqCtTi8oRSphn0=;
 b=Qrv27bOwz+Zg14Dm9PWJdGcqcrJabxtlsKnf0jVFXUaU7xD1AMObU/+yVkZcksI3LRMPhm2wlXBQEobnd44nSPVMEoOyeJ0t2jQTTr08Lp184LaGEffZZKBBdT8dwavnbckk0V5iBMVVUac/iYp31y+VV3zEwUSPqlw2boVeCZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:33:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:33:10 +0000
Message-ID: <e69948c4-756b-4bc6-b543-eeb0028da83f@amd.com>
Date: Tue, 12 Mar 2024 10:33:06 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v12 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
 <20240301181638.814215-3-tanmay.shah@amd.com>
 <fb78bdda-2ec7-4fcc-888e-233905a9386c@linaro.org>
 <17d58a39-7d56-4513-8d5f-7c18809c6cfb@amd.com>
 <cc06e895-e0f5-40da-8c29-0e4bf62bcacf@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <cc06e895-e0f5-40da-8c29-0e4bf62bcacf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:805:66::38) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c10c1ab-0bc3-44ff-ea46-08dc42a9b8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/y1txCgK9b3AvLW55rnaASu4Sx9Mhqe5UNmKgxIlORVwthd+N2RWCwMkPSsVJxmcPLvoL8320lYS/99dEwrTjbvLmxYyeeK62RSO+7/M6eq3v/yyHWzH0R2sdv1+t65c1r+nMxsh19nf+3pXhnXhd8ED+5PmKuPQQ0PAWFC0s2J10v8+AjANP+AAdKs0UbgtuxxQlhyYOyzBLsoezWsnGJyprdwTBDj9R7xWdEU3PAuyqKyOCW5UOdISiZUQ9usv3KKhdan2VafLMD38PJOmeUskKMptYaf4C+pDNQE2TqEAsRhrGCE0Rp5/pnUDLH/uxnxRSUNtLRm86/4QcUXl5BobBbvTxeY0/E3bTybHU59eGPPJlxArd39P3ZHt0/rVDvKAwkfzXjrIKGMF4gU3hwIkIf6lPf35MidTxZDqp4LGvsT+4K7TufuiAY2+HTvVLgShQVUBTPRBrcHPH1sheuCx+A0MKsvjCKtIqXAWWfr24QmnvHkuWSZLyNeI56osMTboyq5W68x0ibEdxboTX+2ABg+54cEzdcVVld2orxIsVgI6zvAJbIBv1l9hxvruixwVavQWGoheRXpqUuMPUsJBLMtIY7CZTSNMIU4CqRRaorPbY/NiLzGa/9KeCS/o9J+Z6fjZWf4FL4mgkIoidLxx1Avga7rApXoCa7a/dns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFrYXk3d0pwQkxRaXhUTk9jOUN2NU1Ea3pwM2tDN3hEUndsN3NRaDdFSExW?=
 =?utf-8?B?a24wQjFYYUptMlU2VEkyMm5Ca25ZUmZud1p4eXVWY2R5MW1oQm9HbGFGSWZL?=
 =?utf-8?B?YUp6SGxzaFBBT2psckVZRXFmQzhFTXQ2WktBODhyYVA3SEQ3Y0JGZmpqbGdm?=
 =?utf-8?B?YjdDdTc2WWZpTHkway9USTBWdDczR3FtdXBkT0dkQVpTY1BBTDZ4SHJOdkdt?=
 =?utf-8?B?NnFoK0t1Z080WVZvdFZvRnArTnJ6MTh5OE0zcEdCT3VSanZTMmY3cmVDWGhN?=
 =?utf-8?B?TWMyWklIZU8rQUFXd3hFVm9xSlJ4VCtLTUpaNFprMkdUMi9CSXRORzh1OFdB?=
 =?utf-8?B?WStuZlhhdjhaSW9jcC9palNwZHV5VzRselhIbG5QTmc3MzFvQ1VKMDF3QTVn?=
 =?utf-8?B?U1BTUDhnejN0Y3VtdUZhMHplRnRyb0VWT3BzUTA3ZFBnZTBKMCtRYzI5OU9l?=
 =?utf-8?B?c0lpMWxLSXFYMFlhWjZrTUZiYTV1V21qZTFSekJzd0hZZC9sZEhwN1NicGZQ?=
 =?utf-8?B?d2ppeUdBVU0yVjY4ZGJDNzIrb1JWYXI0VDNobzRybEZmbG9la3VENDdUUmZS?=
 =?utf-8?B?b3FZdVBSSEdHQXpKUGxtSVNiV3M1WHJSMGhVTnAyaG01RWxNUDRacEszMkRC?=
 =?utf-8?B?ckpiTHFRRE14RUZ6eUtzc0dSSWdtRGNIYmFHbStsOHYrYzNnQU5ER2FTNnRL?=
 =?utf-8?B?NUcyenhPVVpldEhkVEF0TUphWDhUVzVYT3pkcTBjcnFEVENnc3pNVzNwS3JH?=
 =?utf-8?B?ejNyUUJLRVRRRXl6MmVsM3pocTRSM1VCVVZra3lnVEJBcXM3ZzVXZ3JEeG5o?=
 =?utf-8?B?VmxWYjEyd0dhWHJqUWh3TGptOXI5VjlLRlNoazdRVUxXekwzR04yL3lZeVlH?=
 =?utf-8?B?QXBnS3MzcEQ4MVBBN0VFcXh4KzRraWN6UGEwSTF5VWNDeHBhRUwxUDJqQm1N?=
 =?utf-8?B?bjdLWklrNXRkWWtYZUtSdGFWUUlDNjY1R1czcHJVUTRFWUVHUjNYV2E3Z0dL?=
 =?utf-8?B?UERTN1hhNXJKUXlBdG9YNVZldWUrK2tJcDRjYjBTTGxZY2FaTGJjYkk3RUlt?=
 =?utf-8?B?OTJVa3kzcjBCTGRCdnZHSW1WWmNIdTFXby95U2lHbGRsc2E5NDdVWWlpZjRV?=
 =?utf-8?B?NUJMVGJYUWxITDcyT3dvM2F4aHQrS0tQb3dPN29TNkNWbkh2QWpvQnI1K3JU?=
 =?utf-8?B?R3ZDQXpxUVVxYTFNSWx6TjlnVkxXZW1RbXF0SzV4Tkw5eTY3RW1Sc1dPcVM4?=
 =?utf-8?B?eW5ybHRoS2lSaVdrM3BidHpMd0dtMnVFTEFmbTdvcy9YMW04LzBrZ1I1L2Ur?=
 =?utf-8?B?SmY5QXRKajdwUnAxSHUrUmZ4QzBtRlczVjRmTW1seXJFUy9rRWIvQUJvVjZn?=
 =?utf-8?B?dXhDZHFvREp1aGJiYjZudjkvSG81RXVDaWxwR0VCRlQ2VkJLWXR2b1gvd2xB?=
 =?utf-8?B?OGpDWTZES3NrcnRyZTd2MWVmZXdOUVVnL0VQcU0vMUtNdjkwMWxUU2s1ejZn?=
 =?utf-8?B?bjJVUTJzYzBDUWlUZ2s3d1V4cE9DdTF2bHdJaWhiVzRablp4TWV4am41cmVH?=
 =?utf-8?B?WkZWUDJxVHFEMlgxbXYwTUVNeTl0Q3JHVnVKeU0zR2JxNTVGQzFVRCtxN0xy?=
 =?utf-8?B?am5ISlcvckN2MVdFSWk0WWgyRklaanVYMVlrcS9XRXduSExoUmNJaEs4ZmQw?=
 =?utf-8?B?bTBraUJ3d2RnYWQwTFI3VExGaGt0M1AzdTZZSnY2U0pMTTBHWmdPb2g0cVRL?=
 =?utf-8?B?U2dBWDROSGtIZFZyWnMxQ3NsTUliK0JRT0p3eUNuQTdscGhzR3ZPbXNKUzAw?=
 =?utf-8?B?b0oxTUVFRFhERC9Nc2U0SXdHNG1Kbk1BUWs1L0F5cGFuSlNRRFNHN0tqMHcw?=
 =?utf-8?B?Z05SOHBKZ05JYlF6QnQ4US9LaVVSYnFRQWRaYk4rUEc1eXBjc0dEQXNDZDdO?=
 =?utf-8?B?Y3ByVGt0N1NHOEEwbE9NOHh4RzhQTWpyZTFIcXYwWm9JZERGNVlRVit1Z1NE?=
 =?utf-8?B?WThlYi9SOWh6OFplYmZqYXRPcHVNblhmNmtLL3d2QjZZSkcvZG1RRUxRMWVu?=
 =?utf-8?B?cVJMM3FtenlBcjE0YXcxNnJKYVg4NTdqMWd1SHhiQkU0b25PTHlTWTUrc2FT?=
 =?utf-8?Q?IEbriBF0QVWYA/gjVrlCX684r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c10c1ab-0bc3-44ff-ea46-08dc42a9b8f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:33:10.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQDI4Qvfs0m+lDOk8KcABP5jpdJd3vk+7g9YkcFNJaxBFW92zUJm75Iy3/C5zMEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139


On 3/12/24 7:10 AM, Krzysztof Kozlowski wrote:
> On 11/03/2024 19:39, Tanmay Shah wrote:
> >>> +
> >>> +    else:
> >>> +      patternProperties:
> >>> +        "^r5f@[0-9a-f]+$":
> >>> +          type: object
> >>> +
> >>> +          properties:
> >>> +            reg:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - description: ATCM internal memory
> >>> +                - description: BTCM internal memory
> >>> +
> >>> +            reg-names:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - const: atcm0
> >>> +                - const: btcm0
> >>> +
> >>> +            power-domains:
> >>> +              maxItems: 3
> >>
> >> Please list power domains.
> > 
> > Hello,
> > 
> > Sent v13 addressing both comments.
> > 
>
> And gave me exactly two hours to disagree?

I am sorry, I thought I was addressing the right comments.

It was minor change tempted me to push new revision, will wait longer next time.

>
> Best regards,
> Krzysztof
>

