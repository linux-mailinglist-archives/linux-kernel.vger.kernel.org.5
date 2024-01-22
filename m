Return-Path: <linux-kernel+bounces-33188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65648365D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF04D1C2258C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4A3D57D;
	Mon, 22 Jan 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="giVRhsB4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2013.outbound.protection.outlook.com [40.92.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466B3D56B;
	Mon, 22 Jan 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934939; cv=fail; b=KYTghefZsRnmV6NxkvV7grD2zJLjru5L/DNMRwG4YlzV4mxOedVMYu8ueHN9jUITDJa8ZUJ32786qKuv7pnRuGwREO58t4g9i5reFvozX0k1OMITiRe/JjbUuhQfith+6DCHfHPlYmc9S/Qxm1a1mJmW/raHK8jAom+QdUmaD28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934939; c=relaxed/simple;
	bh=RRnevTnp5NZYix2dFA1lpK3Eh6I9a5b1kk18RIpGqLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkiQKmUgxSYjiidRsnbeA09rNmeT/CSDEur8UewndI2YMub3qdS3IiKig3G5B+UC+nXJOtt+nytmZN1Mk1iHF44Xo+XzDbjjifArWoNLRUaEvzyf934mS3C+lQ7Z8mH3sJot+WEi4uwQZUKaepEgL4BzClPqSA+Wt7ATUrkF+iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=giVRhsB4; arc=fail smtp.client-ip=40.92.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvDxMn3n8MSWr8sIHC/It0yYH38X6guQPsZ+I0rT+gKbNNeVv9bPadQwPDubDKE+/i9Iii8cUI7pO15CENJodIKeZhQYhDpzTQtbl/jZmAlsu5N9WQ4YOdKR7a6+0Z/HVROcVeHLahCcNxQkwH9h/bjxnimmWgrgnQrYired/2lXfG6stPFrrKZxhGADXaGvYGry0DlAyRbP+alayD5eZtvU1SWf/O91ifvNiOKP2MAk+lQdgkuhfNe7Ot3XRKlUpv+Xp8oeiuY2NBwUhiLUWwxfky2gtnyd/JuI3ouLSmN8cYvSwoJm2rPuVJ6P1eWN8zHoR4yBjy8LntTfYfkCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaUnUK4H+whPRA7xxPbNbgB2u01thfzp4lXi4JwQ6Ik=;
 b=ZUm93mOnJ+vpLZOr2fOhFcU/6p1lGHmHyIh0zKp0q4HqoKMRpBjWTVAI5Lw2wiWG3aX1l0uOqmdTHffcBlzJvWvSvlsGjcK0vukxz/Qb6JlXln2KNyZAjVv3DMPqFjRYzqQui+dlex25QZn4oQbFhhErv+nWYSHzecS1dwkBgx8WrLwe45izDjK6ER2Helnu4d8TQRGyPPO5DQZc8PpX0M0XGyiye2Fi9amKBoqVhObo4N5nuXSUQw2WSopE8y6Tpy5lXmDOni9F1u0f2chvjdKQAz938S/16WHvYi36WxQbAbQgjrNEAgQ9mea2fz18n+WAi8CuwBHYQWbSjR2m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaUnUK4H+whPRA7xxPbNbgB2u01thfzp4lXi4JwQ6Ik=;
 b=giVRhsB4PcZVUdDxlS8d/S2eawYcg6xCQEd+FB8Cutr1u7lEynCBYU5iKV5gnAUPw2L04+GlyDsj95/XBg0posP+jRSLC4mL3Xi1O43ZOVa4AoDJ54WbAtMSIYZLwt7M1Ybf87oo5auh4Vq7ZTQPjqePSeBfl0mSEdlHX5DGAHzQg37AQHmnfQ0cv9vSQflKOIcGUQDpRdR2LlPcmv18Onw/fUXKgNHceQpWGeVYayaCofYc4fuKVQGCAjfQettDNGmnBXiW7k/KuMaibLD/JPdqlXsY4Atv9hiNEOLnSJI1TSCDZhHfY1VdbeW8wzwps02RtCmHO8oSyyXLsZ+uXQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by JH0PR01MB5558.apcprd01.prod.exchangelabs.com
 (2603:1096:990:18::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Mon, 22 Jan
 2024 14:48:52 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:48:52 +0000
Message-ID:
 <TYZPR01MB555605D62765CB4D548207C3C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Jan 2024 22:48:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] clk: qcom: support for duplicate freq in RCG2 freq
 table
