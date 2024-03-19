Return-Path: <linux-kernel+bounces-107595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471487FEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B89A28411D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4EF8005A;
	Tue, 19 Mar 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="GC52OMZ8"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2090.outbound.protection.outlook.com [40.107.14.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80202E400;
	Tue, 19 Mar 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855235; cv=fail; b=I3/LvlIqYFYs4lK1b7df0pUQGKUrvGYXoC2c5RiLbfBM89btM1vlL8D6YkogywfEXNtEU7evuzkDE1GrUjSYPe3bx0v0mggtut4WEfhcCgsUBmQvl6kqpjAIrFoGF689BWeyN4t9wyWp+ZdkChcdPq4XvnXzBHl/tC0uC4zbA3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855235; c=relaxed/simple;
	bh=YhLE3yOkYz9az3exxUFkDAPcbDjvfz5Dyv+mTTouHRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L24QNDLKmAfth9qE33S8/gM4Wy8j5fTDwsxS/oXzsVf2duy9YmEj26xTM3XlB/IMQctZJI5yArzwLrla0Tuymy39RMLt4nUEmhG6NkQ7GnPe6Y1Ar19UzkktFdfqcjqdYbnzqBOpU57OdWiriRCa8o6GiBPmWHMmOHs1MzzzfUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=GC52OMZ8; arc=fail smtp.client-ip=40.107.14.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB+YCV1BUI9iTevbms5qWuOgQh3krukIgozYTrMwLbp8NKTz+cnVHv90AIlmn26+qddPpZUQcEI9Ul3OxrJKsPmcfqoP/2u3NycNRHbRiMMquzdk3HlSolkCTh4r7CrUMBEITFqrNWk4tJcye478nLBokzmLOK/tKJJITcwWZuugaHJOKyOl2yvxTelkdhq9qY1IB0TpeI2NVOY+u39TUZJ2I0MFc8nmxQCAItM89jN3cFi/w1AdpUeRyTWJP3piKiw+FLpgmtjNKCU7hzorIszFA8Z3tFraVPqAZwRU/UAJhn+hNqF5Q9JdUUuS+2MyWgUFfjqb2mFo/iD5PnHLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJZwKwx5Qgr94CJ72QMcxqIEx2fDsV3FHNLUiT5jD7s=;
 b=CK9n1WxRkd+XqtfTjGAXMqa4MeVdkKl5z4xpjxiF3lH1A02MBOp8WSC4Z3iAte6o3j2j5Ker2fkojsS7+uo70uAbvSDDidBVI0biusEB2tl8RKToXtLKe6aZEIdlYcIV2ROj/beaTDjAHA3oDmwjeEWzmtubh2gh0zZjBe6v1v9d1yZIkX4fpq+vBDI8lykHPRILe/kke9vmcUG4vbOLkxWBk2ebXYmgmk2fOAEXXZl74tGOtD8OkzVa2QAuem7f70kNzSYyQ40kMAQBQQM+JryI4L5IIGu4P53VUh57p4P60rXP40QYUwXecamv04UGAl3FB0SpBBFwnNaw6VE+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJZwKwx5Qgr94CJ72QMcxqIEx2fDsV3FHNLUiT5jD7s=;
 b=GC52OMZ86ihqq25TImQ+dwVR712tshQPAhRJTFQS0cc4SqJukBfpaIE/fQ3mZCoMpu+RLZ55tMtRIRy2HwCf/hk+kj7TmrAPlbBDeLp434YncRP8cV2SxvVeEsJECyT90dADHyuwCzJJsC9IZdYl3tbjLZN2S/r5C5l2j1mpe+jPsDKpm/lxsxYpaW3EXWMvxlBFhjsWCh84e79MBZ8bYIuJY2hw9BfJb6EpPxw8mSeXF6RRxcgd3g4ZrRCD6RzOYJfkDhCWkMxFf+fFm6XJd/rP9Cpnt5K0S8+L7YPkg3uEIQJpKfOzqSgRRRy9PJEC9BcZugf9bad+DS1zs1B9yA==
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 by PR3PR04MB7244.eurprd04.prod.outlook.com (2603:10a6:102:8e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 13:33:50 +0000
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2]) by PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2%4]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 13:33:50 +0000
Message-ID: <4ed9a005-6f16-4fb6-b9a8-f753ad78eac6@criteo.com>
Date: Tue, 19 Mar 2024 14:33:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Erwan Velu <erwanaliasr1@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313090719.33627-2-e.velu@criteo.com>
 <20240318174503.GE1623@kernel.org>
 <d33b98de-dfc0-445e-bdd7-0ae76d050ed4@criteo.com>
 <20240319122024.GJ185808@kernel.org>
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <20240319122024.GJ185808@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0197.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::17) To PAXPR04MB8989.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8989:EE_|PR3PR04MB7244:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cImAhg8TVeFZYquqYpxmgNwXCFSa2vcWWu+nthxXi5NX7VsY3wIAVXlkUNo0/mVSfak1JE8Vz/Oht2R7KaJSrmmyg8w4VIvc/AvZ9HVyl/SYVE2zNHzLp4ZPnpVKB4ZuK7EnLj5MUvKm2h0UOzCpaFfPGGpewUlzlXneLZkVb7lolOzC2+4iOwSaOAhXmCtkW0kz4X0/CC38k0j/66FZIB33Guc8cARB/Z9SetsZmDkpFAJ17/7laGHQ4qJcW7BKBPhrr/biOysqTrbaEFwhgRMpIAEmtcoAYtB9jsyxNSlH/SmTecquxitY1IKRkz2oNv6RGXpmGwuNecSkEj77Ff0DFAvHPwvVO8OSnKAxbEXpLPHimwN0Dtop24oA7OQpdYtCUqxvML5PdR2/OFumNEoWPkdSsWQs8eMxXMm0cNSKMyvVee5RlBMX1OmEcXPKwqHTLimYIQu/1/jeDvi5jykQNTqaoJekVRBOvMtFfw6KJG/T3DyHmycc5u7uF/e2ZeJQHvLhsw4lLvKspK9A4jTQXRJ3Pw0qBVwllmFCubz28yS46TpeDOVYUugwYhY0Xdn9J4wVIweS5mO87yVuxXrr+ph4xjP5Uvn+CUurV+BtXYzMlMv/kQLzGkSRuuIC1g3mfPcU+pJsFkh/0TuKNpRUpTip5w5B5/MubZ43h+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8989.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnRHV2pDWVBrYy9xSjhHT2RUYkx2b3NKSjZaaU1qRGkwMHp0aDdJWmRvVHQ1?=
 =?utf-8?B?K2VGNUQxaThrOHZvN3NWeUxCaERTNzZVQU1IdmFKVFNrclNQYzluWllMUVpG?=
 =?utf-8?B?TEkyMXZLMmRYaC83ZVZKaFBsK2pZS3ZRaCtaUmc3WTg0ZDVMNnI3NnJBRC9a?=
 =?utf-8?B?TXA0UjJBY1VPYUU5MzVTc0lWU292dm9LMlI1aUZtc3pxQVc0NU5DVVpGM3Zx?=
 =?utf-8?B?ZzE1dzRPbFg3ekZuaXVuRHloajZqdTdOU21rQWR2eFM0aS9ZbGN5YTI1RDRt?=
 =?utf-8?B?WmpFcHRubFExKzlzVng0aHBLc2FzbkFIaWVIUklNZzZ2VFYxWGtiTUpRdlpV?=
 =?utf-8?B?eFFMQzFlcnFvUlVSWnhWZ1YxbFp3Yjh0dWIwWWlmUW92WUJ6MUpFUnNJL0Fu?=
 =?utf-8?B?ZmwveUg5TER1ZXh5ZjBQYUNPMnZTUmI3T0Y4dUpyU2VreU9hZlA0U1JEb0Ra?=
 =?utf-8?B?UnJMYkNEVytTem1hVmhCdWx1cDU5OVZmYzBuZHRtRmhiVzlQYUY1bXlLT0xt?=
 =?utf-8?B?d3JubFdSa29LSkI4WUhsRXdwZEdNT3hVd1hRTk9LcSs0UDlwcTAwYldIM1V4?=
 =?utf-8?B?VUN6YTZCSHdzbHFVb0U4QkVOWEMyYlBWeThCQUVrdEkwdzFqanJHSE8wNGtm?=
 =?utf-8?B?NUEyRVlERk02eU9rQVVJbHlBaldhMUxMa1BFOUJXRmJTK29pTjhMdmJIYVIr?=
 =?utf-8?B?RHJhYkF2Nk9ueVY0djk1SzlWZlZSVXFQeHA3dFIyc1dyY3hMWmlMQm5Ycmpa?=
 =?utf-8?B?WU5UUzUwYk1ab2hJSGl3RXhUTnFYS3QxZFlIMTlrMmxWQ1lUYStpaTFwYzlX?=
 =?utf-8?B?b1VCVzYvYkFZVXh1bHBZdytjS1FNQXFzOWdHWXMyT2FRY2NzbFBBSkJhOFVw?=
 =?utf-8?B?aW5STmpVK28xNWNpRzB1OFE2a1psaG1RN2pjV2Z2ek1VYVR4V3REMzJxNDB2?=
 =?utf-8?B?MDd2bG5xOTNiNmRXNkNQcEZtYlFCdk5xNnk4M2svQ2tjZ3c4OXp1TzYxSEdL?=
 =?utf-8?B?U3FwV0NrZTBwZ29oQ3N4bytpa2dMR3E2eW4vWW44V2s0TW5PK2dZY0piNGNq?=
 =?utf-8?B?eWc4Y2J2SE03MXRqaGJrYW5hMjEvMFVqL24wL1V1ZXpHSkN2S0Job2dvdkZK?=
 =?utf-8?B?NG9LOExrb3FnUEFDbFpGeHloNUhJOTY2VWhwcUlUNlVUNUFBeDN4WDRhcFZo?=
 =?utf-8?B?N3pPeDVqTHpqVWVKK2Fsd2VvbUdPaWFUT3h0NWdWNkxNd0hTT09wVzJ0T3g1?=
 =?utf-8?B?QlpkRm9KNFJ2WXo5NG9yMHB3cUtQOUUreFpNVlVHNzV2SHlRRHR3K1did1lr?=
 =?utf-8?B?UXA4RG1hbmhKWDZRWWdFcmZGT0FQQWV6SFQ1a1NqMHg0TFVtaWlZN2gyOXMy?=
 =?utf-8?B?MDZNN0F5SzJZNGtZZEg3b3N1VGFoTHltdzB4a3N2czdSYVBsYWt0K2NZQlpY?=
 =?utf-8?B?Rm1kZzFKR2crY3FwNWR3NGsyaWh5K05OZldEdWZleVNTK0NQUGp1R3pyZDA4?=
 =?utf-8?B?R3paMllRN0tQdkJVWUhoaWtuQ2RpbnJRUWlVZFQ2bFl4RlRhcm9XOS9LeDdu?=
 =?utf-8?B?bGpGaU4wVWZxS0NSSVR0MmFoNU1RZXdaeTltS0ttbmlqM0sxeFQvaTBHeVdh?=
 =?utf-8?B?d2lsMTgzcy9jSzhqellHT1FYRmx3aGlnYnJNM2JjNmdVajR1Q3M3cE9OOGtP?=
 =?utf-8?B?L0p5bWVCeS9zaTd4Y2NYWkEyeFczeXBqMEoycm96ckcrWmY4RDJKMUpJOWtw?=
 =?utf-8?B?R1JTZ1FhZlkyRnAzNnZraU9EMTYxV3hmRjEzTGhWMVFnQTBFSVdIZ0JJVGlP?=
 =?utf-8?B?V1M0M2gyRzc0V0xZWTYralIrdHp0aG42bm5QVzZ6aWpQUHk4Y3hnZlI4NTdP?=
 =?utf-8?B?UmMyMVRxRnJZUUlHY3U0eHBXUlNqNTF1SlV2OEFRY1VHRno1UlA4M2hRUHNB?=
 =?utf-8?B?aW55YmxKSDcwek5ESVJXcjdRd3JEclB6Z2RyUTlwOC82OXBibjdPbmMyNHFv?=
 =?utf-8?B?c0Zad3NhZDZBdzZBQ1ZjWkFpNlZQZmYrL01Uc2duQkU2VkNmbCs0Rk03SHR1?=
 =?utf-8?B?QjYxSWMxdlhkU3pBbXBLMFd3eG5EZkllcTRiTHE2QmdsQ2JiYVF4LzlWd1I5?=
 =?utf-8?B?c3llcTEzSHR2YnhuM0lIZnRqaEpLOGZzRUxOQm1xcGNxUm9nWmRZemJJMTJW?=
 =?utf-8?Q?Nuqg7Zzm4e/8W6zK5Dh3qR5V8DqDXtNfPo2N+F21ALep?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf270319-5f99-48d2-b5c1-08dc4819362c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8989.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 13:33:50.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfejCPBod5FLPfpuez5xcR9sNml28vuIMkEZtu6GstmZN0Va0dhMZO0QRmEapr+YUU73ejoBq7V9RIdG1Dai8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7244

Le 19/03/2024 à 13:20, Simon Horman a écrit :
[...]
> FWIIW, I think handling these questions in follow-up patches is fine.

I wonder if the previous patch must be merged first, so I can reference 
it in the commit message, or if I should shoot it now.

Erwan,


