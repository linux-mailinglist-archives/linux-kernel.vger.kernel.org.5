Return-Path: <linux-kernel+bounces-80676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706C866B17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15C2283D84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E11CD37;
	Mon, 26 Feb 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AAwbXVZ+"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22831CD18
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932835; cv=fail; b=OrwH/38ynJCKPcET9zYpfFecrfb/+3/Ib6X0pg7e1kOUyG1mvYX0L1drtyPMmV/zHC0CaVhkDxzo8pf+/rKKelWJ9fKlW6Lk+Q0TyBvAH2abCev0U4f0ywhBQ3ytxrE2QSt0k8l/om5kjrqeFM4MqaYQvgpqd4qzeuGWceSRj8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932835; c=relaxed/simple;
	bh=sx7n3QvZg/0MeELmqCpL5BOCa+ZS50YVs92T/g6Bj6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCZW2SBZnmUXr9xAK4EBgOVgqKisdHfiUd1dv6MtMhnnx5KzsEK78Fudik/L+JqIqWjcQPFO4v1BJLc9gRZqgoE4Gb3jYucBqN6UvLRZn8S2efhaDzelKa1JjSJBL1opqY/6zyrt3KB+UF3G+C8tMD1SirFuB1Yd7Ip3coiWbLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AAwbXVZ+; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLgia7wUc4MZjMJQ9BHhU25oaB5VMGdN5JVJP/Yv6ZUNS7P1SyKXHRhD5kjuUnYZo+2Otq+IgNxDMMQ8ZA2bUpk+pKdQvpaYVHxw13qoFa4GEwFPoJ9ZIJpV5sYqwDAls0R4/FUpBQhaO8Pte/Etyrs6yoYMfSan3yKnVszYBTGeVT/skAWe25mJJX4mECLj/AzndEW+cOWz5XkcX5c8FMeAlQ+zs2MFsQCBhP1nmpNaostNbrKgw7Yj3SbZ0vyiEKrOdIZLxie6bMjNnK+d6nCkq1u02J1kSkFgHg66ZsTAsO7G6AW4iDq7vMFmLs9hsgYAbW+wTtKwZgdNUp7Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV+za19P11GpG0vLFuD7MRWY05OuAXyr9WZa6387vYE=;
 b=aYV/zc0fFL4mtbDx3NufEWC5C3a6CUcgSjpZBSJOfPebHHB6l24M9iOjkt25wigOLonJ28+p6fG6oi0i1tQLSSzq/OnD1Fa6Td3UkrKDio34TkeJ/414fhHyrcxe2DpEVWK5MFC9VffdtT6vmR1UalZQ7FUUm8JpZs0YnUENS06ZzFOJkeu4WMqPDl7EE/p3I+/ALbNnU1OOMCh9YwYoHJwdgedGvtW11F3Ap82TK2YlB4d97TEbhYYC2Y46xz2sequwdke5sZHy8hosqBkKGEYN5JO1BgGRVgYZajs6+RqBV50q7egRR5i8Cv932XlwqIKoGY3uNFAJfmrVkYklfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV+za19P11GpG0vLFuD7MRWY05OuAXyr9WZa6387vYE=;
 b=AAwbXVZ+88QvK+PYEWKsMYTzpt/hJmcV6uGtb7E20+LYF85dUaD+tj3DIYzgTBAzeOjaAcF0EkLf4j3Rn2NaeLe2qzNf7XPxcFeEvmo+Ogf9U1lSXvaLuvE+B8Rjgu0445skBjqSr9FTzODIMhkgfbU2aaqLrMmcku9pCRKf2cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 07:33:49 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 07:33:49 +0000
