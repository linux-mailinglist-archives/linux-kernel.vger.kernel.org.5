Return-Path: <linux-kernel+bounces-77941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090F860D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A151C23D30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594818E14;
	Fri, 23 Feb 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K2xThMd1"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43218039;
	Fri, 23 Feb 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677631; cv=fail; b=MyM8OvlwMTaAX9X2eyZEu9jd5wAy2Sswiecplgm2pI51Svwg+86JAU5IpsZ9hmUo/bwzCKIoPxTsIhphsiSKrinh9koY8KlDYmCA/EEIRrjk2KeFzbnrbYdVQOI6i56uNSXNO5KPQf81xsEY/fq4vlHp5Qkp/3OuWhOeOX7KN8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677631; c=relaxed/simple;
	bh=2tI1jQ22hsi8Yfl1IdGfLhHTxH92QBQWTF9vswyb7gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SCmxvCI9JuDgkqKElna410h+x1P4CV2xq1lCjprerIb071F2uoEMmk3oiO7Q5zGZVghx3ZyX+zFmVVRC/iXt2/m4gh3agaKO6+twVQVD9ehUK30rHaMeIKGY6eL1yL68LqMOOIUbPTYz8nQCR2sH0w8cN0OLeo/H77nYDv+1Wuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K2xThMd1; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/jCp5HtypRLGgpulXQsWPX/QY5CTHaX2cL7rVY1sI3mW1ae3Sk5hhqGFYrVdgNczhbES7qfz3Xc9KtPZ1fVcrPHAlx6k7lleyMiJQ5E1Kcs8c+a7UGEdfhhvSvQfNfUAzjXJGs2GupWnla6dR69wrtHgY7rEJZQkb2pzFUvCeWFMYnpiO4PrOJQctJrEShhnbJfcX1LBC1SVl/Fv3swOHaDY/S3ax+NXzfqyI95j14NXmlAmRSrigXMk/zJg6b5vPsRaaNgMq4WjtXM9lbhEoIh+yo9sOGES0aOSnGcjRVuMGOgJvRRzTSZtciQKPn/gTt8H1NAGHX54ISpZgEWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8kZ5wfB+dpEEtdIpviFgrdFpC/y7IL//GR+4o97IVY=;
 b=O87LdkWgsdGBFJOIiFEPozBZoYfSB66RYSQGXT0T50DwJHwksO2HviBvkGI3w+aP4zcIndIhW30w8G70gt8o2338n6taEdUScRKqa2upE48XT+uq0hMTEfA0wmdKhkRGKNfsd0HVUeJ+dJjRE+Tp9Se7jNoplIs6miIw9EBW0ysHjGlwL8tqj+FQU8QJzEGWTOburCfKiqm1h6I7677ZzfczcZzLOztD/XGLXn7q4tyt9NqSEkvHw3K7RXtSoMO8cnGHxIwvWW2UqhZxfVSVWvBEbbnKHdy5zc5UMLYbjAA/fXZBVOqarwWwo8NqVy9QWL4FxwJaosjSvdzIoRsR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8kZ5wfB+dpEEtdIpviFgrdFpC/y7IL//GR+4o97IVY=;
 b=K2xThMd1jZ/G4545qdjj+GE2ZtrSqx8umTU+VpTrNMy4Dee44Vf0ZIHrUIBhcgN9fn6+97IHFlGNFC+DEFhuEZItQoPIMQKcn9QJBL6KArJfHs2GnfXp7+8xYvjTSbkqsRq90oby0lFYCQnU5ozPKhnWkCt8S511kA8jjS2Lxos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by PAXPR02MB7182.eurprd02.prod.outlook.com
 (2603:10a6:102:1bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 08:40:26 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::c7bc:b48d:f12f:422a]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::c7bc:b48d:f12f:422a%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 08:40:25 +0000