To: Krzysztof Kozlowski <krzk@kernel.org>, mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Praveenkumar I <ipkumar@codeaurora.org>,
 Abhishek Sahu <absahu@codeaurora.org>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <01c61975-cc78-4045-8c60-bb11045a7c97@kernel.org>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <01c61975-cc78-4045-8c60-bb11045a7c97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [xvFBJBVqUxYVsQiTpjSvtcxCxQkISDGc]
X-ClientProxiedBy: TYWPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <37c5b44f-e2e3-4576-92e6-f1ee35457abf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|JH0PR01MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cc0fb3-f045-4a4a-0a76-08dc1b593fe8
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwVW9E9DuPMSJQYDsoO61wNHAyBv3x15cQCZHeko/dZ4YWiCBPaq+jUDBBPxcbw0ZzQ1exN1LUvoqtsUGSuEtni39f02r1FNrEXLitnJKrSHVnMAJcJLhI4mWEA8KQwSCnayEc9gQ6SVyHZpBIsdzUvSUEZJKLRVlLkO39gc6vQaCPXW92MVJUv7sTgFdkgMSUQK/6r0oLw3tl/qO4Z87079K0SRc4PKNJRdH+dAPjApZyr0Xt3uKMfaLpMkhEwkb2zXm5XEgNkgZZ0laPMD/HyQMODNm6gR2a3Yy3EeIZFVW5FmcSqpMKJ8fw0viPzGYYHKnBMJkkRfi+2yLjq9i1h/HJeKuPe5WQcQPoO2WWgaeBmJ0kK6EGfFix7hwNVf6ZeA0O8e4kqqDccciPWj1avFQj9SAGlGH2X7HETyPmLjew48oetyALUQERzkO6Z0BjwHGg1bVn8c2VKckc04mMBWwIQDyO3qjrQCwJma1uyFteAhebrRCYhgYyCqROB600zLcspS+hzJ88t43RBYa96CJNh1AtHeKXaSV13yDAXo4sglo0pP6WUmGCX+HNt+3M+YdXcugFf86/Vc+8GfMjfHYC3KtFV3a4oZ3/asSsXRb+c9Sa76Yd8TeQML//pHPYd0dcxYi64N8noZzLRcQFLPmV/iam2WLr7xPocKmUlzgjt0S7cNEJMq0+CO/AvA2WmmHsUVnNiGWH3j3JSMUaUGcmnf1JRMgR1E6qx9698Rvmb7SaX7wafGhWpzyU0fsQE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aRLh7RiXjVs94dvQCnWAjxbhGfFpjhmbtf3iH5REkE6LYPCs5GujU744b+04aepCo1LKn1c44NFuPN1U9c8FvpP9c4oqXQt34KWkdJTNyL4KV+AQPdVKCsOiSgRMvs5bMB8NgqHE1F1X+l51Kp3UE19olnZYn71zZAd0izi5Kyb4mKq3/lhNlbxfDO9s2Pj7sa0H782eGROPHAMKJf4vIqnCC0kjItRK96NtyTM5ODdQ8AXdKRvmh8XNP5R190Uqt7oAboBuSfXzilxc3cI7tuFWu6USzMuJZKigcGO2i8gNFekF3ZEQea7Sra/5+Nrw2j8dxDeIfsENSgU5Jde4yJp+bCTclDdJ3oALiR0dyoP9vAL6blMFcOsuBRnCEeozipu/xuZEjYQjm6qkdvfxkKAtYHAQ/MeLxncyy541EUlyUVmda16xB8Mxus3B2PTIWQABR4PcJ7Ot07AOoq2m4ReU9bJnlvW1uDlSIfR8y7/rSO8nXQQ6s+knj7hw7hmTPeMTCJxaC3a+5/0mYlbX8JfzxtMyA8f+ElKzwB6wYnOurppSi/7OxUg8qRh8vmn9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRudFZCTHc2Wktka25DZDVNeGppZVA3NXRkRlV0K3VmU3ZOVE5iYjJ3aFA0?=
 =?utf-8?B?MjhVcjNuTkhpV1YzV3c4QjkvMkVsb3haMVY2SXZCSUd5UHdDUHhMalZYcEpl?=
 =?utf-8?B?OXV4SkY4VEdIYktWWnJ5ZCtNb3NQYkE4Q3Rjc04zYmVNR0JQdzM4emNhQjJK?=
 =?utf-8?B?TFhMS1FlTUJPL09FaWkwOWNTZEMwWXZVN1NPRGhiMWgyOFlXNFlvQmVBL2xn?=
 =?utf-8?B?LzZaY1VVR0FBS0FaSnF3N3hDMmswRUowWStDSnMybnJMb1BKenk5Wmk1S2VB?=
 =?utf-8?B?ckgrRnNIK0N2dFlpT1VjWDF4eGM2ZTBpSDdyQ0R4UTZHaGY0MUIwWFdrRGpy?=
 =?utf-8?B?UElLbjg5U2NTWU5EVFo0cG5BQm93OURnRnRCdHZUUE00MCtvbkhlaGpiV0pr?=
 =?utf-8?B?S3VVbTFtMDFRaDRlL3htWHdFMGVpbDlUUUNvOWUrV3p6b1VZMGVMNWtOb0NV?=
 =?utf-8?B?L3JMUzB0SDRLWXZ1VzJOWmw0NlR1ZmRDNk9jdVVtM21KSDRpVjNKRHlNVVRX?=
 =?utf-8?B?aElLTEo1ZVVUWWUrMmtZcll1ZmpYSWVtcUlzYlNROTRuRi8zY2ZIWVFvRTZ3?=
 =?utf-8?B?RmZtaUZ6NU5uVE5WOVNrbmdPL3NEOGoxUHdQa2p1eTdwWlQ5Z1crS1VjK25X?=
 =?utf-8?B?cXorRkxEOGpKVEUreGs1MVJyYVN4VFB0TmFFdkRMTitZNlNNZTJFRVFlRlRV?=
 =?utf-8?B?VTVRQXFhNTVrSng4d0tPb3pTSTVGM2VPYUNlUGg4UGpzRzk2RDU3ckl1aWND?=
 =?utf-8?B?clRtcmFxMm1WaXpoTVJTajJ4Rjk5bVNWbWtnRm1VZmFrRkg2cVNIaUJEcFpH?=
 =?utf-8?B?Q1dxUzlPQlY5bDZDeGQxNDJjMnp2YzU2ai93bTNlN21vZ2hhMHJveVE2ZUN0?=
 =?utf-8?B?WndvTktXQ1N0dWdFaUxRZUorNHZrUlRXcnFWMWlhVUJuYlNEZ0NmRGtKOHcr?=
 =?utf-8?B?NXBnbXhLMUl5VFZzZ1hBbzVGUC8vQmJKai80elZnemt1aDdoeVRaeGxicnln?=
 =?utf-8?B?REQwaFFmYk56RkxJdU9vdXp6YkgzQmM2ejNsMGJZOU1vYkFyTWdxY0MzWm9Q?=
 =?utf-8?B?SGRHMFhuSVpmYjJPUkdrQldITEhFcW5KeWwxTG5OeDE1eERycHdrbHhWT09u?=
 =?utf-8?B?K2pNWWFmVjM0RG12NWVsUTh3eXNVUjRtUGtjSXV5OGU2ZFltWitrbmE1NXB3?=
 =?utf-8?B?T0J1U2R3TXFKQlhWcTVoQmhRM0o4RVIrYTFKazVGSVVacDdsUXAxMkxHMFdX?=
 =?utf-8?B?ejVyTFFqYm9SN0FBMlZqcDNUYk5PYW1FVnJ1M1ljQ3g2aVRBSWZEOERKV0R0?=
 =?utf-8?B?a1c1dHlUenIvUUh5QzJIaDZXQ0hHNU5KZnBadFdDQUV3TmdITTd5bHZERHJI?=
 =?utf-8?B?dE5LdWlQc08xR1VZa1RmTXRSVnBOQlV1WFVJTnNkU2d1TEp4QUI2ckludGRu?=
 =?utf-8?B?aFEzRWZzRVlzOUcrczIvb1plZ0s3ZU0wQ3VZbHI0R3RERHZnOFV6djg4RVR3?=
 =?utf-8?B?ZmduaHdwT0JEdTZSaE1RM3pMVHVBQ29ybWdrYnp0ZUwvMWhoR25SRnhFSk1p?=
 =?utf-8?B?dmVNblN6NEN5MzByZThUL3RYbVo1NVVZN3d0R3pTd3NlcW9XYVZBQXFrYmxR?=
 =?utf-8?B?S2RqVjNxaXV0UW1YT0pCVXEyM0ltK1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cc0fb3-f045-4a4a-0a76-08dc1b593fe8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:48:51.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5558

在 2024/1/22 15:55, Krzysztof Kozlowski 写道:
> On 21/01/2024 13:42, Ziyang Huang wrote:
> [...]
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Sorrr for my mistake. For easily comparison, I added these patches to 
git index, which mess up ./scripts/checkpatch.pl and 
/scripts/get_maintainer.pl and led to wrong results. After restored 
them, I noticed these issues, will fix them in next patches.