Message-ID: <e9d061fb-c377-46a8-bd01-e661a75122a5@oss.nxp.com>
Date: Mon, 26 Feb 2024 09:33:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Chester Lin <chester62515@gmail.com>,
 Shawn Guo <shawnguo2@yeah.net>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Olof Johansson <olof@lixom.net>, krzysztof.kozlowski+dt@linaro.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, soc@kernel.org,
 NXP S32 Linux Team <s32@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
 <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
 <bcb79af4-56d9-4204-9503-cff996f1ba41@oss.nxp.com>
 <e6f6070e-8355-4a0b-a904-1a24970f249b@linaro.org>
 <e530d504-dfa3-4d39-b903-b2570bb8b014@suse.com>
 <c3e68c62-b81f-475b-9b15-c983c94aed8b@app.fastmail.com>
 <Zdiu8s5Cgz9s6dLP@dragon> <ZdmZ4JC0CsX2qs5C@linux-8mug>
 <57dce440-d24b-4638-9395-62dfb03ec002@app.fastmail.com>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <57dce440-d24b-4638-9395-62dfb03ec002@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::28) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM7PR04MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: f55f734f-a951-4222-cf17-08dc369d45ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ufT/cXFJkwomMrwfNdP3V8gvsdQkgOOOisXBOciLiEbY7SQQ7RFf52b7kKTxNARaS6UWgn2V/IqmkZvHej/ekr5EJWR793PKEPXTS+W2frxOeGRjsFEv/xodGnO1vt/1ToA3Ar4HuQ/n0FBAm/9bbCN2JlzdE3ZEUerR/xfN+q+mJRJEk3CJj/G1S/fjR/6SQvoMMgqBHWb6TmJhXnn7lsg/PkZ9FLXxzNxmEwwVrO0tIJLf/77rrcmdXJNpLD5K5KYxWumbF4VqRMzkct7weuc0nFXL+8KpIPQylHx32NRI5+4MVYOkJvPRWQtGveDZcgQOQMn0L49HhH23NbcgTafpLtGkf48wUy0CWrFzrzG/cBWsUmwc7UYxyn5zrjdKEzcW+uozJjgrm0pH3YNf9Swej/GXPzg547DG8Ihkhvuj9A8nJ/kVLwOwGyO/Hv4NLJD2hwyTMZyQhkDqQJIxbd5EQoC1s1Y+UqVonot0tBBmNuf+V/rhur6yxBT4y5x7OFSb0/LE7TB1/8SVPjWXA9/3P6qZG0xLM26A7v3ddH5/MhFKgw+eF7/D9lkf9ZTzvSDjMDpeWIqQ3SFTXuSXPPEeSA1izAVT41wNeqJBDfvUdm20eGYGhgqHw2VdL4saOS41VoGrb8b5FJZrjg8+zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVNIYTZ6RmxjY2pSeklmQ201N3hvakdqMVhxeTV2N3VKQlhBMWc4M1dUQjk1?=
 =?utf-8?B?SGNGZkJRWVQwMy9CWTlzQUJqeGxieXc1MExZNTNIOGk4RDhGVEtPM0FMQW1Q?=
 =?utf-8?B?SVFBbktaSStDc0VjMmtLTU5mdzkwQUJuRTF1TnVpZFhRNThaZTVybG5mcC85?=
 =?utf-8?B?L1prMWgzQWp4bnN4VVJDWTZBM1V1bUZNN1RLTCtIcjhKRC92Uk14OUNtYlY5?=
 =?utf-8?B?WEQyaytjRW5aNVZXQmVwVVF0TEpwMnloTTgyYjlMMkZaUTlEVzUyVTQxYzNv?=
 =?utf-8?B?STNvaHFzKzhBYU16d3pxb3dhVjhTS1hCekg0UUx0YkxGc0Nrb09vRDJVbDNR?=
 =?utf-8?B?SVFqZlBrcXBvL1JJTG4vOXdsSllZNmZIa2ZRbXRIV3pBMXY5MkhUV2FWNWgy?=
 =?utf-8?B?TE1jT2tLZEhtcDdyYit4ZUFrN1dxNFlHenFZU3dBcTVyU3p2QklaQTRTMDBi?=
 =?utf-8?B?YlkyenU1UDNMQlpLUnl4WFF3N3JSSUFTdzRjZzdFSkEyWE9KZ2pOK0s1S1R1?=
 =?utf-8?B?NVh2NUNpKzYyQituM2dLclN1Y2NuOVp3ckoyQ2JmbWJ5akFobmVua2liMnlK?=
 =?utf-8?B?Y1dsUUM0MW81RG5VNmFkeDUwOUExN2VOSjdYSlFMUVh5OFlqbHd5VlhOSDFR?=
 =?utf-8?B?UWNaWXFySU92MysyNlhzNDhsY1AzQkRha3VNdXVrTkxVVld5b3ZCVzU5dVZ0?=
 =?utf-8?B?MGZscWdMdDV2QVN6N2xDL3RROG1PblF2OG1MWFZhODhHVGVGWDk3ajUwL2ZZ?=
 =?utf-8?B?d0RLRE9jbFlUVzZSYkNNSDBsVURKZE56RkFxbU1iN0NGOEVMRW9sWE9uMGxX?=
 =?utf-8?B?WCtrR0RmakVmT0J6V1pQbkVsWnYyZGJyS1owazdFdHNYb3hYZEtDNzVrMEhs?=
 =?utf-8?B?YlJ1YWR1YUpINHVsZ09xRkQxTlNHanRjdExDU1RZR3orV2JEK0tmTFFMdnJ6?=
 =?utf-8?B?a21pTEZyZGJsTHpjVll6WHZhNEc1NGtHcXVzSWhhZjNwQ2xxcEgxeitKMWRt?=
 =?utf-8?B?WktMa0RmU0IzbE1Fdmwyb2hEYWZFbWw4OW1CMnlRcVJibWtiT3dyRXd5dTdk?=
 =?utf-8?B?ZU1hM0RXeklBcW04MWtlQnlLS2NOUi9JWXJiQlVoTHp0ZGlPUmZ3aXJQZXZx?=
 =?utf-8?B?Mmg0K0szYUFlelA2ZXJ5NXp2cU90cThCb1FGclFmNWxnMHlsRHFSZmFFaHND?=
 =?utf-8?B?OWM1OGxCYkdyeUxrQnNuNGNWUU5RSERUMmVSc3lHSzEzNmlwa1hqVjRreVJv?=
 =?utf-8?B?UVdFcUhqNTd2UkpDUEt6aEZxekZvRExSVlJtYW43Z2VlcjQ4aUg0eWZONzRI?=
 =?utf-8?B?a3dEQ0FWRzIwVVhSQTNzdFhsSG5Vb0w0QndhdmpPT1g1N3pJL1BjdndNZ1lh?=
 =?utf-8?B?VGNCa2JoM3FTWGFnSS8vdGRhY1QxSWl5LzRtNDVBWmlNV2V6ejdpeFNRQlFl?=
 =?utf-8?B?b0tNQXg2YUNjdkZYRlE4K2VyV3hYOCtOOWtMRUR3YTZ3N0xMKytNOXNrZHVO?=
 =?utf-8?B?YTFhRkFHaW5OVlZJSjYzK3JodDBQOWJsSmVtMUt1U214WFdHSXlQb2VjYXRr?=
 =?utf-8?B?RitCNTdkVnBqclh3YXVpejJGblp4TjNuc1IrUXVjVTA1QVBLUmR5MnN6ZE9L?=
 =?utf-8?B?VzhJOGtDNTVPUExTa0pFamdpWkczNTV5YjFjV1V1ZG9ESDBTWFBRS3JheEFN?=
 =?utf-8?B?ZnhOYUlpdytxa00rblB0VGI4cU52a2Zad0hFdktEWUNjdXU4OG9jbnlwTC9a?=
 =?utf-8?B?aEx6cU1NMjNCZ0VWT0ZoVGYwejFCRDVRaUNOdGg3Z2RLZU1PUVFFMXhWYkt2?=
 =?utf-8?B?SDNiVEFiTjk4UFB4ZVBWMEZUeEFITjByZC9iM0xWdjZzNlNKSFEvQVk0NUZy?=
 =?utf-8?B?QTlkajFkYkExcWN4QUhJOSt3eHpZeVBRam9xU1ZrSzNkemZmN0cvWVlsZzl2?=
 =?utf-8?B?SG5iN1Z1Tm5sVEJkRVdLWmZWMGVJcFF5eWEyNzd2STBZN3JMNVdxT283dkJ6?=
 =?utf-8?B?cUVHTndLejR3MngzUUpSRVNHSm81ZkZwWjIyNjF5Wmp4L0MxUkV6NWtlUllJ?=
 =?utf-8?B?aGtaUlZ0MnEvZTZUUG5CUFd6Z2QvS2J3aTk1VkludEpQNnZSTHpaaVJVN0hJ?=
 =?utf-8?B?Z3FGT2toR1lQcDNqbWwyN2hCZnpPMlE2bVZyTG13ZGUwTHBkYmhMNndENWpQ?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55f734f-a951-4222-cf17-08dc369d45ae
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 07:33:49.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rX0YlOFkHQb31K8qbRdynTCcXEuGk153ViXP4knkczYJyEAUuamzx39LP9xBaFA7rMVxBNcNsbpZHxrmXyAGfvFLbwgWFPF9cQfoddvqXug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048