Message-ID: <1fe2c4b3-9dd2-a961-4198-45aca3449c36@axis.com>
Date: Fri, 23 Feb 2024 16:40:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] power: supply: bq27xxx: Introduce parameter to config
 cache regs
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219100541.48453-1-Hermes.Zhang@axis.com>
 <eh34cvorgnrw4v5a6emzjk2p6om2ybkn627bpmh775z4ubw63h@nbxgpm767u4x>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <eh34cvorgnrw4v5a6emzjk2p6om2ybkn627bpmh775z4ubw63h@nbxgpm767u4x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:802:18::34) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|PAXPR02MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: a59c554c-7595-4e96-0b87-08dc344b14e9
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZEWI03OETo0g7nvrw+IfMFM6W5/rgghPNqBX88vWfBWtzSpBDLXSWaNZniacmH06RJ/UJk+slj5vNDQJ2BhCgRVeHin3gpZxUCd7cZfLACBWaqDPfXPKoQhvmacjvAd6OY1d8Hi3hA6/wWeXpVRVmPMPkEOXOiYcesf02v55slnDcMWPQtDaXIG8js/Ov8wE6CbOrerScubPqb1D59hOepTqFBqeZYlvr4c7qanActT0St8uKpGUNyCHv2C2p5lWm6NRLGImuzY7acMVPzd0b7u1PHpLlgOb5eJoOQi/eF060GJRhAVOkQwgrpu5n5QBf5dkeOIUo0668UA3YRd9lPG89hD/+WyWW6CgMpaSe6je9JSK3lB5jahmk7QivRzgLK/ZsT/+hpRD7nEpWDAmwtd73pZWN+svN9f3s3FNZ9z8KwOjIfc1JVDOS9sROQest1lDtwfez2xaMV1rjRlgvVnp+02fWvTfUwRuvqffALfjpoKhrIpwl2od1kgLST11fA3pfkfLDibgR8lcR14VI+91n1HCTlzLWwPOkqpkUMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRVekRGUUtZd053TTBCU2VYbS9QM0x6TGZjTmd2VFcwaHpXcTAzQzhqVXda?=
 =?utf-8?B?VkVPKzZrU09DbkYvQnFFY2ZpWndZT3Z5QW9ud1ozSGZpZHRsdjRPV3gwWVZ1?=
 =?utf-8?B?S2dIYk1LMFFna0liL1hKd1AyaXZvcTluVWlKNmVScUtDTzc5U2twVjhSOGIw?=
 =?utf-8?B?QTJ1aHVkMVFwYTN6eEYwKzBFYk5oK0VXb25uaVpVQkIwaW5ZOHdXWGhnZXdo?=
 =?utf-8?B?S3NFWHdnSDhCOEtqVFNQamRMTEdUbFpzWkxvNktuaDJQYmxVaXhyRUYwSlVU?=
 =?utf-8?B?WTMrK29OS2VXbXF1NFVnRFJSdHJOSEZjOW1FT2xubnlLYUp0YUx6QmtkZmV5?=
 =?utf-8?B?dUVCTDIxZEFBTUN2cDRvOXFBZDdzd0RKZWx1M2Y2VU9uYVlZWDdXeHQyZDJT?=
 =?utf-8?B?bFlEZitIZUV0Z3hOTTRSZllGQ0VCaWZlNzU4THJCZnNqczJoR0F1NE1TVlIr?=
 =?utf-8?B?eTQwUUdMUEEwaUFBUThnSnFmcGc2WTFSQks2MENtS05LNmM2R28zSlhaMWpN?=
 =?utf-8?B?clZLN2RvME1ubnRTdHhHay8vUFlpbnZ2QTdRY1NSVFY3UlFydmFBYnNuSERZ?=
 =?utf-8?B?VFQwa2VVb3c5V0UyaVZYZVlaUUxZbTE1Q0xzRGpGSnNWemo5bVpwNnhOc2Vv?=
 =?utf-8?B?MHBmSFNCR3o1Q1Y3cGZiTXVqU0d6MGFEMC9UUnJWWXhuZ25uV1hvdlNyL2F4?=
 =?utf-8?B?bktveWVkdGhhVktzamxQVE1lSkZuRGhjTTJWZTVoWnVrVndDRjFPaHhmNE5I?=
 =?utf-8?B?b3o5YUpvY25XeHFZZXlwOThSYVRVVVpGNjQrV1RLOE81ZGxIQW9wWDRhVXZr?=
 =?utf-8?B?bkRBenFWTy9MWkIxaFBRcTEvbDFRZTRoS2ljaDNzUnZuSHFNVDZkYmJhZ1ZM?=
 =?utf-8?B?OXpkd25MZGo5QXZYdTJEdXR0QTd3eGh3TkFPN3k0MEhuVjRxS1R4ZTFMSHJU?=
 =?utf-8?B?cDVkOEdNSHNjSHlPS1RTNUx6NW9OampBNzFxbWNGUlFXR2R5OU9ZMm5pYXQ3?=
 =?utf-8?B?bGF6NVZjYlRhQzlLQit2NXBHT2huc2VaWGZpRlZKWHJrSCtpVi9MT0lralg5?=
 =?utf-8?B?MDZTVEhlMTZ6ZkVWUVZKclEwQmZLcm9JRkMrQ2RwVXNFMVlrZ1h5bHh2dkg5?=
 =?utf-8?B?Njk0UEFsbjZZYS83aC9aWG8weG1iSGdYMXRUN2dTM1F1aml5VFRYcCtqVG92?=
 =?utf-8?B?bHJwdkJIY25uQ1g3Ui9pc3IvWVlzNzlId1MvaGdoVUJOQ3RMS1lRRU5lblZH?=
 =?utf-8?B?WlZGc3EzbVhqbjNzU0N0cG1DWlN6WGd4MFpsTlFKZjBnT2ZTTWZlazExU2I0?=
 =?utf-8?B?TVg0ak1OTEJTSFNSL0hZTDFFeWNkVXE3TXZtOVF3Wm5GNDZaWjRGSGVuSDJP?=
 =?utf-8?B?WXN6NzlhTVUwUG9kelZ5S0Q2MVZtV0pIc2U0M1VUVnhzRkNKbGJ5U3UwQ1U0?=
 =?utf-8?B?YlcrQzlsdUNWc2NQdEFQTTZadGNybXdOa2dYcUUzbitRMVlIMy8ydHRpNDZF?=
 =?utf-8?B?cXNLS1UyT243QVlDVWRLL1FRRkdPc2MwR1pRLzdiSWd2Y3FCR2RFNmlINXk0?=
 =?utf-8?B?VUJDL2cvKzBlaGpRZERvR2xoeEsyK090bk1HM1g4M2o5M2pSTFQyb0NzdERK?=
 =?utf-8?B?NGdENkd6dlFFTy94dldOQ25KQ0VqRWN6MlVNZVlMa1UwbzJiWFNHeXpmalp6?=
 =?utf-8?B?bXBubGJDalBZYmlPa3ZwdS9jL0dqcVF4NDRIL1BWVit0allxbWpqakFEKzhI?=
 =?utf-8?B?NDA5NEMyUnk2MlZSTjdtbDR3VHp1cCtQODlpVzJrS2VVRjltcktLT1NPWEVs?=
 =?utf-8?B?ZnZiWVhtSytPSk13YU5raVdIYndXZ1dXMURzUVNhaUM1T0tzRGNtaGcvQVFx?=
 =?utf-8?B?Q3lEaU9wOVROOEtDR2VSRTJkd3VMMTE3Z2o4V2xxenBBV2hub3FMMnFlM3di?=
 =?utf-8?B?MTk1YnVwNDFvaWU4RDJvalpzL0hXWVdXc2FwbTQ4aVpsMXljdGJQMGdYVkxL?=
 =?utf-8?B?WlJ1NHhvMkwxVEpzb1lOYnlIcVFxdkFYMXl5OUs4SDVDaWFVdHJtUHp4RHA2?=
 =?utf-8?B?cmtBMFZxK3hUazRhK1diYVYwYzN1RjFGdjVrK3JVanBOQlJuekgxeHN4SjdV?=
 =?utf-8?Q?N+ehUfV+/z9OcHVec13BvAlVk?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59c554c-7595-4e96-0b87-08dc344b14e9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:40:25.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lzksganwtsBEOSWs62eKmAPq3bsKZmJWMlgte++DeTs/xPVmWYZJ/13KWDqhKe+pTfsRPzbUzdLfh5JTA70YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7182

Hi,

On 2024/2/22 7:03, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Feb 19, 2024 at 06:05:40PM +0800, Hermes Zhang wrote:
>> Since all of the regs in the bq27xxx_reg_cache are now cached, a simple
>> property read (such as temperature) will need nine I2C transmissions.
>> Introduce a new module parameter to enable the reg cache to be configured,
>> which decrease the amount of unnecessary I2C transmission and preventing
>> the error -16 (EBUSY) happen when working on an I2C bus that is shared by
>> many devices.
> So the problem is not the caching, but the grouping. So instead
> of adding this hack, please change the code to do the caching
> per register. That way you can just keep the caching enabled and
> don't need any custom module parameters.

Thanks for the reply. Yes, the key is the grouping. So do you suggest to 
drop the bq27xxx_reg_cache struct totally and handle the cache for each 
register in e.g. bq27xxx_battery_get_property()? Then it will require an 
extra time info for each register, will that be a big cost? Or am I 
misunderstanding?

Best Regards,

Hermes


