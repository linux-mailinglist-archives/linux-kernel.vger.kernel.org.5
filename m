Return-Path: <linux-kernel+bounces-134746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C189B64D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BC1282495
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41E469D;
	Mon,  8 Apr 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O0ydvh23"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2107.outbound.protection.outlook.com [40.107.7.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819415228;
	Mon,  8 Apr 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546136; cv=fail; b=nmrD5+0McLFJZUpexXQHi/3BPD4LII/CWaWH3HCkcTQ4JLL0RAxFWrypx+U9cUB320D+Bmq9oTEYODMVJAGOShPU8xRYHvoxwtcpRDb2l+HbCTjfNFclXb6MZvRDp6hPUIu3bGBjkx4tvuf6sVGKp8frgQZPteFighcdZK+ZCKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546136; c=relaxed/simple;
	bh=MPBBiUBk4rYz5S5/v+TzQfnkZWC7332iHmDif/8exhw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tCrtnVz/Q3btdieRAzZB9dcdULaFbOas9Bi12PEWtbQ62+PMozOAFp3bkeVnQ2DM6hfvPiQPkqfdu0WA1CDoGRygiVsufNCPHgjEHV+eWIIjg9RCtRYkg6PCAM8ua+pXTE4nDMscthuH4QcTm55BaWHBct5ksvShbqYCYrs4v5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O0ydvh23; arc=fail smtp.client-ip=40.107.7.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgm09H3+Czs9/bvuR/vE/eAiUoAbH2E4CPlVrqRAVS6/dctBDSIK6qFXoLR8hj0K1CH91WnQCnQBVjUiPk/x4usKaLF9O6Ce/aFY1Gb8kBUlaSQYdNrHD8/rTBWy9DQGjSFnaW3qv9WfTx8cSaFm+1Rvz30YD3ORYEO8ba6RqchGNX8MMgS90GesA/9ie6R7YgewSpIfT1Dz75Sxp+HO6O2O68mtUl5yScEjbW1elQhrnsUw7dcJ8wYp+ZXWZcJXsm6gKIDKd0wkxj2jzl/sQmBjRYAJ/1IvOFMMhn8GHGSkSw7G1nnqN3gJecvIjBfKkJmvdVT+xnnjchsG5yG6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTzdvnEOcLNYTcaNlHs97nu1P4HJ598uRhSFr2NdX4g=;
 b=fQzdZIR++PBirbZR4qxh7Ftl7EWCoBMTnKcfUYKyzGsK6yBQhznReMDHVPf09wGLDMPG/K6PRgxGZEkbAUcAHpKaQ523+JrrF75bYSj/KWwDpvxFzAqOEXpiMX6ifhOEOYR0jJdW5RAkpYAuDqzY4A0gJtJ+3B8V5edO8+s+3NFzFs5jBFiAgrdcjU60VbwMEyjrC5H4VE5D0swaKDF86UIqFM9FSKkCrha2QrPjYxWqkzLC9z2OVaRpjnbWafg5AwbpFHch8rWuA8SJULcIvGxIotRSwD3FUvjj1XzZs3q+ShNTT45eoZqWjzMlUF1ONMLAT7yBwVLDsb3Q1MsoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTzdvnEOcLNYTcaNlHs97nu1P4HJ598uRhSFr2NdX4g=;
 b=O0ydvh23O3YWb+L0/8uRDZ2wwG9D/TEMUB3glNWMRVgyxUxFcngwysaMm5f48d1YHwoZ3suA0VJI2SPZIrhbtQe3jCEKc2TGTIr7ryQV9Fox1u2mYqk5DXPWm0HPvl49Ozv7srdT8A41TQfEyuv4YfDyNipDmY77zgVYkwEHWlA=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by PAXPR04MB8391.eurprd04.prod.outlook.com (2603:10a6:102:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:15:31 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 03:15:31 +0000
Message-ID: <e3d64b07-98fc-4d43-a1ef-561cbac58552@nxp.com>
Date: Mon, 8 Apr 2024 06:15:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 1/1] dt-bindings: media: imx-jpeg: add
 clocks,clock-names,slot to fix warning
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER" <imx@lists.linux.dev>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER"
 <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240404035205.59492-1-Frank.Li@nxp.com>
 <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