On 2/24/24 13:42, Arnd Bergmann wrote:
> On Sat, Feb 24, 2024, at 08:25, Chester Lin wrote:
>> Hi all,
>>
>> Sorry for the late reply since I lost connection with upstream due to a
>> health condition, which affected my eyesights for a while so I tried to use
>> my eyes as less as possible. Please accept my apologies anyway.
> 
> No worries, and thanks for the clarifications.
> 
>> On Fri, Feb 23, 2024 at 10:42:58PM +0800, Shawn Guo wrote:
>>> On Fri, Feb 23, 2024 at 01:29:10PM +0100, Arnd Bergmann wrote:
>>
>> Before leaving SUSE I reached NXP to see if anyone could take over it but I
>> didn't get response unfortunately. Maybe it was too rush to find a right person
>> at the moment but I still wish that someone can take over this role based on the
>> following reasons:
>>
>> - Since I have returned my S32G boards to SUSE, currently I do not have 
>> a platform
>> to verify S32G patches unless I could get a new one. I wish I could 
>> still help
>> out but hardware & doc resources will be the biggest challenge to me.
>>
>> - My current employee may have competitive relationship with NXP in automotive
>> field, which means I may not be fit in this role unless nobody cares.
> 
> In general, there no problem to just retire from a maintainer
> position or mark it as 'Odd fixes' instead of 'Maintained' when
> you are no longer planning to actively maintain it.
> 
>>>>
>>>> Added everyone there to Cc, having any s32 patches go through
>>>> the imx tree would be the easiest way as far as I'm concerned.
>>>> I've added the maintainers to Cc, let's see what they think.
>>>
>>> It's unintentional that IMX entry covers s32 dts files, as they have a
>>> dedicated entry.
>>>
>>> ARM/NXP S32G ARCHITECTURE
>>> M:      Chester Lin <chester62515@gmail.com>
>>> R:      Andreas Färber <afaerber@suse.de>
>>> R:      Matthias Brugger <mbrugger@suse.com>
>>> R:      NXP S32 Linux Team <s32@nxp.com>
>>> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>> S:      Maintained
>>> F:      arch/arm64/boot/dts/freescale/s32g*.dts*
>>>
>>> However I'm fine with collecting and sending patches through IMX tree,
>>> if S32G folks help review them.
>>>
>>
>> This looks good to me as well.

