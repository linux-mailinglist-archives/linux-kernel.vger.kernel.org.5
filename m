Return-Path: <linux-kernel+bounces-90055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5086F96D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52B3281768
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB503B675;
	Mon,  4 Mar 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MjzHum8B"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154679EF;
	Mon,  4 Mar 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709529221; cv=fail; b=UHPCiMPu2VTCqdVC7Lj/hRXqCk07L4XcyLA0WnrA2k+M/mSTtSjaXQAmlfgJPS4E4Mp+or46yBtUfU+3XTLUf67o7uwzn8FKUEpqTeNfikSqim6EkdeD5xcnMMOrePbvDWKZ6dcsR0p/V/gMA+kc+Pin1DS3OBYgNMi6xF6eYuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709529221; c=relaxed/simple;
	bh=AxRk7uM8O/nPn88GB048VHTYxuQIl9Eg7ekTIJ6w5yI=;
	h=To:Cc:References:From:Subject:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=sPpfeP2rb/rdi2e4DdgkuRiOa1dzB6V//IVc4+vPh6pT8U2e6bqArZNyN5SjdhkzCiArSvdDS1eVie2Plx0eeGMdebxbmXZ9HpZFhiiaeR1g2sOVCVt0QOFFQkQkJX8OXNi26jtdNxffOCo3kF0a0W0cNXCGdIFTczpi81ryn48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MjzHum8B; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdYv1LrY+7uSdymQ7qK+Zf6Hb0YnSKYWyc2ZGB2JzMnR51LCKRdAJDKreZtvdNpQHVqQ2mcUEAfiLd0H7HRhP7bSFWqWCaox2/heIirUPkFeeQpGqinRFM7EYVQiw6cfzj6Aezlv7JLJp5IWVu726eATtyPcIh8IAyLlNzQV86/tPP/CVN6wrh6NCMdF/JDmUI3st51BnK/I1UA5BzC4IgCJcOmydb6BZ6pe1dnXCGidofv7BK+GM/x2txhsIpL4ZyB1PWJLPnPawQoVinqhN/PJ4d8JYWoA4plDJ+XJFwOLXQctUu0UyREg5SokGIHHvLKH/8LH0F1dX6Xby732ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMLH8AGdvv29YaZL7O6Q3ZbLcguHJN4x7/x5K9BX5ZU=;
 b=W+5pwlwOTNAN4Fzmtz5rv7FoQEqPgJjcBpN/4iJTRMGtjqLWJiy3fDJk2LXO+XN9HuJuoX7FHPyFrmOn45v/wgwzLBtaxs62IaurVKD0+3a3Kv/HgNnUyy2L1rKP7bg01aMTCIEjdeNe1g/Hst2uD6fJzE4AoZzkZS3zNtuzh2OtMScRYHwVpjVL6+gj5/HWeAREVDbwETsxb3kH3fEZ7b2Y8XWxY1QDu/kudHqL3Ue9pHhG9ccVjv3qTrVgdR/PZVUiMEPix0gI5ICIG74aHzrC1UkOtTwOACcqFOGza2wq0heehM0HvW32NIH33eHDyzitkpUp3JD5i99w3H+Xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMLH8AGdvv29YaZL7O6Q3ZbLcguHJN4x7/x5K9BX5ZU=;
 b=MjzHum8BWeb068Pd1LZwkzZL/izBKVOmA6gn5pUtD+sJ7jHBYEeGPmuAgnHLNWaPxE7V3n1obmvZta2tvRT5YsZa1ACahmG3t5nNSSfue2B6/hqkUthSgiKsvaaJd0ixaIqQeLpQ/GujU870RviDzTjX9Rhkriqv/k6oY//QrLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 05:13:37 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::ef23:4e27:b6c:dcfb]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::ef23:4e27:b6c:dcfb%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 05:13:37 +0000
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de, tony.luck@intel.com,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, sathyapriya.k@amd.com,
 naveenkrishna.chatradhi@amd.com