From: Mirela Rabulea <mirela.rabulea@nxp.com>
In-Reply-To: <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VE1PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:803:118::44) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|PAXPR04MB8391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EY42rfBItaJYE1h8ONsWIJXpcbhNJ5lOP3YkiEV/D5R09yEqxTsiJdawnd97RjoxZXbavYhFnglTQ/ykJCeJKy0w2EKljNbNVX6jPUXZI4Nnu/wAPxKt4He8f7yRktvTZDO2vrCxsQ91SZgPwdW1RGgUCdbT+187phzQ0P2wwlbkvxKlCbQJzK2N+p5MFvgxjPYSyzTAPuEfsENdHUJgMwupMstb9ch5PHcNHwDfzoHc+ROZdeT5fc9i0uPN8RFrPnzYyIfeQtS5kdeOgn0yoAL3jyYnCy3/2QBr0oFtSeVW7JiO9FD+oa4YLFqN/MtctqA8BmRzuQZVviD8CYTs66Djx0YAnv2I04T0ymVjLSgGj9UnLIMaxQ/NxPXlWJyLvDfwoJYxbPf8fpFETwdfwlwkeT0hn0GiHlBi6HTKZXb6Egcbziby2ViHM9RZf6tZntcy2GazU0xi3jKhW4TM/erie15e4cbC6glD/ylUV7TVkJMY9PbULp8PENICUPttjhA32koPjSYhzwoEW2wAMs3ckBCGNOvzZFmULmRm/8OphvuAPC3matjBXdL6s1R6Xh8EGYuRVa3WTNcA4EPAg90yYUE4mzxfm51dM2okp21pXkocCHIE2SqTzSs/EEbavgMjmcQwSY+YQFrWoeZCBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRhT3dPbjdQa0x3dk96YjJQS2JpbVR4SmYxMXd0ODIvVmsyeHliV0JZZE5w?=
 =?utf-8?B?NlE5VjVkb3VyRWR6a05QbFZQdCtadzltbGt4bTkvQ3Y4RjNSc3lqSzNkOVZS?=
 =?utf-8?B?c2ZKa1pVZVlRWXJ1VTdmZ2ZqYktsaW92c3ZzWEhGN1NhZ0hMNnlkMGVWNjNn?=
 =?utf-8?B?K0loNWpZR0p1RWdFSWpKTElINHc3aXZZUDNoaVhCeDdwM0dCSTlBR21qdkQ0?=
 =?utf-8?B?WnlIbFlvZTdPOVZGbXhXSGF0RU96QVhlSm9LV2k1c3pYOTBpNmFvVmVZcnNT?=
 =?utf-8?B?Y3RGaXhMRUxpL2hFaVZ5SE5sVVVPQmFDN1NZcGpYenlXNzRnMzBGSHRZMlR3?=
 =?utf-8?B?elF0aGMvR2VXN1hQYjJDUU5aODhwSlpvSC9mMUNTQUFHZVg2MUtWVWwwcjdL?=
 =?utf-8?B?czZVbHdsd01yUXdDTFlBSlRkTGFXU3hSMEJhanVtZzF0Q3gxMGl4Y2lHZk5x?=
 =?utf-8?B?SUIwSHdRQk0xaHZtKzE2N2FIbVlobTNGTUFqMjVTQWx6V0hRL3U4S0haNXk4?=
 =?utf-8?B?RkVtaHZqbTlDSGJtR25rSTVwSkJXNFkvY2Z6K1NGNzdwYytmUkNYdGxNWktj?=
 =?utf-8?B?TTVZQndDbjU4aDZVS1VmUHFMRDZOc2FDd0JyUzJqcDVveGliTUk4SStGYWcz?=
 =?utf-8?B?aXJRekNGL0lhS09mNG9qaTVjcEdsejRaSXFyTDcweDhCdytZTFZjRXl6c3RY?=
 =?utf-8?B?RnluRWRocEFvVUVUNWhXSmFLQ0RhQmp2TFB0MWZmOXlmQmxudXBFZWJoTU5u?=
 =?utf-8?B?ZVlTT0ZuZDdhNkpXWVBoUitralYyc25YWGo1UXFwbjBjckFvQWcvMnpaK1Rr?=
 =?utf-8?B?S1Y1b3AxSDI5blBDNEVJS1N4aGVGRWtIOEtYRkNEOVdhcGZQQ25jbnp3NU9p?=
 =?utf-8?B?OUhFeDVXQmFmTDJFbTd1SkRLSFdwTmRtNHdmS1RCSEdrMGRqM1NQcy9oemtF?=
 =?utf-8?B?Tnh4eFRtQmVpdjVQVnJQNzFaVnYxK2c4UXYxRy9nNHU2WEhzb2g2V2xqQ3Zk?=
 =?utf-8?B?b0dDRWdUL2RYcWNod1lONEkzYTg1cXBVbTB4M1VjSkJsL0ZsK0wrd2FJMytY?=
 =?utf-8?B?MkRtUGRyUHhEWW5GeVc4SFcrL1hUenVGalVMeFg5RkhKUEVndnA3MGwxUlBR?=
 =?utf-8?B?dkxTdS83WXBTN0wydmEvZ1oyeDNDc09wNUxxRzdoT05MZ0xQNlAvRnk3TlVT?=
 =?utf-8?B?eFlUTUorOFVHcWV0elo3ODRYSDdaQzd0bW82Z1Q3K0FwaGRBRHRIckxYL2pq?=
 =?utf-8?B?aGVuOE9GT2FGcDNKMjNDekNEZEVrbm1HajkzYWduajFzRkpyKzBwazM5RlVO?=
 =?utf-8?B?MkRFYmdETEtvR2Q5RHJTc1NiWDIwbGpIZlBYWllTRzNsb1FHRldaZWhHWmlQ?=
 =?utf-8?B?U0VXR0RmRmxrR1h0U3owbmlhWUV1M2ZxZVBnMkNlT0NRR3BxZE9ONzIwMGl6?=
 =?utf-8?B?WWxZWHNPSlNqbDhCNjlSTk9mdVI2dnJSdStHT0pPdWU2U0dlalhMZ1NGbDB4?=
 =?utf-8?B?WUJXS1hocnQ0Q29UTjc3WlVPYVN3WEQ0OU16S0ZoT1B5ZFZBRjZrWXgrYyt4?=
 =?utf-8?B?TVJKMTcyQmcrMWljbDRYbTc3TmRFYmhUQjJmS1FkUTJCUjdzYVNhUXQvMlM4?=
 =?utf-8?B?V21EQUFYMmhkTTFRaVJnY0krV0U0VFBaSmdKbXVQOW5xUS82NTdWUFNVNVFw?=
 =?utf-8?B?OU1LbllWQldPd2t2Qkg1dVMyZnV6Nkt3bHpJdEMxbkRqYW5qUDJsK3hqalJN?=
 =?utf-8?B?dGM0Nno4VFpKNXFvQXBMeUZoZ1o4ci9GYU9rZWI4QmpHUHl2bGFScWdUeHNo?=
 =?utf-8?B?ZEZxZ2JiYThiNFNMdDVJK2FoVnoydkQ4OTE2VThoblRCcWcyMHVXZ25Rem5B?=
 =?utf-8?B?SlQ0OFdvU2F5WWNQOU53dlpacFoweW5sT3ZjR01KdnRGN1g4MzFzT2NacFR6?=
 =?utf-8?B?MWMwaDE2aCtBcWErUm9jUUdweGdFY1M3RHpvRTF2Yi93QmpwckZGcXB1aHdl?=
 =?utf-8?B?L3NXV1RKbDR0bUthdG5tRS9aaG1CdFFreldZaUxuYmFtNVVQaU8rVkJMaW5u?=
 =?utf-8?B?Q2FWSVZPTlNKZkZkbzY4SXV3ZTJZL21jNmk4L1pBZnAxMW1Ob2VoY2hoeFVE?=
 =?utf-8?Q?iJIzekJ5OqIQqUsAyA34fBDc1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd9716-f344-42cc-75d0-08dc577a25dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:15:31.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw17Th8SAljwRDkXCszAz9uHkcaBtS1bPKm9RXPyFDjoc4YhTV8cQD5izOs5a2S3nTLaUNiz2EGUj0x8GvqwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8391

