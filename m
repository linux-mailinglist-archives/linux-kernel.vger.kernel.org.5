Return-Path: <linux-kernel+bounces-149694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6AD8A94AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A11282A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E77D419;
	Thu, 18 Apr 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="LmiJ4t1K"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2025.outbound.protection.outlook.com [40.92.90.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96B7C0A9;
	Thu, 18 Apr 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427944; cv=fail; b=B8ftzcxYwCk8EuhaaBFwmNbDZOfUHeuuipBPqPxOpq5plae4rkyBkM+3u6jKlulAp8uWarJ1lPLPJcCSmCO/1AW5ehGc80GebJqp2lz4ebaSPmJRRvhJGw9AJnCkMvANimL2+ANfX1GSdXZdwCK1VSYsJCium4IYjUING6+yZbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427944; c=relaxed/simple;
	bh=YbI+tddVRzgkHJhW6HBkPFDxHjfgLq8iu6uubPsJbFs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evJf8hRJnMPP2C/TCLS/0cgWQD8TjccH75gHE0c4j8fI8jRvhCA+xJ2/qAYHGtcg6aFV+/yaSDqw94o9ngOj55G99qhAkKzml0HdZqN7R2KTrzrNS8lIgW3kF8vjBOqaBp/YOCngmxHkKDL2oruqcYkrY8KctHbJ4dIFYvb05Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=LmiJ4t1K; arc=fail smtp.client-ip=40.92.90.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZpNDy6lVgp2OmNyAN/F/CRzFbOLoiSw7GbPbcGXxw1UVNJoa6FzPDdlu1mUPvK7rnHoyqPefFJRf9NylR8WvgncJuqNgt4nUbM6UCYItan2FNobtk8YMVSORZ7sJ0FGqdebLDbLlDocjNWdA6l4eUakuW9GUz1YJS6xXXBZfRPS7cDIS7bJrSXhADLUbRvOHXcs2E3s2tUYjLtqJSGfWBC1pHTadXP9lCaj1PwlljO5kxTXIUIjdT3BDQLWHf2vExkIYwZjDW88yg+9EHT3nHzh1+HDVLRCDD4EAYkK3D6q6Opj+lLjifk+6iHtgFUDrei1/AHKP8mwh/3szw7fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4tZXdiM9YsgSy5fLSmlkxgGAzbSa94TmRVc78yIrag=;
 b=aEZ01EgDjb3puLzO0xrRFhvazvRmw10t2g1SPWyCWGOz8B+dQf8CXzXcff//gfjCEfw3Q5tndFpl0AwjSy2irJNKc5QR3Va7XZ+Tfuqiq8Md+0gLpqp9utzCbFq4QzLQb2JCIMhoYNVE5A0EcGhw4HDwLK4OE+gStkJgtxqC3MSWsIGAy2bawCroE8SUEYMyN8pX73+wpvpNm4UNyfuu4Xb+xtlVkMUn8EkBQWNlhFqzkqrrwc2P899j8xXAPPSPkwHm5tntklT2vPrFYfZh6scL9PGLwEj0a/zHVaPUl0eg3+Trf7gfOKH+DFDkVkWHl7dW7ra6UGZoDbpzx8SbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4tZXdiM9YsgSy5fLSmlkxgGAzbSa94TmRVc78yIrag=;
 b=LmiJ4t1KEiNP5gVZ9XrIprkZuX0ZzHi4iSC2j+KX+kYOhHQWxf9562yjB8Q4Tceji8YN/lxHmknFydPxj6dqIV7LYDe1SQdBWKYlgvlO3Dq6qSytVaz+7X5Yxmb6sMt96r5hqrCAUm/54o9HqrarfXwFjhv6YxkuHciVbuMgXQyPb7VTS6AYeeVVfDyd9AZYb+31WM2Q4FIP190WFfcENndDCEw9FXLpplf5PCLogry9xusgSxqYEnYgYEfV7JpX9AwoNJjUl3euFJ/XpAV2zBr49qxpFWcmJBMUTRV36aHGoEewq2IpI5Y/GS547zNwM+ubvJ28d6AZ5HwQvPZSvw==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by GVXPR09MB7653.eurprd09.prod.outlook.com (2603:10a6:150:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Thu, 18 Apr
 2024 08:12:19 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 08:12:19 +0000
Message-ID:
 <AM0PR09MB2675C3D6432177B4CABAD49A950E2@AM0PR09MB2675.eurprd09.prod.outlook.com>
Date: Thu, 18 Apr 2024 10:12:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFC: trf7970a: disable all regulators on removal
To: Krzysztof Kozlowski <krzk@kernel.org>, mgreer@animalcreek.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM0PR09MB2675EDFD44EC82B6BCBB430F95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <64ca6d41-8173-4e0e-9467-4fa32db812ec@kernel.org>
Content-Language: en-US
From: Paul Geurts <paul_geurts@live.nl>
In-Reply-To: <64ca6d41-8173-4e0e-9467-4fa32db812ec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [VZJ6rMpEF/4nzQd0GjVDqx4q7N02swvy]
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID:
 <afcf094a-1844-42cd-b0c9-5daa2c5b4e3d@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|GVXPR09MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: dd37de3c-598e-4647-af8d-08dc5f7f440b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ea+Qi9JpCwMkS47moSeQBTVLkxci8TUmrlpjHBRRaM71xYLES99Js5UgrtNCpSsE7twX49/0rsa5zpIOZkcVzjc4xpwTP1uwU0iFmv6g4TuOtefseQsMnZVFeIczAxNcrMGYL707BYqUjRhA7nRenyTNtJsa03uUxgEQxLN0gLtx3G8VcEkLdI/+ukPfxtST9ug+01fNrMnVTdV5RSj28arCc8sqFO9lakgoUrO08fOSvO675Y5+lbJy7ma6ggmhhAglaS54zILVLcgwACDHWj6+TyS1anF9S5bH0i0M5XBZtAoxUIMDkLYx99GNZlO/2PZ6eAPt2SbWuv2agfLJAD6yk/SubW/KLgDlV6JOyOXJhQPmN1uBVsWdS+Y2f2XKv1PVkoKsQe+Poe/1P53Tk7RAgs582PHQGm5akRoJ2QochyVuN6dpsliiXqRvLxvrLySWjZ09MHhClRLeZD+v9r0kRNDu8b1a5O/zcLulmFl4s/oCQtjW1cPLmCRkNywMRA5GIDIm5pKh5FlMZwzU4lEIWc6U82aptiVRhfJefq/QvEIwLKGQYWeFTy/ZNk8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW1oeUlaNUl3d2h3Z2tFQXU3TFR6NVZPczU0MlhCSzFtT3BwenpJZEdWRkE0?=
 =?utf-8?B?SzYvUE1Bejd2T1lQb3hCaWovdWZXeVNlQ1FROEczZkZJejE3N0JDS3R0MFNW?=
 =?utf-8?B?bkV4c3l6eXpEQWI0VkltdVhDWGEyWkhrcWs3SEJZUXBFSkdVb3F2NVY2R1Ra?=
 =?utf-8?B?WFN6a0hvbjBZalNRejFSWlRjU2VqOFpVVTRIZkdPYWkzRkhBU0ovRUtJWHVB?=
 =?utf-8?B?bm9BS2FIYTk2NEdGc3Ixc0hVT3B1ZHBzZUx2MG54a3JxcEZyVUFXOUhIeExM?=
 =?utf-8?B?NkZrWjdwL1puYVlKY0hvTG9LQ2ZFaUhGNTFhUmhTNlhCOVg0RGRFT2hHVy91?=
 =?utf-8?B?VHRDM3A5aXVFeWU1ZDN2dTRVelhvaG5xMEZGQVhqYnI1ZTRvUlJEMmdQZ3hk?=
 =?utf-8?B?ZWtwNkFvZzJuNXluTFVKT0ovTXR5Q1hEV1NzOTVNNGgwY3EzYjFNSU81Sytz?=
 =?utf-8?B?Mjl0UkcwQmgrVUVUMm9qUG5nQ01PVmYwbVJyd2tCT1RyWDU1Ly8wZVZmd0pG?=
 =?utf-8?B?aWpuOEN1enVlakZObVl0T0xLUGtwZnZXdzZXOEpieE5OdVk0RFRNOTg3Z3pZ?=
 =?utf-8?B?S3hoZFpKblk4cjZhbTcyaDZNR2xuUFgrdHlVSmhtS3NLMXgybVgrNGlwaWRv?=
 =?utf-8?B?TVUwb0pBTWVMNHBNd3NpazlwRXljR3lkM29veDRmTHRQRVZ3cU5YemhaSW5F?=
 =?utf-8?B?Nkova1FRVVVNZkx5OUJzU0duMjU3dTU0L2c1RE9OcytmSjdidG5HY2piTWtv?=
 =?utf-8?B?b2plWERTQ1N2U1ViODBtaFhveTRINldsMWZ0MHhsRFZUV1FKMTVxaUJZZnBD?=
 =?utf-8?B?YVRMZjlPaVd4M1NIdnA2bTJZMTJkaFZ0WElJcHEvbGllQ0JmVkxnS25qNFhl?=
 =?utf-8?B?a2RnZGlPbW9SbnQyYWp3aFJacjZvVUxhUEdEQ0diMmlURTFncEdxTm1UTDVV?=
 =?utf-8?B?NlUzeHYvUDBxaDdUYVJXMnVGUWFWUllBcm0xekNoaUE1SFp3LzhzRk5YbTJJ?=
 =?utf-8?B?ZnI0cFRhSkZCMlp6VjdzRkxzUjEybVVZTU5xZitQd2NFUURYWk5oYVQ4QlJG?=
 =?utf-8?B?QjkySHpxcUprUTNCNXhQSklzK3ZqVjJoR0R3eGgxZ3BiOXRtYzZMU1IxZm5U?=
 =?utf-8?B?U0Z4OU5Vbk43YzFlQ3NBek9BaXlEUXJYcGoxY1Nla2R1NmlNSHNCdG5laGhI?=
 =?utf-8?B?YitPZkZzOWxXc3FWT2FoeHhGOXZjd2lwZGcvQ2FoVDBYRmpwNjJKNVBaUjVu?=
 =?utf-8?B?MW5tSEtqb1JnZkZUMVhkNDRhbXl2R2lDV0VWdWkzclhZRkNiSE9Hd1ZhM242?=
 =?utf-8?B?bXBRSW9oTFJYa0twZDBtV3NNMzRETUo0NEJiWGhnZFdyazdjeGZnZG9BQXcv?=
 =?utf-8?B?aVVCU1RSMjYxeFZLczdxRmRLZFR5Z2VvcW1sOFMzNm41eElzQzRmOUljcUVp?=
 =?utf-8?B?amg2c3o2N2dtc2lZeG5hNDlwV0l5aVBsWjNNMVNvcGJnWkZ3YXNTaFBBd0NY?=
 =?utf-8?B?enZjUU0vK0RJbis4ZHNyUWxiTlJaWlJLcEV5TVFTQXpDRmNqZzEzUG1mUHVt?=
 =?utf-8?B?RU5ueFpIQzFWeXNZRkJObGJjamtvRlljdkFoS0p2d0RXVWczQWtXN3RCYnRB?=
 =?utf-8?Q?jzmuWYdJ400jcxvkLaOfp+rSeeNmyIK5kvItR3rqteIA=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd37de3c-598e-4647-af8d-08dc5f7f440b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:12:19.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7653

On 17-04-2024 15:15, Krzysztof Kozlowski wrote:
> On 16/04/2024 22:28, Paul Geurts wrote:
>> During module probe, regulator 'vin' and 'vdd-io' are used and enabled,
>> but the vdd-io regulator overwrites the 'vin' regulator pointer. During
>> remove, only the vdd-io is disabled, as the vin regulator pointer is not
>> available anymore. When regulator_put() is called during resource
>> cleanup a kernel warning is given, as the regulator is still enabled.
>>
>> Store the two regulators in separate pointers and disable both the
>> regulators on module remove.
>>
>> Fixes: 49d22c70aaf0 ("NFC: trf7970a: Add device tree option of 1.8 Volt IO voltage")
>>
>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
> No blank lines between tags. Please look at existing commits (git log).
Will fix this, thanks
>
>> ---
>>  drivers/nfc/trf7970a.c | 42 +++++++++++++++++++++++-------------------
>>  1 file changed, 23 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
>> index 7eb17f46a815..9e1a34e23af2 100644
>> --- a/drivers/nfc/trf7970a.c
>> +++ b/drivers/nfc/trf7970a.c
>> @@ -424,7 +424,8 @@ struct trf7970a {
>>  	enum trf7970a_state		state;
>>  	struct device			*dev;
>>  	struct spi_device		*spi;
>> -	struct regulator		*regulator;
>> +	struct regulator		*vin_regulator;
>> +	struct regulator		*vddio_regulator;
>>  	struct nfc_digital_dev		*ddev;
>>  	u32				quirks;
>>  	bool				is_initiator;
>> @@ -1883,7 +1884,7 @@ static int trf7970a_power_up(struct trf7970a *trf)
>>  	if (trf->state != TRF7970A_ST_PWR_OFF)
>>  		return 0;
>>  
>> -	ret = regulator_enable(trf->regulator);
>> +	ret = regulator_enable(trf->vin_regulator);
> That does not look like equivalent code. Previously this was vddio, right?
This is part of the original issue created by 49d22c70aaf0. This should be the VIN regulator, but the pointer override made it VDD-IO.
>
>
> Best regards,
> Krzysztof
>