I agree, this looks good to me too.

> 
> Ok, in this case I would suggest we change this section to
> only have 'R:' entries and no 'M:' for the moment.
> 
> Between the four of you (Chester, Andreas, Matthias, Ghennadi),
> I think we can choose to keep everyone or drop those that are
> unlikely to actually review patches. Please let us know you
> would like to be included as a reviewer or not.

I would like to be included as reviewer.
Can we add Shawn as the maintainer since Chester agreed to pass on the
responsibility to him?

> 
> For the pinctrl driver, I would add the files to the "freescale"
> pinctrl entry in a similar way and end up with
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efeaeb51f183..c1924c0053bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2555,13 +2555,14 @@ F:      drivers/*/*/*wpcm*
>  F:     drivers/*/*wpcm*
>  
>  ARM/NXP S32G ARCHITECTURE
> -M:     Chester Lin <chester62515@gmail.com>
> +R:     Chester Lin <chester62515@gmail.com>
>  R:     Andreas Färber <afaerber@suse.de>
>  R:     Matthias Brugger <mbrugger@suse.com>
>  R:     NXP S32 Linux Team <s32@nxp.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm64/boot/dts/freescale/s32g*.dts*
> +F:     drivers/pinctrl/nxp/
>  
>  ARM/Orion SoC/Technologic Systems TS-78xx platform support
>  M:     Alexander Clouter <alex@digriz.org.uk>
> @@ -17415,7 +17416,9 @@ R:      Pengutronix Kernel Team <kernel@pengutronix.de>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/pinctrl/fsl,*
> +F:     Documentation/devicetree/bindings/pinctrl/nxp,s32*
>  F:     drivers/pinctrl/freescale/
> +F:     drivers/pinctrl/nxp/

Could you please add 'L: NXP S32 Linux Team <s32@nxp.com>', given that
this list is relevant for S32 patches ?

>  PIN CONTROLLER - INTEL
>  M:     Mika Westerberg <mika.westerberg@linux.intel.com>
> @@ -17469,14 +17472,6 @@ S:     Supported
>  F:     drivers/gpio/gpio-sama5d2-piobu.c
>  F:     drivers/pinctrl/pinctrl-at91*
>  
> -PIN CONTROLLER - NXP S32
> -M:     Chester Lin <clin@suse.com>
> -R:     NXP S32 Linux Team <s32@nxp.com>
> -L:     linux-gpio@vger.kernel.org
> -S:     Maintained
> -F:     Documentation/devicetree/bindings/pinctrl/nxp,s32*
> -F:     drivers/pinctrl/nxp/
> -
>  PIN CONTROLLER - QUALCOMM
>  M:     Bjorn Andersson <andersson@kernel.org>
>  L:     linux-arm-msm@vger.kernel.org

Best regards,
Ghennadi