Hi Krzysztof,

On 04.04.2024 09:26, Krzysztof Kozlowski wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
>
>
> On 04/04/2024 05:52, Frank Li wrote:
>> Fix below DTB_CHECK warning.
>>
>> make CHECK_DTBS=y freescale/imx8qxp-mek.dtb
>>    DTC_CHK arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
>> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
>>        from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
> No, that's not the reason to add properties. Add them if they are valid.
>
>
>
>> +  slot:
>> +    description: Certain slot number is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 3
> NAK. Every time.
>
> Fix your DTS instead.
>
> Please read the feedback instead of pushing this stuff for the third time!
>
> https://lore.kernel.org/all/bbb1875b-7980-46aa-80b4-dbaf2a2d5755@linaro.org/
>
> Can NXP take responsibility for this piece of code?

Thanks for feedback.

For the clocks issue, I looked at the patches sent previously by 
Alexander Stein and Fabio Estevam, and the current one:

https://lore.kernel.org/linux-devicetree/?q=dfblob%3A3d9d1db3704+dfblob%3A7899e17aff3

As I also said in the past, I think Fabio's patch was more complete, so 
I took his _v3, I tried to incorporate all the feedback given, and I 
sent a subsequent _v4, here (bindings & dtb):

https://lore.kernel.org/linux-devicetree/20240408030734.1191069-1-mirela.rabulea@nxp.com/


For the slots issue, I will consult with Ming and get back.

Thanks for your patience, and sorry for the inconvenience.


Regards,

Mirela

>
> Best regards,
> Krzysztof
>

