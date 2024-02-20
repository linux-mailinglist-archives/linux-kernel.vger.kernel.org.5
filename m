Return-Path: <linux-kernel+bounces-73021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECD85BC37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D198B24900
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305C69E0E;
	Tue, 20 Feb 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="q0ydXOTg"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2119.outbound.protection.outlook.com [40.107.15.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C269968;
	Tue, 20 Feb 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432283; cv=fail; b=Lxkv1oo9RRMZtwRbsNX5+N1AOnMm3g4P1ki99Pv322+/z1lvdRccOasuLHQhJb1vH5/i/wfizJFryhGjVfB0bzvgIJgn41vcaUQLxgNVLTdMb+993za5rzkc5a8I4fcMWop5mwQVV0+iOaOaeY98KBtS1+vHHJugJEZC4ztKsWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432283; c=relaxed/simple;
	bh=PsMft/6UgF8onGOlg/RjJ5uaSw3Wn5LkpRVep2yoJyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehDV2eXxY7cd+qfirxtQHjxI4wpx+J0GeqVdeZpOGGaOi2ZCZuqb6luoYlN5fNVHAP7bct+UQwVGMgnMR/crtdfW7Ex8TRFw9D6xGM7wMXC/IOtDPa/jBIQ9N6A+WEErDVnx/F89OdUzU8wOabA3Bj3fNQNjrbsbOrzoXmDuP0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=q0ydXOTg; arc=fail smtp.client-ip=40.107.15.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqSxAZXLOE8lCS5kMQUsyYWQF5m+F/zCmZP+HNqLanMw0wN468CPP2ELyRnD1JESbVXHlNU6NXfjJcWbT9HDljM7ctSWhLbSddr289PGBEPClji/FhTZhdqUnN9cJER7HTGmopuGfTEHQWWclXfBB/MnypANEVBheqrKW8QvbH0coYPZKOKm7Iz1TPF89QJ9F7qfjOTykdjHTXX/7EXEnx3Y8R2TJemuNok3kAy63dXaL1HBl9JSx8FWWSk5ohvtSNy9Nu/Aehw3lCU61kNC4QzFUpvEiypyAZUJ6YB7EXb5UK/wJoGZ8ude2DOv4riUyV2FjL37533QsgxSvHaxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufc2vsPyD46Q9PM0Ayy2F7AZcHXNpsX2EoguXilzGKQ=;
 b=K9+38nn8Le7INqgrsQVxxVrQ1cAIRPrFmstLkUo+5WURJTf16XFvJv1EbpgXTWGkBT6HodLpm407/AGXEva8T3TQi9jjCVMml+nQWVuDr+nMNlaMSTkqy+PY2PszW4NxSE0JyzDwtkUka/n7xnvYGgVvNiL8mFHwbYwiIU3PbIqhI45Ih2+Ik3rAIO6q9R4iFd4JIZ6aew5a/17DvV1CNdVEIUKyjgNapDJgWvPsUJ18ihkQslVusMwUaEp9WVEVMLnMNVoFsXg6oPOMLkA+a8xSdw7E8dcBtu6nX28Zk9luZK25j3KAL47DAmGIDUewgk+/pvdp8Zb7lEUw3nrVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufc2vsPyD46Q9PM0Ayy2F7AZcHXNpsX2EoguXilzGKQ=;
 b=q0ydXOTgQaCCGN6MoKXSSW1PP5prs+UB1Pbe1rgCiXBL7X/pm4XMjZkvgYc3tEG0HNx8bPIS+bGvF2/TTEm2Xb05uRAub4YE5Dc1ZYsiRBYE7esF/+593I8cdUeQdx6thgYRDNHVfo6gmN0HZav7OaIzoEF+arwRqrmyMNbaxWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 12:31:18 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 12:31:18 +0000
Message-ID: <741c19b8-55f5-4f3f-8391-10fc2758e687@solid-run.com>
Date: Tue, 20 Feb 2024 13:31:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
Content-Language: en-US
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Yazan Shhady <yazan.shhady@solid-run.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
 <mafs08r3f8h16.fsf@kernel.org>
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <mafs08r3f8h16.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f75b406-6aed-4653-b26a-08dc320fd66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3pWGOOcPhN/w7L10Bd/3oz5cn3+jZPoX6dhW16YetXnEa528vizjQpvXxzNwkOJD3Ickp4n43Kbc29JDScdZy4I7+5Losc4puZ3D5hKmHNqgWoqmz5Rp1f61Cfrj/Ef1taxQsb7DZOwTlwmSPga+kZl3g43mFQwUe20dT2lqUnzbl6dklvoIxiUqwLpibfqBYvO1sEga4Ra4NMl79wJ40v2D2tYZLC2xhe81w3/fzMS7m4NAQkBmDGc/u6XVW+sxjatZ2K1PsEjeUBap+m25OH3OliFvVwjB7judqCsR48gpwYAm8ZVaYKWrWKtTLuvfd6TUkUHvAiGxMzErSYknP5VF+zIzHaFF6/mCzLXjzQ+Sed77f+u+CNxoJeosnuKlVgbIC69DXPegw3A9/dBF+7jiTjhoyCju2dWI6NYf2BN8hN1virZ1qTN9x78KQR+X9F666oSCrDC6WD8ui9bq4hRquCB8/EsyJaZb3/voasra+pGKCcesno5ksXVnPjfnjdkVW3khOilVl4zOR4UEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3h6cXVSanhycjZjUVpaeXlYT2RFSFFkOWZNandmdnJxelo5cmpWUmVBVWV5?=
 =?utf-8?B?VmVNVjBIVEF2M3A0QVNQcXhmdnFCbEhaR0U4M0tCSk15VGFKNkpHWng5dEcr?=
 =?utf-8?B?MUxwNGNLajEzYnZlNVZTSW5CWmhEQ1JkaTliNTgyTi8wWFJNQ2MyR2xsajl3?=
 =?utf-8?B?K0xYeVozTU9sSXRiZHlVV1NUZEtMdXFjUG16WHlleG1jclNVV1ZBWDVjTS9X?=
 =?utf-8?B?K3lUN2docWtqZHRzeFBVcU5Ka1ZhSVJCM0hkeG0rZ2wxdWJEczRoUzFnWDZi?=
 =?utf-8?B?cS9KUlNZTlMyWHltWU1KYmZNdVpFUjYvb1FqZjV5ZVVZaWJwVFJsaXRTUmRY?=
 =?utf-8?B?YjRnUmhFRGhkdVN0ZTdHak05VE9vaHdIRWp2bzlTWUNoYVRIOEY5ZTJPSjdX?=
 =?utf-8?B?SzFNOFpHM2ttMStwZjlpZ2NTaUZOMWtTdWxNc213Z1FMcFJTbDBkY2hVbjUx?=
 =?utf-8?B?NlRnTGVYalJ0YUdzTTV3ajhSWHU4WDVUNWJnSTJjckplencyNkt2Ukdab05R?=
 =?utf-8?B?SEhLaVVDb1pPbTZjSkVCS3dLeXJrTmg5Ynk5M0VjWUZKeFJIN1FPZ1Z6SGxv?=
 =?utf-8?B?Qzl0aU00Y1ZHckJWTTlRZ1g3dUlXTm5TYy9xMzUyRVJRaUlhWEoxSllXakNu?=
 =?utf-8?B?d0RHY1FHV210b1JBMStFYjVSaVdsQUhGQ05rR1psakY4ZGhYMEJZMkRDQ3or?=
 =?utf-8?B?ZWVubCs5eWp6QVlTVjB6UURqOCtQenNJY2dHcDNsTTlDcnM5ZGtmNFBRQkto?=
 =?utf-8?B?NG1wa0FMTnpLRkRGN0oyZGhUOVcyNi9SYzRWcDNNcjczWlVTY08vMytLazBz?=
 =?utf-8?B?OVlXd3pENXAyY1Jmbk1rcFJ2OWRmbWM3ZjhOYlRkcDc1TisycHZBdlc1Q2VH?=
 =?utf-8?B?MU5rcEJqb0pXM1hYTjNWcTdqMStJSHFGTHBldnJ3RVNwNUY4RUJCM1hBRXUw?=
 =?utf-8?B?bVR5YWo2UW93NkdIMU1VNmgvaE9nMmxZYmlhdy9xSDlNUmhXeWthdnhrbWpt?=
 =?utf-8?B?WHUxdmFrczRSQWZzWEVKN0NpdUdtaG51bjBMeStoZTBUZHJ2dDZqc3V5Zkhv?=
 =?utf-8?B?ZExqODM1QWFqNkRFdTBJcCtHeWo2c2QwZlkvdmd3ZGFsbzRrT0VUTnFhaFJv?=
 =?utf-8?B?S0Y2cDUzaU0zZUQrb1diQVVrVFJvTGJtL2ZTT3RTMWd5OTg2WEszZGE3ejkr?=
 =?utf-8?B?aEF1MEh5Qm5YTXdlajluZGNyblVXL3BrZklkMjVrdmNHVWVMZkNmMEZ1aVpm?=
 =?utf-8?B?UGhKM3NhQ1ZWR3Jjek9sVG5VOWtJNnFWeklvVnYxMFdsNzJuRTB3ZVdhY0pC?=
 =?utf-8?B?eFUra1lsemdqMGs3K24ybHF1blFMbnM0T0FGZjZ2YVE5ZDJFZmo5U0hXbGxy?=
 =?utf-8?B?c2s3Q2Z3MUNsbGdtY1N6N2oyU25aVi9DM1ZKRTdhOUROYlVGZHpxdFAzZUlF?=
 =?utf-8?B?N05FMWFNaHoxVzlkdktXMEVCZTJ6bmNndFRQT29PWDF1VG83T2N2Tjh0cEhn?=
 =?utf-8?B?V0FSWVVTVHZmeGhVajBReVFab3Awb1lkNnFrOEdlSzRNTGpRdTdSOUFqUXdM?=
 =?utf-8?B?RTdRRSs1RmZmZDA4Z0VMKzFxVDU0SVJMRDYycDRoL2NKVVg2Rlo1cnQ5RXR0?=
 =?utf-8?B?SGMrS0NKbW9wTnhqTFhkVTgxSUNGQm9LYnFZUk9KU3R3RlAxbGZYZ1NrZnNF?=
 =?utf-8?B?d3R0QTltWmV1aUtXZEsyMkFRdkpTT0FZODFJcFZXV3UvU05CT3JadksxZDFJ?=
 =?utf-8?B?Z3dvZS9wRDNMKzk2K2xsNlFtRnFkY2U1RnVnbXhRQUNtYUhRRkN0VDFPY1Vi?=
 =?utf-8?B?dlJZQ0hqVUZsV0tqd05meG5ralFNdGQybkFhd2FRQW5WS211UEJtSFFTR3JD?=
 =?utf-8?B?VUR0OTdJWTNVUmt4aFZpSUN1YW41US9Tcmlvby9ySXpGdmZ4U1BGaWJick4z?=
 =?utf-8?B?R0MwdzlvQjBUbmVnMktUemduSkpDK29kOXplK0N0SU81S1R5eGRRZy9rUUlm?=
 =?utf-8?B?dUgrc1g0SjhCQ2FKc0tTd1ltUFVVWFl1TlNRcFdVSWt1TEptckdONk5IdFlI?=
 =?utf-8?B?YjYyTklFU3FRRk0yWjk5dXl0Q1M0SCtrSytNLzFnNmc4WHdlM0ZVN3FCRjg5?=
 =?utf-8?Q?lkPk/1jWXLz95tJGsAwczilcI?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f75b406-6aed-4653-b26a-08dc320fd66f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:31:18.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR9FJ9hjEYObl1ejq8ao1hQqfePQkn8NP3e7rT4EPLI8rYE4qaXvjDSfmGJ5JzDxsT5b5RVxtNrNXzyBeloGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383

Am 20.02.24 um 13:19 schrieb Pratyush Yadav:
> On Mon, Feb 19 2024, Josua Mayer wrote:
>
>> Some spi flash memories have an interrupt signal which can be used for
>> signalling on-chip events such as busy status or ecc errors to the host.
>>
>> Add binding for "interrupts" property so that boards wiring this signal
>> may describe the connection.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>
> BTW, I don't see any support in SPI NOR for handling these interrupts.
> Do you plan to add them in a later patchset?
No current plans, I have little knowledge how spi-nor works in the kernel.
> If not, what do you get by
> describing them?
Foremost I get to submit a correct device-tree (describes hardware)
to the kernel, without maintainers getting all over me for introducing
new dtbs_check errors.

And I really do prefer submitting a complete device-tree so that all
knowledge I have gained reading private schematics is readily
available the next time someone works on it.

>
>> ---
>> Changes in v7:
>> - split out of original patchset because it should go via mtd tree
>> - collected acked-by Rob Herring from v6
>> - Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
>> ---
>>   Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> index 58f0cea160ef..6e3afb42926e 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> @@ -52,6 +52,9 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  interrupts:
>> +    maxItems: 1
>> +
>>     m25p,fast-read:
>>       type: boolean
>>       description:
>>