References: <20240301143748.854090-1-yazen.ghannam@amd.com>
From: "M K, Muralidhara" <muralimk@amd.com>
Subject: Re: [PATCH v2 0/3] FMPM Debug Updates
Message-ID: <764cbfb7-0c1c-e9be-06f5-d5f1547a65c0@amd.com>
Date: Mon, 4 Mar 2024 10:43:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240301143748.854090-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e0601f-e6b0-47c2-9fb9-08dc3c09d8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hrr3JRQ12mPrg3ZidvX7ck12TaJSupZQB4rEJfgXvg2L9WyhcmlRZZPAvcFg7ZnBRoNK2hrkCTL3o3C1QmGKC1bVErEFxnaY4Vf/rXwlrl6azlDau/lc2htUjxwEn9n7ybm1aEUwDCcJeCE5jwvvF5pguYIJH95finxZaVA5bgisF5x4HGnSnPCAcLMJGdGsGoIamPPdrv91rJNA5kQk93N1zhhGGDSMO3Q0rrrtxXoNtMg3pXcb+KfImiaDywYfVISnruYnT21dYbU3eWAG1tsYr7mTZeigtBfPZrGm3/CAM8OXU7M/wuBvnHruBaPNm1b3p7bHNVSobPO2M8sEYlFVqjScL1zA+HcTbI7m4ic7BNUmuE7OEVlDM42twg6a2Y9Ni3dNSi+oPACIenxMxy7jJ3G8kzNJyrQFrCrrkuCPtVLNjRbm7ITLNS7UyAJBtFE7zjiJazpg+FwKs84FGl0R38sfaj4A/5ngLPK2p/fulfyL9Wg6L/x9j+9NC6dCuk6Md/pMy4aKLQ5ooixL9eSQNCM+p1ZilYfGnim3WjiG3Hp9IeN3FTKfJW0SJ3LW37YnQdWgdO49vEPC0IakC7Agr7XX0GGGqB8SCrM/4JE8v6RN01XTP8aaHbtW2HN6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRhWjhrdVZhZzFmK1lDeS9kVDJYcWUzZzhaVWwycVRMTm9wY2J0OTVDb2Zm?=
 =?utf-8?B?WkdyWVkzcWRUWU1Wb29GSEt0NEROemtzQktOOE5VTGFyczVPcG9vVlZzK2Zk?=
 =?utf-8?B?Y1V0c0RDTkxzeDFDbkVsZjBSa0tjZFBrYzJlOUJpdy9VejhQQU5rWlpTNU9X?=
 =?utf-8?B?djNJSnUzcC9SeHA2K1lXcmQ4ck5aQWY3Z2xacHdaSHRhTUgzN015MjdRNUs4?=
 =?utf-8?B?Z0dTOVEzOTE1dkMrclQ4TEY4K3J2T0FQTmtnRnVadUVJUExZZXUvU2p1dzFy?=
 =?utf-8?B?T2RqcEZ3M3Y2VnV2UjRLQWIyOEpYblA3YU1aMytrUmpRSG0yUTFZM0lEUW01?=
 =?utf-8?B?STk4WmJjckVlQThGWHgvUjNFUEdKVU5OMncraEY0eURsaEgyUjBEZ2J3QW83?=
 =?utf-8?B?STBWd1dUdlY5QmhPbTZ4ZFJuY1NueXJXT1JJUmdNcEtpQ0VrVW96UWRoUzFF?=
 =?utf-8?B?cm5BSnloelRjMVcwa1l1VHFyZUpsZFdhVHhKaVdXU0JTa0ZrK3RhNFhRWVFN?=
 =?utf-8?B?TXFXQVdYbGludzIrd3NUTnRKSFNDeW5sRjA5WU9WZ1M3S3VKNlVmTUxld3p2?=
 =?utf-8?B?ME0zYVFSeklDY1dyNmZMYTNYVTdlSVFOZ1hyeVJ4NGtRTFFHc0d5aC82YnRX?=
 =?utf-8?B?dFlDNXI0NTYveVU1dXd4UDM4aWo1eVAzT21yMjc2dDdmSCtlVWtBQ2R2cHdl?=
 =?utf-8?B?UzhJQVMyQ094VzRDZ3FFb0d2ZnMyRERRNjlJa2xjNVd3dHR3UVFBZFFyMStn?=
 =?utf-8?B?T01tZlZRVzV6dytsZVNwRlNrb2krdElKQnNsd05tYWlqeExmY29pRzM0Y3Za?=
 =?utf-8?B?c2gweGxzdEZBbkhrcjRUMVVaNjNrcTgzV3hwbDJEMzFkTjJGaW1WcDlNSWVQ?=
 =?utf-8?B?WC9JNmpROTVqS2w5SG4yNWZzZHZoejdtSGxsQkVLVXdlaHdtWURmbFpBMVdB?=
 =?utf-8?B?cWExMW5Zd1Jjanl5eHo4eG9YYjNMaC9WNllreUszbkd4U0toY29jSnZqZGM1?=
 =?utf-8?B?Z2E3V3dkbnVnc3dTRWFFa01KSE9nZkxnOEltV0MyWWRnR2gzTXZtb1hlVXI0?=
 =?utf-8?B?c0ZXK0ZvRlV5eWVwdi81WFVBWTZIRDVnS3d0a1hhdm15L0RaYitSQ0hvdnFK?=
 =?utf-8?B?TjA1OGdCdUNYdmdGUmUvR1JieWROYVpPbVM2R0ZyTEVlUFVLTUdTQ3NzcE5J?=
 =?utf-8?B?WUJaMjJ2VHhvQ0N1SFdRRjBNQmRvZWhEQUQ5WUtDK240UE9FMGM4c1luMTVZ?=
 =?utf-8?B?aFJRUS9Cbkp1NDRjeStmek9Kandnd1o2U09uekFPVVNCeHN2aXd0S0QwTUVD?=
 =?utf-8?B?OFo2RHRHZ0dpYllVYzJ6RXhWVnA4bG8xN1BQbllJUmxZZG84ci9rT0daTHRp?=
 =?utf-8?B?SXhpSFJ1ekY5cEErNEpaa2wvSWJaOXJiV0gwV1krb2JHVGZPZ3p0QW5CTEVu?=
 =?utf-8?B?Ym4rSGpYN2FZclY0WThmRmZKOTM0bmNTKzNsdmhJakhnSzRUQWgyNGc5S3Fh?=
 =?utf-8?B?UVlqckFDNE9YODh0ZjlHVGFTS1JIQXVtWHU5aWRyMFJveVVWbUtyM0Rab3BU?=
 =?utf-8?B?a3pQMFlkd2EyZUdtd01JcWRxalFBQUFKMWVkUEFBd0J4a1Z6b1V5TkFsRGIw?=
 =?utf-8?B?Z1dXcTBBNk5ZUnU2V1o3Nlh1Sk1PaFA5OFlYSUNhcC9MbmR3RSs4ZldNS1F6?=
 =?utf-8?B?MlNBOGxhaklHSHkrQ25pOW8xUzhLbWZwT3NGNjR6bllldlA3UGMvU2dpU1Ez?=
 =?utf-8?B?bE5tUlVEYll4QlJZV3NheEhqbUR3L0kwdkZ0T3BrdXZYNzc5WDYxN09SUlFp?=
 =?utf-8?B?UXozYjB2dWpFd200dk5HeFQ0UlBwL0lzMXIyd3NoS3hyL3gwRVc3OWRlM2dy?=
 =?utf-8?B?dVRJbms1eEtrLy9pQkxGTHRsSWdlRXpKaDRxZzgva3c1a2hWeStUYjA5dXla?=
 =?utf-8?B?Tnl1OW9FUUNIbldHcVJUMWJPK3p1WkEzWkZWa1U2N2FsSXUrOXBWWHNqUmk3?=
 =?utf-8?B?WC9kNWNRcjBYbldBU0pmbDFoVU1vU1Y3YjJMcUpYRkdpWDlicGFJdXNMcDdj?=
 =?utf-8?B?RS9ENEptVk5RSy9aRWpjbWFzUUNWeWd5SDJyMVdHemozZnpXbWdMcXhyRlpX?=
 =?utf-8?Q?c2mIC2+r3xCLqAyAvORjamF3e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e0601f-e6b0-47c2-9fb9-08dc3c09d8e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 05:13:37.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knnuu4hB+Xdk3x7MBv+pUlUvoGunxVWqHiMxjpG+sj+U5CLfrrV5h8pFKkW9xqy9yVsftd1mhINPRRtPcGLO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

Hi Yazen and Boris,

For Patch 2: "RAS/AMD/FMPM: Save SPA values", Please include below tags

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: muralidhara.mk@amd.com
Signed-off-by: muralidhara.mk@amd.com
Tested-by: sathyapriya.k@amd.com

For Patch 3: "RAS/AMD/FMPM: Add debugfs interface to print record 
entries" Please include below tag
Tested-by: sathyapriya.k@amd.com



On 3/1/2024 8:07 PM, Yazen Ghannam wrote:
> Hi all,
> 
> This set adds two pieces of debug functionality.
> 1) Saving the system physical address of a recorded error.
> 2) Printing record entries through a debugfs file.
> 
> I'd like to include Murali, Naveen, and Sathya as co-developers, since
> this is based on their previous work from here:
> https://lore.kernel.org/r/20231129075034.2159223-4-muralimk@amd.com
> 
> v1 Link:
> https://lore.kernel.org/r/20240226152941.2615007-1-yazen.ghannam@amd.com
> 
> v1->v2:
> * Patch 1 replaced with suggested patch from Boris.
> * Patch 2 update variable names and some code flow.
> * Patch 3 rebase on changes from 1 and 2.
> 
> Thanks,
> Yazen
> 
> Borislav Petkov (AMD) (1):
>    RAS: Export helper to get ras_debugfs_dir
> 
> Yazen Ghannam (2):
>    RAS/AMD/FMPM: Save SPA values
>    RAS/AMD/FMPM: Add debugfs interface to print record entries
> 
>   drivers/ras/amd/fmpm.c | 199 +++++++++++++++++++++++++++++++++++++++++
>   drivers/ras/cec.c      |  10 ++-
>   drivers/ras/debugfs.c  |   8 +-
>   drivers/ras/debugfs.h  |   2 +-
>   4 files changed, 215 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 3513ecaa685c6627a943b1f610421754734301fa
> 

